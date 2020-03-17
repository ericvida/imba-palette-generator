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
tag color-code
	@hue = @hues[@index]
	@colorName = "color {@index}"
	def copy
		console.log "copy"
	def render
		<self style="background-color: hsl({@hues[@index]},{@gsat}%,{@glit}%);">
			<input[@colorName]> @colorName
			# TODO: Make button to copy color code
			<button :click.copy()> "copy"
			<code>
			for hsl,i in @hslarray.reverse()
				<p> "--{@colorName}-{i}00:{hsl};"
### css			
color-code {
	background-color: #0f0f0f;
	display: block;
	width: 100%;
	padding: 1rem;
}
h3 {
	color: white;
	margin: 0;
	padding: 0;
}
p {
	color: white;
	margin: 0;
}
###
