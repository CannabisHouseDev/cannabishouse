# frozen_string_literal: true

class HomeController < ApplicationController
  after_action :generate_meta_tags

  def index
    set_meta_tags(title: 'Strona główna')
    @posts = if user_signed_in?
               Post.published.order('post_date DESC').page params[:page]
             else
               Post.published.where(inner: false).order('post_date DESC').page params[:page]
             end
  end

  def blog
    set_meta_tags(title: 'Blog')
    @posts = if user_signed_in?
               Post.blog.order('post_date DESC').page params[:page]
             else
               Post.blog.where(inner: false).order('post_date DESC').page params[:page]
             end
  end

  def map
    set_meta_tags(title: 'Mapa')
  end

  def under_construction; end

  private

  def generate_meta_tags
    prepare_meta_tags title: 'Cannabis House - Strona Główna',
                      description: 'Strona Stowarzyszenia Cannabis House z siedzibą w Łodzi. Przyłącz się do naszych działań :) Wspomóż nas swoją inicjatywą.'
  end
end
