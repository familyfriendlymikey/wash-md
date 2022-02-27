const port = 8080

import http from 'http'
import { WebSocketServer } from 'ws'
import { marked } from 'marked'
import fs from 'fs'
import open from 'open'
import ghcss from './ghcss'

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
	res.write(get_content!)
	res.end!

const wss = new WebSocketServer({ server:server })

def get_content
	"""
		<html>
			<script>
				const socket = new WebSocket('ws://localhost:{port}')
				socket.addEventListener('message', function (event) \{
					location.reload()
				\})
			</script>
			<body class="markdown-body">{marked(fs.readFileSync(infile, "utf8"))}</div>
			<style>{ghcss}</style>
		</html>
	"""

wss.on('connection') do |ws|
	fs.watchFile(infile, {"interval": 100} do ws.send('md'))

server.listen(port) do
	open("http://localhost:{port}")
