class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :student_number
      t.string :name
      t.boolean :entry

      t.timestamps
    end
  end
end
