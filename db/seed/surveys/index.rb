puts 'Creating Social Harmfulness : Index Survey'

questions = [['Czy osiągasz stałe, opodatkowane dochody?',
              [['Tak', 'yes', 0],
               ['Nie', 'nie', 2]]],
             ['Czy przywiązujesz dużą wagę do faktu, że posiadanie konopi jest w Polsce nielegalne?',
              [['Tak', 'yes', 1],
               ['Nie', 'nie', 2]]],
             ['Czy używasz konopi w ilości większej niż 5g miesięcznie?',
              [['Tak', 'yes', 2],
               ['Nie', 'nie', 1]]],
             ['Czy używałeś kiedykolwiek konopi w miejscach publicznych?',
              [['Tak', 'yes', 2],
               ['Nie', 'nie', 0]]],
             ['Czy używałeś kiedykolwiek konopi w miejscu pracy lub nauki?',
              [['Tak', 'yes', 2],
               ['Nie', 'nie', 0]]],
             ['Czy kiedykolwiek świadomie udzieliłeś konopi nieletniemu?',
              [['Tak', 'yes', 2],
               ['Nie', 'nie', 0]]],
             ['Czy kiedykolwiek świadomie udzieliłeś konopi dorosłemu, który używał po raz pierwszy?',
              [['Tak', 'yes', 2],
               ['Nie', 'nie', 0]]],
             ['Czy kiedykolwiek świadomie udzieliłeś konopi dorosłemu, który już wcześniej używał konopi?',
              [['Tak', 'yes', 1],
               ['Nie', 'nie', 0]]],
             ['Czy kiedykolwiek czerpałeś korzyść majątkową z udzielenia komuś konopi?',
              [['Tak', 'yes', 2],
               ['Nie', 'nie', 0]]],
             ['Czy bierzesz czynny udział w życiu społecznym (wybory, media, akcje)?',
              [['Tak', 'yes', 0],
               ['Nie', 'nie', 1]]],
             ['Czy działasz w organizacjach rządowych/państwowych (służby, ośrodki, instytuty...) lub je wspomagasz?',
              [['Tak', 'yes', 0],
               ['Nie', 'nie', 1]]],
             ['Czy działasz w organizacjach pozarządowych (stowarzyszenia, fundacje...) lub je wspomagasz?',
              [['Tak', 'yes', 0],
               ['Nie', 'nie', 1]]],
             ['Czy w Twoim bliskim środowisku zażywanie konopi jest tolerowane?',
              [['Tak', 'yes', 0],
               ['Nie', 'nie', 1]]],
             ['Czy wśród członków Twojej rodziny zażywanie konopi jest tolerowane?',
              [['Tak', 'yes', 0],
               ['Nie', 'nie', 1]]],
             ['Czy uważasz, że jesteś uzależniony od konopi?',
              [['Tak', 'yes', 1],
               ['Nie', 'nie', 0]]],
             ['Czy leczysz się lub leczyłeś się z powodu nadmiernego zażywania konopi?',
              [['Tak', 'yes', 2],
               ['Nie', 'nie', 0]]],
             ['Czy konopie zażywasz tylko rekreacyjnie?',
              [['Tak', 'yes', 1],
               ['Nie', 'nie', 0]]],
             ['Czy byłeś karany w związku z konopiami?',
              [['Tak', 'yes', 2],
               ['Nie', 'nie', 0]]],
             ['Czy popełniłeś kiedykolwiek czyn zabroniony wzwiązku z używaniem konopi (poza przypadkami posiadania na własny użytek) np. kradzież, włamanie, pobicie...?',
              [['Tak', 'yes', 1],
               ['Nie', 'nie', 0]]]]

title = 'Ankieta relacji konopi i życia w społeczeństwie'
description = 'Ankieta jest anonimowa, a odpowiedzi ujmowane zbiorczo m.in. w celach statystycznych. Pierwsze wypełnienie ma harakter historyczny, nie rzutuje na udział w badaniu i przeprowadzana jest w celach naukowych, oraz utworzenia punktu odniesienia dla kolejnych ankiet. Prosimy o odpowiedzi zgodne z prawdą.'
internal_name = 'pum'
internal_name = 'index'
study = Study.find_by(title: 'onboarding')
author = User.where(email: 'konrad.rycerz@cannabishouse.eu').first
single = QuestionType.find_by(name: 'single').id

s = Survey.create(title: title, description: description, internal_name: internal_name, author: author, required: true, study_id: study.id)
questions.each_with_index do |q, i|
  question = Question.create(title: q[0], order: i, survey_id: s.id, question_type_id: single)
  q[1].each do |o|
    QuestionOption.create(display: o[0], name: o[1], question_id: question.id, score: o[2])
  end
end
