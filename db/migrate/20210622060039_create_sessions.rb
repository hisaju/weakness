class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.string :session_key
      t.text :content

      t.timestamps
    end
  end
end
