require 'rails_helper'

describe UserExam do
  describe 'for_user' do
    let(:user) { FactoryGirl.create(:user) }

    let!(:first_for_user) { FactoryGirl.create(:user_exam_with_questions, user: user) }
    let!(:not_for_user) { FactoryGirl.create(:user_exam) }
    let!(:second_for_user) { FactoryGirl.create(:user_exam, user: user) }

    subject { UserExam.for_user(user) }

    it 'returns only exams for given user' do
      expect(subject.to_a).to match_array [first_for_user, second_for_user]
    end

    describe 'query limit' do
      let(:exams) { subject.to_a }

      it 'takes only 1 query' do
        pending 'Selecting all the required things should take only 1 SQL query, not 4 or over :)'
        expect { exams }.to query_limit_eq 1
      end

      it 'includes exam within one query' do
        exams
        expect { exams.first.exam }.to query_limit_eq 0
      end

      it 'includes exam questions within one query' do
        exams
        expect { exams.first.exam.questions.to_a }.to query_limit_eq 0
      end

      it 'includes answers within one query' do
        exams
        expect { exams.first.exam.questions.first.answers.to_a }.to query_limit_eq 0
      end
    end
  end

  describe 'dependent destroy' do
    let!(:user_exam) { FactoryGirl.create(:user_exam) }

    it 'destroys user exam on destroying user' do
      expect { user_exam.user.destroy! }.to change { UserExam.count }.by(-1)
    end

    it 'destroys user exam on destroying exam' do
      expect { user_exam.exam.destroy! }.to change { UserExam.count }.by(-1)
    end
  end

  describe 'uniqueness of user_id and exam_id' do
    let(:user) { FactoryGirl.create(:user) }

    it "doesn't allow to create the same user exam for the same user and exam" do
      user_exam_1 = FactoryGirl.create(:user_exam, user: user)
      expect(user_exam_1).to be_valid
      user_exam_2 = FactoryGirl.build(:user_exam, user: user, exam: user_exam_1.exam)
      expect(user_exam_2).to be_invalid
    end
  end
end
