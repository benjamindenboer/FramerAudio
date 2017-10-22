<h1 align="center">
  <img src="https://d.pr/i/vnA8Vm+" width="160" alt="icon"><br>
  Framer Audio<br>
  <img src="https://d.pr/i/YrdGtQ+" width="50">
  <br>
</h1>
<br>
<p align="center">  
  <img src="https://cdn-std.dprcdn.net/files/acc_589332/rWg5bh" width="840" alt="banner">
  <br>
  <p align="center">From music player mock-ups in Design, to audio players in Code. A Framer module that allows you to design audio interfaces and states, and then bring them to life.</p>
</p>

<br>

## Overview
All included properties and methods.


| Properties    | Type          | Parameters | Description |
| ------------- | ------------- | ----------- |----------- |
| Audio.wrap    | Method  |  `play, pause`  | Wrap slider logic around 2 layers. |
| audio   | String  |   |
| showProgress   | Method  | `slider, knob` | Wrap progress logic around 2 layers. |
| showVolume  | Method  | `slider, knob` | Wrap volume logic around 2 layers. |
| showTime | Method  | `time` | Show time with a TextLayer. |
| showTimeLeft | Method  | `timeLeft` | Show time left with a TextLayer. |

<br>

## Get Started
[Download the example file](https://framer.cloud/BsbYC) or read on for step-by-step instructions.
First, grab the `audio.coffee` file and place it within the `/modules` folder (located within your `.framer` folder).
Then, to include the module, `require` both the `Audio` and `Slider` classes:

```
# Include the module
{Audio, Slider} = require "audio"
```

Next, you’ll likely want to define two basic states in Design: a *play* and *pause* state. I’ve named these layers `play` and `pause` respectively, and made them targetable in Code. Next, I’ll wrap the `Audio` object around these layers, and store the entire object in a variable named `audio`.

```
# Wrap AudioLayer
audio = Audio.wrap(play, pause)
audio.audio = "audio.mp3"
```








