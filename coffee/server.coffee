sys = require 'sys'
fs = require 'fs'
url = require 'url'
http = require 'http'

http.createServer( ( req, res ) ->
  _url = url.parse( ".#{ req.url }" ).pathname
  method = req.method
  data = null
  
  req.addListener 'data', ( d ) ->
    data = d.toString()
    
  req.addListener 'end', ->
    if data? and method isnt 'GET'
      res.writeHead 200, { 'Content-Type': 'application/json' }
      #processData data, method, res
    else
      res.writeHead 200, { 'Content-Type': 'text/html' }
      stats = fs.statSync url
      if stats.isDirectory()
        url = url + '/index.html'
        url = url.replace '//', '/'
        res.end fs.readFileSync url
      else
        res.end fs.readFileSync url
      
).listen( 8000 ) # createServer

console.log 'server listening on port 8000'