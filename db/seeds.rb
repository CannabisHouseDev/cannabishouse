# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


pages = Page.create([{title: "testowa strona", body: "<h1> TEST<br><p>Testowy paragraph", slug: "testowa-strona", show_in_menu: true}, 
                     {title: "Stowarzyszenie", body: "Losowa treść testowa", slug: "stowarzyszenie", show_in_menu: true}
                    ])