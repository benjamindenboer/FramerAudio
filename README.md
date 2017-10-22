<h1 align="center">
  <img src="https://d.pr/i/vnA8Vm+" width="160" alt="icon"><br>
  Framer Audio<br>
  <img src="https://d.pr/i/YrdGtQ+" width="50">
  <br>
</h1>
<br>
<p align="center">  
  <img src="https://d.pr/i/5AIZVa+" width="840" alt="banner">
  <br>
  <h6 align="center">INTRODUCTION</h6>
  <p align="center">From music player mocks in <a href="https://framer.com/features/design?utm_source=github&utm_medium=link&utm_campaign=framer_audio_benjamin">Design</a>, to fully functional audio players in <a href="https://framer.com/features/code?utm_source=github&utm_medium=link&utm_campaign=framer_audio_benjamin">Code</a>. A <strong>Framer</strong> module that allows you to design audio interfaces for iOS, Android, Desktop and more—and then bring them to life. From play buttons to volume sliders.</p>
</p>

<br>

## Overview
All included properties and methods.


| Properties    | Type          | Parameters | Description |
| ------------- | ------------- | ----------- |----------- |
| Audio.wrap    | Method  |  `play, pause`  | Wrap audio obbject around 2 layers. |
| audio   | String  |   | Source of the audio file. |
| showProgress   | Method  | `slider, knob` | Wrap progress logic around 2 layers. |
| showVolume  | Method  | `slider, knob` | Wrap volume logic around 2 layers. |
| showTime | Method  | `time` | Show time with a TextLayer. |
| showTimeLeft | Method  | `timeLeft` | Show time left with a TextLayer. |

| Properties    | Type          | Parameters | Description |
| ------------- | ------------- | ----------- |----------- |
| Slider.wrap    | Method  |  `background, fill, knob`  | Wrap slider logic around 3 layers. |


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

The layers are automatically made part of the same object—and the play and pause interactions are functional by default. 

## Examples
- Play, Pause Example — https://framer.cloud/BsbYC
- Slider Wrapping Example — https://framer.cloud/BlHxd
- Audio Player Example — https://framer.cloud/pHMBF

## More Resources
- W3S Audio DOM Reference — https://www.w3schools.com/tags/ref_av_dom.asp
- MDN Audio Reference — https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio
- MDN Media Events — https://developer.mozilla.org/en-US/docs/Web/Guide/Events/Media_events

---

## Contact
- Follow <a href="https://twitter.com/benjaminnathan">@benjaminnathan</a> on Twitter.
- Follow <a href="https://twitter.com/framer">@framer</a> on Twitter.
