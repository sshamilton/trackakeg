class CreateKegs < ActiveRecord::Migration
  def change
    create_table :kegs do |t|
      t.integer :kegweight
      t.float :kegtemp

      t.timestamps
    end
  end
end
