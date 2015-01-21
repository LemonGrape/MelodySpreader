class CreateMelodies < ActiveRecord::Migration
  def self.up
    create_table :melodies do |t|
      t.string :name
      t.string :author
      t.string :wav_path
      t.string :sheet_path
      t.string :raw_path
      t.integer :inst
      t.timestamps
    end
  end

  def self.down
    drop_table :melodies
  end
end
