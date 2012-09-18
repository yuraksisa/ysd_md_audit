module Audit

  #
  # Concrete auditor for DataMapper models
  #
  module AuditorDataMapper
    include Auditor
    
    def self.included(model)
      Auditor.prepare_model(model)       
    end
            
  end #AuditorDataMapper
  
end #Audit