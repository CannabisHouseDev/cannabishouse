puts 'Creating KSSUK-30 Survey'


questions = [['Jakie jest Twoje wykształcenie?',
              [['podstawowe', 'podstawowe ', 0],
               ['średnie ogólne', 'średnie ogólne', 0],
               ['średnie zawodowe', 'średnie zawodowe', 0],
               ['średnie techniczne', 'średnie techniczne', 0],
               ['wyższe licencjackie', 'wyższe licencjackie', 0],
               ['wyższe magisterskie', 'wyższe magisterskie', 0],
               ['wyższe, co najmniej dr', 'wyższe, co najmniej dr', 0]]],
             ['Jaki obecnie wykonujesz zawód?',
              [['bezrobotny', 'bezrobotny ', 0],
               ['emeryt, rencista', 'emeryt, rencista', 0],
               ['gospodyni domowa', 'gospodyni domowa', 0],
               ['inżynier', 'inżynier', 0],
               ['kadra zarządzająca, menedżerska', 'kadra zarządzająca, menedżerska', 0],
               ['kierowca zawodowy', 'kierowca zawodowy', 0],
               ['lekarz', 'lekarz', 0],
               ['pracownik służby zdrowia', 'pracownik służby zdrowia', 0],
               ['nauczyciel', 'nauczyciel', 0],
               ['operator', 'operator', 0],
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
              [['Tak', 'yes', 2],
               ['Nie', 'no', 0]]],
             ['Czy bierzesz czynny udział w życiu społecznym? (np. głosujesz w wyborach)',
              [['Tak', 'yes', 2],
               ['Nie', 'no', 0],
               ['Czasem', 'czasem', 1]]],
             ['Czy działasz w organizacjach rządowych / państwowych?',
              [['Tak', 'yes', 2],
               ['Nie', 'no', 1]]],
             ['Czy działasz w organizacjach pozarządowych? (poza Cannabis House)',
              [['Tak', 'yes', 2],
               ['Nie', 'no', 1]]],
             ['W jakim wieku zażyłeś/aś pierwszy raz konopie?',
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
               ['Raz w miesiącu (okazjonalnie)', 'monthly', 2],
               ['Raz w tygodniu', 'weekly', 1],
               ['2-3 razy w tygodniu', 'other_day', 1],
               ['Codziennie', 'daily', 0],
               ['Kilka razy dziennie', 'multiple', 0]]],
             ['W jakich ilościach jednorazowo zażywasz konopie?',
              [['Nie zażywam', 'nie zażywam', 2],
               ['<0,2 grama', 'low', 2],
               ['0,5 grama', 'medium', 1],
               ['>0,5 grama', 'high', 0]]],
             ['Jaką ilość konopi zażywasz tygodniowo?',
              [['nie zażywam', 'nie zażywam', 2],
              ['<1 grama', 'very_low', 2],
              ['1-2 gram', 'low', 2],
              ['3-10 gram', 'medium', 1],
              ['>10 gram', 'high', 0]]],                           
             ['Jaką ilość konopi zażywasz miesięcznie?',
              [['Nie zażywam', 'nie zażywam', 2],
               ['<1 grama', 'very_low', 2],
               ['5-10 grama', 'low', 2],
               ['11-20 grama', 'medium', 1],
               ['21-30 grama', 'high', 0],
               ['>30 grama', 'very_high', 0]]],
             ['Czy czujesz się prześladowany/na z powodu zażywania konopi?',
              [['Nie zażywam', 'nie zażywam', 2],
               ['Tak', 'yes', 1],
               ['Nie', 'no', 2],
               ['Nie zwracam na to uwagi', 'meh', 0]]],
             ['Czy członkowie Twojej rodziny wiedzą, że zażywasz konopie?',
              [['Nie zażywam', 'nie zażywam', 2],
               ['Tak', 'yes', 2],
               ['Nie', 'no', 1],
               ['Nie wiem (nie poruszamy tego tematu)', 'meh', 0]]],
             ['Czy pracodawca wie, że zażywasz konopie?',
              [['nie zażywam', 'nie zażywam', 2],
               ['Tak', 'yes', 2],
               ['Nie', 'no', 1],
               ['Nie wiem', 'meh', 0]]],
             ['Czy Twoi znajomi wiedzą, że zażywasz konopie?',
              [['Nie zażywam', 'nie zażywam', 2],
               ['Tak', 'yes', 2],
               ['Nie', 'no', 1],
               ['Nie wiem (nie poruszamy tego tematu)', 'meh', 0]]],
             ['Czy w Twoim środowisku zażywanie konopi jest tolerowane?',
              [['Nie zażywam', 'nie zażywam', 2],
               ['Tak', 'yes', 2],
               ['Nie', 'no', 1],
               ['Nie wiem (nie poruszamy tego tematu)', 'meh', 0]]],
             ['Czy wśród członków Twojej rodziny zażywanie konopi jest tolerowane?',
              [['Nie zażywam', 'nie zażywam', 2],
               ['Tak', 'yes', 2],
               ['Nie', 'no', 1],
               ['Nie wiem (nie poruszamy tego tematu)', 'meh', 0]]],
             ['Jaki jest Twój stosunek do organów ścigania? (Policja, ABW, CBŚ)',
              [['Nic do nich nie mam', 'nic do nich nie mam', 2],
               ['Powinni ścigać poważniejsze przestępstwa', 'powinni ścigać poważniejsze przestępstwa', 1],
               ['Organy ścigania działają pod presją', 'organy ścigania działają pod presją', 1],
               ['Nie toleruję ich (tylko przeszkadzają)', 'nie toleruję ich (tylko przeszkadzają)', 1],
               ['Sami są przestępcami', 'sami są przestępcami', 0]]],
             ['Jaki jest Twój stosunek do kościoła katolickiego?',
              [['Nie interesuje mnie', 'nie interesuje mnie', 0],
               ['Jestem praktykującym katolikiem', 'jestem praktykującym katolikiem', 2],
               ['Należę do innego kościoła', 'należę do innego kościoła', 2],
               ['Jestem innego wyznania ', 'jestem innego wyznania ', 2],
               ['Jestem apostatą', 'jestem apostatą', 0],
               ['Jestem niewierzący', 'jestem niewierzący', 0],
               ['Stan duchowny to pasożyty i przestępcy', 'stan duchowny to pasożyty i przestępcy', 0]]],
             ['Jaki jest Twój stosunek do organów władzy państwowej (wykonawczej)?',
              [['Nie interesuję się', 'nie interesuję się', 0],
               ['Urzędnicy wykonują tylko swoją pracę', 'urzędnicy wykonują tylko swoją pracę', 2],
               ['Są po to by utrudnić życie człowiekowi', 'są po to by utrudnić życie człowiekowi', 1],
               ['Organy władzy państwowej działają pod presją', 'organy władzy państwowej działają pod presją', 1]]],
             ['Jaki jest Twój stosunek do sądów?',
              [['Nie interesuję się', 'nie interesuję się', 0],
               ['Sądy są sprawiedliwe', 'sądy są sprawiedliwe', 2],
               ['Sądy nie sądzą sprawiedliwe', 'sądy nie sądzą sprawiedliwe', 1],
               ['Sądy same łamią prawo', 'sądy same łamią prawo', 1],
               ['Sądy działają pod presją', 'sądy działają pod presją', 1]]],
             ['Jaki jest Twój stosunek do władzy ustawodawczej (sejm/senat)?',
              [['Nie interesuję się', 'nie interesuję się', 0],
               ['Wykonują swoją pracę / reprezentują moje interesy', 'wykonują swoją pracę / reprezentują moje interesy', 2],
               ['Nie reprezentują moich interesów / robią wszystko by utrudnić życie człowiekowi', 'no', 1]]],
             ['Czy leczysz się z powodu zażywania konopi?',
              [['Tak', 'yes', 0],
               ['Nie', 'no', 1],
               ['Nie zażywam', 'nnie zażywamo', 2]]],
             ['Czy uważasz, że jesteś uzależniony od konopi?',
              [['Tak', 'yes', 0],
               ['Nie', 'no', 1],
               ['Nie zażywam', 'nie zażywam', 2]]],
             ['W jaki sposób zażywasz konopie??',
              [['Doustnie (w potrawach) ', 'doustnie', 0],
               ['Palę', 'palę', 0],
               ['Inhaluję z waporyzera', 'nhaluję z waporyzera', 1],
               ['Nie zażywam', 'nie zażywam', 2],
               ['Inny sposób', 'inny sposób', 1]]],
             ['Czy byłeś karany?',
              [['Tak', 'yes', 0],
               ['Nie', 'no', 2]]],
             ['Czy byłeś karany w związku z konopiami?',
              [['Tak', 'yes', 0],
               ['Nie', 'no', 2]]],
             ['Czy leczysz się/leczyłeś się kiedykolwiek neurologicznie lub psychiatrycznie?',
              [['Tak, leczę się', 'Tak, leczę się', 0],
               ['Nie', 'no', 2],
               ['Kiedyś się leczyłem', 'kiedyś się leczyłem', 1]]],
             ['Czy konopie zażywasz tylko rekreacyjnie?',
              [['Tak', 'yes', 0],
               ['Nie (pomagają mi też w dolegliwościach)', 'Nie', 2],
               ['Nie zażywam', 'nie zażywam', 2]]]]

title = 'Ankieta medyczna nr 5'
description = 'Ankieta jest anonimowa, a odpowiedzi ujmowane zbiorczo m.in. w celach statystycznych. Pierwsze wypełnienie ma harakter historyczny, nie rzutuje na udział w badaniu i przeprowadzana jest w celach naukowych, oraz utworzenia punktu odniesienia dla kolejnych ankiet. Wymagane są odpowiedzi, które są prawdziwe lub najlepiej oddają Twoje poglądy.'
internal_name = 'kssuk30'
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
