class CreateComposers < ActiveRecord::Migration
  def self.up
    create_table :composers do |t|
      t.string :name
      t.string :email
      t.string :twitter
      t.string :desc
      t.timestamps
    end
  end

  def self.down
    drop_table :composers
  end
end
