user = User.create! email: "example@example.com"

exam = Exam.create! name: "General Knowledge"
exam.questions.create!(text: "For which of the following disciplines is Nobel Prize awarded?").tap do |q|
  q.answers.create! text: "Physics and Chemistry", correct: true
  q.answers.create! text: "Physiology or Medicine", correct: true
  q.answers.create! text: "Literature, Peace and Economics", correct: true
end
exam.questions.create!(text: "First human heart transplant operation conducted by Dr. Christiaan Barnard on Louis Washkansky, was conducted in:").tap do |q|
  q.answers.create! text: "1967", correct: true
  q.answers.create! text: "1968"
  q.answers.create! text: "1958"
  q.answers.create! text: "1922"
end
exam.questions.create!(text: "Guarantee to an exporter that the importer of his goods will pay immediately for the goods ordered by him, is known as:").tap do |q|
  q.answers.create! text: "laissezfaire"
  q.answers.create! text: "inflation"
  q.answers.create! text: "Letter of Credit (L/C)", correct: true
  q.answers.create! text: "None of the above"
end

user.user_exams.create! exam: exam
