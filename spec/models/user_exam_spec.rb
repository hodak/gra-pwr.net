require 'rails_helper'

describe UserExam do
  describe 'for_user' do
    let(:user) { FactoryGirl.create(:user) }

    let!(:first_for_user) { FactoryGirl.create(:user_exam, user: user) }
    let!(:not_for_user) { FactoryGirl.create(:user_exam) }
    let!(:second_for_user) { FactoryGirl.create(:user_exam, user: user) }

    subject { UserExam.for_user(user) }

    it 'returns only exams for given user' do
      expect(subject.to_a).to match_array [first_for_user, second_for_user]
    end

    it 'also joins exam within one query' do
      exams = subject.to_a
      expect { exams.first.exam }.to query_limit_eq(0)
    end
  end
end
