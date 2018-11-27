#!/usr/bin/env ruby

require_relative 'karel/model/compass'
require_relative 'karel/model/location'
require_relative 'karel/model/token_container'
require_relative 'karel/utils/parser'

module Karel
  def self.usage
    puts <<~USAGE
      Usage: #{$0} file
      Interpret a Karel file and print the final state

      Example:
      % #{$0} move-up.krl
      location: (10, 10)
      direction: up
      tokens: [{"location":"(10, 0)","count":1},{"location":"(5, 5)","count":2}]
      operations: 42
    USAGE
  end

  def self.run(args)
    if args.length != 1
      usage
      exit(1)
    elsif !File.exist?(args.first)
      puts "File '#{args.first}' not found"
    else
      program = Utils::Parser.parse(args.first)
      response = program.execute(
        Model::Compass.new(:up),
        Model::Location.new(0, 0),
        Model::TokenContainer.new
      )
      puts <<~STATE
        location: #{response.location.to_s}
        direction: #{response.compass.direction}
        tokens: #{response.tokens.as_json}
        operations: #{response.operations_count}
      STATE
    end
  rescue SyntaxError => error
    puts "Syntax error: #{error.message}"
    exit(2)
  rescue RuntimeError => error
    puts "Run time error: #{error.message}"
    exit(1)
  end
end
