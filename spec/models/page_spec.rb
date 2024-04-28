# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:page_attributes) { { title: 'test', content: 'test' } }

  describe 'creates a new page' do
    context 'with valid parameters' do
      it 'should be able to save page' do
        page = Page.new(page_attributes.merge(name: 'test'))
        expect(page.save).to eq(true)
      end
    end

    context 'with invalid parameters' do
      it 'ensures name is present' do
        page = Page.new(page_attributes)
        expect(page.valid?).to eq(false)
      end

      it 'ensures name is uniq' do
        page1 = Page.create(page_attributes.merge(name: 'test'))
        page2 = Page.new(page_attributes.merge(name: 'test'))
        expect(page2.valid?).to eq(false)
      end

      it 'ensures name is in a good format' do
        page1 = Page.new(page_attributes.merge(name: 'test test'))
        page2 = Page.new(page_attributes.merge(name: 'test@test'))
        page3 = Page.new(page_attributes.merge(name: 'test-test'))
        page4 = Page.new(page_attributes.merge(name: 'ая_124GOOD'))
        expect(page1.valid?).to eq(false)
        expect(page2.valid?).to eq(false)
        expect(page3.valid?).to eq(false)
        expect(page4.valid?).to eq(true)
      end

      it 'ensures title is present' do
        page = Page.new(name: 'test', content: 'test')
        expect(page.valid?).to eq(false)
      end

      it 'ensures content is present' do
        page = Page.new(name: 'test', title: 'test')
        expect(page.valid?).to eq(false)
      end
    end
  end

  context 'hierarchy tests' do
    it 'has ancestors' do
      page1 = Page.create(page_attributes.merge(name: 'page1'))
      page2 = Page.create(page_attributes.merge(name: 'page2', parent: page1))
      expect(page1.ancestors.size).to eq(0)
      expect(page2.ancestors.size).to eq(1)
      expect(page2.ancestors.first.id).to eq(page1.id)
    end

    it 'has descendants' do
      page1 = Page.create(page_attributes.merge(name: 'page1'))
      page2 = Page.create(page_attributes.merge(name: 'page2', parent: page1))
      expect(page2.descendants.size).to eq(0)
      expect(page1.descendants.size).to eq(1)
      expect(page1.descendants.first.id).to eq(page2.id)
    end
  end

  specify '#full_path' do
    page1 = Page.create(page_attributes.merge(name: 'page1'))
    page2 = Page.create(page_attributes.merge(name: 'page2', parent: page1))
    page3 = Page.create(page_attributes.merge(name: 'page3', parent: page2))
    expect(page3.full_path == 'page1/page2/page3')
  end

  specify '#html_processing' do
    page = Page.create(name: 'test', title: 'test',
                       content: '*Bold style* \\\\Italic style\\\\ ((name1/name2 Link style))')
    expect(page.content).to eq('<b>Bold style</b> <i>Italic style</i> <a href="/name1/name2">Link style</a>')
  end
end
