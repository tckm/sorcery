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
            def add_history!
              self.password_history.create({
                  user_id:          self.id,
                  crypted_password: self.crypted_password,
                  salt:             self.salt
              })

              clear_old_history
            end

            def in_history?(password)
              res = false

              self.password_history.each do |item|
                check = self.sorcery_config.encryption_provider.matches?(item.crypted_password, password, item.salt)
                    
                return check if check
              end

              return res
            end

            def clear_old_history
              last_n = 5

              if self.password_history.size > last_n
                last_n_history = self.password_history.order("id DESC")
                                                      .limit(last_n)
              
                min_id = last_n_history.select("MIN(id) AS min_id")[0]
                                       .min_id

                delete_res = self.password_history.where("id <= ?", min_id)
                                                  .delete_all
              end  
            end
          end
        end
      end
    end
  end