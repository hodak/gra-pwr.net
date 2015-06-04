class QuestionRepresenter < Struct.new(:question)
  def to_h
    {
      id: question.id,
      text: question.text,
      answers: question.answers.map { |a| AnswerRepresenter.new(a).to_h },
      created_at: question.created_at
    }
  end
end
