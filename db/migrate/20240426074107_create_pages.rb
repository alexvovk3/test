# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.string :name, null: false
      t.string :title, null: false
      t.text :content, null: false

      t.index :name, unique: true

      t.timestamps
    end
  end
end
