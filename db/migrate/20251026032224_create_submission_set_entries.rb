class CreateSubmissionSetEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :submission_set_entries do |t|
      t.references :submission_set, null: false, foreign_key: true
      t.references :submission, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
