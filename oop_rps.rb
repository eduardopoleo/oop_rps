# a player a computer player
#  player
#  	hand 

# a game object compares both   

CHOICES= {'r'=>'Rock','p'=>'Paper', 's'=>'Scissors'}

class Player
	attr_accessor :name, :hand

	def initialize(n)
		@name = n
		@hand = ""
	end
	# Having this method here.. Does not feel right. But it works :(
	def display_winning_message
		case self.hand
		when 'r'
			puts "Rock crushes scissors!"
		when 'p'
			puts "Paper wraps rock!"
		else
			puts "Scissors cuts paper!"
		end
	end

	def to_s
		"#{name} has chosen #{CHOICES[hand]}"
	end

end

class Human < Player

	def pick_hand
		puts "#{self.name} choose one option please: (r/p/s)"
		begin
			self.hand = gets.chomp.downcase

			unless CHOICES.keys.include?(hand)
				puts "Please give a valid answer!"
			end
		end until CHOICES.keys.include?(hand)
		self.hand
	end

end

class Computer < Player

	def pick_hand
		self.hand	= CHOICES.keys.sample
	end

end
#Important one can use objects from other classes to initialize the game.

class Game
	attr_accessor :human, :computer

	def initialize
		system("clear")
		puts "What's your name?"
		name = gets.chomp.capitalize
		puts " "
		puts "Choose your adversary: 1) for C3PO, 2) for R2D2, 3) for Siri"
		
		begin
			choice = gets.chomp.capitalize
			case choice
			when "1"
				adversary = "C3PO"
			when "2"
				adversary = "R2D2"
			when "3"
				adversary = "Siri"
			else
				puts "Sorry we are still fixing that robot"
			end
		end until choice == "1" || choice == "2" ||  choice == "3"

		@human = Human.new(name)
		@computer = Computer.new(adversary)
	end

	def compare_hands
			if human.hand == computer.hand
				puts "Hands are equal. It's a tie"
			elsif (human.hand == 'r' && computer.hand == 's') || (human.hand == 'p' && computer.hand == 'r') || 
				(human.hand == 's' && computer.hand == 'p')
				human.display_winning_message
				puts "#{human.name} won"
			else
				computer.display_winning_message
				puts "#{computer.name} won"
			end
	end

	def play_again?
		puts "Do you want to play again? (y/n)"
		begin
			choice=gets.chomp.downcase
			if choice == "y"
				new_game
			elsif choice == "n"
				puts "GoodBye!"
			end

			unless choice == "y" || choice == "n"
				puts "Please give a valid answer!"
			end
		end until choice == "y" || choice == "n"
	end

	def new_game
		system("clear")
		human.pick_hand
		computer.pick_hand
		puts human
		puts computer
		puts " "
		compare_hands
		puts " "
		play_again?
	end

end

play=Game.new.new_game