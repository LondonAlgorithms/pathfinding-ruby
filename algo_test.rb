require(ENV["FILE"])# "./algo"
require 'rspec/autorun'
require "rspec"
require "./spec/spec_helper.rb"
require "json"

def run_functions(solution,function_array)
  function_array.each do |fn_obj|
    x = fn_obj["function_name"]
    y = fn_obj["params"]
    solution = solution.send(x, *y)
  end
  solution
end


describe "Pathfinder" do
  after(:all) do
    File.write(ENV["FILE"] + "_results.json", outputs.to_json.to_s)
  end
  problems.each_with_index do |problem, pb_index|
    initialize_params = problem["class_initialize_params"]
    solution = Pathfinder.new(*initialize_params)

    object = { problem_id: pb_index }
    tests = []
    problem["tests"].each_with_index do |test_obj, index|
      context "test #{index}" do
        x = test_obj["check_name"]
        y = test_obj["value"]


        if x == "equality"
          it "equality" do
            res = run_functions(solution,problem["functions_to_call_on_instance"])

            result = expect(res).to(eq(y))
            tests << { test_id: index, result: result }
          end
        elsif x == "functionCalled"
          it "functionCalled" do
            allow(solution).to receive(y.to_sym)
            run_functions(solution,problem["functions_to_call_on_instance"])
            result = expect(solution).to have_received(y.to_sym)
            tests << { test_id: index, result: result }
          end
        end
      end
    end
    object[:test_results] = tests
    outputs << object
  end
end
