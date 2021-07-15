puts 'Creating GHQ30 Survey'

questions = ['Jestem w stanie skupić się nad tym co robię.',
             'Z powodu zmartwień mniej śpię.',
             'Czuję, że odgrywam znaczącą i pożyteczną rolę w swoim otoczeniu.',
             'Czułem/czułam się zdolny/a do podejmowania różnych decyzji.',
             'Odczuwam ciągłe obciążenie.',
             'Czuję, że nie potrafię pokonać trudności.',
             'Byłem/byłam w stanie cieszyć się zwyczajnymi codziennymi sprawami.',
             'Potrafię radzić sobie ze swoimi problemami.',
             'Czuję się nieszczęśliwy i przygnębiony.',
             'Utraciłem/utraciłam wiarę w siebie.',
             'Uważam siebie za osobę bezwartościową.',
             'Czuję sę wystarczająco szczęśliwy biorąc wszystko pod uwagę.',
             'Potrafię być stale w ruchu i mieć zajęcie.',
             'Wychodziłem/wychodziłam z domu tak często jak zazwyczaj.',
             'Uważam, że ogólnie dobrze sobie radzę.',
             'Jestem zadowolony/a jak wywiązuję się ze swoich obowiązków.',
             'Bardzo się przejmuję wszystkim.',
             'Wszystko mnie przytłacza.',
             'Odczuwam obawy i zdenerwowanie przez cały czas.',
             'Czasami nie mogłem/nie mogłam nic zrobić z powodu skłonności do obaw.',
             'Mój sen jest niespokojny i zaburzony.',
             'Radzę sobie tak, jak większość ludzi radziłaby sobie na moim miejscu.',
             'Jestem zdolny/a odczuwać serdeczność i miłość do bliskich mi osób.',
             'Łatwo nawiązuję i utrzymuję przyjacielskie stosunki z innymi ludźmi.',
             'Widzę życie jako ciągłą walkę.',
             'Odczuwałem/odczuwałam strach lub panikę bez wyraźnego powodu.',
             'Czułem/czułam, że życie jest całkowicie beznadziejne.',
             'Jestem spokojny/a o swoją dobrą przyszłość.',
             'Czuję, że nie warto żyć.']

title = 'Ogólny Kwestionariusz Zdrowia Badanego'
description = 'Ankieta ma określić stan Twojego zdrowia oraz dolegliwości medyczne w ciągu ostatnich kilku tygodni, jeżeli występowały. Proszę zaznacz te odpowiedzi, które według Twojej opinii są najbardziej zgodne z rzeczywistością. Proszę pamiętaj, że pragniemy poznać ostatnie i obecne dolegliwości, a nie te, które występowały w przeszłości.'
internal_name = 'ghq30'
study = Study.find_by(title: 'Badanie Biologiczne')
author = User.where(email: 'konrad.rycerz@cannabishouse.eu').first
single = QuestionType.find_by(name: 'single').id

s = Survey.create(title: title, description: description, internal_name: internal_name, author: author, required: true, study_id: study.id)
questions.each_with_index do |q, i|
  q = Question.create(title: q, order: i, survey_id: s.id, question_type_id: single)
  QuestionOption.create(display: 'Zupełnie nie', name: 'strong_no', question_id: q.id, score: 1)
  QuestionOption.create(display: 'Nie bardziej niż zwykle', name: 'no', question_id: q.id, score: 2)
  QuestionOption.create(display: 'Trochę mniej niż zwykle', name: 'yes', question_id: q.id, score: 3)
  QuestionOption.create(display: 'Znacznie bardziej niż zwykle', name: 'strong_yes', question_id: q.id, score: 4)
end
