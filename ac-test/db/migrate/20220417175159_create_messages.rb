class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :room, foreign_key: true, index: true

      t.timestamps
    end
  end
end
