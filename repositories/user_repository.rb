# complex queries and data access for business logic/ intelligence:

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

        # uses ActiveRecord Model `.find_by` method (DIRECTLY)
        @data_source.find_by(email: email.downcase.strip)
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

    # NEW PERSISTENCE METHODS (Data Access Logic) HERE!!
    def save_user(user)
        if user.save
            {success: true, user: user}
        else
            {success: false, errors: user.errors.full_messages}
    end
    def create_user(attributes)
        user = @data_source.new(attributes)
        save_user(user)
    end

    def update_user(user, attributes)
        user.assign_attributes(attributes)
        save_user(user) 
    end
    def delete_user(user)
        user.destroy
        {success: true}
    rescue => e
        {success: false, error: e.message}
    end

    # ADD COMPLEX QUERIES (Domain-specific Data Access)

    def find_users_for_password_reset
    end
    
    # BUSINESS LOGIC:

    # complex queries for business actions:
    # may combine :scope with complex query
    def add_users_for_marketing_promo
        # write complext combination here!
        @data_source.active.registered_today.joins(:orders).where("orders.total > 50")
    end

    # AGGREGATION METHODS: (Business intel logic)

    # used for business analytics and reports:
    def user_count
        @data_source.user_count
    end
    def find_users_registered_today
        # A simple & chainable :scope in the User#Model?
        @data_source.active.registered_today
    end
    def user_by_registeration_month
        @data_source.group("DATE_TRUNC('month', created_at)").count
    end
end