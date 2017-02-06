class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer
      t.datetime :when
      t.boolean :ignore
      t.string :colour

      t.integer :question_id
    end
  end
end
