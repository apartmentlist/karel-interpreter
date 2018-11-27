module Model
  Location = Struct.new(:x, :y) do
    def to_s
      "(#{x}, #{y})"
    end

    def <=>(other)
      if x == other.x
        y <=> other.y
      else
        x <=> other.x
      end
    end
  end
end
