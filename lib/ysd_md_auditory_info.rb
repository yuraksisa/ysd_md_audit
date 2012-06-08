module Auditory
  #
  # Extends a model adding audit information, that is, the date and the user who created the resource and who last updated it.
  # 
  # To add this information 
  #
  module AuditoryInfo

    def self.included(model)

      model.property :creation_date, DateTime, :field => 'creation_date' # The creation date
      model.property :creation_user, DateTime, :field => 'creation_user' # The user who created it
      model.property :last_update, DateTime, :field => 'last_update'     # If the content has been modified it holds the last update date
      model.property :last_update_user, String, :field => 'last_update_user', :length => 20 # The user who updated it
    
    end

    # Overwritten to store auditory data
    #
    def create
     
      attribute_set(:creation_date, Time.now) if (attribute_get(:creation_date).nil? or not attribute_get(:creation_date) or attribute_get(:creation_date).to_s.strip.length == 0)
      
      if AuditoryInfo.method_defined?(:connected_user) 
        attribute_set(:creation_user, connected_user.username)
      end
      super
    end 

    # Overwritten to store auditory data
    #
    def update
      attribute_set(:last_update, Time.now)
      if AuditoryInfo.method_defined?(:connected_user)
        attribute_set(:last_update_user, connected_user.username)
      end
      
      super
    end

  end #AuditoryInfo
end #Auditory