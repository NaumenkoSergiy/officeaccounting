module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      check
      self.current_user = user
    end

    protected

    def check
      reject_unauthorized_connection unless user
    end

    def user
      User.find_by(id: verifier.verify(cookies[:token]))
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      nil
    end

    def verifier
      ActiveSupport::MessageVerifier.new(Rails.application.secrets.secret_key_base)
    end
  end
end
