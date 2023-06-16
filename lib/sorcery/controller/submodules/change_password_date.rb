module Sorcery
    module Controller
      module Submodules

        module ChangePasswordDate
          def self.included(base)
            p ['---------------- ChangePasswordDate.base', base]
            base.send(:include, InstanceMethods)
          end
  
          module InstanceMethods
        
            def change_password!(old_password, password, password_confirmation)
                p ['------------------------ ChangePasswordDate.change_password!', old_password, password, password_confirmation]

                is_old_password_match = current_user.valid_password?(old_password)
                is_new_password_match = password == password_confirmation

                res = false

                if is_old_password_match && is_new_password_match
                    last_change_password_date = Time.now

                    res = current_user.update({
                        password:                  password,
                        password_confirmation:     password_confirmation,
                        last_change_password_date: last_change_password_date
                    })
                end

                return res
            end
  
          end
        end
      end
    end
  end
  