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

    let(:question_two_id) { '3b42dcc7-e3c9-43d1-bd9b-a2d4cb5dde6c' }
    let(:question_params_two) { {
      id: question_two_id,
      text: 'Question two',
      answers: [
        { id: '1a89138f-9ebd-4524-9cf9-59ecedcab3cd', text: 'e', correct: true },
        { id: 'a4a2ebeb-f7b7-4590-8069-dbd0bdbca586', text: 'f', correct: false }
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

    it 'is possible to delete a question and its answers' do
      params_with_two_questions = params.deep_merge({ exam: { questions: { question_two_id => question_params_two } } })
      expect { put :update, params_with_two_questions }.to change { Question.count }.by(2)
      expect { put :update, params }.to change { Answer.count }.by(-2)
      expect(Question.count).to eql 1
      expect(Question.first.text).to eql 'Question one text'
    end

    it 'is possible to delete an answer' do
      expect { put :update, params }.to change { Answer.count }.by(3)
      params[:exam][:questions].values.first[:answers].pop
      expect { put :update, params }.to change { Answer.count }.by(-1)
      expect(Answer.all.map(&:text)).to eql ['Incorrect answer', 'Correct answer']
    end
  end
end
