require_relative 'game/map'
require_relative 'game/snake'
require 'io/console'

module Game
  class Runner
    attr_reader :map, :snake, :game_opts, :score
    
    def initialize(game_speed=1)
      @map       = Game::Map.new(10,10)
      @snake     = Game::Snake.new(1)
      @game_opts = { :speed => game_speed }
      @score     = 0

      subscribe_to_snake_events!
    end

    def start!(opts = {})
      p "Starting with options: #{opts}"
      begin
        # TODO Create UI?
        while
          snake.change_direction!(get_input!)
        end
      end
    end

    def notify(event, opts = {})
      if event == :change_direction
        p "Change direction: #{opts[:direction]}" 
      elsif event == :eat_fruit
        p "Eating fruit! #{opts}"
      else
        raise StandardError.new("Unexpected event: #{event}")
      end
    end

    private

    def get_input!
      input = STDIN.getch
      return :left  if input.downcase == 'j' 
      return :right if input.downcase == 'l'
      input
    end

    def subscribe_to_snake_events!
      self.snake.subscribe_to_event(self, :change_direction)
      self.snake.subscribe_to_event(self, :eat_fruit)
    end
  end
end
