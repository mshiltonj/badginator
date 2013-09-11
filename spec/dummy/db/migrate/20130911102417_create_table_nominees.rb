class CreateTableNominees < ActiveRecord::Migration
  def change
    create_table :nominees do |t|
      t.string :name
      t.timestamps
    end
  end
end
