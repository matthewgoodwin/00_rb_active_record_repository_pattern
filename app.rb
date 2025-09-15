# app.rb - application entry

# require resources

require 'bundler/setup'
require_relative 'lib/database'
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
        CreateUsers.new.up unless User.table_exists?
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
        invalid_user = User.new(email: "invalid")
        unless invalid_user.save
            puts "Validation Error: #{invalid_user.errors.full_message}"
        end
    end
    
    def demo_repository_pattern  
    end
end