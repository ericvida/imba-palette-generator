

let lit = [2,12,22,32,42,52,62,72,82,92,98]
let sat = [70,80,90,100]
tag app-root
	@theme = [
		hue: [270,0,0,0,0]
		name: "indigo"
		sat: [80,88,96,100]
		---
		hue: [300,0,0,0,0]
		name: "pink"
		sat: [80,88,96,100]
		---
		hue: [350,0,0,0,0]
		name: "red"
		sat: [80,88,96,100]
		---
		hue: [20,0,0,0,0]
		name: "orange"
		sat: [80,88,96,100]
		---
		hue: [40,0,3,6,8]
		name: "yellow"
		sat: [90,95,98,100]
		---
		hue: [68,0,0,0,0]
		name: "lime"
		sat: [80,88,96,100]
		---
		hue: [90,0,0,0,0]
		name: "green"
		sat: [80,88,96,100]
		---
		hue: [180,0,0,0,0]
		name: "teal"
		sat: [80,88,96,100]
		---
		hue: [220,0,0,0,0]
		name: "blue"
		sat: [80,88,96,100]
		---
		hue: [250,0,0,0,0]
		name: "purple"
		sat: [80,88,96,100]
	]
	def bg hue, sat, val
		return "background-color: hsl({hue}, {sat}%, {val}%);"
	def s properties
		return "style=\"{properties}\""
	def render
		<self>
			console.log @theme[0].hue
			<style>
				'body, main {'
				"background-color: hsl({@theme[0].hue[0]},{sat[3]}%,{lit[1]}%	);"
				'}'
				'h1 {' 
					"text-align: center;"
					"padding: 2em;"
					"font-weight: bold;"
					"font-family: sans-serif;"
					"text-transform: uppercase;"
					"color: hsl({@theme[0].hue[0]},{sat[3]}%,{lit[9]}%	);"
				'}'
			<h1> "Color Theme"
			<main.cards>
				for item in @theme
					<div.card>
						<span style="{@bg(item.hue[0] - item.hue[1],item.sat[3],lit[10])}">
							<p> "--{item.name}-white: hsl( {item.hue[1]}, {item.sat[3]}%, {lit[10]}% );"
						<span style="{@bg(item.hue[0] - item.hue[1],item.sat[3],lit[9])}">
							<p> "--{item.name}-900: hsl( {item.hue[1]}, {item.sat[3]}%, {lit[9]}% );"
						<span style="{@bg(item.hue[0] - item.hue[1],item.sat[3],lit[8])}">
							<p> "--{item.name}-800: hsl( {item.hue[1]}, {item.sat[3]}%, {lit[8]}% );"
						<span style="{@bg(item.hue[0] - item.hue[1],item.sat[2],lit[7])}">
							<p> "--{item.name}-700: hsl( {item.hue[1]}, {item.sat[2]}%, {lit[7]}% );"
						<span style="{@bg(item.hue[0] - item.hue[1],item.sat[1],lit[6])}">
							<p> "--{item.name}-600: hsl( {item.hue[1]}, {item.sat[1]}%, {lit[6]}% );"
						<span style="{@bg(item.hue[0] - item.hue[1],item.sat[0],lit[5])}">
							<p> "--{item.name}-500: hsl( {item.hue[1]}, {item.sat[0]}%, {lit[5]}% );"
						<span style="{@bg(item.hue[0] - item.hue[2],item.sat[1],lit[4])}">
							<p> "--{item.name}-300: hsl( {item.hue[2]}, {item.sat[1]}%, {lit[4]}% );"
						<span style="{@bg(item.hue[0] - item.hue[2],item.sat[2],lit[3])}">
							<p> "--{item.name}-200: hsl( {item.hue[2]}, {item.sat[2]}%, {lit[3]}% );"
						<span style="{@bg(item.hue[0] - item.hue[3],item.sat[3],lit[2])}">
							<p> "--{item.name}-100: hsl( {item.hue[3]}, {item.sat[3]}%, {lit[2]}% );"
						<span style="{@bg(item.hue[0] - item.hue[4],item.sat[3],lit[1])}">
							<p> "--{item.name}-000: hsl( {item.hue[4]}, {item.sat[3]}%, {lit[1]}% );"
						<span style="{@bg(item.hue[0] - item.hue[4],item.sat[3],lit[0])}">
							<p> "--{item.name}-black: hsl( {item.hue[4]}, {item.sat[3]}%, {lit[0]}% );"
			<section>

### css scoped
:root {
	--space-sm: 10px;
	--space-md: 20px;
}
:root * {
	box-sizing: border-box
}
.cards {
	display: flex;
	flex-wrap: wrap;
	flex-basis: 400px;
	max-width: 2000px;
	margin: 0 auto;
	padding: 10px;
	justify-content:start;
}
.card {
	text-align: center;
	flex: 0 1 calc(33% - 1.3em);
	min-width: 400px;
	display: flex;
	flex-direction: column;
	margin: 10px;
}
.card span {
	padding:5px 20px;
	flex-grow: 1;
	flex-basis: 20px;
}
###
