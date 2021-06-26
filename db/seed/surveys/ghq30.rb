puts 'Creating GHQ30 Survey'

questions = ['Chętnie podejmuję nowe wyzwania i nietypowe zadania.',
             'Moje wysiłki są z góry skazane na porażkę.',
             'Łatwo nawiązuję kontakty z innymi',
             'Uważam siebie za wartościową osobę.',
             'Mam plany i przekonanie, że uda mi się je zrealizować.',
             'To, co robię, sprawia mi przyjemność.',
             'Często jestem zmęczona/y przez cały dzień.',
             'Rzadko choruję.',
             'Nic mnie nie cieszy.',
             'Widzę w sobie same',
             'Nie potrafię walczyć o swoje potrzeby.',
             'Lubię siebie.',
             'Jestem niespokojna/y, drażliwa/y i wybuchowa/y.',
             'Dobrze śpię i wysypiam się.',
             'Czasem używam miękkich narkotyków.',
             'Potrafię się skupić i pracować efektywnie.',
             'Miewam nieuzasadnione obawy i lęki.',
             'Zdarza mi się objadać lub ograniczać jedzenie.',
             'Podejmowanie samodzielnych decyzji sprawia mi trudność.',
             'Mam pasje i je realizuję.',
             'Jestem przekonana/y, że moje życie jest na dobrej drodze.',
             'Chętnie poznaję nowych ludzi.1234',
             'Szybko dochodzę do siebie, kiedy ponoszę porażkę.',
             'Miewam myśli samobójcze.',
             'Codziennie palę papierosy.',
             'Uważam, że ludzie są do mnie uprzedzeni.',
             'Zdarza mi się nadużywać alkoholu.',
             'Lubię ludzi i dobrze się wśród nich czuję.',
             'Mam mniejszą ochotę na seks niż kiedyś.',
             'Odczuwam bóle mięśni, karku, ramion i pleców.']

title = 'Medical Survey #6'
description = 'This survey is required to participate in the program.'
internal_name = 'ghq30'

author = Profile.find_by(role: 'researcher').user
single = QuestionType.find_by(name: 'single').id

s = Survey.create(title: title, description: description, internal_name: internal_name, author: author)
questions.each_with_index do |q,i|
  q = Question.create(title: q, order: i, survey_id: s.id, question_type_id: single)
  QuestionOption.create(display: 'Zdecydowanie nie zgadzamsię', name: 'strong_no', question_id: q.id, score: 1)
  QuestionOption.create(display: 'Raczej nie zgadzam się', name: 'no', question_id: q.id, score: 2)
  QuestionOption.create(display: 'raczej zgadzam się', name: 'yes', question_id: q.id, score: 3)
  QuestionOption.create(display: 'zdecydowanie się zgadzam', name: 'strong_yes', question_id: q.id, score: 4)
end
