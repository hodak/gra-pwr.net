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

  # TODO: this shouldn't be form logic
  # Also, this method sux big time!
  def persist!
    ActiveRecord::Base.transaction do
      Exam.find_or_initialize_by({ id: id }).tap do |e|
        e.update!(exam_hash)
        e.questions.where('id not in (?)', questions.keys).destroy_all
        questions.each do |id, q|
          question = e.questions.find_or_initialize_by(id: id)
          answers_ids = q['answers'].map { |a| a['id'] }
          question.answers.where('id not in (?)', answers_ids).destroy_all
          question.update!(q.except('answers'))

          q['answers'].each do |a|
            answer = question.answers.find_or_initialize_by(id: a['id'])
            answer.update! a
          end
        end
      end
    end
  end

  # TODO: get rid of those with_indifferent_access
  private
    def questions_validation
      return errors.add(:questions, 'Must have at least one question') if questions.blank?

      questions.each do |uuid, question|
        question = question.with_indifferent_access
        errors.add(uuid, 'ID is not valid UUID') if (question['id'] =~ UUID::REGEX) != 0
        errors.add(uuid, 'Question text is required') if question['text'].blank?
      end
    end

    def answers_validation
      return if questions.blank?

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

    def exam_hash
      {
        id: id,
        name: name
      }
    end
end
