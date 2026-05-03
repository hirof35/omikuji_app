class CreateResults < ActiveRecord::Migration[8.0]
  def change
    create_table :results do |t|
      t.string :fortune
      t.string :message

      t.timestamps
    end
  end
end
