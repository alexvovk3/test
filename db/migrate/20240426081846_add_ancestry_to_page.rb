# frozen_string_literal: true

class AddAncestryToPage < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :ancestry, :string
    add_index :pages, :ancestry
  end
end
