module HotMess
  class Application
    def crypt
      @@crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    end
  end
end
