class AnswerRepresenter < Struct.new(:answer)
  def to_h
    {
      id: answer.id,
      text: answer.text,
      correct: answer.correct
    }
  end
end
