# frozen_string_literal: true

class Page < ApplicationRecord
  has_ancestry

  validates :name, presence: true, uniqueness: true, format: { with: /\A[а-яa-z0-9_]*\z/i }
  validates :title, :content, presence: true

  before_save :html_processing

  def full_path
    ancestors.map(&:name).append(name).join('/')
  end

  private

  def html_processing
    self.content = content
                   .gsub(/\*(.+?)\*/, '<b>\1</b>')
                   .gsub(/\\\\(.+?)\\\\/, '<i>\1</i>')
                   .gsub(/\(\((.+?) (.+?)\)\)/, '<a href="/\1">\2</a>')
  end
end
