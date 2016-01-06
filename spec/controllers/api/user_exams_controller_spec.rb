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
  end

  describe "force ssl" do
    it "forces SSL when FORCE_SSL ENV is set" do
      allow(ENVied).to receive(:FORCE_SSL).and_return true
      get :index
      expect(response.status).to eql 301
      expect(response.redirect_url).to match(/^https/)
    end

    it "doesn't force SSL when FORCE_SSL ENV is not set" do
      allow(ENVied).to receive(:FORCE_SSL).and_return false
      get :index
      expect(response.status).to eql 200
    end
  end
end
