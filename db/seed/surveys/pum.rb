puts 'Creating PUM Survey'

questions = ['Czy zdarzyło Ci się nie pójść lub spóźnić się do szkoły/pracy z powodu używania marihuany?',
             'Czy z powodu używania marihuany miałeś poważny konflikt z rodziną?',
             'Czy z powodu używania marihuany miałeś poważny konflikt z przyjaciółmi?',
             'Czy zdarzyło Ci się samodzielnie kupić marihuanę? (poza badaniem lub zrealizowaniem recepty)',
             'Czy masz coraz więcej kłopotów z nauką, przyswajaniem nowych informacji?',
             'Czy zdarzało Ci się palić marihuanę w samotności?',
             'Czy często odczuwasz potrzebę użycia marihuany?',
             'Czy zdarzyło Ci się wydać na marihuanę tak dużo pieniędzy, że musiałeś zrezygnować z innych rzeczy, na których Ci zależało?']

title = 'Ankieta do autoewaluacji'
description = 'Dzieki tej ankiecie masz możliwosć sprawdzić jak używnaie konopi wpływa na zdolność radzenia sobie. Ankieta jest anonimowa, a odpowiedzi ujmowane zbiorczo m.in. w celach statystycznych. Prosimy o odpowiedzi zgodne z prawdą.'
internal_name = 'pum'
study = Study.find_by(title: 'onboarding')
author = User.where(email: 'konrad.rycerz@cannabishouse.eu').first
single = QuestionType.find_by(name: 'single').id

s = Survey.create(title: title, description: description, internal_name: internal_name, author: author, required: true, study_id: study.id)
questions.each_with_index do |q, i|
  q = Question.create(title: q, order: i, survey_id: s.id, question_type_id: single)
  QuestionOption.create(display: 'Tak', name: 'yes', question_id: q.id, score: 1)
  QuestionOption.create(display: 'Nie', name: 'no', question_id: q.id, score: 0)
end
