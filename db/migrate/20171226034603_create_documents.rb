class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.text :description
      t.string :file
      t.references :company_id, foreign_key: true
      t.references :employee_id, foreign_key: true

      t.timestamps
    end
  end
end
