class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.column :address, :string
      t.column :to, :string
      t.column :subject, :string
      t.column :text, :string

      t.timestamps
    end
  end
end
