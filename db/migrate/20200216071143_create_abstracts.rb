class CreateAbstracts < ActiveRecord::Migration[5.1]
  def change
    create_table :abstracts do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :author
      t.string :doi
      t.text :body

      t.timestamps
    end
  end
end
