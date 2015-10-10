class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.integer :user_id
      t.integer :match_id
      t.boolean :given

      t.timestamps null: false
    end
  end
end
