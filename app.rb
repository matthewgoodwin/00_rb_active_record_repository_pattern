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
    end
    def demo_activerecord_pattern
    end
    def demo_repository_pattern  
    end
end