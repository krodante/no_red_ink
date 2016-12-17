require "csv"

class Output
  QUESTIONS_CSV = CSV.read("questions.csv", headers: true, header_converters: :symbol)

  def self.calculate_for(number)
    questions = []
    hash_csv = QUESTIONS_CSV.map {|row| row.to_hash }

    duplicate_csv(number, hash_csv, 1)

    questions_per_strand = number/2.to_i

    strand_1 = hash_csv.find_all { |x| x[:strand_id] == "1" }
    strand_2 = hash_csv.find_all { |x| x[:strand_id] == "2" }

    if number.odd?
      questions = add_one_for_odd(questions, questions_per_strand, strand_1, strand_2)
    else
      questions << add_strand(questions_per_strand, strand_1)
      questions << add_strand(questions_per_strand, strand_2)
    end

    puts questions.flatten.inspect
  end

  def self.add_strand(questions_per_strand, strand, extra = 0)
    strand.sample(questions_per_strand + extra).map { |x| x[:question_id] }
  end

  def self.add_one_for_odd(questions, questions_per_strand, strand_1, strand_2)
    prng = Random.new
    strand_id = rand(1..2)
    if strand_id == 1
      questions << add_strand(questions_per_strand, strand_1, 1)
      questions << add_strand(questions_per_strand, strand_2)
    else
      questions << add_strand(questions_per_strand, strand_1)
      questions << add_strand(questions_per_strand, strand_2, 1)
    end
    questions
  end

  def self.duplicate_csv(number, hash_csv, row)
    if number >= hash_csv.count
      new_hash_csv = hash_csv
      new_hash_csv << hash_csv[row]
      new_hash_csv
      duplicate_csv(number, new_hash_csv, row + 1)
    else
      return new_hash_csv
    end
  end

end