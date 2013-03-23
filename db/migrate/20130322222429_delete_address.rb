class DeleteAddress < ActiveRecord::Migration
  def change
    remove_column :emails, :address
  end
end
