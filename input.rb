require './output'

class Input
	def self.run
    loop do
      puts "How many questions do you want to put in this quiz?"
      a = gets.chomp
      if a.to_i <= 0
        puts "You must set a number greater than 0."
      else
        Output.calculate_for(a.to_i)
        exit
      end
    end
  end
end
