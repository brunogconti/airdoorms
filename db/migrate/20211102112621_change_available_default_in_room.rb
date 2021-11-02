class ChangeAvailableDefaultInRoom < ActiveRecord::Migration[6.0]
  def change
    change_column_default :rooms, :available, false
  end
end
