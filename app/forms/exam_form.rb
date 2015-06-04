class ExamForm
  include Virtus.model
  include ActiveModel::Validations

  validates_presence_of :id
  validates_format_of :id, with: UUID::REGEX
  validates_presence_of :name

  attribute :id, String
  attribute :name, String
end
