require 'date'

module Audit

  #
  # Concrete auditor for Persistence models
  #
  module AuditorPersistence
         
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
     
  
  end #AuditorPersistence

end #Audit