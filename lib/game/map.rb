module Game
  class Map
    def initialize(width, height)
      raise StandardError.new("Invalid Map Values #{x}, #{y}") unless valid_coordinates(width,height)
    end

    private

    def valid_coordinates(width,height)
      (width > 1) && (height > 1)
    end
  end
end