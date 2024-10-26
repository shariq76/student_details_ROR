class CreateStudents < ActiveRecord::Migration[7.2]
  def change
    create_table :students do |t|
      t.string :name
      t.string :subject
      t.integer :mark

      t.timestamps
    end
  end
end
