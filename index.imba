const port = 8087
const url = "http://localhost:{port}"

const { WebSocketServer } = require 'ws'
const { marked } = require 'marked'
const fs = require 'fs'
const ghcss = require './ghcss'
const { watch } = require 'chokidar'

const server = require('http').createServer! do |req, res|
	res.statusCode = 200
	res.setHeader('Content-Type', 'text/html')
	res.write """
		<html>
			<style>
				{ghcss}
			</style>
			<script>
				const socket = new WebSocket("ws://localhost:{port}")
				socket.addEventListener('message', function (event) \{
					document.body.innerHTML = event.data
				\})
			</script>
			<body class="markdown-body"></body>
		</html>
	"""
	res.end!

const wss = new WebSocketServer({ server })

wss.on('connection') do |ws|
	console.log "Socket connected, watching current dir at {url}."
	watch('**/*.md').on('change') do |path|
		ws.send(marked(fs.readFileSync(path, "utf8")))

server.listen(port)
