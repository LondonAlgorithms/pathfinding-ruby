require './algo'
require 'pry'
require 'json'

f = open('challenge-2.json').read
json = JSON.parse(f)
problems = json["challenges"]

outputs = []

problems.each do |problem|
  initialize_params = problem["class_initialize_params"]
  #problem["class_name"].constatize.new(initialize_params).send(function, fn_params)
  solution = Pathfinder.new(*initialize_params)
  problem["functions_to_call_on_instance"].each do |fn_obj|
    x = fn_obj["function_name"]
    y = *fn_obj["params"]
    solution = solution.send(x, y)
  end

  problem["tests"].each_with_index do |test_obj, index|
    x = test_obj["check_name"]
    y = test_obj["value"]

    if x == "equality"
      result = expect(solution).to eq y
      outputs << { test_id: index, result: result }
    end
  end
  #h = { user_output: solution, expected_output: problem["output"] }

  #outputs << h
end

puts outputs.to_json

#allow(thing).to receive(:fn_name)
#thing.fn_name
#expect(thing).to have_received(:fn_name)
