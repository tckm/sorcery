module Sorcery
    module Model
      module Submodules

        module ChangePasswordDate
          def self.included(base)
            base.sorcery_config.class_eval do
              attr_accessor :change_date_limit
            end
  
            base.sorcery_config.instance_eval do
              @defaults.merge!(:@change_date_limit => 90)
  
              reset!
            end
  
            base.send(:include, InstanceMethods)
            base.extend(ClassMethods)
          end
  
          module ClassMethods
 
          end
  
          module InstanceMethods
          end
        end
      end
    end
  end