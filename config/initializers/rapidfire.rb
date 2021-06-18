Rails.application.config.after_initialize do
  Rails.application.reload_routes!

  Rapidfire::ApplicationController.class_eval do
    main_app_methods = Rails.application.routes.url_helpers.methods
    main_app_route_methods = main_app_methods.select{|m| m =~ /_url$/ || m =~ /_path$/ }
    main_app_route_methods.each do |m|
      define_method m do |*args|
        main_app.public_send(m, *args)
      end
      helper_method m
    end
  end
end
