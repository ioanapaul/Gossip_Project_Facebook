class CreatePrivateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :private_messages do |t|
      t.text :content
      t.references :sender, foreign_key: { to_table: :users }  # Crée la clé étrangère vers users
      t.timestamps
    end
  end
end

