class CreateSubmissionSets < ActiveRecord::Migration[8.0]
  def change
    create_table :submission_sets do |t|
      t.references :owner, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
