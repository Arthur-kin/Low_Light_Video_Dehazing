#  Blackvideo Dehazing (Low-Light Image Enhancement)

This project is a MATLAB implementation that utilizes **Dehazing** algorithms to enhance **Low-Light Images**.

The core concept involves inverting a low-light image into a Negative Image, which visually shares similar characteristics with a Hazed Image. We then apply the Atmospheric Scattering Model (ASM) and Dark Channel Prior (DCP) techniques to dehaze the image. Finally, the image is inverted back to restore a clear image with significantly improved brightness and contrast.

##  Presentations

To help you quickly understand the core technology and visual results of this project, I have prepared two presentations:

*   ⏱️ **[3-Minute Pitch](./docs/presentation_3min.pdf)** 
    *Ideal for a quick overview of the project's motivation, Histogram analysis, and the visual comparison between low-light and dehazed models.*
*   📖 **[Full Presentation](./docs/presentation_full.pdf)** 
    *Includes complete algorithm derivations, MATLAB implementation details, and data analysis.*

##  Core Technology & Algorithm Flow

The algorithm of this project mainly covers the following key steps:
1. **Histogram Analysis**: Comparing and analyzing image histograms.
2. **Atmospheric Scattering Model (ASM)**: Establishing the physical model of atmospheric scattering.
3. **Dark Channel Prior (DCP)**: Estimating the ambient light using the dark channel prior.
4. **Parameter Estimation & Guided Filter**: Estimating parameters and using a Guided Filter to smooth and preserve the edges of the transmission map $t(x)$.
5. **Restoring $J(x)$**: Image restoration and outputting the final enhanced result.

##  Directory Structure & Files

*   `ASM.m`: Implementation of the Atmospheric Scattering Model and the core dehazing algorithm.
*   `histogram_contract.m`: Code for processing image histograms and contrast analysis.
*   `docs/`: Directory for project-related documents and presentations.
    *   `presentation_3min.pdf`
    *   `presentation_full.pdf`

##  How to Run

1. Ensure MATLAB and the Image Processing Toolbox are installed.
2. Clone this repository to your local machine:
   ```bash
   git clone [https://github.com/Arthur-kin/Blackvideo_dehazing.git](https://github.com/Arthur-kin/Blackvideo_dehazing.git)
