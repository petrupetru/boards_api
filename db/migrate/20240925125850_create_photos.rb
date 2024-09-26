class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.string :content
      t.string :photo_source

      t.timestamps
    end
  end
end
