# frozen_string_literal: true

json.extract! post, :id, :title, :body, :status, :user_id, :post_date, :image, :slug, :inner, :created_at, :updated_at
json.url post_url(post, format: :json)
