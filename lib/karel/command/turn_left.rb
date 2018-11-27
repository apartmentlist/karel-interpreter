require_relative 'response'

module Command
  class TurnLeft
    def execute(compass, location, tokens)
      Response.new(
        compass: compass.turn,
        location: location,
        tokens: tokens
      )
    end
  end
end
