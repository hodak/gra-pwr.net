class ExamForm
  include Virtus.model
  include ActiveModel::Validations

  validates_presence_of :id
  validates_format_of :id, with: UUID::REGEX
  validates_presence_of :name
  validate :questions_validation
  validate :answers_validation

  attribute :id, String
  attribute :name, String
  attribute :questions, Hash

  private
    def questions_validation
      errors.add(:questions, 'Must have at least one question') if questions.length == 0
      questions.each do |uuid, question|
        question = question.with_indifferent_access
        errors.add(uuid, 'ID is not valid UUID') if (question['id'] =~ UUID::REGEX) != 0
        errors.add(uuid, 'Question text is required') if question['text'].blank?
      end
    end

    def answers_validation
      questions.each do |uuid, question|
        question = question.with_indifferent_access
        answers = question[:answers]

        errors.add(uuid, 'Questions must have at least two answers') if answers.length < 2
        errors.add(uuid, 'At least one answer must be correct') if answers.none? { |a| a[:correct] }

        answers.each do |answer|
          answer = answer.with_indifferent_access
          errors.add(uuid, "ID of \"#{answer[:text]}\" is not valid UUID") if (answer['id'] =~ UUID::REGEX) != 0
        end
      end
    end
end
