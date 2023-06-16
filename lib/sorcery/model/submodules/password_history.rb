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
          end
        end
      end
    end
  end