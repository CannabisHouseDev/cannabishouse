# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :prepare_meta_tags, :set_locale

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  protected

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

  def after_sign_in_path_for(resource)
    onboarding_path if !resource.onboarded?
    case resource.profile.role
    when "user"
      #todo
    when "participant"
      #todo
    when "dispensary"
      #todo
    when "doctor"
      #todo
    when "researcher"
    #todo
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
