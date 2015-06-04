# TODO: this representer has too much logic (simple, current_user...)
class UserExamRepresenter < Struct.new(:user_exam)
  def to_h
    {
      id: user_exam.id,
      repeat: user_exam.repeat,
      repeat_wrong: user_exam.repeat_wrong,
      exam: ExamRepresenter.new(exam).to_h,
      user_answers: user_exam.user_answers.where(user_exam_id: user_exam.id).map do |ua|
        {
          id: ua.id,
          question_id: ua.question_id,
          answers: ua.answers
        }
      end
    }
  end

  def simple
    {
      id: user_exam.id,
      repeat: user_exam.repeat,
      repeat_wrong: user_exam.repeat_wrong,
      exam: {
        id: exam.id,
        name: exam.name
      }
    }
  end

  private
    def exam
      user_exam.exam
    end
end
