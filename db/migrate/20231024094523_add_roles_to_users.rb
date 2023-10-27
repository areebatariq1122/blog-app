class AddRolesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :roles, :string
  end

  def up
    if user = User.find_by(email: 'admin@example.com')
      user.add_role(:admin) if user
    else
      user.add_role(:visitor) if user
    end
  end

  def down
    Role.where(name: ['admin', 'moderator']).delete_all
  end

end

