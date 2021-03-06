module Model
  class TokenContainer
    def initialize
      @tokens = {}
    end

    def any?(location)
      @tokens.key?(location)
    end

    def pick(location)
      if !@tokens.key?(location)
        fail "No tokens at #{location}"
      elsif @tokens[location] == 1
        @tokens.delete(location)
      else
        @tokens[location] -= 1
      end
      return self
    end

    def put(location, value = 1)
      @tokens[location] ||= 0
      @tokens[location] += value
      return self
    end

    def as_json
      @tokens.keys.sort.map do |location|
        {
          'location' => location.to_s,
          'count' => @tokens[location]
        }
      end
    end
  end
end
