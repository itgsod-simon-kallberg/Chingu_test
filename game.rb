require 'chingu'


class Game < Chingu::Window

	#constructor
	def initialize
		super
		self.input = {esc: :exit}
		@background_image = Gosu::Image.new(self, "map2.png", true)
		@player = Player.create
	end

	def draw
		@player.draw
		@background_image.draw(0,0,0)
	end

end

class Player < Chingu::GameObject

	#meta-constructor
	def setup
		@x, @y = 40, 0
		@speed = 5
		@image = Gosu::Image["magic.png"]
		self.factor = 0.5 #size
		self.input = {
			holding_left: :left,
			holding_right: :right,
			holding_up: :up,
			holding_down: :down
		}

	end

	def left
		unless @x - 28 <= 0
	    	@x -= @speed
		end
	end

	def right
		unless @x + 28 >= 800
			@x += @speed
		end
	end

	def up
		unless @y - 28 <= 0
			@y -= @speed
		end
	end

	def down
		unless @y + 28 >=600
			@y += @speed
		end
	end

end


Game.new.show