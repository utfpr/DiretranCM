class AddAdminToUsuario < ActiveRecord::Migration[5.0]
  def change
    add_column :usuarios, :admin, :boolean, default: false
  end
end
