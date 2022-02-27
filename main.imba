const port = 8080
const url = "http://localhost:{port}"

import http from 'http'
import { WebSocketServer } from 'ws'
import { marked } from 'marked'
import fs from 'fs'
import open from 'open'
import ghcss from './ghcss'
import { watch } from 'chokidar'

let p = console.log

if process.argv.length !== 3
	if process.argv.length < 3
		p "No argument provided."
	else
		p "Too many arguments."
	process.exit()

let infile = process.argv[2]

unless fs.existsSync(infile)
	p "File does not exist."
	process.exit()

const server = http.createServer! do |req, res|
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
	p "Socket connected, watching {infile} at {url}."
	watch(infile).on('all') do
		ws.send(marked(fs.readFileSync(infile, "utf8")))

server.listen(port) do
	open(url)
