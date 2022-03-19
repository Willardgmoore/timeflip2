module Timeflip2
  module V2
    require 'lib/timeflip2/apis/timeflip2_api/v2/client'
    include Auth
    class Client
      require 'httparty'

      def email_sign_in(email, password)
        request(
          http_method: :post,
          endpoint: "/api/auth/email/sign-in",
          params: credentials(email: email, password: password)
        )
      end

      def get_settings(authenticated: true, authority: {}, credentials: @creds, details: {}, principal: {})
        request(
          http_method: :post,
          endpoint: "/api/settings",
          params: {authenticated: authenticated, authority: authority, credentials: @creds, details: details, principal: principal}
        )
      end

      private

      def credentials(email: nil , password: nil)
        @creds ||= {"email": email, "password": password}
      end

      def request(http_method:, endpoint:, params:{})
        HTTParty.send(http_method, full_url(endpoint), options(params))
      end

      def full_url(endpoint)
        'https://newapi.timeflip.io' + endpoint
      end

      def options(params)
        { headers: { "Content-Type": "application/json" },
          body: params.to_json }
      end
    end
  end
end

# irb
# require_relative 'lib/timeflip2/apis/timeflip2_api/v2/client'
# Timeflip2::V2::Client.new.email_sign_in(email, password)