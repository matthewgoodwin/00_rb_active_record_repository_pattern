# lib/database.rb
require 'active_record'
require 'yaml'

class Database
    def self.establish_connection(environment = 'development')
        config = DATABASE_CONFIG(environment)
        # puts "#{config['database']}"
        # puts "#{config['port']}"

        # pass in the `development` hash as method `arg`
        # ActiveRecord::Base.establish_connection(DATABASE_CONFIG['development'])
        ActiveRecord::Base.establish_connection(config)

        # test DB connectivity:
        begin
            ActiveRecord:Base.connection.execute("SELECT 1")
            puts "DB connection successful!"
        rescue => exception
            puts "DB connection failed #{exception.message}"
            raise exception
        end
    end

    # create the database:
    # set defaut environment to 'development':
    def self.create_database(environment= 'development')
        config = DATABASE_CONFIG[environment]

        # use `.merge()` to merge hashes ( `config` + `{'database' => 'postgres'}` )
        # new hash contains `config` + 'database' property set to 'postgres'
        admin_config = config.merge('database' => 'postgres')
        ActiveRecord::Base.establish_connection(admin_config)

        begin
            ActiveRecord:Base.connection.execute("CREATE DATABASE '#{config['database']}' ")
            puts "Database: #{config['database']} created!"
        rescue ActiveRecord::StatementInvalid => exception
            if exception.message.include?("already exists")
                # development[database]
                puts "Database #{config['database']} already exists!"
            else
                raise exception
            end  
        end

        # Reconnect to our actual database
        establish_connection(environment)
    end
end
