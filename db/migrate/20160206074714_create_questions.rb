class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :type
      t.text :common_answers

      t.timestamps null: false
    end
  end
end
