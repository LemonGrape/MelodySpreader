class CreateMelodies < ActiveRecord::Migration
  def self.up
    create_table :melodies do |t|
      t.string :name
      t.string :author
      t.string :desc
      t.string :duration
      t.string :wav_path
      t.string :sheet_path
      t.string :raw_path
      t.integer :inst
      t.integer :composer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :melodies
  end
end
