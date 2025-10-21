## Personalized Motion Guidance Framework for Athlete-Centric Coaching
# Overview
This repository provides the implementation of a personalized motion generation and feedback system designed to support athlete-centric coaching.
Our method combines Variational Autoencoder (VAE) and Transformer-based motion generation to produce individualized guidance for athletes based on their movement data.

# Repository Structure
PMGF/  
├── Transformer_VAE &nbsp;&nbsp;&nbsp; #Main programs of the PMGF  
├── mat_analysis2 &nbsp;&nbsp;&nbsp; # Analysis code of matllab for the analysis2  
└── README.md &nbsp;&nbsp;&nbsp; # This file  

# Installation
This project is designed to be easily executed in Google Colab.
All experiments and demonstrations can be reproduced by mounting the project folder and running the main notebook.
First, open a new Google Colab notebook and make sure that the runtime type is set to GPU
(Runtime → Change runtime type → Hardware accelerator → GPU).
Then, mount the project directory named Transformer_VAE into the Colab environment.
If you store this folder on your Google Drive, the following step will make it accessible inside Colab.
Once the folder is mounted, navigate to the project path and execute the main notebook to start the program ("main_program.ipynb").

If you wish to reproduce the statistical analysis performed in Analysis 2 of the paper,
please follow the steps below using your local MATLAB environment.
Download the folder named "mat_analysis2" from this repository to your local machine.
This folder contains the MATLAB scripts and data required for the secondary analysis.
Once downloaded, open MATLAB and load the file "Analysis2.mat" inside the "mat_analysis2" directory.

# Requirements
・Google Colab (Python environment)  
・MATLAB R2022b (or later)

# Citation
・Takamidoa, R., Suzukia, C., & Nakamoto, H. (2025). Personalized Motion Guidance Framework for Athlete-Centric Coaching. arXiv preprint arXiv:2510.10496.
