% Analysis2
addpath('./functions')
file_path_ori="./data/motions/original_motions";
file_path_re="./data/motions/reconstruct_motions";

mu_pos=readmatrix("./data/mu_data.csv");
mu_pos = repmat(mu_pos, [1, 1, 101]);
mu_pos = permute(mu_pos, [3, 1, 2]);

sigma_pos=readmatrix("./data/sigma_data.csv");
sigma_pos = repmat(sigma_pos, [1, 1, 101]);
sigma_pos = permute(sigma_pos, [3, 1, 2]);

target_player_idx=readmatrix("./data/target_player_idx.csv");

per_pitch_num=5;
frame_rate=101/1.2;

%% load data
original_motions=cell(1,length(target_player_idx));
reconst_motions=cell(1,length(target_player_idx));

for i=1:1:length(target_player_idx)
    idx=target_player_idx(i);
    file_name_ori=dir(fullfile(file_path_ori,append("P_",num2str(idx,"%02d")),"*.mat"));   
    file_name_re=dir(fullfile(file_path_re,append("P",num2str(idx),"_", "*.csv")));

    ind_motions_ori=cell(1,size(file_name_ori,1));
    ind_motions_re=cell(1,size(file_name_re,1));
    for pitch=1:1:size(file_name_ori,1)
        load(fullfile(file_path_ori,append("P_",num2str(idx,"%02d")),file_name_ori(pitch).name));
        X=X(:,:,1:3);
        X=X.*sigma_pos+mu_pos;
        X_reshape=zeros(size(X,1),size(X,2)*size(X,3));
        for joint_num=1:1:size(X,2)
            joint_pos=squeeze(X(:,joint_num,:));
            X_reshape(:,3*(joint_num-1)+1:3*joint_num)=joint_pos;
        end
        ind_motions_ori{pitch}=X_reshape;
        
        temp_motion=readmatrix(fullfile(file_path_re,append("P",num2str(idx-1),"_",num2str(pitch),".csv"))); 
        ind_motions_re{pitch}=temp_motion;
    end
    original_motions{i}=ind_motions_ori;
    reconst_motions{i}=ind_motions_re;
end

%% if you want to make a video, please set movie_on=1
movie_on=0;
if movie_on==1
   view_angle=[45 5];
   for i=1:1:length(target_player_idx)
       idx=target_player_idx(i);
       movie_path=fullfile("./video/",append("P_",num2str(idx,"%02d"),".mp4"));           
       % using fastest ball's data
       create_movie_both(original_motions{i}{1},reconst_motions{i}{1},movie_path,view_angle)
   end
end

%% calculate eight biomechanical features & statistical testing

feature_number=8;
feature_values_ori=zeros(feature_number,length(target_player_idx));
feature_values_re=zeros(feature_number,length(target_player_idx));

land_frame=17;
for target_p_id=1:1:length(target_player_idx)

   features_ind_ori=zeros(feature_number,per_pitch_num);
   features_ind_re=zeros(feature_number,per_pitch_num);
   for pitch_id=1:1:per_pitch_num
       motion_ori=original_motions{target_p_id}{pitch_id};
       motion_re=reconst_motions{target_p_id}{pitch_id};

       res_wr_velo_ori=(diff(motion_ori(:,6*3)).^2+diff(motion_ori(:,6*3-1)).^2+diff(motion_ori(:,6*3-2)).^2).^0.5;
       [~,release_tim_ori]=max(res_wr_velo_ori);

       res_wr_velo_re=(diff(motion_re(:,6*3)).^2+diff(motion_re(:,6*3-1)).^2+diff(motion_re(:,6*3-2)).^2).^0.5;
       pose_diff = motion_re - motion_ori(release_tim_ori,:);
       distances = vecnorm(pose_diff, 2, 2);
        
       [~, release_tim_re] = min(distances);       

       %F1. Shoulder-joint movement
       res_lsh_velo_ori=(diff(motion_ori(:,3*3)).^2+diff(motion_ori(:,3*3-1)).^2+diff(motion_ori(:,3*3-2)).^2).^0.5;
       res_lsh_velo_re=(diff(motion_re(:,3*3)).^2+diff(motion_re(:,3*3-1)).^2+diff(motion_re(:,3*3-2)).^2).^0.5;
       features_ind_ori(1,pitch_id)=sum(res_lsh_velo_ori(release_tim_ori-land_frame:release_tim_ori));
       features_ind_re(1,pitch_id)= sum(res_lsh_velo_re(release_tim_ori-land_frame:release_tim_ori));
       
       %F2.shoulder abduction
       vec_rhip_rsh_ori=motion_ori(release_tim_ori-land_frame:release_tim_ori,8*3-2:8*3)-motion_ori(release_tim_ori-land_frame:release_tim_ori,2*3-2:2*3);
       vec_rhip_rsh_ori=vec_rhip_rsh_ori./vecnorm(vec_rhip_rsh_ori,2,2);  
       vec_rel_rsh_ori=motion_ori(release_tim_ori-land_frame:release_tim_ori,4*3-2:4*3)-motion_ori(release_tim_ori-land_frame:release_tim_ori,2*3-2:2*3);
       vec_rel_rsh_ori=vec_rel_rsh_ori./vecnorm(vec_rel_rsh_ori,2,2);  

       vec_rhip_rsh_re=motion_re(release_tim_re-land_frame:release_tim_re,8*3-2:8*3)-motion_re(release_tim_re-land_frame:release_tim_re,2*3-2:2*3);
       vec_rhip_rsh_re=vec_rhip_rsh_re./vecnorm(vec_rhip_rsh_re,2,2);    
       vec_rel_rsh_re=motion_re(release_tim_re-land_frame:release_tim_re,4*3-2:4*3)-motion_re(release_tim_re-land_frame:release_tim_re,2*3-2:2*3);
       vec_rel_rsh_re=vec_rel_rsh_re./vecnorm(vec_rel_rsh_re,2,2);

       theta_ori = acos(dot(vec_rhip_rsh_ori, vec_rel_rsh_ori,2));
       theta_re = acos(dot(vec_rhip_rsh_re, vec_rel_rsh_re,2));
       
       features_ind_ori(2,pitch_id)=mean(theta_ori);
       features_ind_re(2,pitch_id)=mean(theta_re);

       %F3. Forward-trunk-tilt et release
       hip_center_ori=(motion_ori(release_tim_ori,3*8-1:3*8)+motion_ori(release_tim_ori,3*9-1:3*9))/2;
       sh_center_ori=(motion_ori(release_tim_ori,3*2-1:3*2)+motion_ori(release_tim_ori,3*3-1:3*3))/2;      
       vec_ori_yz=sh_center_ori-hip_center_ori;
       vec_ori_yz=vec_ori_yz/norm(vec_ori_yz);

       hip_center_re=(motion_re(release_tim_re,3*8-1:3*8)+motion_re(release_tim_re,3*9-1:3*9))/2;
       sh_center_re=(motion_re(release_tim_re,3*2-1:3*2)+motion_re(release_tim_re,3*2-1:3*2))/2;      
       vec_re_yz=sh_center_re-hip_center_re;   
       vec_re_yz=vec_re_yz/norm(vec_re_yz);

       ref_vec_yz=[1 0];
       features_ind_ori(3,pitch_id)= acos(dot(ref_vec_yz,vec_ori_yz));
       features_ind_re(3,pitch_id)=acos(dot(ref_vec_yz,vec_re_yz));

       %F4.Lateral-trunk-tilt et release
       vec_ori_xz=motion_ori(release_tim_ori,[1 3])-motion_ori(release_tim_ori,[13*3-2 13*3]);
       vec_ori_xz=vec_ori_xz/norm(vec_ori_xz);

       vec_re_xz=motion_re(release_tim_re,[1 3])-motion_re(release_tim_re,[13*3-2 13*3]);
       vec_re_xz=vec_re_xz/norm(vec_re_xz);

       ref_vec_xz=[0 1];
       features_ind_ori(4,pitch_id)=acos(dot(vec_ori_xz,ref_vec_xz));
       features_ind_re(4,pitch_id)=acos(dot(vec_re_xz,ref_vec_xz));

       %F5. Maximum trunk rotational velocity 
       v_ori = motion_ori(1:release_tim_ori, 8*3-2:8*3-1) - motion_ori(1:release_tim_ori, 9*3-2:9*3-1);
       v_re  = motion_re(1:release_tim_re,  8*3-2:8*3-1) - motion_re(1:release_tim_re,  9*3-2:9*3-1);
        
       ang_ori = atan2(v_ori(:,2), v_ori(:,1));
       ang_re  = atan2(v_re(:,2),  v_re(:,1));
        
       ang_ori = unwrap(ang_ori);
       ang_re  = unwrap(ang_re);
        
       omega_ori = diff(ang_ori);
       omega_re  = diff(ang_re);
        
       [peak_hip_rot_velo_ori, tim_hip_ori] = max(abs(omega_ori));
       [peak_hip_rot_velo_re,  tim_hip_re ] = max(abs(omega_re));
        
       features_ind_ori(5,pitch_id) = peak_hip_rot_velo_ori;
       features_ind_re(5,pitch_id)  = peak_hip_rot_velo_re;     

       %F6. Hip–shoulder delay
       s_ori = motion_ori(1:release_tim_ori, 2*3-2:2*3-1) - motion_ori(1:release_tim_ori, 3*3-2:3*3-1);
       s_re  = motion_re(1:release_tim_re,  2*3-2:2*3-1) - motion_re(1:release_tim_re,  3*3-2:3*3-1);
        
       ang_s_ori = atan2(s_ori(:,2), s_ori(:,1));
       ang_s_re  = atan2(s_re(:,2),  s_re(:,1));
       ang_s_ori = unwrap(ang_s_ori);
       ang_s_re  = unwrap(ang_s_re);
        
       omega_s_ori = diff(ang_s_ori);
       omega_s_re  = diff(ang_s_re);
        
       [~, tim_sh_ori] = max(abs(omega_s_ori));
       [~, tim_sh_re ] = max(abs(omega_s_re));
        
       features_ind_ori(6,pitch_id) = tim_sh_ori - tim_hip_ori;
       features_ind_re(6,pitch_id)  = tim_sh_re  - tim_hip_re;

       %F7. Lead knee flextion
       vec_lhip_lkn_ori=motion_ori(release_tim_ori,9*3-1:9*3)-motion_ori(release_tim_ori,11*3-1:11*3);
       vec_lheel_lkn_ori=motion_ori(release_tim_ori,13*3-1:13*3)-motion_ori(release_tim_ori,11*3-1:11*3);
       vec_lhip_lkn_ori=vec_lhip_lkn_ori/norm(vec_lhip_lkn_ori);
       vec_lheel_lkn_ori=vec_lheel_lkn_ori/norm(vec_lheel_lkn_ori);

       vec_lhip_lkn_re=motion_re(release_tim_re,9*3-1:9*3)-motion_re(release_tim_re,11*3-1:11*3);
       vec_lheel_lkn_re=motion_re(release_tim_re,13*3-1:13*3)-motion_re(release_tim_re,11*3-1:11*3);
       vec_lhip_lkn_re=vec_lhip_lkn_re/norm(vec_lhip_lkn_re);
       vec_lheel_lkn_re=vec_lheel_lkn_re/norm(vec_lheel_lkn_re);

       features_ind_ori(7,pitch_id)=acos(dot(vec_lhip_lkn_ori,vec_lheel_lkn_ori));
       features_ind_re(7,pitch_id)=acos(dot(vec_lhip_lkn_re,vec_lheel_lkn_re));       

       %F8. Stride-length
       features_ind_ori(8,pitch_id)=motion_ori(release_tim_ori,13*3-1)-motion_ori(1,12*3-1);
       features_ind_re(8,pitch_id)=motion_re(release_tim_re,13*3-1)-motion_re(1,12*3-1);

   end
   feature_values_ori(:,target_p_id)=mean(features_ind_ori,2);
   feature_values_re(:,target_p_id)=mean(features_ind_re,2);

end

% paire-wised t-test
h = zeros(8,1);
p = zeros(8,1);
ci = zeros(8,2);
stats = struct('tstat', [], 'df', [], 'sd', []);

for i = 1:8
    [h(i), p(i), ci(i,:), stats(i)] = ttest(feature_values_ori(i,:), feature_values_re(i,:));
end

% calculate Cohen's d
effect_size = zeros(8,1);
for i = 1:8
    diff_vals = feature_values_re(i,:)-feature_values_ori(i,:);
    
    sd_diff = std(diff_vals, 1);
    effect_size(i) = mean(diff_vals) / sd_diff;
    if i==1
       effect_size(i)=-effect_size(i);
    end
end

alpha = 0.05;
m = length(p);

% Holm–Bonferroni adjustment
[p_sorted, sort_idx] = sort(p);
sig_label_sorted = strings(size(p_sorted));
stopped = false;
for i = 1:m
    threshold = alpha / (m - i + 1);

    if ~stopped && p_sorted(i) <= threshold
        if p_sorted(i) < 0.01
           sig_label_sorted(i) = 'p < .01';
        elseif p_sorted(i) < 0.05
           sig_label_sorted(i) = 'p < .05';
        elseif p_sorted(i) < 0.10
           sig_label_sorted(i) = 'p < .10';           
        end
    else
        sig_label_sorted(i:end) = 'n.s.';
        stopped = true;
        break
    end
end

sig_label = strings(size(p));
sig_label(sort_idx) = sig_label_sorted;

% Mean difference
mean_ori = mean(feature_values_ori, 2);
mean_re  = mean(feature_values_re, 2);
mean_diff = mean_re - mean_ori;

% Adjust physical unit 
weights=[1 180/pi 180/pi 180/pi 180/pi*frame_rate 1000/frame_rate 180/pi 1];
mean_diff=mean_diff.*transpose(weights);

feature_names = { ...
    'F1: Shoulder-joint movement (mm)', ...
    'F2: Shoulder abduction (deg)', ...
    'F3: Forward trunk tilt at release (deg)', ...
    'F4: Lateral trunk tilt at release (deg)', ...
    'F5: Max trunk rotational velocity (deg/s)', ...
    'F6: Hip–shoulder delay (ms)', ...
    'F7: Lead knee flexion (deg)', ...
    'F8: Stride length (mm)'};

fprintf('%-40s | %-10s | %-15s | %-10s | %-10s | %-10s\n', ...
    'Feature', 'raw p', 'Significance', 'Mean diff', 't-stat', 'Cohen''s d');
fprintf('%s\n', repmat('-', 1, 115));

for i = 1:m
    fprintf('%-40s | %-10.4f | %-15s | %-10.4f | %-10.3f | %-10.3f\n', ...
        feature_names{i}, p(i), sig_label(i), mean_diff(i), stats(i).tstat, effect_size(i));
end

fprintf('%s\n', repmat('-', 1, 115));
fprintf('Total effect size: %.3f\n\n', sum(effect_size));


