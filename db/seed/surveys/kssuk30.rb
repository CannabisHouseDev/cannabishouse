puts 'Creating KSSUK-30 Survey'

questions = [['Jakie jest Twoje wykształcenie?',
              [['Podstawowe', 'podstawowe ', 0],
               ['średnie ogólne', 'średnie ogólne', 0],
               ['średnie zawodowe', 'średnie zawodowe', 0],
               ['średnie techniczne', 'średnie techniczne', 0],
               ['wyższe licencjackie', 'wyższe licencjackie', 0],
               ['wyższe mgr', 'wyższe mgr', 0],
               ['wyższe, co najmniej dr', 'wyższe, co najmniej dr', 0]]],
             ['Jaki obecnie wykonujesz zawód?',
              [['bezrobotny', 'bezrobotny ', 0],
               ['emeryt, Rencista', 'emeryt, Rencista', 0],
               ['gospodyni domowa', 'gospodyni domowa', 0],
               ['inżynier', 'inżynier', 0],
               ['kadra zarządzająca, menedżerska', 'kadra zarządzająca, menedżerska', 0],
               ['kierowca zawodowy', 'kierowca zawodowy', 0],
               ['lekarz', 'lekarz', 0],
               ['pracownik służby zdrowia', 'pracownik służby zdrowia', 0],
               ['nauczyciel', 'nauczyciel', 0],
               ['operator', 'woperator', 0],
               ['pracownik sfery budżetowej', 'pracownik sfery budżetowej', 0],
               ['edukacja', 'edukacja ', 0],
               ['pracownik administracji publicznej', 'pracownik administracji publicznej', 0],
               ['pracownik biurowy', 'pracownik biurowy', 0],
               ['pracownik działu finansowego', 'pracownik działu finansowego', 0],
               ['pracownik działu IT', 'pracownik działu IT', 0],
               ['pracownik działu obsługi klienta', 'pracownik działu obsługi klienta', 0],
               ['pracownik działu sprzedaży', 'pracownik działu sprzedaży', 0],
               ['pracownik fizyczny', 'pracownik fizyczny', 0],
               ['pracownik techniczny', 'pracownik techniczny', 0],
               ['prawnik', 'prawnik', 0],
               ['przedsiębiorca', 'przedsiębiorca ', 0],
               ['samozatrudniony', 'samozatrudniony', 0],
               ['przedstawiciel handlowy', 'przedstawiciel handlowy', 0],
               ['rolnik', 'rolnik', 0],
               ['służby mundurowe', 'służby mundurowe', 0],
               ['sportowiec', 'sportowiec', 0],
               ['student', 'student', 0],
               ['uczeń', 'uczeń', 0],
               ['inny', 'inny', 0]]],
             ['Czy osiągasz stałe dochody?',
              [['Yes', 'yes', 2],
               ['No', 'no', 0]]],
             ['Czy bierzesz czynny udział w życiu społecznym? (np. głosujesz w wyborach)',
              [['Yes', 'yes', 2],
               ['No', 'no', 0],
               ['Czasem', 'czasem', 1]]],
             ['Czy działasz w organizacjach rządowych / państwowych?',
              [['Yes', 'yes', 2],
               ['No', 'no', 1]]],
             ['Czy działasz w organizacjach pozarządowych? (poza Cannabis House)',
              [['Yes', 'yes', 2],
               ['No', 'no', 1]]],
             ['W jakim wieku użyłeś/aś pierwszy raz konopie?',
              [['Nie zażywam', 'nie zażywam', 2],
               ['<12 lat', 'under_12', 0],
               ['12-13 lat', '12', 0],
               ['14-15 lat', '14', 0],
               ['16-17 lat', '16', 0],
               ['18 lat', '18', 1],
               ['>18 lat', 'over_18', 2]]],
             ['Jak długo zażywasz konopie?',
              [['Nie zażywam', 'nie zażywam', 2],
               ['<1 roku', 'under_1', 0],
               ['1 rok', '1', 0],
               ['2-3 lata', '2', 0],
               ['4-5 lat', '4', 1],
               ['>6 lat', 'over_6', 1]]],
             ['Jak często zażywasz konopie?',
              [['Nie zażywam', 'nie zażywam', 2],
               ['raz w miesiącu (okazjonalnie)', 'monthly', 2],
               ['raz w tygodniu', 'weekly', 1],
               ['2-3 razy w tygodniu', 'other_day', 1],
               ['Codziennie', 'daily', 0],
               ['kilka razy dziennie', 'multiple', 0]]],
             ['W jakich ilościach jednorazowo zażywasz konopie?',
              [['nie zażywam', 'nie zażywam', 2],
               ['<0,2 grama', 'low', 2],
               ['0,5 grama', 'medium', 1],
               ['>0,5 grama', 'high', 0]]],
             ['Jaką ilość konopi zażywasz tygodniowo?',
              [['Yes', 'yes', 0],
               ['No', 'no', 1]]],
             ['Czy działasz w organizacjach pozarządowych(stowarzyszenia,fundacje...) lub je wspomagasz?',
              [['nie zażywam', 'nie zażywam', 2],
               ['<1 grama', 'very_low', 2],
               ['1-2 gram', 'low', 2],
               ['3-10 gram', 'medium', 1],
               ['>10 gram', 'high', 0]]],
             ['Jaką ilość konopi zażywasz miesięcznie?',
              [['nie zażywam', 'nie zażywam', 2],
               ['<1 grama', 'very_low', 2],
               ['5-10 grama', 'low', 2],
               ['11-20 grama', 'medium', 1],
               ['21-30 grama', 'high', 0],
               ['>30 grama', 'very_high', 0]]],
             ['Czy czujesz się prześladowany/ana z powodu zażywania konopi?',
              [['nie zażywam', 'nie zażywam', 2],
               ['Yes', 'yes', 1],
               ['No', 'no', 2],
               ['nie zwracam na to uwagi', 'meh', 0]]],
             ['Czy członkowie Twojej rodziny wiedzą, że zażywasz konopie?',
              [['nie zażywam', 'nie zażywam', 2],
               ['Yes', 'yes', 2],
               ['No', 'no', 1],
               ['nie wiem (nie poruszamy tego tematu)', 'meh', 0]]],
             ['Czy pracodawca wie, że zażywasz konopie?',
              [['nie zażywam', 'nie zażywam', 2],
               ['Yes', 'yes', 2],
               ['No', 'no', 1],
               ['nie wiem', 'meh', 0]]],
             ['Czy Twoi znajomi wiedzą, że zażywasz konopie?',
              [['nie zażywam', 'nie zażywam', 2],
               ['Yes', 'yes', 2],
               ['No', 'no', 1],
               ['nie wiem (nie poruszamy tego tematu)', 'meh', 0]]],
             ['Czy w Twoim środowisku zażywanie konopi jest tolerowane?',
              [['nie zażywam', 'nie zażywam', 2],
               ['Yes', 'yes', 2],
               ['No', 'no', 1],
               ['nie wiem (nie poruszamy tego tematu)', 'meh', 0]]],
             ['Czy wśród członków Twojej rodziny zażywanie konopi jest tolerowane?',
              [['nie zażywam', 'nie zażywam', 2],
               ['Yes', 'yes', 2],
               ['No', 'no', 1],
               ['nie wiem (nie poruszamy tego tematu)', 'meh', 0]]],
             ['Jaki jest Twój stosunek do organów ścigania? (Policja, ABW, CBŚ)',
              [['nic do nich nie mam', 'nic do nich nie mam', 2],
               ['powinni ścigać poważniejsze przestępstwa', 'powinni ścigać poważniejsze przestępstwa', 1],
               ['organy ścigania działają pod presją', 'organy ścigania działają pod presją', 1],
               ['nie toleruję ich (tylko przeszkadzają)', 'nie toleruję ich (tylko przeszkadzają)', 1],
               ['sami są przestępcami', 'sami są przestępcami', 0]]],
             ['Jaki jest Twój stosunek do kościoła katolickiego?',
              [['nie interesuje mnie', 'nie interesuje mnie', 0],
               ['jestem praktykującym katolikiem', 'jestem praktykującym katolikiem', 2],
               ['należę do innego kościoła', 'należę do innego kościoła', 2],
               ['jestem innego wyznania ', 'jestem innego wyznania ', 2],
               ['jestem apostatą', 'jestem apostatą', 0],
               ['jestem niewierzący', 'jestem niewierzący', 0],
               ['stan duchowny to pasożyty i przestępcy', 'stan duchowny to pasożyty i przestępcy', 0]]],
             ['Jaki jest Twój stosunek do organów władzy państwowej (wykonawczej)?',
              [['nie interesuję się', 'nie interesuję się', 0],
               ['urzędnicy wykonują tylko swoją pracę', 'urzędnicy wykonują tylko swoją pracę', 2],
               ['są po to by utrudnić życie człowiekowi', 'są po to by utrudnić życie człowiekowi', 1],
               ['organy władzy państwowej działają pod presją', 'organy władzy państwowej działają pod presją', 1]]],
             ['Jaki jest Twój stosunek do sądów?',
              [['nie interesuję się', 'nie interesuję się', 0],
               ['sądy są sprawiedliwe', 'sądy są sprawiedliwe', 2],
               ['sądy nie sądzą sprawiedliwe', 'sądy nie sądzą sprawiedliwe', 1],
               ['sądy same łamią prawo', 'sądy same łamią prawo', 1],
               ['sądy działają pod presją', 'sądy działają pod presją', 1]]],
             ['Jaki jest Twój stosunek do władzy ustawodawczej (sejm/senat)?',
              [['nie interesuję się', 'nie interesuję się', 0],
               ['wykonują swoją pracę / reprezentują moje interesy', 'wykonują swoją pracę / reprezentują moje interesy', 2],
               ['nie reprezentują moich interesów / robią wszystko by utrudnić życie człowiekowi', 'no', 1]]],
             ['Czy leczysz się z powodu zażywania konopi?',
              [['Yes', 'yes', 0],
               ['No', 'no', 1],
               ['nie zażywam', 'nnie zażywamo', 2]]],
             ['Czy uważasz, że jesteś uzależniony od konopi?',
              [['Yes', 'yes', 0],
               ['No', 'no', 1],
               ['nie zażywam', 'nnie zażywamo', 2]]],
             ['W jaki sposób zażywasz konopie??',
              [['doustnie (w potrawach) ', 'doustnie', 0],
               ['palę', 'palę', 0],
               ['nhaluję z waporyzera', 'nhaluję z waporyzera', 1],
               ['nie zażywam', 'nie zażywam', 2],
               ['inny sposób', 'inny sposób', 1]]],
             ['Czy byłeś karany?',
              [['doustnie (w potrawach) ', 'doustnie', 0],
               ['Yes', 'yes', 0],
               ['No', 'no', 2]]],
             ['Czy byłeś karany w związku z konopiami?',
              [['doustnie (w potrawach) ', 'doustnie', 0],
               ['Yes', 'yes', 0],
               ['No', 'no', 2]]],
             ['Czy leczysz się/leczyłeś się kiedykolwiek neurologicznie lub psychiatrycznie?',
              [['Tak, leczę się', 'Tak, leczę się', 0],
               ['No', 'no', 2],
               ['kiedyś się leczyłem', 'kiedyś się leczyłem', 1]]],
             ['Czy konopie zażywasz tylko rekreacyjnie?',
              [['Yes', 'yes', 0],
               ['nie (pomagają mi też na dolegliwości)', 'nie', 2],
               ['nie zażywam', 'nie zażywam', 2]]]]

title = 'Medical Survey #5'
description = 'This survey is required to participate in the program.'
internal_name = 'kssuk30'

author = Profile.find_by(role: 'researcher').user
single = QuestionType.find_by(name: 'single').id

s = Survey.create(title: title, description: description, internal_name: internal_name, author: author, required: true)
questions.each_with_index do |q,i|
  question = Question.create(title: q[0], order: i, survey_id: s.id, question_type_id: single)
  q[1].each do |o|
    QuestionOption.create(display: o[0], name: o[1], question_id: question.id, score: o[2])
  end
end