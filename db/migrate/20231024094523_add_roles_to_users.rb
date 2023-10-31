class AddRolesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :roles, :string
  end

  def up
    if user = User.find_by(email: 'admin@example.com')
      user.add_role(:admin) if user
    elsif user
      user.add_role(:visitor)
    end
  end

  def down
    Role.where(name: %w[admin moderator]).delete_all
  end
end
