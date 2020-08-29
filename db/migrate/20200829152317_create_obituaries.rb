class CreateObituaries < ActiveRecord::Migration[6.0]
  def change
    create_table :obituaries do |t|
      t.string :name, nil: false
      t.timestamp :dod, nil: false
      t.string :link, nil: false
      t.string :funeral_home, nil: false

      t.timestamps
    end

    add_index :obituaries, [:name, :dod, :funeral_home], unique: true
  end
end
