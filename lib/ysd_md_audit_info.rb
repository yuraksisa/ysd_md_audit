module Audit

  # Model auditor
  #
  # It holds the audit information, that is, the date and the user who created the resource and who last updated it.
  # It also allows us to know who is the user which performs the operation.
  #
  #
  # To add this information to a resource, just include the module
  #
  # class MyModel
  #     include Persistence::Model
  #     include Audit::Auditor
  #
  # end
  #
  #
  module Auditor

    def self.prepare_model(model)

      model.property :creation_date, DateTime, :field => 'creation_date' # The creation date
      model.property :creation_user, DateTime, :field => 'creation_user' # The user who created it
      model.property :last_update, DateTime, :field => 'last_update'     # If the content has been modified it holds the last update date
      model.property :last_update_user, String, :field => 'last_update_user', :length => 20 # The user who updated it
    
    end
    
    #
    # Returns the connected user
    #
    def connected_user
      nil
    end

  end #Auditor
  
  #
  # Concrete auditor for DataMapper models
  #
  module AuditorDataMapper
    include Auditor
    
    def self.included(model)
      Auditor.prepare_model(model)       
    end
            
  end
  
  #
  # Concrete auditor for Persistence models
  #
  module AuditorPersistence
     include Auditor
    
    def self.included(model)
      Auditor.prepare_model(model)       
    end    
     
    #
    # Overwritten to store auditory data
    #
    def create
     
      attribute_set(:creation_date, Time.now) if not attribute_get(:creation_date) or attribute_get(:creation_date).to_s.strip.length == 0
      attribute_set(:creation_user, connected_user.username) if connected_user
      
      super

    end 

    # Overwritten to store auditory data
    #
    def update
    
      attribute_set(:last_update, Time.now)
      attribute_set(:last_update_user, connected_user.username) if connected_user
      
      super
    
    end
     
  
  end
  
  
end #Auditory