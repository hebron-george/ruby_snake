module Game
  class Snake
    MAX_FRUIT_VALUE = 100
    attr_reader   :length
    attr_accessor :events_subscribers

    # Possible events:
    #   - Eat fruit (:eat_fruit)
    #   - Change direction (:change_direction)
    
    def initialize(length=1)
      @length             = length
      @events_subscribers = Hash.new
      p "Created snake!"
    end

    def change_direction!(direction)
      return unless valid_directions.include?(direction)
      notify_listeners! :change_direction, direction: direction
    end

    def eat_fruit(fruit)
      return unless valid_fruit?(fruit)
      notify_listeners! :eat_fruit, fruit: fruit
    end

    def subscribe_to_event(subscriber, event)
      self.events_subscribers[event] = [] if self.events_subscribers[event].nil?
      self.events_subscribers[event] << subscriber
      p "Subscribed #{subscriber} to #{event}"
    end

    private

    def valid_directions
      [ :left, :right ]
    end

    def valid_fruit?(fruit)
      return true unless fruit <= 0
      return true unless fruit > MAX_FRUIT_VALUE
    end

    def notify_listeners!(event, opts = {})
      self.events_subscribers[event].uniq.each { |s| s.notify(event, opts) }
    end
  end
end
