# console.rb sets up your application environment
# Load the entire app
require_relative 'app'

def setup_console
  @app = App.new              # Create app instance
  @user_repo = UserRepository.new  # Create repository instance
  
  puts "🔧 Console Ready!"
  puts "Available objects:"
  puts "  @app       - Main application"
  puts "  @user_repo - User repository"  
  puts "  User       - ActiveRecord model"
end

setup_console
if __FILE__ == $0
    require 'pry'
    puts "Starting interactive console..."
    binding.pry
end