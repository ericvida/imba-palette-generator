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
	gHueArray: []
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
		@calcHsl()
		@collectHsl()
	def calcHue
		# initial hue array
		@hueArray = []
		# figure out step size between lowest hue and highest hue.
		@hueStepSize = (360/@colorNum)
		# create hue Increment variable and set initial value to @hue
		let hueIncrement = @hue
		# push initial value to @hueArray
		@hueArray.push(hueIncrement)
		# push @hueStepSize to @hueArray for each time in array.
		for step,i in (@colorNumArray)
			@hueArray.push(Math.floor(hueIncrement += @hueStepSize))
		# console.log "hue steps: " + @hueArray
		state.gHueArray = @hueArray
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
		# call litStep variable and set starting point to litDark val
		let litStep = @litDark
		# push default litStep value if less than 2 steps
		if @stepNum > 2
			@litArray.push(litStep)

		# for each steps between lowest and highest
		for step in @litStepsBetweenArray
			# if step is not the mid step of shades array.
			if @litIncrement isnt @midStep(@stepNum)
				# push val + low step size
				@litArray.push(Math.round(litStep += @litLowStepSize))
			# push middle value always
			if @stepNum is @midStep(@stepNum)
				@litArray.push(@lit)
			# for each step between low/mid/high
			if @litIncrement isnt @midStep(@stepNum)
				@litArray.push(Math.round(litStep += @litHighStepSize))
		# push highest value if more than 2 steps
		if @stepNum > 2
			@litArray.push(Math.round(litStep += @litHighStepSize))
			@litArray.push(Math.round(litStep += @litHighStepSize))
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
	
	# // TODO: make hslArray customizable from the card.
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
			# add hslArray to collectionArray
			@hslCollection.push(calcHsl(card))
		# console.log @hslCollection
	# is value odd
	def isOdd num
		# returns true or false
		return num % 2
	# is num larger than two
	def isBiggerThanTwo num
		# return true or false
		return num > 2
	# return
	def midStep
		if @isOdd(@stepNum)
			"It's Odd"
		if @isBiggerThanTwo(@stepNum)
			"+3"
		if @isOdd(@stepNum) and @isBiggerThanTwo(@stepNum)
			return Math.floor(@stepNum/2)+1
		else
			return 1
import './tags/color-card'
import './tags/color-code'
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
				<h3> "Imba Theme Generator"
				<div.control>
					<span> "number of colors "
					<span> "{state.gColorNum}"
				<input[state.gColorNum].slider type="range" min=1 max=15> 
				<div.control>
					<span> "First Hue's Value "
					<span> "{state.gBaseHue}°"
				<input[state.gBaseHue].slider type="range" min=1 max=360> 
				<div.control>
					<span> "Number of shades "
					<span> "{state.gStepNum}"
				<input[state.gStepNum].slider type="range" min=3 max=11 step=2> 
				<div.control>
					<span> "saturation of brights "
					<span> "{state.gSatLight}%"
				<input[state.gSatLight].slider type="range" min=0 max=100 step=1>
				<div.control>
					<span> "saturation of middle "
					<span> "{state.gSat}%"
				<input[state.gSat].slider type="range" min=0 max=100 step=1>
				<div.control>
					<span> "saturation of darks "
					<span> "{state.gSatDark}%"
				<input[state.gSatDark].slider type="range" min=0 max=100 step=1>
				<div.control>
					<span> "brightness of brights "
					<span> "{state.gLitLight}%"
				<input[state.gLitLight].slider type="range" min=state.gLit max=100 step=1>
				<div.control>
					<span> "brightness of middle "
					<span> "{state.gLit}%"
				<input[state.gLit].slider type="range" min=state.gLitDark max=state.gLitLight step=1>
				<div.control>
					<span> "brightness of darks "
					<span> "{state.gLitDark}%"
				<input[state.gLitDark].slider type="range" min=0 max=state.gLit step=1>
				<button.bw-toggle :click.toggleBW()> "Toggle Black & White"
				<imba-credit>
			<main>
				<section.card-container>
					for hslArray,i in colors.hslCollection
						<color-card i=i hues=colors.hueArray hue=state.gHueArray[i] hslarray=hslArray gsat=state.gSat glit=state.gLit gsatdark=state.gSatDark>
				# <section.code-container>
				# 	for hslArray,index in colors.hslCollection
				# 		<color-code index=index hues=colors.hueArray hue=state.gHueArray[i] hslarray=hslArray gsat=state.gSat glit=state.gLit>
### css
@import url('https://fonts.googleapis.com/css?family=Open+Sans|Titillium+Web:700&display=swap');
body {
	background-color: #efefef;
	padding: 0;
	margin: 0;
	font-family: 'Open Sans', sans-serif;
}
app-root {
	display: flex;
}
aside {
	flex: 0 0 150px;
	padding: 0 20px;
	background-color: white;
	min-height: 100vh;
	position: relative;
	font-size: .6rem;
}
aside h3 {
	font-family: 'Titillium Web', sans-serif;
	font-weight: bold;
	font-size: .9rem;
}
main {
	flex: 1 1 auto;
}
.control {
	margin: 0 auto;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}
.card-container {
	display: grid;
	gap: 1rem;
	padding: 20px;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	height: max-content;
	background-color: #efefef;
}
.code-container {
	display: block;
	width: 100%;
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
