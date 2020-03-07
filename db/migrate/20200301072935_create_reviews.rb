class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :image
      t.text :content
      t.string :recommend
      t.references :user, foreign_key: true
      t.references :shop, foreign_key: true
      t.references :genre, foreign_key: true

      t.timestamps
    end
  end
end
