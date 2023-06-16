module Sorcery
    module Model
      module Submodules

        module External
          def self.included(base)
            base.sorcery_config.class_eval do
              attr_accessor :change_date_limit,
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
            def change_password!()
                return 'hello'
            end
          end
        end
      end
    end
  end