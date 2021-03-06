
http    = require 'http'
opts    = hostname:'api.openweathermap.org'
imgPath = 'http://openweathermap.org/img/w/'
def     = ''

exports.defaults = (cfg) ->
  objs = []
  objs.push "#{i}=#{n}" for i,n of cfg  
  def = objs.join '&'

exports.find = (cfg, cb) ->
  opts.path = "/data/2.5/find?#{buildPath(cfg)}"

  getWeather opts, (json) ->
    if json.cod==200
      item.weather[0].iconUrl = "#{imgPath}#{item.weather[0].icon}.png" for item in json.list
    cb json  


exports.now = (cfg, cb) ->
  opts.path = "/data/2.5/weather?#{buildPath(cfg)}"
  
  getWeather opts, (json) ->
    if json.code==200
      json.weather[0].iconUrl = "#{imgPath}#{json.weather[0].icon}.png"
    cb json


exports.forecast = (cfg, cb) ->
  opts.path = "/data/2.5/forecast?#{buildPath(cfg)}"

  getWeather opts, (json) ->
    if json.cod==200
      item.weather[0].iconUrl = "#{imgPath}#{item.weather[0].icon}.png" for item in json.list
    cb json


exports.daily = (cfg, cb) ->
  opts.path = "/data/2.5/forecast/daily?#{buildPath(cfg)}"  

  getWeather opts, (json) ->
    if json.cod==200
      item.weather[0].iconUrl = "#{imgPath}#{item.weather[0].icon}.png" for item in json.list
    cb json


exports.history = (cfg, cb) ->
  opts.path = "/data/2.5/history/city?#{buildPath(cfg)}"  

  getWeather opts, (json) ->
    if json.cod==200
      item.weather[0].iconUrl = "#{imgPath}#{item.weather[0].icon}.png" for item in json.list
    cb json
  

buildPath = (cfg) ->
  objs = []  
  objs.push "#{i}=#{n}" for i,n of cfg

  return "#{def}&#{objs.join('&')}"


getWeather = (opts, cb) ->
  http.get opts, (res) ->
    buffer = new Buffer 0
    
    res.on 'readable',  ->
      buffer = Buffer.concat [buffer, @read()]
      
    res.on 'end', ->
      cb JSON.parse buffer.toString 'utf8'
