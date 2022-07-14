require_relative "question_db.rb"
require_relative "question.rb"
require_relative "user.rb"

class Reply

    attr_accessor :body, :question_id, :author_id, :parent_reply_id, :id
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map{|datum| Reply.new(datum)}
    end

    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT *
        FROM replies
        WHERE id = ?
        SQL
        return nil unless reply.length > 0
        Reply.new(reply.first)
    end

    def self.find_by_author_id(author_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT *
        FROM replies
        WHERE author_id = ?
        SQL
        return nil unless reply.length > 0
        Reply.new(reply.first)

    end

    def self.find_by_question_id(question_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT *
        FROM replies
        WHERE question_id = ?
        SQL
        return nil unless reply.length > 0
        Reply.new(reply.first)

    end

    def self.find_by_parent_reply(parent_reply)
        reply = QuestionsDatabase.instance.execute(<<-SQL,parent_reply)
        SELECT *
        FROM replies
        WHERE id = ?
        SQL
        return nil unless reply.length > 0
        Reply.new(reply.first)
    end

    def self.find_by_child_reply(parent_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
        SELECT *
        FROM replies
        WHERE parent_reply_id = ?
        SQL
        return nil unless reply.length > 0
        Reply.new(reply.first)
    end

    def initialize(option)
        @id = option['id']
        @body = option['body']
        @author_id = option['author_id']
        @question_id = option['question_id']
        @parent_reply_id = option['parent_reply_id']
    end

    def author
        User.find_by_id(@author_id)
    end

    def question
        Question.find_by_id(@question_id)
    end

    def parent_reply
        Reply.find_by_parent_reply(@parent_reply_id)
    end

    def child_replies
        Reply.find_by_child_reply(@id)
    end

end