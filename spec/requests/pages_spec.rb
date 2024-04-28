# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :request do
  let(:page_attributes) { { title: 'test', content: 'test' } }

  describe 'GET /' do
    it 'renders a successful response' do
      get root_path
      expect(response).to be_successful
    end
  end

  describe 'GET /page' do
    it 'renders a successful response' do
      page = Page.create(page_attributes.merge(name: 'page1'))
      get page_show_path(page.full_path)
      expect(response).to be_successful
    end
  end

  describe 'GET /add' do
    it 'renders a successful response' do
      get root_page_new_path
      expect(response).to be_successful
    end
  end

  describe 'GET /page/add' do
    it 'renders a successful response' do
      page = Page.create(page_attributes.merge(name: 'page'))
      get page_new_path(page.full_path)
      expect(response).to be_successful
    end
  end

  describe 'GET /page/edit' do
    it 'renders a successful response' do
      page = Page.create(page_attributes.merge(name: 'page'))
      get page_edit_path(page.full_path)
      expect(response).to be_successful
    end
  end

  describe 'POST /add' do
    context 'with valid parameters' do
      it 'creates a new Page' do
        expect do
          post root_page_create_path, params: { page: page_attributes.merge(name: 'page1') }
        end.to change(Page, :count).by(1)
      end

      it 'redirects to the created page' do
        post root_page_create_path, params: { page: page_attributes.merge(name: 'page1') }
        expect(response).to redirect_to(page_show_path(Page.last.full_path))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Page' do
        expect do
          post root_page_create_path, params: { page: page_attributes }
        end.to change(Page, :count).by(0)
      end

      it 'renders a successful response' do
        post root_page_create_path, params: { page: page_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /edit' do
    context 'with valid parameters' do
      it 'updates the requested page' do
        page = Page.create page_attributes.merge(name: 'page')
        patch page_update_path(page.full_path), params: { page: { title: 'new title' } }
        page.reload
        expect(page.title).to eq('new title')
      end

      it 'redirects to the page' do
        page = Page.create page_attributes.merge(name: 'page')
        patch page_update_path(page.full_path), params: { page: { title: 'new title' } }
        page.reload
        expect(response).to redirect_to(page_show_path(page.full_path))
      end
    end

    context 'with invalid parameters' do
      it 'renders a successful response' do
        page = Page.create page_attributes.merge(name: 'page')
        patch page_update_path(page.full_path), params: { page: { title: '' } }
        expect(response).to be_successful
      end
    end
  end
end
