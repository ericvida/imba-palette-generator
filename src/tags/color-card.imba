import {bghsl, chsl, c} from './utils.imba'
class ColorShades
	def constructor shadeNum
		@shadeNum = shadeNum
		@shadeList = []
		@shadeBuilder(@shadeNum)
	def shadeBuilder n
		@weighted = 0
		for i in [1...n]
			if i isnt 0
				@weighted += (100/@shadeNum)
				@weighted = Math.floor(@weighted)
				@shadeList.push(@weighted)
			else
				@shadeList.push(0)
tag color-card
	def render
		let shades = ColorShades.new @shadesnum
		<self>
			<span> "{@hue} hue"
			<input[@hue].slider type="range" min=0 max=360>
			<span> "{@shadesnum + 1} shades"
			<input[@shadesnum].slider type="range" min=2 max=11>
			<div.color-preview style="background-color: hsl({@hue},80%,60%);">
				<h1> "{@hue}"
			<div.shade-container>
				<span.shade style="{bghsl(@hue,80,5)} {chsl(100,100,100)}"> "black"
				for shade in [...shades.shadeList]
					if shade > 34
						<span.shade style="{bghsl(@hue,80,shade)}"> shade
					else
						<span.shade style="{bghsl(@hue,80,shade)} {c("white")}"> shade
				<span.shade style="background-color: hsl({@hue},80%,97%);"> "white"
				
### css
color-card {
	flex-basis: 1fr;
	background-color: #fff;
	border-radius: 5px;
	margin-bottom: 20px;
	padding: 10px;
	min-width: 100px;
	max-width: 200px;
	text-align:center;
}
color-card input {
	width: 100%;
}
.color-preview {
	padding: 10px;
	text-align: center;
}
.shade-container {
	display: flex;
	flex-direction: column-reverse;
}
.shade-container span {
	padding: 5px;
	text-align: center;
}
###
