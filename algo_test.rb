require './algo'
require 'rspec'
require './spec/spec_helper.rb'
require 'pry'
require 'json'

def run_functions(solution,function_array)
  function_array.each do |fn_obj|
    x = fn_obj["function_name"]
    y = fn_obj["params"]
    solution = solution.send(x, *y)
  end
end

f = open('challenge-2.json').read
json = JSON.parse(f)
problems = json["challenges"]

outputs = []

problems.each do |problem|
  initialize_params = problem["class_initialize_params"]
  solution = Pathfinder.new(*initialize_params)
  run_functions(solution,problem["functions_to_call_on_instance"])

  RSpec.describe "test #{index}" do
  problem["tests"].each_with_index do |test_obj, index|
    x = test_obj["check_name"]
    y = test_obj["value"]


      if x == "equality"
        it "equality" do
          result = expect(solution).to(eq(y))
          outputs << { test_id: index, result: result }
        end
      elsif x == "functionCalled"
        it "functionCalled" do
          allow(solution).to receive(y.to_sym)
          run_functions
          result = expect(solution).to have_received(y.to_sym)
          outputs << { test_id: index, result: result }
        end
      end
    end
  end
end

puts outputs.to_json
