const port = 3000

import express from 'express'
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

const app = express()
const server = require('http').createServer(app);
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

app.get('/', do(req, res) res.send(get_content!))

server.listen(port) do
	open("http://localhost:{port}")
