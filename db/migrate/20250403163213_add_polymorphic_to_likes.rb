class AddPolymorphicToLikes < ActiveRecord::Migration[7.0]
  def change
    # Ajouter la colonne polymorphique uniquement si elle n'existe pas déjà
    unless column_exists?(:likes, :likable_type)
      add_reference :likes, :likable, polymorphic: true, null: false
    end
  end
end
