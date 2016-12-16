require "csv"

class Output
  KEYS = [:strand_id, :strand_name, :standard_id, :standard_name, :question_id, :difficulty]
  QUESTIONS_CSV = CSV.read("questions.csv", headers: true, header_converters: :symbol)

  def self.calculate_for(number)
    questions = []
    hash_csv = QUESTIONS_CSV.map {|row| row.to_hash }

    questions_per_strand = number/2.to_i
    prng = Random.new
    strand_id = rand(1..2)

    strand_1 = hash_csv.find_all { |x| x[:strand_id] == "1" }
    questions << strand_1.sample(questions_per_strand).map{ |x| x[:question_id] }

    strand_2 = hash_csv.find_all { |x| x[:strand_id] == "2" }
    questions << strand_2.sample(questions_per_strand).map{ |x| x[:question_id] }

    puts questions.flatten.inspect
  end

end