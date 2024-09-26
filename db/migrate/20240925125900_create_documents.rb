class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :content
      t.string :document_link

      t.timestamps
    end
  end
end
