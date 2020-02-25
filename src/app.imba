

let lit = 			[2,12,22,42,52,62,72,92,98]
let sat = 			[70,80,90,100]
let satBrights = 	[90,95,98,100]
let satDarks = 		[80,88,96,100]
let litBrights = 	[2,12,22,32,42,49,60,70,78,86,95]
let litDarks = 		[2,12,22,32,42,52,62,72,82,92,98]
tag app-root
	@theme = [
		hue: [293,0,0,0,0,0]
		name: "indigo"
		sat: satDarks
		lit: litDarks
		---
		hue: [339,0,0,0,0,0]
		name: "pink"
		sat: satDarks
		lit: litDarks
		---
		hue: [8,0,0,0,0,0]
		name: "red"
		sat: satDarks
		lit: litDarks
		---
		hue: [26,0,0,0,0,0]
		name: "orange"
		sat: satBrights
		lit: litBrights
		---
		hue: [46,0,4,6,10,15]
		name: "yellow"
		sat: satBrights
		lit: litBrights
		---
		hue: [81,0,0,0,0,0]
		name: "green"
		sat: satDarks
		lit: litBrights
		---
		hue: [165,0,0,0,0,0]
		name: "teal"
		sat: satDarks
		lit: litDarks
		---
		hue: [194,0,0,0,0,0]
		name: "blue"
		sat: satDarks
		lit: litDarks
		---
		hue: [265,0,0,0,0,0]
		name: "purple"
		sat: satDarks
		lit: litDarks
	]
	def bg hue, sat, val
		return "background-color: hsl({hue}, {sat}%, {val}%);"
	def turnOffLights
		@lightsOff = !@lightsOff
		console.log "Lights Off/On"
	# Will return steps between lower and upper values
	# Good for custom saturation of palettes.
	# def lightness lower, upper, steps
	# 	let diff = upper - lower # difference is 10
	# 	let inc = diff / (steps) # steps are 5, of 2ea.
	# 	for step in [lower .. upper] when lower < upper
	# 		lower += inc

	# Will return hue variation steps between middle and shadows
	# for more color rich shadows.
	def hue main, shadow, steps
		let diff = main - shadow
		let inc = diff / (steps)
		for step in [main .. shadow] when shadow
			main += inc
	def render
		<self>
			<style>
				'h1 {' 
					"text-align: center;"
					"padding: 2em;"
					"font-weight: bold;"
					"font-family: sans-serif;"
					"text-transform: uppercase;"
					"color: hsl({@theme[0].hue[0]},{sat[3]}%,{lit[4]}%	);"
				'}'
			<h1.light-switch  :click.@turnOffLights()> "Imba Color Theme Generator"
			<main.cards.lightsOff=@lightsOff>
				for item in @theme
					<color-card color=item>
			<section.results>
				<pre>
					<code>
						':root {'
						for item in @theme
							<color-code color=item>
						'}'
					
tag color-card < div
	def render
		<self.card>
			<input[@color.hue[0]].color-number type="number" min="1" max="360" step="1">
			<span.main-color style="{#context.bg(@color.hue[0] - @color.hue[1],@color.sat[0],@color.lit[5])}">
				<h3> @color.name
			for lightness, i in @color.lit
				<span style="{#context.bg(@color.hue[0], @color.sat[0], lightness)}"> 
					if i is 0
						<p> "{@color.name}-black"
					elif i is 10
						<p> "{@color.name}-white"
					else
						<p> "{@color.name}-{i}00"
tag color-code < code
	<self>
			for lightness, i in @color.lit
				if i is 0
					<p> "--{@color.name}-black: hsl({@color.hue[0]},{@color.sat[0]}%,{lightness}%)"
				elif i is 10
					<p> "--{@color.name}-white: hsl({@color.hue[0]},{@color.sat[0]}%,{lightness}%)"
				else
					<p> "--{@color.name}-{i}00: hsl({@color.hue[0]},{@color.sat[0]}%,{lightness}%)"

### css scoped
html, body {
	padding: 0;
	margin: 0;
}

.light-switch {
	background-color: hsl(265,80%,12%);
	cursor: pointer;
}
.light-switch:hover {
	background-color: hsl(265,80%,22%);
}
.cards {
	display: flex;
	padding: 50px 10px;
	background-color: hsl(265,80%,92%);
	margin: 0;
}
main.lightsOff {
	background-color: hsl(265,80%,2%);
}
.card {
	flex: 0 1 calc(33% - 1.3em);
	display: flex;
	flex-direction: column;
	align-items: center;
}
.card span {
	width: 200px;
	height: 50px;
	border-radius: 0px;
	display: flex;
	align-items: center;
	justify-content: center;
	}
.card input {
	width: 200px;
	padding: 10px;
	background-color: #efefef;
	border: 0;
	text-align: center;
	font-size: 2em;
	color: #2f2f2f;
	font-weight: bold;
}
.dark {
	color: white;
}
.card .main-color {
	width: 200px;
	height: 100px;
}
pre, code {
	margin: 0;
}
code {
	background-color: hsl(265,80%,12%);
	color: hsl(265,80%,92%);
	padding: 40px;
	display: block;
}
###

# Input Number Styles
### css
.color-number {
  position: relative;
}

input[type=number]::-webkit-inner-spin-button,
input[type=number]::-webkit-outer-spin-button
{
  -webkit-appearance: none;
  margin: 0;
}

input[type=number]
{
  -moz-appearance: textfield;
}

.color-number input {
  width: 45px;
  height: 42px;
  line-height: 1.65;
  float: left;
  display: block;
  padding: 0;
  margin: 0;
  padding-left: 20px;
  border: 1px solid #eee;
}

.color-number input:focus {
  outline: 0;
}

.color-number-nav {
  float: left;
  position: relative;
  height: 42px;
}

.color-number-button {
  position: relative;
  cursor: pointer;
  border-left: 1px solid #eee;
  width: 20px;
  text-align: center;
  color: #333;
  font-size: 13px;
  font-family: "Trebuchet MS", Helvetica, sans-serif !important;
  line-height: 1.7;
  -webkit-transform: translateX(-100%);
  transform: translateX(-100%);
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  -o-user-select: none;
  user-select: none;
}

.color-number-button.color-number-up {
  position: absolute;
  height: 50%;
  top: 0;
  border-bottom: 1px solid #eee;
}

.color-number-button.color-number-down {
  position: absolute;
  bottom: -1px;
  height: 50%;
}
###



# CSS RESET
### css
html {
  box-sizing: border-box;
  font-size: 16px;
}

*, *:before, *:after {
  box-sizing: inherit;
}

body, h1, h2, h3, h4, h5, h6, p, ol, ul {
  margin: 0;
  padding: 0;
  font-weight: normal;
}

ol, ul {
  list-style: none;
}

img {
  max-width: 100%;
  height: auto;
}
###
