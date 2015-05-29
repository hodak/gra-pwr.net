require 'rails_helper'

describe Api::ExamsController do
  let!(:user) { sign_in }

  before do
    require'pry';binding.pry
  end

  it 'works' do
    expect(true).to eql true
  end
end
