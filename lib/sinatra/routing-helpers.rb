require 'securerandom'
require 'uri'
require 'sinatra/base'
require 'sinatra/routing-helpers/version'

module Sinatra
  module RoutingHelpers
    module HelperMethods
      include Rack::Utils

      # better handling of referer path
      def parsed_referer_path
        rf = request.referer

        if (!rf.nil? && !rf.empty?) && parsed_referer = URI.parse(rf)
          if parsed_referer.path.end_with?('/')
            parsed_referer.path.chop!
          end

          parsed_referer.path
        else
          nil
        end
      end

      # simple
      def is_page?(route)
        path_info = request.path_info

        case route
        when String; route == path_info
        when Array;  route.include?(individual_route)
        else
          false
        end
      end

      # quickly build a URL with params
      def url_with_params(headed_to, extra_params = {})
        # pop off empty values to avoid cluttering the URL bar
        cleaned_params = extra_params.reject { |key, value| value.nil? || value.empty? }
        parsed         = URI.parse(headed_to)

        # if we have anything to parse up, let's do it
        if parsed.query || !cleaned_params.empty?
          parsed.query = [parsed.query, build_query(cleaned_params)].compact.join('&')
        end

        parsed.to_s
      end

      def busted_url(headed_to)
        url_with_params(headed_to, ensure: SecureRandom.hex(16))
      end

      # Returns the url of the referer along with the params posted to that page
      # Lets you hand back invalid params for correction in the previous page.
      #   You can also add extra params in to send back.
      #
      #   redirect to(back_with_params(my_extra_param: 'my extra value'))
      #
      def back_with_params(extra_params = {})
        back_to       = parsed_referer_path || '/'
        clean_params  = params.reject do |key, value|
          settings.params_blacklist.include?(key.to_sym)
        end

        url_with_params(back_to, extra_params.merge(clean_params))
      end

      # handles a non-working cancel button
      def back_or(new_path)
        if back.nil? || [request.path_info, uri(request.path_info), '/', ''].include?(back)
          new_path
        else
          back
        end
      end
    end

    def self.registered(app)
      app.helpers HelperMethods

      # block some things from the URL
      app.set :params_blacklist, [
        :password, :_csrf, :ip
      ]
    end
  end

  register RoutingHelpers
end
