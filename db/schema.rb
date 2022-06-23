ActiveRecord::Schema[7.0].define(version: 20_220_623_004_049) do
  create_table 'users', force: :cascade do |t|
    t.string 'student_number'
    t.string 'name'
    t.boolean 'entry'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
