class PasswordHistory < <%= migration_class_name %>
  def change
    create_table :password_history do |t|
      t.integer user_id,          null: false
      t.string :crypted_password, null: false
      t.string :salt,             null: false

      t.timestamps                null: false
    end
  end
end