class UserExamRepresenter < Struct.new(:user_exam)
  def to_h
    exam = user_exam.exam

    {
      exam: {
        id: exam.id,
        name: exam.name
      },
      repeat: user_exam.repeat,
      repeat_wrong: user_exam.repeat_wrong
    }
  end
end
