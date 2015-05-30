module ControllerHelpers
  module Api
    def sign_in(user = FactoryGirl.create(:user))
      allow(controller).to receive(:current_user) { user }

      user
    end

    def parsed_body
      JSON.parse(response.body)
    end
  end
end
