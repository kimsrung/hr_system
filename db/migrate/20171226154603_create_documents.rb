class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.text :description
      t.string :assigned_file
      t.string :submitted_file
      t.references :company, foreign_key: true
      t.references :employee, foreign_key: true
      t.references :employer, foreign_key: true

      t.timestamps
    end
  end
end
