# app.rb - application entry

# require resources

require 'bundler/setup'
require_relative 'lib/database'
require_relative 'db/migrate/20250909005356_create_users.rb'
require_relative 'models/user'
require_relative 'repositories/user_repository'

# create app; init database and User#Repository

class App
    def initialize
        setup_database
        @user_repository = UserRepository.new()
    end
    def run
        puts ("ruby active record app!")
        demo_activerecord_pattern
        demo_repository_pattern
        puts "demo completed!"
    end

    private

    def setup_database
        # create and connect to database:
        Database.create_database
        Database.establish_connection

        # run migrations
        # CreateUsers.new.up unless User.table_exists?
        # run manually:
        run_migrations
    end

    def run_migrations
        unless ActiveRecord::Base.connection.table_exists?(:users)
            puts "Running Migrations..."
            CreateUsers.new.up
            puts "migration complete!"
        else
            puts "Table already exists. Skipping migration..."
        end 
    end

    def demo_activerecord_pattern
        puts "ACTIVERECORD!"
        puts "*"*50
        # create users with ActiveRecord Pattern
        
        user_1 = User.new(
            first_name: "Charlie",
            last_name: "Brown",
            email: "charlie@activerecord.com",
            password: "cb123_password"
        )
        user_1.save!

        user_2 = User.new(
            first_name: "Mary",
            last_name: "Jane",
            email: "mary@activerecord.com",
            password: "mj123_password"
        )
        user_2.save!

        # Demonstrate ActiveRecord user queries:
        puts "ActiveRecord User Queries:"
        puts "Total Users: #{User.count}"
        puts "Recent Users: #{User.recent.limit(2)}"
        puts "User By Name: #{User.by_name.pluck(:email)}"
        puts "FINDER METHOD: Find By Email !"
        user_found = User.find_by_email('mary@activerecord.com')
        puts "User found: #{user_found&.full_name}"

        # validations here:
        # invalid_user = User.new(email: "invalid")
        # if invalid_user.valid?
        #     puts "user valid"
        # else
        #     puts "Validation Error: #{invalid_user.errors.full_messages.join(', ')}"
        # end
    end
    
    def demo_repository_pattern
        puts "REPOSITORY PATTERN"
        puts "*"*50

        # use repo for data access:
        puts "Using REPOSITORY for Data Access!"

        result = @user_repository.create_user(
            first_name: "super",
            last_name: "man",
            email: "superman@repository.com",
            password: "sm123_password"
        )
        # .create_user(attributes) calls .save_user(user)
        # save_user() returns a object: `{ success: true, user: user }`
        # or an error message `{success: false, errors: user.errors.full_messages}`
        if result[:success]
            # the :user object is passed in and set as user
            puts "success: Repository created #{result[:user].full_name}"
        else
            # the :errors is assigned if :save_user is false:  
            puts "failure: Repository failed: #{result[:errors]}"
        end

        # repo finder methods:
        active_users = @user_repository.find_all_active_users
        puts "REPO find all users..."
        puts "active users: #{active_users.count}"

        recent_users = @user_repository.find_recent_users(2)
        puts "REPO find recent users..."
        puts "recent users: #{recent_users.map(&:email)}"

        # repository search:
        # search_users via Model query of fname:
        puts "REPO Search..."
        search_result = @user_repository.search_users("Charlie")
        # use results to return full name:
        puts "search for Charlie: #{search_result.map(&:full_name)}"

        # repository analytics:
        # search for user data
        puts "REPO Analytics..."
        users_today = @user_repository.find_users_registered_today.count
        puts "users registered today: #{users_today}"
    end # end of demo_repository_pattern
end