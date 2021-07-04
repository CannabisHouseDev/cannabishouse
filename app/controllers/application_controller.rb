# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :prepare_meta_tags, :set_locale
  before_action :set_paper_trail_whodunnit
  before_action :authenticate_user!
  add_flash_types :success, :error

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  protected

  def can_administer?
    %w[admin researcher doctor].include? current_user.profile.role
  end

  def prepare_meta_tags(options = {})
    site = t('company.name')
    site_name = 'cannabishouse.eu'
    title = [controller_name, action_name].join(' ')
    description = t('company.description')
    icon = '/favicon.png'
    image = '/logo-ch.jpg'
    current_url = request.url

    # Let's prepare a nice set of defaults

    defaults = {

      site: site_name,
      title: title,
      icon: icon,
      description: description,
      keywords: %w[cannabishouse eksperyment społeczny badania naukowe cannabis house reglamentacja regla-permis nauka
                   konopie social experiments scientific research science weed],
      twitter: { site_name: site_name,
                 site: '@CannabisHouseEU',
                 card: 'summary',
                 description: description,
                 image: image },
      og: { url: current_url,
            site_name: site_name,
            title: title,
            image: image,
            description: description,
            type: 'website' }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
