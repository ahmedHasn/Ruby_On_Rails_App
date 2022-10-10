class RemoveColumnNumberApplication < ActiveRecord::Migration[7.0]
  def change
    remove_column :applications, :number
  end
end
