class UserExamRepresenter < Struct.new(:user_exam)
  def to_h
    exam = user_exam.exam

    {
      id: user_exam.id,
      repeat: user_exam.repeat,
      repeat_wrong: user_exam.repeat_wrong,
      exam: {
        id: exam.id,
        name: exam.name,
        questions: exam.questions.map { |q| QuestionRepresenter.new(q).to_h }
      }
    }
  end
end
