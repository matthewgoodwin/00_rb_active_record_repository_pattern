class CreateUsers < ActiveRecord::Migration[7.0]
    def up
        create_table :users do |t|
            t.string :first_name, null: false, limit: 50
            t.string :last_name, null: false, limit: 50
            t.string :email, null: false, limit: 255
            t.string :password_digest, null: false

            t.timestamps

            t.index :email, unique: true
        end
    end
    def down
        drop_table :users
    end
end