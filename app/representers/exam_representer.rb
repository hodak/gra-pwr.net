class ExamRepresenter < Struct.new(:exam)
  def to_h
    {
      id: exam.id,
      name: exam.name,
      questions: exam.questions.inject({}) { |h, q| h[q.id] = QuestionRepresenter.new(q).to_h; h }
    }
  end
end
