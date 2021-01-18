class ApplicationController < ActionController::Base
  before_action :prepare_meta_tags

  protected

  def prepare_meta_tags(options={})

    site = "Cannabis House"
    site_name = 'cannabishouse.eu'
    title = [controller_name, action_name].join(" ")
    description = "Stowarzyszenie Cannabis House"
    icon = '/favicon.png'
    image = '/logo-ch.jpg'
    current_url = request.url

    # Let's prepare a nice set of defaults

    defaults = {

      site: site_name,
      title: title,
      icon: icon,
      description: description,
      keywords: %w[cannabishouse eksperyment społeczny badania naukowe cannabis house reglamentacja regla-permis nauka konopie],
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
end
