require 'rails_helper'

describe Api::ExamsController do
  let!(:user) { sign_in }

  describe 'update' do
    let(:id) { '70108314-cade-4fe4-b16a-5c2a2ccff55a' }
    let(:question_id) { 'bc05dc5d-a14d-42e2-8a46-f7d933de18b2' }

    let(:question_params_one) { {
      id: question_id,
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
    } }

    let(:params) { {
      id: id,
      exam: {
        name: 'Exam name',
        questions: { question_id => question_params_one }
      }
    } }

    it "creates new exam if one doesn't exist" do
      expect { put :update, params }.to change { Exam.count }.by(1)
      expect(Exam.last.id).to eql id
    end

    it 'updates existing exam' do
      FactoryGirl.create(:exam, id: id)
      params[:exam][:name] = 'Hodor'

      expect { put :update, params }.not_to change { Exam.count }
      expect(Exam.last.id).to eql id
      expect(Exam.last.name).to eql 'Hodor'
    end

    it 'returns exam in json' do
      put :update, params
      expect(parsed_body['exam']['id']).to eql id
      expect(parsed_body['exam']['name']).to eql 'Exam name'
      expect(parsed_body['exam']['questions']).to have_key(question_id)
    end

    it 'requires valid uuid in param' do
      params[:id] = 'e'
      put :update, params
      expect(parsed_body['error']['id']).to eql ['is invalid']
      expect(response.status).to eql 422
    end

    it 'automatically creates user exam for exam creator' do
      expect { put :update, params }.to change { UserExam.count }
      ue = UserExam.last
      expect(ue.user_id).to eql user.id
      expect(ue.exam_id).to eql parsed_body['exam']['id']
    end

    it "doesn't create user exam for user editing exam if already exists" do
      put :update, params
      params[:exam][:name] = 'Hodor'
      expect { put :update, params }.not_to change { UserExam.count }
    end

    it 'allows to create exam with questions and answers' do
      expect { put :update, params }.to change { Answer.count }.by(3)
      exam = Exam.last
      expect(exam.questions.length).to eql 1
    end

    it "doesn't save changes when validations returns true but there is an error on saving" do
      put :update, params

      allow(ExamForm).to receive(:valid?).and_return true
      params[:exam][:questions].values.first[:answers].first[:id] = 'e'
      params[:exam][:name] = 'Hodor'

      put :update, params
      expect(Exam.last.name).to eql 'Exam name'
    end
  end
end
