module Sorcery
    module Controller
      module Submodules

        module ChangePasswordDate
          def self.included(base)
            base.send(:include, InstanceMethods)
          end
  
          module InstanceMethods
        
            def change_password!(old_password, password, password_confirmation)        
                is_old_password_match = current_user.valid_password?(old_password)
                is_new_password_match = password == password_confirmation
                update_result         = false

                if is_old_password_match && is_new_password_match
                    last_change_password_date = Time.now

                    update_result = current_user.update({
                        password:                  password,
                        password_confirmation:     password_confirmation,
                        last_change_password_date: last_change_password_date
                    })
                end

                res = {
                    is_old_password_match: is_old_password_match
                    is_new_password_match: is_new_password_match
                    update_result:         update_result
                }

                return res
            end
  
          end
        end
      end
    end
  end
  