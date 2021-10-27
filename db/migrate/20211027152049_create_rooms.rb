class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :title
      t.text :description
      t.string :address
      t.string :room_type
      t.float :value

      t.timestamps
    end
  end
end
