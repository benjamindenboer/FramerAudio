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
 <p align="center"><a href="https://youtu.be/KCeOa9F3L9A">Watch the video.</a></p>
</p>
<br>

## Overview
All included properties and methods.


| Properties    | Type          | Parameters | Description |
| ------------- | ------------- | ----------- |----------- |
| Audio.wrap    | Method  |  `play, pause`  | Wrap audio object around 2 layers. |
| audio   | String  |   | Source of the audio file. |
| showProgress   | Method  | `slider, knob` | Wrap progress logic around 2 layers. |
| showVolume  | Method  | `slider, knob` | Wrap volume logic around 2 layers. |
| showTime | Method  | `time` | Display current time with a TextLayer. |
| showTimeLeft | Method  | `timeLeft` | Display time left with a TextLayer. |

Also included: the `Slider.wrap` method.

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

---

## Volume & Progress Sliders
If you’d like to add volume or progress sliders, you’ll either need to define a [SliderComponent in Code](https://framer.com/docs/?utm_source=github&utm_medium=link&utm_campaign=framer_audio_benjamin#slider.slidercomponent), or use the included `Slider.wrap` method. 

```
# Slider via Code
slider = new SliderComponent

# Slider via Design
slider = Slider.wrap(bg, fill, knob)
```

The `Slider.wrap` method takes three parameters:
- `background` — The background layer of the slider.
- `fill` — The fill layer of the slider.
- `knob` – The knob layer of the slider.

All of these can be styled completely in the design. The method wraps a component around these 3 layers to handle all of the sliding functionality for you.

Once you have set-up a slider, you can make it reflect the **progress** or the **volume**.

- `showProgress(layer)` — adjust audio track progress.
- `showVolume(layer)` — adjust audio track volume.

```
# Show and edit audio progress 
audio.showProgress(slider)

# Show and edit audio volume 
audio.showVolume(slider)
```

---

## Examples
- **[Play, Pause](https://framer.cloud/BsbYC)**. Two artboards, one Audio object.
- **[Slider Wrapping](https://framer.cloud/BlHxd).** From 3 layers in Design to an interactive slider in Code.
- **[Audio Player](https://framer.cloud/pHMBF)**. With current time, duration and progress sliding.

## More Resources
- [W3S Audio DOM Reference](https://www.w3schools.com/tags/ref_av_dom.asp).
- [MDN Audio Reference](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/audio).
- [MDN Media Events](https://developer.mozilla.org/en-US/docs/Web/Guide/Events/Media_events).

---

## Contact
- Follow me on Twitter <a href="https://twitter.com/benjaminnathan">@benjaminnathan</a>.
- Follow <a href="https://twitter.com/framer">@framer</a> on Twitter.
