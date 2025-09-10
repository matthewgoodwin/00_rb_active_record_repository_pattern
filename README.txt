Goals and Methods:
The goal is to demonstrate the ActiveRecord and Repository patterns without the use of Rails.
Legacy systems may not use rails, so its important to understand how the ActiveRecord works under the hood.

###### PROCESS TO RECREATE #####
Step 1: Create Project:

# create the directory
mkdir project_directory (00_rb_active_record_repository_patterns)
cd project_directory (00_rb_active_record_repository_patterns)

# initial the project; create the Gemfile
run `bundle init`

touch README.txt


Step 2: Define the Dependencies in the Gemfile:

- Manage ORM # Use either Rails or ActiveRecord Gem

- Define database adapter # pg, mysql, sqlite3 etc establish adapter accessed by ActiveRecord

- Define Database Migrations without rails # `standalone_migrations` gem uses rake
# gives access to migrations using the `rake` task manager

- Debugging gem # use `pry` in development

- run `bundle install`


### issue report ###
```
An error occurred while installing psych (5.2.6), and Bundler cannot continue. 
In Gemfile: standalone_migrations was resolved to 8.0.0, 
which depends on railties was resolved to 7.2.2.2, 
which depends on irb was resolved to 1.15.2, 
which depends on rdoc was resolved to 6.14.2, 
which depends on psych
```
# This error implies that `psych` gem could not be installed..
# psych is a YAML parser. This is required for `standalone_migrations` to work..

# Homebrew to install:
run `brew install libyaml`

# make sure bundler and rubygems are current:
run `gem update --system`
run `gem install bundler`

# them make sure that any stranded gems/ dependencies are removed before `bundle install`
run `bundle clean --force`
run `bundle install`

This should resolve the issue

## end issue report ###

Step 3: Establish the DB configuration:

# run `mkdir config`
# run `cd config`
# run `touch database.yml`
- `config/database.yml`

Step 4: Establish DB connection Setup:
# run `mkdir lib`
# run `cd lib`
# run `touch database.rb`
-> `lib/database.rb`

Step 5: Create Migration for Users (craete User table)
# db/migrate/00000000000000_create_user.rb
# start irb -> run `formatted_time = Time.now.strftime("%Y%m%d%H%M%S")`
# output `20250909005356`

# run `mkdir db`
# run `cd db`
# run `mkdir migrate`
# run `cd migrate`
# run `touch 20250909005356_create_user.rb`

-> `db/migrate/20250909005356_create_user.rb`