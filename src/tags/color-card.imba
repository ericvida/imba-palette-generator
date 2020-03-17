import {bg,bghsl, chsl, c} from './utils.imba'
# class ColorShades
# 	def constructor shadeNum
# 		@shadeNum = shadeNum
# 		@shadeList = []
# 		@shadeBuilder(@shadeNum)
# 	def shadeBuilder n
# 		@weighted = 0
# 		for i in [1...n]
# 			if i isnt 0
# 				@weighted += (100/@shadeNum)
# 				@weighted = Math.floor(@weighted)
# 				@shadeList.push(@weighted)
# 			else
# 				@shadeList.push(0)
# tag color-card-old
# 	def render
# 		let shades = ColorShades.new @shadesnum
# 		<self>
# 			<span> "{@data.hue} hue"
# 			<input[@hue].slider type="range" min=0 max=360>
# 			<span> "{@shadesnum + 1} shades"
# 			<input[@shadesnum].slider type="range" min=2 max=11>
# 			<div.color-preview style="background-color: hsl({@hue},100%,50%);">
# 				<h1> "{@hue}"
# 			<div.shades>
# 				if @bw
# 					<span.shade style="{bghsl(@hue,80,5)} {chsl(100,100,100)}"> "black"
# 				for shade in [...shades.shadeList]
# 					if shade > 34
# 						<span.shade style="{bghsl(@hue,80,shade)}"> shade
# 					else
# 						<span.shade style="{bghsl(@hue,80,shade)} {c("white")}"> shade
# 				if @bw
# 					<span.shade style="background-color: hsl({@hue},80%,97%);"> "white"
tag color-card
	def render
		<self>
			<div.color-preview style="background-color: hsl({@hue},{@gsat}%,{@glit}%);"> 
				<b> @hue+"°"
			# TODO: Add support for slider to tweak color of each card.
			# <input[@hue].slider type="range" min=glit max=100 step=1>
			<div.shades>
				for hsl,i in @hslarray.reverse()
					<span.shade style="background-color:{hsl}; color: hsl({@hue},{@gsat}%,8%);"> "{hsl}"
### css				
color-card {
	background-color: #fff;
	border-radius: 5px;
	padding: 10px;
	height: auto;
	text-align: center;
}
color-card input {
	width: 100%;
}
.color-preview {
	padding: 20px 0;
	text-align: center;
	border-radius: 5px 5px 0 0;
}
.shades {
	display: flex;
	flex-direction: column;
}
.shades span.shade {
	padding: 5px;
	text-align: center;
}
.shades span:last-child {
	border-radius: 0 0 5px 5px;
	color: #5f5f5f;
}
###
