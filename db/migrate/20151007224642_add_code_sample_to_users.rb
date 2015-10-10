class AddCodeSampleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :code_sample, :text
  end
end
