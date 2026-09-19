# 2Dto3D-Video-Converter-for-VR
### **Developed & Maintained by SaintDruG**

An advanced, zero-friction AI pipeline engineered specifically for macOS to instantly transform standard flat 2D videos into high-fidelity Side-by-Side (SBS) 3D formats. 

Whether you are converting cinematic YouTube downloads, mobile videos captured on an iPhone, or traditional home movies, this platform strips file container anomalies, calculates spatial environments using deep learning, and outputs files beautifully optimized for native playback on modern VR headsets like the Meta Quest.

---

## What This Tool Does Natively

Standard 2D video lacks depth, but true VR cameras are expensive. This tool bridges the gap by acting as an automated intelligence manager that orchestrates heavy-duty video cleaning and cutting-edge deep learning inference.

### Core Features & Pipeline
1. **Intelligent Audio & Container Demuxing:** Prevents pipeline failures by scanning files for complex streams. If you drop a raw iPhone video inside, it dynamically drops Apple’s proprietary 4-channel `apac` Spatial Audio layout and maps a clean stereo layer. If you use a YouTube file, it smoothly scales default configurations.
2. **Monocular Depth Map Estimation:** Leverages a pre-trained Depth Anything V2 neural network to track spatial hierarchies inside every frame, computing foreground/background separation values seamlessly.
3. **Disparity Shift Rendering:** Automatically warps a dual-view stereoscopic matrix. It leaves the original frame intact for your left eye while utilizing AI depth metrics to shift the right eye's perspective relative to your configured strength factor.
4. **Hardware Optimized Execution:** Out of the box, the pipeline detects your Mac's hardware layout, automatically scaling processing tasks through Apple Silicon GPU acceleration (MPS / Core ML) if active, falling back safely to high-throughput multi-threaded CPU structures.

---

## Supported Source Content

| Source Type | Track Handling | Playback Result |
| :--- | :--- | :--- |
| **iPhone/Mobile Captures** | Auto-removes broken metadata and `apac` tracking data tracks. Isolates clean audio channels. | Striking 3D depth layer added to your personal moments, memories, and personal recordings. |
| **YouTube & Web Downloads** | Dynamically skips custom profile constraints. Auto-maps basic stereo audio fields. | Creates an ultra-immersive, giant 3D theatrical viewport floating cleanly in space. |
| **Action Cam/Flat Footages** | Smoothly reads traditional mp4 container arrays. | Adds deep positional layer separation to fast-moving standard action sequences. |

---

## Terminal Interface Preview

When launching the environment, you are greeted with a customized, responsive ANSI-colored interactive shell terminal layout built for scannability:

```text
=================================================================
        2D to 3D Video Converter for VR (Written by SaintDruG)   
=================================================================
  Description: This tool uses monocular depth estimation AI to   
  extract depth values frame-by-frame and generate a Side-by-Side 
  (SBS) flat 3D video perfect for viewing in VR movie players.  
=================================================================

  1) Convert 2D Video to 3D SBS
  2) Exit Program

Select an option [1-2]: 
```

---

## Installation & Deployment

This package operates completely inside a sandboxed shell virtual environment (`.venv`), guaranteeing it will never conflict with or alter your Mac's system-level Python libraries.

### Prerequisites
Make sure your Mac terminal has basic command-line access utilities configured. Open your terminal and paste this sequence:

```bash
# 1. Clone your standalone repository layout
git clone https://github.com
cd 2Dto3D-Video-Converter-for-VR

# 2. Grant explicit execution clearances to script components
chmod +x setup.sh convert3d.sh

# 3. Fire up the automated dependencies installer environment
./setup.sh
```

> **What `setup.sh` handles in the background:** It checks if your system has Homebrew and FFmpeg installed, compiles them if missing, constructs the local `.venv` container, and automatically configures safe version mappings of `torch`, `transformers`, and `opencv-python`.

---

## Quick Start Guide

Once the installation routine is finished, running conversions becomes a single-command process:

```bash
./convert3d.sh
```

1. Select option `1` on your keyboard and hit Enter.
2. Go to your Mac Finder, locate the video you want to process, and drag and drop it directly into the terminal window. 
3. *Note: The script automatically sanitizes Mac syntax anomalies, meaning spaces, plus signs, brackets, and backslashes will be stripped and parsed perfectly.*
4. Hit Enter and sit back! The AI progress bar will begin counting up frame-by-frame.

**Output Location:** The final processed asset will compile cleanly right into the same directory folder as your original input video named as `[YourOriginalName]_3D_sbs.mp4`.

---

## Optimal VR Playback Recommendations

To ensure your newly generated spatial assets render with the perfect perspective layout without distortion inside your headset player (such as 4XVR Video Player, Skybox VR, or DeoVR):

* **Do NOT select 3D 180° or 3D 360° Modes:** Because the original footage was not captured with a fish-eye spherical lens array, wrapping the screen will stretch the frame like a bubble and ruin perspective constraints.
* **Select Flat/Cinema Projection:** This treats the asset correctly like an ultra-massive, high-definition floating silver screen inside your virtual theatre environment.
* **Toggle 3D SBS / FSBS3D:** Turn on the Side-by-Side profile integration flag inside your player interface bar. The split views will fuse instantly into a deep, crisp 3D canvas layer.

---

## Modifying Core Configurations

If you want to tailor the depth intensity profile for different screen sizes, open `convert3d.sh` using text editors or terminal tools (`nano convert3d.sh`), locate line 95, and modify the parameters:

* `--strength 0.05` -> Increase this value (e.g., `0.08`) to increase stereoscopic separation and push background details further back. Lower it to soften depth layouts.
* `--eye-resolution 1920 1080` -> Modify this value to match targeted resolution standards (e.g., lower it to `1280 720` to decrease total processing time drastically on older Intel Macs).

---

## License & Acknowledgments

* Core Pipeline Wrapper architectures structured by SaintDruG.
* AI Monocular Depth layers fueled by the Depth Anything V2 algorithmic engineering research models.
* Distributed under the MIT License. Check out `LICENSE` documentation details for open distribution parameters.

---
*For issues, optimization pull requests, or layout feature requests, open a tracker ticket directly inside the project's GitHub Repository Issues panel!*
