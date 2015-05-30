require 'rails_helper'

describe Api::UserExamsController do
  let!(:user) { sign_in }

  let!(:first_for_user) { FactoryGirl.create(:user_exam_with_questions, user: user) }
  let!(:not_for_user) { FactoryGirl.create(:user_exam) }
  let!(:second_for_user) { FactoryGirl.create(:user_exam, user: user) }

  describe 'index' do
    it 'returns proper user exams' do
      get :index
      exams_ids = parsed_body.map { |ue| ue['exam']['id'] }
      expect(exams_ids).to eql [first_for_user.exam.id, second_for_user.exam.id]
    end

    it 'includes questions' do
      get :index
      expect(parsed_body[0]['exam']['questions']).not_to be_empty
    end

    it 'includes answers' do
      get :index
      expect(parsed_body[0]['exam']['questions'][0]['answers']).not_to be_empty
    end

    it 'takes only 1 database query' do
      pending 'see model specs for user exam'
      expect { get :index }.to query_limit_eq 1
    end
  end
end
