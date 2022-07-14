require_relative "question_db.rb"
require_relative "question.rb"
require_relative "reply.rb"
require_relative "question_follows.rb"

class User

    attr_accessor :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map{|datum| User.new(datum)}
    end

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT *
        FROM users
        WHERE id = ?
        SQL
        return nil unless user.length > 0
        User.new(user.first)
    end

    def self.find_by_name(fname, lname)
        person = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT *
        FROM users
        WHERE fname = ? 
        AND lname = ?;
        SQL
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end


    def authored_questions
        Question.find_by_author_id(@id)
    end

    def authored_replies
        Reply.find_by_author_id(@id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(@id)
    end

end