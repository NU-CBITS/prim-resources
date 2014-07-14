class CreateIpAddressNumber < ActiveRecord::Migration
  def change
    create_table :ip_address_numbers do |t|
      t.string :number
      t.references :participant, index: true

      t.timestamps
    end
  end
end
