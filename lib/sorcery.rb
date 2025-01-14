require 'sorcery/version'

module Sorcery
  require 'sorcery/model'

  module Adapters
    require 'sorcery/adapters/base_adapter'
  end

  module Model
    require 'sorcery/model/temporary_token'
    require 'sorcery/model/config'

    module Submodules
      require 'sorcery/model/submodules/user_activation'
      require 'sorcery/model/submodules/reset_password'
      require 'sorcery/model/submodules/remember_me'
      require 'sorcery/model/submodules/activity_logging'
      require 'sorcery/model/submodules/brute_force_protection'
      require 'sorcery/model/submodules/external'
      require 'sorcery/model/submodules/magic_login'
      require 'sorcery/model/submodules/change_password_date'
      require 'sorcery/model/submodules/password_history'
    end
  end

  require 'sorcery/controller'

  module Controller
    autoload :Config, 'sorcery/controller/config'
    module Submodules
      require 'sorcery/controller/submodules/remember_me'
      require 'sorcery/controller/submodules/session_timeout'
      require 'sorcery/controller/submodules/brute_force_protection'
      require 'sorcery/controller/submodules/http_basic_auth'
      require 'sorcery/controller/submodules/activity_logging'
      require 'sorcery/controller/submodules/external'
      require 'sorcery/controller/submodules/change_password_date'
      require 'sorcery/controller/submodules/password_history'
    end
  end

  module Protocols
    require 'sorcery/protocols/oauth'
    require 'sorcery/protocols/oauth2'
  end

  module CryptoProviders
    require 'sorcery/crypto_providers/common'
    require 'sorcery/crypto_providers/aes256'
    require 'sorcery/crypto_providers/bcrypt'
    require 'sorcery/crypto_providers/md5'
    require 'sorcery/crypto_providers/sha1'
    require 'sorcery/crypto_providers/sha256'
    require 'sorcery/crypto_providers/sha512'
  end

  module TestHelpers
    require 'sorcery/test_helpers/internal'

    module Rails
      require 'sorcery/test_helpers/rails/controller'
      require 'sorcery/test_helpers/rails/integration'
      require 'sorcery/test_helpers/rails/request'
    end

    module Internal
      require 'sorcery/test_helpers/internal/rails'
    end
  end

  require 'sorcery/adapters/base_adapter'

  if defined?(ActiveRecord::Base)
    require 'sorcery/adapters/active_record_adapter'
    ActiveRecord::Base.extend Sorcery::Model

    ActiveRecord::Base.send :define_method, :sorcery_adapter do
      @sorcery_adapter ||= Sorcery::Adapters::ActiveRecordAdapter.new(self)
    end

    ActiveRecord::Base.send :define_singleton_method, :sorcery_adapter do
      Sorcery::Adapters::ActiveRecordAdapter.from(self)
    end
  end

  if defined?(Mongoid::Document)
    require 'sorcery/adapters/mongoid_adapter'
    Mongoid::Document::ClassMethods.send :include, Sorcery::Model

    Mongoid::Document.send :define_method, :sorcery_adapter do
      @sorcery_adapter ||= Sorcery::Adapters::MongoidAdapter.new(self)
    end

    Mongoid::Document::ClassMethods.send :define_method, :sorcery_adapter do
      Sorcery::Adapters::MongoidAdapter.from(self)
    end
  end

  require 'sorcery/engine' if defined?(Rails)
end
