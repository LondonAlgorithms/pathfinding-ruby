require './algo'
require 'pry'
require 'json'

f = open('challenge.json').read
json = JSON.parse(f)
problems = json["problems"]

binding.pry
outputs = []

problems.each do |problem|
  input = problem["input"]
  #problem["class_name"].constatize.new(initialize_params).send(function, fn_params)
  solution = Algorithm.new(*input).solve
  h = { user_output: solution, output: problem["output"] }
  outputs << h
end

puts outputs.to_json

allow(thing).to receive(:fn_name)
thing.fn_name
expect(thing).to have_received(:fn_name)
