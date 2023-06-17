module Sorcery
    module Model
      module Submodules

        module PasswordHistory
          def self.included(base)
            base.send(:include, InstanceMethods)
            base.extend(ClassMethods)
          end
  
          module ClassMethods

          end
  
          module InstanceMethods
            def add_history!()
              self.password_history.create({
                  user_id:          self.id,
                  crypted_password: self.crypted_password,
                  salt:             self.salt
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