const port = 8080
const url = "http://localhost:{port}"

import { WebSocketServer } from 'ws'
import { marked } from 'marked'
import fs from 'fs'
import ghcss from './ghcss'
import { watch } from 'chokidar'

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

server.listen(port) do
	require('open')(url)
