
let theme = [
	hue: 270
	name: "indigo"
	---
	hue: 300
	name: "pink"
	---
	hue: 350
	name: "red"
	---
	hue: 20
	name: "orange"
	---
	hue: 40
	name: "yellow"
	sat: [70,80,90,100]
	---
	hue: 68
	name: "lime"
	---
	hue: 90
	name: "green"
	---
	hue: 180
	name: "teal"
	---
	hue: 220
	name: "blue"
	---
	hue: 250
	name: "purple"
]
let lit = [2,8,14,26,38,50,62,74,86,98]
let sat = [70,80,90,100]
tag app-root
	def bg hue, sat, val
		return "background-color: hsl({hue}, {sat}%, {val}%);"
	def s properties
		return "style=\"{properties}\""
	def render
		<self>
			<main>
				for item in theme
					<div.theme-card>
						<span style="{@bg(item.hue,sat[3],lit[9])}">
						<span style="{@bg(item.hue,sat[3],lit[8])}">
						<span style="{@bg(item.hue,sat[2],lit[7])}">
						<span style="{@bg(item.hue,sat[1],lit[6])}">
						<span style="{@bg(item.hue,sat[0],lit[5])}">
						<span style="{@bg(item.hue,sat[1],lit[4])}">
						<span style="{@bg(item.hue,sat[2],lit[3])}">
						<span style="{@bg(item.hue,sat[3],lit[2])}">
						<span style="{@bg(item.hue,sat[3],lit[1])}">
						<span style="{@bg(item.hue,sat[3],lit[0])}">
			<section>
				for item in theme
					<h3> item.name
					<p> "--{item.name}-white: hsl({item.hue},{sat[3]},{lit[9]}));"
					<p> "--{item.name}-800: hsl({item.hue},{sat[3]},{lit[8]}));"
					<p> "--{item.name}-700: hsl({item.hue},{sat[2]},{lit[7]}));"
					<p> "--{item.name}-600: hsl({item.hue},{sat[1]},{lit[6]}));"
					<p> "--{item.name}-500: hsl({item.hue},{sat[0]},{lit[5]}));"
					<p> "--{item.name}-300: hsl({item.hue},{sat[1]},{lit[4]}));"
					<p> "--{item.name}-200: hsl({item.hue},{sat[2]},{lit[3]}));"
					<p> "--{item.name}-100: hsl({item.hue},{sat[3]},{lit[2]}));"
					<p> "--{item.name}-000: hsl({item.hue},{sat[3]},{lit[1]}));"
					<p> "--{item.name}-black: hsl({item.hue},{sat[3]},{lit[0]}));"

### css scoped
:root {
	--space-sm: 10px;
	--space-md: 20px;
}
main {
	display: flex;
	justify-content: space-evenly;
}
div.theme-card {
	display: flex;
	flex-direction: column;
	flex-grow: 1;
}
.theme-card span {
	background-color: red;
	flex-grow: 1;
	flex-basis: 80px;
}
###
