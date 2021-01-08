class HomeController < ApplicationController
  after_action :generate_meta_tags

  def index
    set_meta_tags(title: 'Strona główna')
  end
  
  def blog
    set_meta_tags(title: 'Blog')
  end

  def map
    set_meta_tags(title: 'Mapa')
  end

  def under_construction
  end

  private
  def generate_meta_tags
    prepare_meta_tags title: "Cannabis House - Strona Główna", description: "Strona Stowarzyszenia Cannabis House z siedzibą w Łodzi. Przyłącz się do naszych działań :) Wspomóż nas swoją inicjatywą."
  end
end
