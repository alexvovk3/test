# frozen_string_literal: true

Rails.application.routes.draw do
  root  'pages#index'

  get   '/add',       to: 'pages#new_root', as: :root_page_new
  post  '/add',       to: 'pages#create',   as: :root_page_create

  get   '*path/add',  to: 'pages#new',      as: :page_new
  post  '*path/add',  to: 'pages#create',   as: :page_create

  get   '*path/edit', to: 'pages#edit',     as: :page_edit
  patch '*path/edit', to: 'pages#update',   as: :page_update

  get   '*path',      to: 'pages#show',     as: :page_show
end
