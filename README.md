## Project Title: Personalized Motion Guidance Framework for Athlete-Centric Coaching
# Overview
This repository provides the source code, anonymized dataset, and analysis scripts for the Personalized Motion Guidance Framework (PMGF), a generative AI-based framework for producing individualized motion guidance for sports coaching.

PMGF is designed to bridge the gap between group-level biomechanical findings and athlete-specific coaching needs. The framework uses a Transformer-based Variational Autoencoder (Transformer-VAE) to learn latent representations of athletic motion sequences. By manipulating these latent representations, PMGF generates personalized guidance motions that preserve each athlete’s original movement characteristics while shifting the motion toward a target pattern or toward biomechanically favorable features.

In this study, PMGF was developed and evaluated using baseball pitching motion data from 51 pitchers. The framework implements two main latent-space manipulation strategies:

(1) Motion style transfer between individuals, which generates smooth intermediate motions between a learner’s original motion and a target motion, such as an expert athlete’s motion.

(2) Biomechanical feature-oriented optimization, which shifts an athlete’s motion in the latent space to enhance key pitching-related features, such as stride length, knee extension, trunk tilt, and hip–shoulder delay.

The validation analyses showed that PMGF can generate smooth transitions between individual pitching motions and produce biomechanically plausible refinements associated with higher ball velocity. These outputs are intended to support personalized, athlete-centric coaching practices, especially by providing individualized visual feedback for observational learning.

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
