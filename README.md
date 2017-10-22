<h1 align="center">
  <img src="https://d.pr/i/vnA8Vm+" width="160" alt="icon"><br>
  Framer Audio<br>
  <img src="https://d.pr/i/YrdGtQ+" width="50">
  <br>
  <br>
</h1>
<br>
<p align="center">
  <br>
  
  <img src="https://cdn-std.dprcdn.net/files/acc_589332/rWg5bh" width="840" alt="banner">
  <br>
  <p align="center">From music player mock-ups in Design, to audio players in Code. A Framer module that allows you to design audio interfaces and states, and then bring them to life.</p>
</p>

---

## Overview
An overview of included properties and methods.


| Properties    | Type          | Parameters | Description |
| ------------- | ------------- | ----------- |----------- |
| Audio.wrap    | Method  |  `background, fill, knob`  | Wrap slider logic around 3 layers. |
| audio   | String  |   |
| showProgress   | Method  | `slider, knob` | Wrap progress logic around 2 layers. |
| showVolume  | Method  | `slider, knob` | Wrap volume logic around 2 layers. |
| showTime | Method  | `time` | Show time with a TextLayer. |
| showTimeLeft | Method  | `timeLeft` | Show time left with a TextLayer. |


## Get Started
First, grab the `audio.coffee` file and place it within the `/modules` folder (located within your `.framer` folder).
Then, to include the module, `require` both the `Audio` and `Slider` classes:

```javascript
# Include the module
{Audio, Slider} = require "audio"

```









