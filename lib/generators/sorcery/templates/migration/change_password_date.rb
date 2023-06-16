class SorceryChangePasswordDate < <%= migration_class_name %>
  def change
    add_column :<%= tableized_model_class %>, :last_change_password_date, :date, default: nil
  end
end