module Sorcery
    module Controller
      module Submodules

        module PasswordHistory
          def self.included(base)
            base.send(:include, InstanceMethods)
          end
  
          module InstanceMethods
          end
        end
      end
    end
  end
  