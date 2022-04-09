require_relative 'questions_database'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'reply'


class User 
    def self.find_by_id(id)
        user_data = QuestionsDatabase.get_first_row(<<-SQL, id: id)
            SELECT
                users.*
            FROM
                users
            WHERE
                users.id = :id
            SQL
            
            user_data.nil? ? nil : User.new(user_data)
    end

    def self.find_by_name(fname, lname)
        attrs = { fname: fname, lname: lname }
        user_data = QuestionsDatabase.get_first_row(<<-SQL, attrs)
            SELECT
                users.*
            FROM
                users
            WHERE
                users.fname = :fname AND users.lname = :lname
            SQL

            user_data.nil? ? nil : User.new(user_data)
    end

    attr_reader :id
    attr_accessor :fname, :lname

    def initialize(options = {})
        @id, @fname, @lname = options.values_at('id', 'fname','lname')
    end

    def attrs
        { fname: fname, lname: lname }
    end

    def save
        if @id
            QuestionDatabase.execute(<<-SQL, attrs.merge({ id: id }))
                UPDATE
                    users
                SET
                    fname = :fname, lname = :lname
                WHERE
                    users.id = :id
            SQL
        else
            QuestionDatabase.execute(<<-SQL, attrs)
                INSERT INTO
                    users (fname, lname)
                VALUES
                    (:fname, :lname)
            SQL

            @id = QuestionDatabase.last_insert_row_id
        end

        self
    end

    def authored_questions
        Question.find_by_author_id(id)
    end
    
    def authored_replies
        Reply.find_by_user_id(id)
    end

    def followed_questions_for_user_id
        QuestionFollow.followed_questions_for_user_id(id)
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(question_id)
    end

    def average_karma
        QuestionDatabase.get_first_value(<<-SQL, author_id: self.id)
            SELECT
                CAST(COUNT(question_like.id) AS FLOAT) /
                    COUNT(DISTINCT(questions.id)) AS avg_karma
            FROM
                questions
            LEFT OUTER JOIN
                question_likes
            ON
                questions.id = question_likes.question_id
            WHERE
                questions.author_id = :author_id
        SQL
    end

end