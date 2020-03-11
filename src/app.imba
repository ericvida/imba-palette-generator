let state =
	gBaseHue: 5
	gColorNum: 9
	gStepNum: 9
	gSat: 80
	gSatDark: 100
	gSatLight: 100
	gLitDark: 10
	gLit: 50
	gLitLight: 90
# class ColorCards
# 	def constructor colorNum
# 		@colorNum = colorNum
# 		@hueList = []
# 		@colorBuilder(colorNum)
# 	def colorBuilder n
# 		@weighted = 80
# 		for i in [0...n]
# 			if i isnt 0
# 				@weighted += (360/@colorNum)
# 				@weighted = Math.floor(@weighted)
# 				@hueList.push(@weighted)
# 			else
# 				@hueList.push(0)
class Color
	def constructor h
		@hue = h
		@sat = state.gSat
		@satDark = state.gSatDark
		@satLight = state.gSatLight
		@lit = state.gLit
		@litDark = state.gLitDark
		@litLight = state.gLitLight
		@colorNum = state.gColorNum
		@colorNumArray = Array.new()
		for item,k in [0...@colorNum]
			@colorNumArray.push(item)
		@stepNum = state.gStepNum
		@stepNumArray = Array.new()
		for item,k in [0...@stepNum]
			@stepNumArray.push(item)
		@calcSat()
		@calcLit()
		@calcHue()
		@collectHsl()
	def calcHue
		# initial hue array
		@hueArray = []
		# figure out step size between lowest hue and highest hue.
		@hueStepSize = (360/@colorNum)
		# push @hueStepSize to @satArray for each time in array.
		@hueArray.push(@hue)
		# push from 
		for step,i in (@colorNumArray)
			@hueArray.push(Math.floor(@hue += @hueStepSize))
		# console.log "hue steps: " + @hueArray
	def calcLit
		# initial saturation Array
		@litArray = []
		# figure out step size between lowest lit and highest lit.
		@litStepSize = (@lit[1]/@stepNum)
		# figureout number of steps between lowest, mid, and high lit.
		@litStepsBetween = Math.floor((@stepNum) / 2)
		@litStepsBetweenArray = Array.new()
		for item,k in [1...@litStepsBetween]
			@litStepsBetweenArray.push(item)
		# figure out step size between low and mid
		@litLowStepSize = ((@lit-@litDark)/@litStepsBetween)
		@litHighStepSize = ((@litLight-@lit)/@litStepsBetween)
		# push @litStepSize to @litArray for each time in array.
		let litIncrement = @litDark
		# push lowest value if less than 2 steps
		if @stepNum > 2
			@litArray.push(litIncrement)

		# for each steps between lowest and highest
		for step in @litStepsBetweenArray
			if @litIncrement isnt @midStep(@stepNum)
				# push val + low step size
				@litArray.push(Math.round(litIncrement += @litLowStepSize))
			# push middle value always
			if @stepNum is @midStep(@stepNum)
				@litArray.push(@lit)
			# for each step between low/mid/high
			if @litIncrement isnt @midStep(@stepNum)
				@litArray.push(Math.round(litIncrement += @litHighStepSize))
		# push highest value if more than 2 steps
		if @stepNum > 2
			@litArray.push(Math.round(litIncrement += @litHighStepSize))
			@litArray.push(Math.round(litIncrement += @litHighStepSize))
		# console.log "lightness array: " + @litArray

	def calcSat
		# initial saturation Array
		# console.log state.gStepNum
		@satArray = []
		# figure out step size between lowest sat and highest sat.
		@satStepSize = (@sat[1])
		# figureout number of steps between lowest, mid, and high sat.
		@satStepsBetween = Math.floor((@stepNum) / 2)
		@satStepsBetweenArray = Array.new()
		for item,k in [0...@satStepsBetween]
			@satStepsBetweenArray.push(item)
		# figure out step size between low and mid
		@satLowStepSize = ((@satDark-@sat)/@satStepsBetween)
		@satHighStepSize = ((@satLight-@sat)/@satStepsBetween)
		# ==
		# push @satDark to satIncrement
		let satIncrement = @satDark
		# push lowest value if less than 2 steps
		if @stepNum > 2
			@satArray.push(satIncrement)
		# for each steps between lowest and highest
		for step in @satStepsBetweenArray
			# push val + low step size
			@satArray.push(Math.round(satIncrement -= @satLowStepSize))
		# push middle value always
		@satArray.push(@sat)
		# for each step between low/mid/high
		for step in @satStepsBetweenArray
			@satArray.push(Math.round(satIncrement += @satHighStepSize))
		# push highest value if more than 2 steps
		if @stepNum > 2
			@satArray.push(Math.round(@satLight))
		# console.log "saturation array: " + @satArray
	
	def calcHsl v
		# create hsl Array
		@hslArray = []
		# for each number of Steps
		for hue,i in @stepNumArray
			# push hsl string
			@hslArray.push("hsl({@hueArray[v]},{@satArray[i]}%,{@litArray[i]}%)")
		return @hslArray

	def collectHsl
		# create collection array
		@hslCollection = []
		# for each number of Colors
		for card,i in @colorNumArray
			# add hslArray to collection
			@hslCollection.push(@calcHsl(card))
		# console.log @hslCollection
	def isOdd num
		return num % 2
	def isBiggerThanTwo num
		return num > 2
	def midStep
		if @isOdd(@stepNum)
			"It's Odd"
		if @isBiggerThanTwo(@stepNum)
			"+3"
		if @isOdd(@stepNum) and @isBiggerThanTwo(@stepNum)
			return Math.floor(@stepNum/2)+1
		else
			return 1


# TODO: Make number of cards Dynamic
# TODO: Make function default color value dynamic based on number of Cards.
import './tags/color-card'
import './tags/imba-credit'
tag app-root
	@blackWhite = true
	@state = state
	def toggleBW
		@blackWhite = !@blackWhite
	def render
		let colors = Color.new state.gBaseHue
		# let colors = ColorCard.new numOfColors
		<self.main>
			<aside>
				console.log colors.midStep()
				<h3> "Eric's Color Themer"
				<div.controls-group>
					<span> "{state.gBaseHue} Base Hue"
					<input[state.gBaseHue].slider type="range" min=1 max=360> 
				<div.controls-group>
					<span> "{state.gColorNum} colors"
					<input[state.gColorNum].slider type="range" min=1 max=15> 
				<div.controls-group>
					<span> "{state.gStepNum} color steps"
					<input[state.gStepNum].slider type="range" min=3 max=11 step=2> 
				<div.controls-group>
					<span> "dark saturation {state.gSatDark} "
					<input[state.gSatDark].slider type="range" min=0 max=100 step=1>
				<div.controls-group>
					<span> "median saturation {state.gSat}"
					<input[state.gSat].slider type="range" min=0 max=100 step=1>
				<div.controls-group>
					<span> "light saturation {state.gSatLight}"
					<input[state.gSatLight].slider type="range" min=50 max=100 step=1>
				<div.controls-group>
					<span> "lightness darkest {state.gLitDark}"
					<input[state.gLitDark].slider type="range" min=0 max=50 step=1>
				<div.controls-group>
					<span> "median lightness {state.gLit}"
					<input[state.gLit].slider type="range" min=0 max=100 step=1>
				<div.controls-group>
					<span> "light lightness {state.gLitLight}"
					<input[state.gLitLight].slider type="range" min=5 max=50 step=1>
				# <button.bw-toggle :click.toggleBW()> "Toggle Black & White"
				<imba-credit>
			<section.card-container>
				for hslArray,i in colors.hslCollection
					<color-card bind:colors=colors bind:i=i bind:steps=colors.stepNum hues=colors.hueArray bind:sats=colors.satArray bind:lits=colors.litArray hsl=hslArray bind:bw=@blackWhite>
### css
@import url('https://fonts.googleapis.com/css?family=Open+Sans|Titillium+Web:700&display=swap');
body {
	background-color: #efefef;
	padding: 0;
	margin: 0;
	font-family: 'Open Sans', sans-serif;
}
.main {
	display: flex;
}

aside {
	flex: 0 0 150px;
	padding: 0 20px;
	background-color: white;
	min-height: 100vh;
	position: relative;
	font-size: .6em;
}
aside h3 {
	font-family: 'Titillium Web', sans-serif;
	font-weight: bold;
}
.controls-group {
	margin: 0 auto;
	display: flex;
	flex-direction: column;
	justify-content: center;
}
.card-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
	align-content: flex-start;
	background-color: #efefef;
	padding: 10px;
	flex-grow: 1;
}
.bw-toggle {
	width: 100%;
	padding: 10px;
	border: none;
	border-radius: 5px;
	font-weight: bold;
	background-color: hsl(240,100%,86%);
	border-bottom: 4px solid hsl(240,70%,76%);
	transform: translateY(0px);
}
.bw-toggle:hover {
	background-color: hsl(240,100%,90%);
	border-bottom: 6px solid hsl(240,70%,80%);
	transform: translateY(-2px);
}
.bw-toggle:active {
	background-color: hsl(240,100%,86%);
	border-bottom: 0;
	border-top: 6px solid hsl(240,70%,76%);
	transform: translateY(-2px);

}

###

### css
.slider {
	margin: 10px 0 20px;
	-webkit-appearance: none;
	width: 100%;
	height: 15px;
	border-radius: 5px;  
	background: #d3d3d3;
	outline: none;
	opacity: 0.7;
	-webkit-transition: .2s;
	transition: opacity .2s;
}

.slider::-webkit-slider-thumb {
	-webkit-appearance: none;
	appearance: none;
	width: 25px;
	height: 25px;
	border-radius: 50%; 
	background: hsla(240,90%,64%,1);
	cursor: pointer;
}

.slider::-moz-range-thumb {
	width: 25px;
	height: 25px;
	border-radius: 50%;
	background: hsla(240,90%,64%,1);
	cursor: pointer;
}
###
