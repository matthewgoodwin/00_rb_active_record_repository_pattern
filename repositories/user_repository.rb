class UserRepository
    def initialize
        # initialize User Repo with the User Model
        @data_source = User
    end

    # FINDER METHODS (DATA ACCESS LOGIC):

    def find_by_id(id)
        # from `.find` from ActiveRecord
        @data_source.find(id)
    rescue ActiveRecord::RecordNotFound
        nill
    end
    def find_by_email(email)
        # AVOID: redundant /wrappers; Call same `User.find_by_email`:
        # @data_source.find_by_email(email) 
        @data_source.find_by(email) # uses ActiveRecord Model `.find_by` method (DIRECTLY)
    end

    # :SCOPE lambda from User#Model
    def find_all_active_users
        # `.active` and `.by_name` methods defined in the User#Model :scope
        # scopes allow us to chain complex method calls without repeating conditions:
        @data_source.active.by_name
        # User.where(active:true).order(:last_name, :first_name)
    end
    def find_recent(limit= 10)
        @data_source.recent.limit(limit)
    end

    # NOT defined as :SCOPE lambda from User#Model because this method sanitizes data
    def search_users(query)
        return @data_source.none if query.blank?
        @data_source.search_by_name(query)
    end

    #  ADD PERSISTENCE METHODS (Data Access Logic) HERE!!
end