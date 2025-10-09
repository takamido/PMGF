function create_movie_both(data1,data2,out_file_path,view_angle)

base_color1="k";
base_color2="r";
line_width=1.5;
v = VideoWriter(out_file_path, 'MPEG-4');
v.FrameRate = 83;
open(v);

fig=figure;
for frame_num=1:1:101
   plot3([data1(frame_num,1) data1(frame_num,4)],[data1(frame_num,2) data1(frame_num,5)],[data1(frame_num,3) data1(frame_num,6)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)
   hold on
   plot3([data1(frame_num,1) data1(frame_num,7)],[data1(frame_num,2) data1(frame_num,8)],[data1(frame_num,3) data1(frame_num,9)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)
   plot3([data1(frame_num,4) data1(frame_num,7)],[data1(frame_num,5) data1(frame_num,8)],[data1(frame_num,6) data1(frame_num,9)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)

   plot3([data1(frame_num,4) data1(frame_num,10)],[data1(frame_num,5) data1(frame_num,11)],[data1(frame_num,6) data1(frame_num,12)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)
   plot3([data1(frame_num,16) data1(frame_num,10)],[data1(frame_num,17) data1(frame_num,11)],[data1(frame_num,18) data1(frame_num,12)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)

   plot3([data1(frame_num,7) data1(frame_num,13)],[data1(frame_num,8) data1(frame_num,14)],[data1(frame_num,9) data1(frame_num,15)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)
   plot3([data1(frame_num,19) data1(frame_num,13)],[data1(frame_num,20) data1(frame_num,14)],[data1(frame_num,21) data1(frame_num,15)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width) 

   plot3([data1(frame_num,22) data1(frame_num,4)],[data1(frame_num,23) data1(frame_num,5)],[data1(frame_num,24) data1(frame_num,6)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)
   plot3([data1(frame_num,25) data1(frame_num,7)],[data1(frame_num,26) data1(frame_num,8)],[data1(frame_num,27) data1(frame_num,9)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)
   plot3([data1(frame_num,22) data1(frame_num,25)],[data1(frame_num,23) data1(frame_num,26)],[data1(frame_num,24) data1(frame_num,27)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)

   plot3([data1(frame_num,22) data1(frame_num,28)],[data1(frame_num,23) data1(frame_num,29)],[data1(frame_num,24) data1(frame_num,30)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)
   plot3([data1(frame_num,34) data1(frame_num,28)],[data1(frame_num,35) data1(frame_num,29)],[data1(frame_num,36) data1(frame_num,30)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)
   plot3([data1(frame_num,34) data1(frame_num,40)],[data1(frame_num,35) data1(frame_num,41)],[data1(frame_num,36) data1(frame_num,42)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)

   plot3([data1(frame_num,25) data1(frame_num,31)],[data1(frame_num,26) data1(frame_num,32)],[data1(frame_num,27) data1(frame_num,33)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)
   plot3([data1(frame_num,37) data1(frame_num,31)],[data1(frame_num,38) data1(frame_num,32)],[data1(frame_num,39) data1(frame_num,33)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)
   plot3([data1(frame_num,37) data1(frame_num,43)],[data1(frame_num,38) data1(frame_num,44)],[data1(frame_num,39) data1(frame_num,45)],'LineStyle', '-', 'Marker','o','Color',base_color1,'MarkerFaceColor',base_color1,"LineWidth",line_width)                  

   %data2
   plot3([data2(frame_num,1) data2(frame_num,4)],[data2(frame_num,2) data2(frame_num,5)],[data2(frame_num,3) data2(frame_num,6)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)
   plot3([data2(frame_num,1) data2(frame_num,7)],[data2(frame_num,2) data2(frame_num,8)],[data2(frame_num,3) data2(frame_num,9)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)
   plot3([data2(frame_num,4) data2(frame_num,7)],[data2(frame_num,5) data2(frame_num,8)],[data2(frame_num,6) data2(frame_num,9)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)

   plot3([data2(frame_num,4) data2(frame_num,10)],[data2(frame_num,5) data2(frame_num,11)],[data2(frame_num,6) data2(frame_num,12)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)
   plot3([data2(frame_num,16) data2(frame_num,10)],[data2(frame_num,17) data2(frame_num,11)],[data2(frame_num,18) data2(frame_num,12)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)

   plot3([data2(frame_num,7) data2(frame_num,13)],[data2(frame_num,8) data2(frame_num,14)],[data2(frame_num,9) data2(frame_num,15)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)
   plot3([data2(frame_num,19) data2(frame_num,13)],[data2(frame_num,20) data2(frame_num,14)],[data2(frame_num,21) data2(frame_num,15)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width) 

   plot3([data2(frame_num,22) data2(frame_num,4)],[data2(frame_num,23) data2(frame_num,5)],[data2(frame_num,24) data2(frame_num,6)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)
   plot3([data2(frame_num,25) data2(frame_num,7)],[data2(frame_num,26) data2(frame_num,8)],[data2(frame_num,27) data2(frame_num,9)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)
   plot3([data2(frame_num,22) data2(frame_num,25)],[data2(frame_num,23) data2(frame_num,26)],[data2(frame_num,24) data2(frame_num,27)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)

   plot3([data2(frame_num,22) data2(frame_num,28)],[data2(frame_num,23) data2(frame_num,29)],[data2(frame_num,24) data2(frame_num,30)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)
   plot3([data2(frame_num,34) data2(frame_num,28)],[data2(frame_num,35) data2(frame_num,29)],[data2(frame_num,36) data2(frame_num,30)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)
   plot3([data2(frame_num,34) data2(frame_num,40)],[data2(frame_num,35) data2(frame_num,41)],[data2(frame_num,36) data2(frame_num,42)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)

   plot3([data2(frame_num,25) data2(frame_num,31)],[data2(frame_num,26) data2(frame_num,32)],[data2(frame_num,27) data2(frame_num,33)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)
   plot3([data2(frame_num,37) data2(frame_num,31)],[data2(frame_num,38) data2(frame_num,32)],[data2(frame_num,39) data2(frame_num,33)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)
   plot3([data2(frame_num,37) data2(frame_num,43)],[data2(frame_num,38) data2(frame_num,44)],[data2(frame_num,39) data2(frame_num,45)],'LineStyle', '-', 'Marker','o','Color',base_color2,'MarkerFaceColor',base_color2,"LineWidth",line_width)                  
    
   xlim([-900 1600])
   ylim([-500 2500])
   zlim([-300 2200])

   view(view_angle) 

   drawnow;
   frame = getframe(fig);
   writeVideo(v, frame);  

   hold off
end

close(v);
close(fig);

end