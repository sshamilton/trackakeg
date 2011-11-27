class CreateKegs < ActiveRecord::Migration
  def self.up
    create_table :kegs do |t|
      t.integer :kegweight
      t.float :kegtemp

      t.timestamps
    end
  end

  def self.down
    drop_table :kegs
  end
end
