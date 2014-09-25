class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :short_url, null: false, unique: true
      t.text   :url,       null: false
      t.text   :token,     null: false, unique: true

      t.timestamps
    end
  end
end
