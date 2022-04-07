def all_words_capitalized?(words)
    words.all? { |word| word.capitalize == word }
end

def no_valid_url?(urls)
    is_valid = ['.com', '.net', '.io', '.org']

    urls.none? do |url| 
        is_valid.any? { |ending| url.end_with?(ending) }
    end
end

  students = [
        { name: "Alice", grades: [60, 68] },
        { name: "Bob", grades: [20, 100] }
      ]


def any_passing_students?(students)
    students.any? do |student|
       p student[:grades]
       avg = student[:grades].sum / student[:grades].length * 1.0
       p avg
       avg >= 75
       
    end
end

any_passing_students?(students)