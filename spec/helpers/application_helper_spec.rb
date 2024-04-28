# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  specify '#raw_text' do
    content = '<b>Bold style</b> <i>Italic style</i> <a href="/name1/name2">Link style</a>'
    expect(raw_text(content)).to eq('*Bold style* \\\\Italic style\\\\ ((name1/name2 Link style))')
  end
end
