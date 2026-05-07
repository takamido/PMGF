## Project Title: Personalized Motion Guidance Framework for Athlete-Centric Coaching
# Overview
This repository provides the source code, anonymized dataset, and analysis scripts for the Personalized Motion Guidance Framework (PMGF), a generative AI-based framework for producing individualized motion guidance for sports coaching.

PMGF is designed to bridge the gap between group-level biomechanical findings and athlete-specific coaching needs. The framework uses a Transformer-based Variational Autoencoder (Transformer-VAE) to learn latent representations of athletic motion sequences. By manipulating these latent representations, PMGF generates personalized guidance motions that preserve each athlete’s original movement characteristics while shifting the motion toward a target pattern or toward biomechanically favorable features.

In this study, PMGF was developed and evaluated using baseball pitching motion data from 51 pitchers. The framework implements two main latent-space manipulation strategies:

(1) Motion style transfer between individuals, which generates smooth intermediate motions between a learner’s original motion and a target motion, such as an expert athlete’s motion.

(2) Biomechanical feature-oriented optimization, which shifts an athlete’s motion in the latent space to enhance key pitching-related features, such as stride length, knee extension, trunk tilt, and hip–shoulder delay.

The validation analyses showed that PMGF can generate smooth transitions between individual pitching motions and produce biomechanically plausible refinements associated with higher ball velocity. These outputs are intended to support personalized, athlete-centric coaching practices, especially by providing individualized visual feedback for observational learning.

## Dataset Information

This repository contains the anonymized and standardized dataset used to develop and evaluate the Personalized Motion Guidance Framework (PMGF). The dataset consists of baseball pitching motion data from 51 pitchers. Each pitcher was assigned an anonymized ID from `P_01` to `P_051`.

The input dataset is stored in the following directory:

```text
./Transformer_VAE/data/input_dataset/
```

Under this directory, each pitcher has an individual folder:

```text
./Transformer_VAE/data/input_dataset/P_01/
./Transformer_VAE/data/input_dataset/P_02/
...
./Transformer_VAE/data/input_dataset/P_051/
```

Each pitcher folder contains five `.mat` files corresponding to five pitching trials:

```text
001.mat
002.mat
003.mat
004.mat
005.mat
```

Each `.mat` file contains the following variables:

* `X`: standardized input motion data with the shape `101 × 15 × 4`

  * `101`: normalized time points
  * `15`: joint positions / anatomical landmarks
  * `4`: feature dimensions (three-dimensional joint positions and resultant velocity)
* `Y`: standardized ball velocity data for the corresponding pitch

All `X` and `Y` values are standardized. The information required to reverse the standardization of the motion-position data is provided in the following files:

```text
./Transformer_VAE/data/mu_pos.csv
./Transformer_VAE/data/sigma_pos.csv
```

Here, `mu_pos.csv` contains the mean values used for standardization, and `sigma_pos.csv` contains the corresponding standard deviation values.

The `.mat` files in this repository are data files, not source code. They are used as input data for the PMGF model training, motion generation, and subsequent analyses. The source code for loading these files, training the Transformer-VAE, generating motion guidance, and conducting analyses is provided separately in the program files and MATLAB scripts.

## Code Information

This repository provides the source code and analysis scripts used to develop and evaluate the Personalized Motion Guidance Framework (PMGF). The main code is divided into two parts: a Python/Google Colab notebook for model training, motion generation, and latent-space manipulation, and a MATLAB script for biomechanical analysis and statistical testing.

### 1. Transformer-VAE model training and motion generation

The main Python program is provided as:

```text
./Transformer_VAE/program/main_program.ipynb
```

This notebook performs the main PMGF procedures, including data loading, Transformer-VAE model training or loading, latent-space analysis, motion reconstruction, motion style transfer, Dynamic Time Warping (DTW) evaluation, and latent-space optimization.

The main functions of `main_program.ipynb` are as follows:

* Loads the standardized pitching motion dataset from:

```text
./Transformer_VAE/data/input_dataset/
```

* Loads each `.mat` file containing:

  * `X`: standardized motion input data
  * `Y`: standardized ball velocity data

* Extracts the three-dimensional joint position data from `X` and uses it as input to the Transformer-VAE model.

* Loads the skeletal graph structure from:

```text
./Transformer_VAE/data/edge_index.mat
```

* Loads the mean and standard deviation files used for inverse standardization of the joint position data:

```text
./Transformer_VAE/data/mu_pos.csv
./Transformer_VAE/data/sigma_pos.csv
```

* Defines and uses a Transformer-based Variational Autoencoder (Transformer-VAE) to encode pitching motion sequences into a latent space and reconstruct motion sequences from latent vectors.

* Either trains a new Transformer-VAE model or loads a pretrained model from:

```text
./Transformer_VAE/pretrained_model/
```

* Computes the latent representations of pitching motions and visualizes the learned latent space using t-SNE.

* Evaluates reconstruction accuracy by calculating the root mean squared error (RMSE) between the original and reconstructed joint positions after inverse standardization.

* Generates stick-figure visualizations comparing original and reconstructed pitching motions.

* Performs motion style transfer between individuals by interpolating between the latent representation of an original pitcher and that of a target pitcher.

* Evaluates the smoothness and continuity of motion style transfer using Dynamic Time Warping (DTW) distances between generated motions and the original/target motions.

* Performs latent-space optimization using an Evolution Strategy (ES) to identify motion patterns that improve biomechanical features associated with pitching performance.

* Saves generated or optimized motion data as `.csv` files for subsequent biomechanical analysis in MATLAB.

The Python notebook is intended to be executed in Google Colab or a compatible Python environment with GPU support. A pretrained model is provided so that users can reproduce the analyses without retraining the Transformer-VAE from scratch.

### 2. Biomechanical analysis and statistical testing

The MATLAB analysis script is provided as:

```text
./mat_analysis2/Analysis2.m
```

This script performs biomechanical analysis of the original and generated/optimized pitching motions.

The main functions of `Analysis2.m` are as follows:

* Adds the required MATLAB function directory:

```text
./mat_analysis2/functions/
```

* Loads the original pitching motions from:

```text
./mat_analysis2/data/motions/original_motions/
```

* Loads the reconstructed or optimized motions generated by the Python notebook from:

```text
./mat_analysis2/data/motions/reconstruct_motions/
```

* Loads the mean and standard deviation files used for inverse standardization:

```text
./mat_analysis2/data/mu_data.csv
./mat_analysis2/data/sigma_data.csv
```

* Loads the target pitcher indices from:

```text
./mat_analysis2/data/target_player_idx.csv
```

* Converts the original `.mat` motion data back to physical-scale joint position data.

* Optionally creates videos comparing original and reconstructed/optimized motions by setting:

```matlab
movie_on = 1;
```

* Calculates the following eight biomechanical features for both original and generated/optimized motions:

  1. Shoulder-joint movement
  2. Shoulder abduction
  3. Forward trunk tilt at release
  4. Lateral trunk tilt at release
  5. Maximum trunk rotational velocity
  6. Hip–shoulder delay
  7. Lead knee flexion / knee extension angle
  8. Stride length

* Compares the original and generated/optimized motions using paired t-tests.

* Calculates Cohen’s d as the effect size for each biomechanical feature.

* Applies the Holm–Bonferroni method to correct for multiple comparisons.

* Prints the raw p-values, adjusted significance labels, mean differences, t-statistics, Cohen’s d values, and total effect size.

### 3. Relationship between Python and MATLAB programs

The Python notebook and MATLAB script are used sequentially.

First, `main_program.ipynb` is used to train or load the Transformer-VAE model, generate reconstructed or optimized pitching motions, and save the generated motion data as `.csv` files.

Second, `Analysis2.m` is used to load the original and generated/optimized motions, calculate biomechanical features, and conduct statistical analyses.

In this repository, `.mat` files are used as data files, not as source code. The executable source code is provided in human- and machine-readable formats, including `.ipynb` for the Python/Google Colab workflow and `.m` for the MATLAB biomechanical analysis.

## Usage Instructions

This project is designed to be easily executed in Google Colab. The main PMGF procedures, including dataset loading, Transformer-VAE model execution, motion reconstruction, latent-space manipulation, and motion generation, can be reproduced by mounting the project folder and running the main notebook.

### Running the Python/Google Colab program

First, open Google Colab and make sure that the runtime type is set to GPU:

```text
Runtime → Change runtime type → Hardware accelerator → GPU
```

Then, mount your Google Drive in the Colab environment. If you store the `Transformer_VAE` folder on your Google Drive, it will become accessible from Colab after mounting the drive.

The main notebook is located at:

```text
./Transformer_VAE/program/main_program.ipynb
```

After mounting Google Drive, navigate to the project directory in Colab and run `main_program.ipynb` from the beginning. The notebook loads the standardized pitching motion dataset from:

```text
./Transformer_VAE/data/input_dataset/
```

The dataset is organized by anonymized pitcher IDs from `P_01` to `P_051`. Each pitcher folder contains five `.mat` files, `001.mat` to `005.mat`, corresponding to five pitching trials. Each `.mat` file contains:

* `X`: standardized input motion data with the shape `101 × 15 × 4`
* `Y`: standardized ball velocity data for the corresponding pitch

The four feature dimensions in `X` correspond to three-dimensional joint positions and resultant velocity. The files `mu_pos.csv` and `sigma_pos.csv` are used for inverse standardization of the joint position data:

```text
./Transformer_VAE/data/mu_pos.csv
./Transformer_VAE/data/sigma_pos.csv
```

A pretrained model is included in this repository so that users can reproduce the analyses without training the Transformer-VAE from scratch. If users wish to retrain the model, they can run the training cells in `main_program.ipynb`.

The notebook generates reconstructed or optimized motion data and saves the outputs as `.csv` files. These generated files are used in the MATLAB analysis described below.

### Running the MATLAB analysis

If you wish to reproduce the statistical analysis performed in Analysis 2 of the paper, please use a local MATLAB environment.

First, download the folder named `mat_analysis2` from this repository to your local machine. This folder contains the MATLAB script, required functions, and data files for the biomechanical and statistical analyses.

The main MATLAB script is:

```text
./mat_analysis2/Analysis2.m
```

Open MATLAB, set the current folder to the `mat_analysis2` directory, and run:

```matlab
Analysis2
```

The script automatically adds the required function directory:

```text
./mat_analysis2/functions/
```

It then loads the original motion data, reconstructed or optimized motion data, inverse-standardization files, and target pitcher indices from the `data` directory. Specifically, it uses files stored under:

```text
./mat_analysis2/data/
```

The script calculates eight biomechanical features for the original and generated/optimized motions, performs paired t-tests, calculates Cohen’s d, applies the Holm–Bonferroni correction, and prints the statistical results.

The `.mat` files in this repository are data files, not source code. The executable source code is provided as `main_program.ipynb` for the Python/Google Colab workflow and `Analysis2.m` for the MATLAB biomechanical analysis.

## Requirements

The Python-based PMGF workflow is designed to run in Google Colab with GPU acceleration. The MATLAB-based biomechanical and statistical analysis was tested using MATLAB R2022b.

### Python / Google Colab environment

- Google Colab
- GPU runtime recommended
- Python 3.x
- PyTorch
- NumPy
- SciPy
- pandas
- scikit-learn
- matplotlib
- tqdm
- h5py
- scipy.io, for loading `.mat` files

The main Python notebook is intended to be executed in Google Colab. Most required packages are preinstalled in the Colab environment. If any package is missing, please install it within the notebook using `pip`.

### MATLAB environment

- MATLAB R2022b or later
- Statistics and Machine Learning Toolbox, for paired t-tests

The MATLAB script `Analysis2.m` was tested in MATLAB R2022b. It uses standard MATLAB functions for data loading, matrix operations, biomechanical feature calculation, paired t-tests, Holm–Bonferroni correction, effect-size calculation, and result output. If optional video generation is enabled by setting `movie_on = 1`, MATLAB video-writing functionality is also used.

## Methodology

This project implements the Personalized Motion Guidance Framework (PMGF), a generative AI-based framework for producing individualized motion guidance from baseball pitching motion data. The overall workflow consists of data preprocessing, Transformer-VAE model training, latent-space manipulation, motion generation, and biomechanical/statistical evaluation.

### 1. Data preprocessing

The input dataset consists of standardized baseball pitching motion data from 51 pitchers. For each pitcher, five pitching trials are included. Each trial is stored as a `.mat` file containing standardized motion data (`X`) and standardized ball velocity data (`Y`).

The motion data were prepared using the following preprocessing steps:

1. Three-dimensional joint position data were extracted from pitching motions.
2. Ball release timing was identified.
3. A fixed-duration motion segment around ball release was extracted.
4. Each motion sequence was temporally normalized to 101 frames.
5. Joint position data and ball velocity data were standardized across the dataset.

The standardized input motion data have the shape `101 × 15 × 4`, corresponding to normalized time points, anatomical landmarks, and feature dimensions. The four feature dimensions consist of three-dimensional joint positions and resultant velocity.

### 2. Transformer-VAE model training

A Transformer-based Variational Autoencoder (Transformer-VAE) was used to learn latent representations of pitching motion sequences. The encoder maps each motion sequence into a latent representation, and the decoder reconstructs the motion sequence from the latent vector.

The model was trained to minimize reconstruction error while learning a smooth latent space suitable for motion generation and manipulation. A motion-speed penalty was also included to improve the fidelity of reconstructed high-speed pitching motions.

A pretrained model is included in this repository, so users can reproduce the analyses without retraining the model. The model can also be retrained by running the training cells in `main_program.ipynb`.

### 3. Latent-space manipulation

After training, each pitching motion is represented as a point in the learned latent space. PMGF generates personalized guidance motions by manipulating these latent representations.

Two manipulation strategies are implemented:

#### Motion style transfer between individuals

The first strategy generates intermediate motions between a source pitcher and a target pitcher by interpolating between their latent representations. This produces smooth transitions from the source motion toward the target motion while preserving characteristics of the source pitcher.

#### Biomechanical feature-oriented optimization

The second strategy shifts a pitcher’s latent representation in a direction that improves biomechanical features associated with pitching performance. An Evolution Strategy algorithm is used to search for an optimized direction in the latent space. The optimized latent vector is then decoded into a generated motion pattern.

### 4. Motion generation and reconstruction

Manipulated latent vectors are decoded by the Transformer-VAE decoder to generate reconstructed, transferred, or optimized pitching motions. These generated motions are saved as `.csv` files and can be used for visualization and biomechanical analysis.

### 5. Evaluation

The generated motions are evaluated using both machine-learning-based and biomechanical analyses.

For motion reconstruction, reconstruction accuracy is evaluated using root mean squared error (RMSE) between the original and reconstructed joint positions.

For motion style transfer, Dynamic Time Warping (DTW) is used to quantify whether the generated motions smoothly transition from the source motion toward the target motion.

For biomechanical feature-oriented optimization, eight biomechanical features are calculated from the original and generated motions:

1. Shoulder-joint movement
2. Shoulder abduction
3. Forward trunk tilt at release
4. Lateral trunk tilt at release
5. Maximum trunk rotational velocity
6. Hip–shoulder delay
7. Lead knee flexion / knee extension angle
8. Stride length

The original and generated motions are compared using paired t-tests. Cohen’s d is calculated as the effect size, and the Holm–Bonferroni method is applied to correct for multiple comparisons.

# Citations
・Takamidoa, R., Suzukia, C., & Nakamoto, H. (2025). Personalized Motion Guidance Framework for Athlete-Centric Coaching. arXiv preprint arXiv:2510.10496.
