class CreateShortUris < ActiveRecord::Migration[5.2]
  def change
    create_table :short_uris do |t|
      t.string :original_uri, null: false
      t.string :short_uri, null: false
      t.integer :times_clicked, default: 0

      t.timestamps
    end
  end
end
