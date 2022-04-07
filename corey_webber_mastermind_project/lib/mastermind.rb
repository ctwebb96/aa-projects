require_relative "code"

class Mastermind

  def initialize(length)
    @secret_code = Code.random(length)
  end

  def print_matches(code)
    puts "exact matches: #{@secret_code.num_exact_matches(code)}"
    puts "near matches: #{@secret_code.num_near_matches(code)}"
  end

  def ask_user_for_guess
    puts "Enter a code"
    guess_code = gets.chomp
    guess_pegs = Code.from_string(guess_code)
    self.print_matches(guess_pegs)
    @secret_code == guess_pegs
 
  end
end
