puts 'Creating PHQ9 Survey'

questions = ['Niewielkie zainteresowanie lub odczuwanie przyjemności z wykonywania czynności',
             'Uczucie smutku, przygnębienia lub beznadziejności',
             'Kłopoty z zaśnięciem lub przerywany sen, albo zbyt długi sen',
             'Uczucie zmęczenia lub brak energi',
             'Brak apetytu lub przejadanie się',
             'Poczucie niezadowolenia z siebie — lub uczucie, że jest się do niczego, albo że zawiódł/zawiodła Pan/Pani siebielub rodzinę',
             'Problemy ze skupieniem się na przykład przy czytaniu gazety lub oglądaniu telewizji',
             'Poruszanie się lub mówienie tak wolno, że inni mogliby to zauważyć? Albo wręcz przeciwnie — niemożność usiedzenia w miejscu lub podenerwowanie powodujące ruchliwość znacznie większą niż zwykle',
             'Myśli, że lepiej byłoby umrzeć, albo chęć zrobienia sobie jakiejś krzywdy',]

title = 'Medical Survey #3'
description = 'This survey is required to participate in the program.'
internal_name = 'phq9'

author = Profile.find_by(role: 'researcher').user
single = QuestionType.find_by(name: 'single').id

s = Survey.create(title: title, description: description, internal_name: internal_name, author: author)
questions.each_with_index do |q,i|
  q = Question.create(title: q, order: i, survey_id: s.id, question_type_id: single)
  QuestionOption.create(display: 'wcale nie dokuczały', name: 'first', question_id: q.id, score: 0)
  QuestionOption.create(display: 'kilka dni', name: 'second', question_id: q.id, score: 1)
  QuestionOption.create(display: 'więcej niż połowę dni', name: 'third', question_id: q.id, score: 2)
  QuestionOption.create(display: 'niemal codziennie', name: 'fourth', question_id: q.id, score: 3)
end
