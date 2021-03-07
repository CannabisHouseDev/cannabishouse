Cannabis House
================

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)


Ruby on Rails
-------------

This application requires:

- Ruby 3.0.0
- Rails 6.1.1

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Getting Started
---------------------
1. Be sure you got correct ruby versions [ you can check your ruby version with <code>rmv list</code>]
2. If not install it with <code>rvm install ruby-X.X.X</code> then use <code>rvm --default use ruby-X.X.X</code>
3. Be sure you got correct version of RAILS [ you can check version via <code>rails -v</code> ]
4. If not install it with <code>gem install rails -v x.x.x</code>
5. Install additional software <code>ngrok</code> it's a client peace of software for getting callbacks __[ normaly you are requesting as localhost:3000 it's not valid for web services, because they don't know what localhost:3000 is ]__ ngrok makes you public with address that webservices can reach back.
6. Run <code>ngrok http 3000</code> with **port** used by your app **[ default one is :3000 ]**
7. Run <code>bundle install</code>
8. Run <code>rails db:setup</code> 
<br>**Here things get little trticky**
<br>First of all we are using postgres database, so if you don't have one please install it.
<br> 
<br> **moving on...**
<br>We got two files <code>config/application.example.yml</code> & <code>config/database.example.yml</code>
<br>This files are needed for configuring your app, please change names of both files.
<br> Do this by removing "example" from fileNames <code>application.example.yml</code> -> <code>application.yml</code>
<br> provide correct data inside those files, you will need some api keys

9. Run <code>rails s</code>
10. CELEBRATE small win of runnig app \\(^o^)/


For Devise
Edit <code>config/environments/development.rb</code>
put this with Your smtp creds:
<code>
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Don't care if the mailer can't send.
  config.action_mailer.perform_caching = false

  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.delivery_method     = :smtp
  config.action_mailer.smtp_settings       = {
    authentication: :login,
    address:        'yourmailprovider.sth',
    port:           587,
    user_name:      'username@yourmailprovider.sth',
    password:       "HARD_PASSWORD",
    domain:         'cannabishouse.eu',
    enable_starttls_auto: true 
  }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  # Send email in development mode?
  config.action_mailer.asset_host = 'http://localhost:3000'
</code>

Documentation and Support
-------------------------

Issues
-------------

Similar Projects
----------------

Contributing
------------

You're more then welcome to join our dev team. Send message to info@cannabishouse.eu or 

join our slack channel https://join.slack.com/t/cannabishouse/shared_invite/enQtNzAzODY0NjkxMjY4LTI1YTEwMDk0YjkwNGNkMjMzODdmY2I3OWEwYTE1YmQwZjA5ZDc5ZDQ4YzYyOTkwZTc0NDQzZjcwOTA0YWM0ZWM

Credits
-------

License
-------
