module JsEnv
  extend ActiveSupport::Concern

  included do
    helper_method :js_env
  end

  def js_env
    data = {
      env: Rails.env,
      templates: templates,
      url: url,
      host: ENVied.HOST
    }

    data[:user] = CurrentUserRepresenter.new(current_user).to_h if current_user

    <<-EOS.html_safe
      <script type="text/javascript">
        shared = angular.module('infish')
        shared.constant('Rails', #{data.to_json})
      </script>
    EOS
  end

  private
    def templates
      Hash[
        Rails.application.assets.each_logical_path
        .select { |file| file.end_with?('swf', 'html', 'json') }
        .map { |file| [file, ActionController::Base.helpers.asset_path(file)] }
      ]
    end

    def url
      protocol = ENVied.FORCE_SSL ? 'https://' : 'http://'
      "#{protocol}#{ENVied.HOST}"
    end
end

