require 'chingu'

class Window < Chingu::Window
	def setup
		$window.switch_game_state(Game)
	end
end


class Game < Chingu::GameState
	#constructor
	attr_accessor :gameover
	def initialize
		super
		self.input = {esc: :exit}
		Labyrinten.new
		Player.create
	end
	def update
		super
		Player.each_bounding_box_collision(Block) do |player, block|
 			#pop_game_state
 			# game_objects.destroy_all
 			Block.destroy_all
 			Player.destroy_all	
 			$window.switch_game_state(Game)
 			#Maze.new
 		end


 		Player.each_bounding_box_collision(Finish) do |player, finish|
 			Block.destroy_all
 			$window.switch_game_state(Labyrint)

 		end
	end
end


class Maze < Chingu::GameState
	def initialize
		y = 0
		File.readlines("#{self.filename}").each do |row|
			x = 0
			tecken = row.split("")
			tecken.each do |t|
				puts t
				if t == "0"
					x += 20
				elsif t == "1"
					Block.create(x: x, y: y)
					x += 20
				
				elsif t == "2"
					Finish.create(x: x, y: y)
					x += 20
				end
			end
			y += 20		
		end
	end
end


class Labyrinten < Maze

	def filename
		"labyrinten.txt"
	end

end

class Labyrint < Maze

	def filename
		"labyrint.txt"
	end

end

class Block < Chingu::GameObject
	has_traits :collision_detection, :bounding_box

	def setup
		@image = Gosu::Image["block.png"]
	end

	 def update
	  	super
	 		
     end

end

class Finish < Chingu::GameObject
	has_traits :collision_detection, :bounding_box

	def setup
		@image = Gosu::Image["finish.png"]
	end

	 def update
	  	super	
     end

end

class Player < Chingu::GameObject
	has_traits :collision_detection, :bounding_box

	#meta-constructor
	def setup
		@x, @y = 90, 10
		@speed = 5
		@image = Gosu::Image["halo.png"]
		self.factor = 1.4 #size
		self.input = {
			holding_left: :left,
			holding_right: :right,
			holding_up: :up,
			holding_down: :down
		}

	end

	def left
		unless @x - 8 <= 0
	    	@x -= @speed
		end
	end

	def right
		unless @x + 8 >= 800
			@x += @speed
		end
	end

	def up
		unless @y - 8 <= 0
			@y -= @speed
		end
	end

	def down
		unless @y + 8 >=600
			@y += @speed
		end
	end

end


Window.new.show