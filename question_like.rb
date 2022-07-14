require_relative "question_db.rb"

class QuestionLike
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map{|datum| QuestionLike.new(datum)}
    end

    def self.find_by_id(id)
        like = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT *
        FROM question_likes
        WHERE id = ?
        SQL
        return nil unless like.length > 0
        QuestionLike.new(like.first)
    end

    def initialize(option)
end