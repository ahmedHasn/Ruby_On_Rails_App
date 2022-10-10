class AddIndexOnTokenColumn < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :applications, :token, algorithm: :default
  end
end
