module Sorcery
    module Controller
      module Submodules

        module PasswordHistory
          def self.included(base)
            base.send(:include, InstanceMethods)
          end
  
          module InstanceMethods
        
            def add_history!(user)
                self.password_history.create({
                    user_id:          user.id,
                    crypted_password: user.crypted_password,
                    salt:             user.salt
                })
            end

            def in_history?(password)
                res = false

                self.password_history.each do |item|
                    check = self.sorcery_config.encryption_provider.matches?(item.crypted_password, password, item.salt)
                    
                    return check if chec
                end

                return res
            end
  
          end
        end
      end
    end
  end
  