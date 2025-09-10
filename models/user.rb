# create the User model

# ActiveRecord automatically maps the User model to the `users` table.
# handles getters and setters methods
# Provides basic technical methods: `save`, `update`,`delete`, `find methods`
# Provides validation methods
class User < ActiveRecord::Base

    # VALIDATIONS: Business Logic
    # basic form: `validates(symbol: :first_name, options: { presence: true })`
    # validates(:first_name, :last_name, :email, {presence: true})
    
    validates :first_name, :last_name, :email, presence: true
    validates :email, uniqueness: {case_sensitive: false}, format: {with: URI::MailTo::EMAIL_REGEXP}
    validates :password, length: {minimum: 6}, allow_null: true

    # password is stored in memory; not stored in DB
    attr_accessor :password

    # CALLBACKS:
    # encrypt_password and normalize email are custom methods
    before_save :encrypt_password, if: :password_present?
    before_save :normalize_email


    # SCOPES: reusable query methods:
    # Scope adds a Class method for retrieving and querying objects
    
    # `->` creates a lambda (anonymous function)
    # e.g `scope(:active, lambda { where(active: true) })`
    # e.g. `method_name(:symbol, lambda, lambda_body)`
    # :symbol is dynamically converted into a method

    # basic form: `def self.my_scope(name, block)`
    # class User < ActiveRecord::Base
    #     def self.active
    #         where(active: true)
    #     end
    # end

    scope :active, -> { where(active: true) }
    scope :recent, -> { order(created_at: :desc) }
    scope :by_name, -> { order(:last_name, :first_name) }

    # INSTANCE METHODS

    def initials
        return "#{:first_name[0]}. #{last_name[0]}".upcase
    end

    def authenticate(plain_password)
        password_digest == encrypt_string(plain_password)
    end


    # CLASS METHODS
    
    # finder methods -> these could be in the USER#REPOSITORY:
    def self.find_by_email(email)
        find_by(email: email.downcase.strip)
    end

    def self.search_by_name(query)
        where(
            "LOWER(first_name) LIKE :query OR LOWER(last_name) LIKE :query",
            query: "%#{query.downcase}%"
        )
    end


    # SANITIZE & 'SECURE'

    private
    def password_present?
        password.present?
    end
    def encrypt_password
        self.password_digest = encrypt_string(password)
    end
    def encrypt_string(string)
        require 'digest' # Ruby's built-in hashing library (DEMO ONLY - not production)
        Digest::SHA256.hexdigest("#{string}_salty_melon")
    end
    def normalize_email
        self.email = email.downcase.strip
    end