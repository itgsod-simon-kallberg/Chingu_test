require 'chingu'


class Game < Chingu::Window

	#constructor
	def initialize
		super
		self.input = {esc: :exit}
		Maze.new
		@player = Player.create
	end
end

class Maze

	def initialize
		y = 0
		File.readlines("labyrint.txt").each do |row|
			x = 0
			tecken = row.split("")
			tecken.each do |t|
				puts t
				if t == "0"
					x += 20
				elsif t == "1"
					Block.create(x: x, y: y)
					x += 20
				end
			end
			y += 20		
		end
	end

end

class Block < Chingu::GameObject
	def setup
		@image = Gosu::Image["block.png"]
	end


end

class Player < Chingu::GameObject

	#meta-constructor
	def setup
		@x, @y = 40, 0
		@speed = 5
		@image = Gosu::Image["gubbe.png"]
		# self.factor = 0.2 #size
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