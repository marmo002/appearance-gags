class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media_files do |t|
      t.string :title
      t.string :audio_link
      t.string :video_link
      t.boolean :is_approved, default: false
      t.text :edit
      t.references :booking, foreign_key: true
    end
  end
end
