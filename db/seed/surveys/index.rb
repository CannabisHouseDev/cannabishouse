puts 'Creating Social Harmfulness : Index Survey'

questions = [['Czy osiągasz stałe, opodatkowane dochody?',
              [['Yes', 'yes', 0],
               ['No', 'no', 2]]],
             ['Czy przywiązujesz dużą wagę do faktu, żeposiadanie konopi jest w Polsce nielegalne?',
              [['Yes', 'yes', 1],
               ['No', 'no', 2]]],
             ['Czy używasz konopi w ilości większej niż 5g miesięcznie?',
              [['Yes', 'yes', 2],
               ['No', 'no', 1]]],
             ['Czy używałeś kiedykolwiek konopi w miejscach publicznych?',
              [['Yes', 'yes', 2],
               ['No', 'no', 0]]],
             ['Czy używałeś kiedykolwiek konopi w miejscupracy lub nauki?',
              [['Yes', 'yes', 2],
               ['No', 'no', 0]]],
             ['Czy kiedykolwiek świadomie udzieliłeś konopini eletniemu?',
              [['Yes', 'yes', 2],
               ['No', 'no', 0]]],
             ['Czy kiedykolwiek świadomie udzieliłeś konopidorosłemu który używał po raz pierwszy?',
              [['Yes', 'yes', 2],
               ['No', 'no', 0]]],
             ['Czy kiedykolwiek świadomie udzieliłeś konopidorosłemu który już wcześniej używał konopi?',
              [['Yes', 'yes', 1],
               ['No', 'no', 0]]],
             ['Czy kiedykolwiek czerpałeś korzyść majątkową zudzielenia komuś konopi?',
              [['Yes', 'yes', 2],
               ['No', 'no', 0]]],
             ['Czy bierzesz czynny udział w życiu społecznym(wybory, media,akcje)?',
              [['Yes', 'yes', 0],
               ['No', 'no', 1]]],
             ['Czy działasz w organizacjachrządowych/państwowych (służby, ośrodki,instytuty...) lub je wspomagasz?',
              [['Yes', 'yes', 0],
               ['No', 'no', 1]]],
             ['Czy działasz w organizacjach pozarządowych(stowarzyszenia,fundacje...) lub je wspomagasz?',
              [['Yes', 'yes', 0],
               ['No', 'no', 1]]],
             ['Czy w Twoim bliskim środowisku zażywaniekonopi jest tolerowane?',
              [['Yes', 'yes', 0],
               ['No', 'no', 1]]],
             ['Czy wśród członków Twojej rodziny zażywaniekonopi jest tolerowane?',
              [['Yes', 'yes', 0],
               ['No', 'no', 1]]],
             ['Czy uważasz, że jesteś uzależniony od konopi?',
              [['Yes', 'yes', 1],
               ['No', 'no', 0]]],
             ['Czy leczysz się lub leczyłeś się z powodunadmiernego zażywania konopi?',
              [['Yes', 'yes', 2],
               ['No', 'no', 0]]],
             ['Czy konopie zażywasz tylko rekreacyjnie?',
              [['Yes', 'yes', 1],
               ['No', 'no', 0]]],
             ['Czy byłeś karany w związku z konopiami?',
              [['Yes', 'yes', 2],
               ['No', 'no', 0]]],
             ['Czy popełniłeś kiedykolwiek czyn zabroniony wzwiązku z używaniem konopi (poza przypadkamiposiadania na własny np. kradzież, włamanie,pobicie...)?',
              [['Yes', 'yes', 1],
               ['No', 'no', 0]]]]

title = 'Medical Survey #4'
description = 'This survey is required to participate in the program.'
internal_name = 'index'

author = Profile.find_by(role: 'admin').user
single = QuestionType.find_by(name: 'single').id

s = Survey.create(title: title, description: description, internal_name: internal_name, author: author, required: true)
questions.each_with_index do |q,i|
  question = Question.create(title: q[0], order: i, survey_id: s.id, question_type_id: single)
  q[1].each do |o|
    QuestionOption.create(display: o[0], name: o[1], question_id: question.id, score: o[2])
  end
end
