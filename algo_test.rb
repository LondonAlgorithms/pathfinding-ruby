require './algo'
require 'json'
require 'pry'

f = open('challenge.json').read
json = JSON.parse(f)
binding.pry

