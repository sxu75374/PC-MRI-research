<div id="top"></div>

# PC-MRI research


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#contents">Contents</a>
      <ul>
        <li><a href="#project-1">Project 1</a></li>
        <li><a href="#project-2">Project 2</a></li>
        <li><a href="#project-3">Project 3</a></li>
      </ul>
    </li>
    <li><a href="#built-with">Built With</a></li>
    <li><a href="#author">Author</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

## About The Project
PC-MRI-research. This repository includes three projects related to the Phase Contrast MRI. All of them is done under the supervise of Dr. Lirong Yan, University of Southern California. I didn't post the dataset of this project for using because the signal acquisition is done by Dr.Lirong Yan.

## Contents
### [Project 1](https://github.com/sxu75374/PC-MRI-research/tree/main/proj1): 
This project compare the difference ROI selection methods which calculate in the same selected ROI based on same mask choose from the first image or calculate based on different masks get from each of the time point over one cardiac cycle. There might be some difference because the voxels of the vessel will diastole and systole with time.

`read_data.m`: load complex map and magnitude map of the dataset. 

`read_phase.m`: load phase map of the dataset. Use `dicomread` and `dicominfo` to load the MRI image dataset.

`samemask.m` and `getQ.m` to select the ROI based on the same selected region (vessel) and use the same mask for all the image in one cardiac cycle based on the 1st complex image. Then, calculate the blood flow rate Q based on that same ROI mask. 

`diffmask.m` and `getQ_separate.m` the ROI selected based on the nested loop for each of the images in one cardiac cycle. Then, calculate the blood flow rate Q based on that same ROI area but different mask acquisite by each of the time points. 

### [Project 2](https://github.com/sxu75374/PC-MRI-research/tree/main/proj2):
Project 2 gets area data and calculates the blood flow rate Q with the correspnding resistivity index (RI) and pulsatility index (PI) of the target vessel in ROI. 
Then, do the analysis based on the correlation with patients age information. This project is implement the paper written by Pahlavian, Soroush H., et al. [Cerebroarterial Pulsatility and Resistivity Indices Are Associated with Cognitive Impairment and White Matter Hyperintensity in Elderly Subjects: A Phase-Contrast MRI Study](https://pubmed.ncbi.nlm.nih.gov/32501154/).

`getAllFiles.m`: get all the address of the images in the data folders.

`read_data.m`: load the whole dataset based on the address obtained by `getAllFiles.m`

`getQ_separate.m`: analyzes and calculates the Q value and PI, RI.

`AgeCorr.m`: analyzes the correlation between PI, RI and patients' age.

### [Project 3](https://github.com/sxu75374/PC-MRI-research/tree/main/proj3):
Project 3 implements the image processing part of small perforating vessels detection in the paper written by Bouvy, W. H., et al. [Assessment of Blood Flow Velocity and Pulsatility in Cerebral Perforating Arteries with 7-T Quantitative Flow MRI](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5008170/) and the paper written by Geurts, Lennart, et al. [Better and Faster Velocity Pulsatility Assessment in Cerebral White Matter Perforating Arteries with 7T Quantitative Flow MRI through Improved Slice Profile, Acquisition Scheme, and Postprocessing](https://pubmed.ncbi.nlm.nih.gov/28699211/).

`getAllFiles.m`: get all the address of the images in the data folders.

`read_data.m`: load the whole dataset based on the address obtained by `getAllFiles.m`

`main.m`: main steps of the image processing part in both of the papers.

## Built With
- [MATLAB R2020a](https://www.mathworks.com/products/matlab.html)

### Installation
This code built and tested with MATLAB R2020a on macOS Catalina version 10.15.7, included package [Image Processing Toolbox](https://www.mathworks.com/products/image.html).

## Author

**Shuai Xu** | University of Southern California

[Profile](https://github.com/sxu75374) - <a href="mailto:imshuaixu@gmail.com?subject=Nice to meet you!&body=Hi Shuai!">Email</a>

Project Link: [https://github.com/sxu75374/PC-MRI-research](https://github.com/sxu75374/PC-MRI-research)

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.md` for more information.

<p align="right">[<a href="#top">back to top</a>]</p>
