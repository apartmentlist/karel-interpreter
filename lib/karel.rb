#!/usr/bin/env ruby

require 'json'

require_relative 'karel/model/compass'
require_relative 'karel/model/location'
require_relative 'karel/model/token_container'
require_relative 'karel/utils/parser'

module Karel
  def self.usage
    puts <<~USAGE
      Usage: #{$0} [options] file
      Interpret a Karel file and print the final state

      Where options include
          -i FILE  initalize the state of the Karel board before before
                   executing the Karel program file

      Example:
      % #{$0} move-up.krl
      location: (10, 10)
      direction: up
      tokens: [{"location":"(10, 0)","count":1},{"location":"(5, 5)","count":2}]
      operations: 42
    USAGE
  end

  def self.initial_state(file)
    compass = Model::Compass.new(:up)
    location = Model::Location.new(0, 0)
    tokens = Model::TokenContainer.new
    if file
      raise "Initialization file '#{file}' not found" if !File.exist?(file)
      File.readlines(file).each do |raw_line|
        line = raw_line.chomp
        match = line.match(/^tokens: (.*)$/)
        if match
          token_config = JSON.parse(match[1])
          token_config.each do |token|
            location_match = token['location'].match(/\((-?\d+), (-?\d+)\)/)
            tokens.put(
              Model::Location.new(location_match[1].to_i, location_match[2].to_i),
              token['count']
            )
          end
        end
      end
    end
    [compass, location, tokens]
  end

  def self.run(args)
    init_file, karel_file = nil
    while arg = args.shift
      if arg == '-i'
        init_file = args.shift
      elsif karel_file.nil?
        karel_file = arg
      else
        usage
        exit(1)
      end
    end

    if karel_file.nil?
      usage
      exit(1)
    elsif !File.exist?(karel_file)
      raise "File '#{karel_file}' not found"
    else
      program = Utils::Parser.parse(karel_file)
      response = program.execute(*initial_state(init_file))
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
