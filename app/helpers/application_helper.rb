# frozen_string_literal: true

module ApplicationHelper
  def raw_text(content)
    content
      .gsub(%r{<b>(.+?)</b>}, '*\1*')
      .gsub(%r{<i>(.+?)</i>}, '\\\\\\\\\1\\\\\\\\')
      .gsub(%r{<a href="/(.+?)">(.+?)</a>}, '((\1 \2))')
  end
end
