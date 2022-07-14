require_relative "question_db.rb"
require_relative "user.rb"
require_relative "question.rb"

class QuestionFollow

    attr_accessor :author_id, :question_id
    
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map{|datum| QuestionFollow.new(datum)}
    end

    def self.find_by_id(id)
        follow = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT *
        FROM question_follows
        WHERE id = ?
        SQL
        return nil unless follow.length > 0
        QuestionFollow.new(follow.first)
    end

    def self.followers_for_question_id(question_id)
        quest = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT *
        FROM users
        JOIN question_follows ON users.id = question_follows.follower_author_id
        
        WHERE question_id = ?
        SQL
        return nil unless quest.length > 0
        quest.map {|author| User.new(author)}

    end

    def self.followed_questions_for_user_id(author_id)
        quest = QuestionsDatabase.instance.execute(<<-SQL,author_id)
        SELECT *
        FROM questions
        LEFT JOIN question_follows ON questions.id = question_follows.question_id

        WHERE author_id = ?
        SQL
        return nil unless quest.length > 0
        quest.map { |question| Question.new(question)}
    end

    def self.most_followed_question(n)
        quest = QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT * 
        FROM questions 
        JOIN question_follows 
        ON questions.id = question_follows.question_id 
        GROUP BY question_id 
        ORDER BY COUNT(*) DESC
        LIMIT  ?
        SQL
        quest.map { |question| Question.new(question)}

    end



    def initialize(option)
        @id = option['id']
        @follower_author_id = option['follower_author_id']
        @question_id = option['question_id']
    end

end