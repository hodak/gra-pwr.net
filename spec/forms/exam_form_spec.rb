require 'rails_helper'

describe ExamForm do
  let(:params) { {
    id: '70108314-cade-4fe4-b16a-5c2a2ccff55a',
    name: 'Exam name',
    questions: {
      'bc05dc5d-a14d-42e2-8a46-f7d933de18b2' => {
        id: 'bc05dc5d-a14d-42e2-8a46-f7d933de18b2',
        text: 'Question one text',
        answers: [
          {
            id: '9a95c86b-72e3-428f-9801-5b54fa4e13be',
            text: 'Incorrect answer',
            correct: false
          },
          {
            id: 'be832612-670b-411b-83d9-1f6e00877e51',
            text: 'Correct answer',
            correct: true
          },
          {
            id: '8316f649-4bfe-4055-b2a1-838cd07a5072',
            text: "Answer so dumb you don't even want to imagine",
            correct: false
          }
        ]
      }
    }
  } }

  subject { ExamForm.new(params) }
  let(:errors) { subject.errors.messages }

  it 'can be valid on valid parameters' do
    expect(subject).to be_valid
  end

  context 'invalid' do
    it 'requires valid id' do
      params[:id] = 'e'
      expect(subject).to be_invalid
      expect(errors).to eql({ id: ['is invalid'] })
    end

    it 'requires name' do
      params[:name] = ''
      expect(subject).to be_invalid
      expect(errors).to eql({ name: ["can't be blank"] })
    end

    it 'requires questions' do
      params[:questions] = {}
      expect(subject).to be_invalid
      expect(errors).to eql({ questions: ['Must have at least one question'] })
    end

    # Hm, what if key is invalid uuid? I don't think it matters, we don't use it
    # during object creation
    it 'requires valid question uuid' do
      params[:questions]['bc05dc5d-a14d-42e2-8a46-f7d933de18b2'][:id] = 'e'
      expect(subject).to be_invalid
      expect(errors).to eql({
        :'bc05dc5d-a14d-42e2-8a46-f7d933de18b2' => ['ID is not valid UUID']
      })
    end

    it 'requires valid uuid of answers' do
      params[:questions].values.first[:answers].second[:id] = 'e'
      expect(subject).to be_invalid
      expect(errors).to eql({
        :'bc05dc5d-a14d-42e2-8a46-f7d933de18b2' => ['ID of "Correct answer" is not valid UUID']
      })
    end

    it 'requires at least two answers' do
      params[:questions].values.first[:answers] = [params[:questions].values.first[:answers].second]
      expect(subject).to be_invalid
      expect(errors).to eql({
        :'bc05dc5d-a14d-42e2-8a46-f7d933de18b2' => ['Questions must have at least two answers']
      })
    end

    it 'requires at least one answer to be valid' do
      params[:questions].values.first[:answers][1][:correct] = false
      expect(subject).to be_invalid
      expect(errors).to eql({
        :'bc05dc5d-a14d-42e2-8a46-f7d933de18b2' => ['At least one answer must be correct']
      })
    end
  end
end
