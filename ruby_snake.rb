#!/usr/bin/ruby
require_relative 'lib/runner'

begin
  # game = Game::Runner.new
  # game.start!
rescue Interrupt => e
  p "Ending game..."
  p "Final score: #{game.score}"
end