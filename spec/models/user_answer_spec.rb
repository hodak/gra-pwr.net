require 'rails_helper'

describe UserAnswer do
  describe 'dependent destroy' do
    let!(:user_answer) { FactoryGirl.create(:user_answer) }

    xit 'removes user answer records when user is destroyed' do
      expect { user_answer.user.destroy! }.to change { UserAnswer.count }.by(-1)
    end
  end
end
