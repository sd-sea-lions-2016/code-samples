class CreateContacts < ActiveRecord::Migration
  def change
    # Create table for contacts here
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
    end
  end
end
