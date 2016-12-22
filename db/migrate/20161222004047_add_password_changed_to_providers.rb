class AddPasswordChangedToProviders < ActiveRecord::Migration[5.0]
  def change
    add_column :providers, :password_changed, :boolean, defaul: false
  end
end
