require 'ysd-md-user-profile' unless defined?Users::Profile
require 'ysd-md-user-connected_user'

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
    include Users::ConnectedUser 

    def self.included(model)
      
      if model.respond_to?(:property)
        model.property :creation_date, DateTime, :field => 'creation_date' # The creation date
        model.property :creation_user, String, :field => 'creation_user', :length => 20 # The user who created it
        model.property :last_update, DateTime, :field => 'last_update'     # If the content has been modified it holds the last update date
        model.property :last_update_user, String, :field => 'last_update_user', :length => 20 # The user who updated it
      end

      if model.respond_to?(:before)

        model.before :create do
          attribute_set(:creation_date, Time.now) if self.creation_date.nil? or self.creation_date.empty?
          attribute_set(:creation_user, connected_user.username) if connected_user
        end

        model.before :update do
          attribute_set(:last_update, Time.now)
          attribute_set(:last_update_user, connected_user.username) if connected_user
        end

      end
    
    end
    
  end #Auditor
  
end #Audit