require './board.rb'
require './human_player.rb'

class Game
    
    def initialize(n, *marks)
        @players = marks.map { |mark| HumanPlayer.new(mark) }   #creates array of a players [a, b, c]
        @current_player = @players.first    #takes first element of array [a]
        @board = Board.new(n)
    end

    def switch_turn
        @current_player = @players.rotate!.first    #rotates through the mapped array from *marks only the first in the list [a, b, c] => [b] the ! keeps the same array rotating
    end

    def play
        while @board.empty_positions?
            @board.print
            pos = @current_player.get_position
            @board.place_mark(pos, @current_player.mark)
            if @board.win?(@current_player.mark)
                puts "Victory!"
                puts @current_player.mark.to_s + ' is the Winner!'
                return
            else
                switch_turn
            end
        end

        puts "It's a Draw!"
    end
end