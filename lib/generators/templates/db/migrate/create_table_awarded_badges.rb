class CreateTableAwardedBadges < ActiveRecord::Migration
  def change
    create_table :awarded_badges do |t|
      t.integer :awardee_id  
      t.string  :awardee_type  
      t.string  :badge_code
      t.timestamps
    end

    add_index :awarded_badges, [:awardee_id, :awardee_type, :badge_code], unique: true
  end
end
