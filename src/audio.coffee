# Framer Audio Module
# By Benjamin den Boer
# Contents: Slider and Audio Class
# Follow me at @benjaminnathan
# Follow Framer at @framer

Events.SliderValueChange  = "sliderValueChange"

class exports.Slider extends Layer

	constructor: (options={}) ->
		super options

	@_knob = undefined
	@_fill = undefined
	@_background = undefined

	_touchStart: (event) =>
		event.preventDefault()

		if @_background.width > @_background.height
			touchX = Events.touchEvent(event).clientX - Screen.canvasFrame.x
			scaleX = @canvasScaleX()
			@value = @valueForPoint(touchX / scaleX - @x)
		else
			touchY = Events.touchEvent(event).clientY - Screen.canvasFrame.y
			scaleY = @canvasScaleY()
			@value = @valueForPoint(touchY / scaleY - @y)

		@_knob.draggable._touchStart(event)
		@_updateValue()

	_touchEnd: (event) =>
		@_updateValue()

	_updateFill: =>
		if @_background.width > @_background.height
			@_fill.width = @_knob.midX
		else
			@_fill.height = @_knob.midY

	_updateKnob: =>
		if @_background.width > @_background.height
			@_knob.midX = @_fill.width
			@_knob.centerY()
		else
			@_knob.midY = @_fill.height
			@_knob.centerX()

	_updateFrame: =>
		@_knob.draggable.constraints =
			x: -knob.width / 2
			y: -knob.height / 2
			width: @_background.width + @_knob.width
			height: @_background.height + @_knob.height

		if @constrained
			@_knob.draggable.constraints =
				x: 0
				y: 0
				width: @_background.width
				height: @_background.height

		if @_background.width > @_background.height
			@_fill.height = @_background.height
			@_knob.midX = @pointForValue(@value)
			@_knob.centerY()
		else
			@_fill.width = @_background.width
			@_knob.midY = @pointForValue(@value)
			@_knob.centerX()

		if @_background.width > @_background.height
			@_knob.draggable.speedY = 0
			@_knob.draggable.speedX = 1
		else
			@_knob.draggable.speedX = 0
			@_knob.draggable.speedY = 1

	addBackgroundLayer: (layer) ->
		@_background = layer
		@_background.parent = @
		@_background.name = "background"
		@_background.x = @_background.y = 0
		return @_background

	addFillLayer: (layer) ->
		@_fill = layer
		@_fill.parent = @
		@_fill.name = "fill"
		@_fill.x = @_fill.y = 0
		@_fill.width = @width / 2
		return @_fill

	addKnobLayer: (layer) ->
		@_knob = layer
		@_knob.parent = @
		@_knob.name = "knob"
		@_knob.draggable.enabled = true
		@_knob.draggable.overdrag = false
		@_knob.draggable.momentum = true
		@_knob.draggable.momentumOptions = {friction: 5, tolerance: 0.25}
		@_knob.draggable.bounce = false
		@_knob.x = Align.center()
		@_knob.y = Align.center()

		return @_knob

	@define "constrained", @simpleProperty("constrained", false)

	@define "min",
		get: -> @_min or 0
		set: (value) ->
			@_min = value if _.isFinite(value)
			@emit("change:min", @_min)

	@define "max",
		get: -> @_max or 1
		set: (value) ->
			@_max = value if _.isFinite(value)
			@emit("change:max", @_max)

	@define "value",
		get: -> return @_value
		set: (value) ->
			return unless _.isFinite(value)

			@_value = Utils.clamp(value, @min, @max)

			if @_background.width > @_background.height
				@_knob.midX = @pointForValue(value)
			else
				@_knob.midY = @pointForValue(value)

			@_updateFill()
			@_updateValue()

	_knobDidMove: =>
		if @_background.width > @_background.height
			@value = @valueForPoint(@_knob.midX)
		else
			@value = @valueForPoint(@_knob.midY)

	_updateValue: =>
		return if @_lastUpdatedValue is @value

		@_lastUpdatedValue = @value
		@emit("change:value", @value)
		@emit(Events.SliderValueChange, @value)

	pointForValue: (value) ->
		if @_background.width > @_background.height
			if @constrained
				return Utils.modulate(value, [@min, @max], [0 + (@_knob.width / 2), @_background.width - (@_knob.width / 2)], true)
			else
				return Utils.modulate(value, [@min, @max], [0, @_background.width], true)
		else
			if @constrained
				return Utils.modulate(value, [@min, @max], [0 + (@_knob.height / 2), @_background.height - (@_knob.height / 2)], true)
			else
				return Utils.modulate(value, [@min, @max], [0, @_background.height], true)

	valueForPoint: (value) ->
		if @_background.width > @_background.height
			if @constrained
				return Utils.modulate(value, [0 + (@_knob.width / 2), @_background.width - (@_knob.width / 2)], [@min, @max], true)
			else
				return Utils.modulate(value, [0, @_background.width], [@min, @max], true)
		else
			if @constrained
				return Utils.modulate(value, [0 + (@_knob.height / 2), @_background.height - (@_knob.height / 2)], [@min, @max], true)
			else
				return Utils.modulate(value, [0, @_background.height], [@min, @max], true)

	# New Constructor
	@wrap = (background, fill, knob, options) ->
		return wrapSlider(new @(options), background, fill, knob, options)

	onValueChange: (cb) -> @on(Events.SliderValueChange, cb)

wrapSlider = (instance, background, fill, knob) ->

	if not (background instanceof Layer)
		throw new Error("AudioLayer expects a background layer.")

	if not (fill instanceof Layer)
		throw new Error("AudioLayer expects a fill layer.")

	if not (knob instanceof Layer)
		throw new Error("AudioLayer expects a knob layer.")

	slider = instance

	slider.clip = false
	slider.backgroundColor = "transparent"
	slider.frame = background.frame
	slider.parent = background.parent
	slider.index = background.index

	slider.addBackgroundLayer(background)
	slider.addFillLayer(fill)
	slider.addKnobLayer(knob)

	slider._updateFrame()
	slider._updateKnob()
	slider._updateFill()
	slider._knobDidMove()

	background.onTapStart ->
		slider._touchStart(event)

	slider.on "change:frame", ->
		slider._updateFrame()

	knob.on "change:size", ->
		slider._updateKnob()

	knob.on "change:frame", ->
		slider._updateFill()
		slider._knobDidMove()

	slider.on "change:max", ->
		slider._updateFrame()
		slider._updateKnob()
		slider._updateFill()
		slider._knobDidMove()

	return slider

class exports.Audio extends Layer

	constructor: (options={}) ->
		options.backgroundColor ?= "transparent"

		# Define player
		@player = document.createElement("audio")
		@player.setAttribute("webkit-playsinline", "true")
		@player.setAttribute("preload", "auto")

		@player.on = @player.addEventListener
		@player.off = @player.removeEventListener

		@_time = false

		super options

		# On click
		@onClick ->
			currentTime = Math.round(@player.currentTime)
			duration = Math.round(@player.duration)

			if @player.paused
				@player.play()
				if @_pauseControl then @_playControl.visible = false
				@_pauseControl?.visible = true

				if currentTime is duration
					@player.currentTime = 0
					@player.play()
			else
				@player.pause()
				@_playControl.visible = true
				@_pauseControl?.visible = false

		@player.onplaying = =>
			if @_pauseControl then @_playControl.visible = false
			@_pauseControl?.visible = true

		@player.onended = =>
			@_playControl.visible = true
			@_pauseControl?.visible = false


		# Utils
		@player.formatTime = ->
			sec = Math.floor(@currentTime)
			min = Math.floor(sec / 60)
			sec = Math.floor(sec % 60)
			sec = if sec >= 10 then sec else '0' + sec
			return "#{min}:#{sec}"

		@player.formatTimeLeft = ->
			sec = Math.floor(@duration) - Math.floor(@currentTime)
			min = Math.floor(sec / 60)
			sec = Math.floor(sec % 60)
			sec = if sec >= 10 then sec else '0' + sec
			return "#{min}:#{sec}"

		@audio = options.audio
		@_element.appendChild(@player)

	@define "audio",
		get: -> @player.src
		set: (audio) ->
			@player.src = audio
			if @player.canPlayType("audio/mp3") == ""
				throw Error "No supported audio file included."

	# Attach a layer to the Audio object
	addPlayLayer: (layer) ->
		@_playControl = layer
		@_playControl.parent = @
		@_playControl.name = "play"
		@_playControl.clip = true

		return @_playControl

	addPauseLayer: (layer) ->
		@_pauseControl = layer
		@_pauseControl.parent = @
		@_pauseControl.name = "pause"
		@_pauseControl.clip = true
		@_pauseControl.visible = false

		return @_pauseControl

	getTime: (layer) ->
		if not (layer instanceof TextLayer)
			throw new Error("AudioLayer expects a text layer.")

		layer.text = "0:00"

		@_time = layer

	getTimeLeft: (layer) =>
		# Set timeLeft
		layer.text = "-0:00"

		@_timeLeft = layer

		@player.on "loadedmetadata", =>
			@_timeLeft.text = "-" + @player.formatTimeLeft()

	setProgress: (layer, knob) ->

		@player.oncanplay = =>
			layer.max = Math.round(@player.duration)

		knob.draggable.momentum = false

		# Check if the player was playing
		wasPlaying = isMoving = false
		unless @player.paused then wasPlaying = true

		layer.on "change:value", =>
			if isMoving
				@player.currentTime = layer.value

			if @_time
				@_time.text = @player.formatTime()
			if @_timeLeft
				@_timeLeft.text = "-" + @player.formatTimeLeft()

		layer.onTapStart =>
			@player.currentTime = layer.value
		knob.onDragMove =>
			isMoving = true

		knob.onDragEnd (event) =>
			currentTime = Math.round(@player.currentTime)
			duration = Math.round(@player.duration)

			if wasPlaying and currentTime isnt duration
				@player.play()

			if currentTime is duration
				@player.pause()
				@_playControl.visible = true
				@_pauseControl?.visible = false

			return isMoving = false

		# Update Progress
		@player.ontimeupdate = =>

			unless isMoving
				knob.midX = layer.pointForValue(@player.currentTime)
				# layer.value = layer.valueForPoint(knob.midX)
				isMoving = false

			if @_time
				@_time.text = @player.formatTime()
			if @_timeLeft
				@_timeLeft.text = "-" + @player.formatTimeLeft()

	setVolume: (layer, knob) ->

		# Set default to 75%
		@player.volume ?= 0.75

		layer.min = 0
		layer.max = 1
		layer.value = @player.volume

		knob.draggable.momentum = false

		layer.on "change:value", =>
			@player.volume = layer.value

	showProgress: (layer, knob) ->
		return @setProgress(layer, knob)

	showVolume: (layer, knob) ->
		return @setVolume(layer, knob)

	showTime: (layer) ->
		return @getTime(layer)

	showTimeLeft: (layer) ->
		return @getTimeLeft(layer)

	@wrap = (layerA, layerB, options) ->
		return wrapLayer(new @(options), layerA, layerB, options)

wrapLayer = (instance, layerA, layerB) ->

	if not (layerA instanceof Layer)
		throw new Error("AudioLayer expects a layer, not #{layerA}. Are you sure the layer exists?")

	play = instance
	play.frame = layerA.frame
	play.parent = layerA.parent
	play.index = layerA.index
	layerA.x = layerA.y = 0

	if layerB
		layerB.x = layerB.y = 0
		play.addPauseLayer(layerB)

	play.addPlayLayer(layerA)

	return play