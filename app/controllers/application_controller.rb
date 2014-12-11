class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from Rack::Timeout::RequestTimeoutError, :with => :handle_timeout

  def refresh_database
    DatabaseRefresher.refresh
  end

  def handle_timeout(exception)
    Rails.logger.tagged('Request Timeout') do |variable|
      Rails.logger.info "#{Time.zone.now}: Rotten Tomatoes API call timed out: #{exception.to_s}"
    end

    redirect_to root_url, alert: 'The call to Rotten Tomatoes timed-out, please try again.'
  end
end
