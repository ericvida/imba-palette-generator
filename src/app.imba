import {bghsl,chsl,c} from './tags/utils.imba'
let numOfColors = 9
let numOfShades = 9
class ColorCard
	def constructor colorNum
		@colorNum = colorNum
		@hueList = []
		@colorBuilder(colorNum)
	def colorBuilder n
		@weighted = 0
		for i in [0...n]
			if i isnt 0
				@weighted += (360/@colorNum)
				@weighted = Math.floor(@weighted)
				@hueList.push(@weighted)
			else
				@hueList.push(0)

# TODO: Make number of cards Dynamic
# TODO: Make function default color value dynamic based on number of Cards.

import './tags/color-card'
import './tags/imba-credit'

tag app-root
	def render
		let colors = ColorCard.new numOfColors
		<self.main>
			<aside>
				<h3> "Global Settings"
				<div.controls-group>
					<span> "{numOfColors} colors"
					<input[numOfColors].slider type="range" min=1 max=9> 
				<div.controls-group>
					<span> "{numOfShades+1} shades"
					<input[numOfShades].slider type="range" min=0 max=10 step=2> 
				<imba-credit>
			<section.card-container>
				
				for card in [0...colors.colorNum]
					<color-card hue="{colors.hueList[card]}" shadesnum=numOfShades>
					




### css	
body {
	background-color: #efefef;
	padding: 0;
	margin: 0;
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
	background: hsla(251,90%,64%,1);
	cursor: pointer;
}

.slider::-moz-range-thumb {
	width: 25px;
	height: 25px;
	border-radius: 50%;
	background: hsla(251,90%,64%,1);
	cursor: pointer;
}
###
