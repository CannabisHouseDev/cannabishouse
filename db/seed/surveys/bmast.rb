puts 'Creating bMAST Survey'

title = 'Medical Survey #1'
description = 'This survey is required to participate in the program.'
internal_name = 'bMAST'
questions = ['Czy uważasz, że używasz konopi w taki sam sposób jak większość użytkowników?',
             'Czy Twoi przyjaciele, bądź krewni uważają, że nadużywasz konopi?',
             'Czy kiedykolwiek próbowałeś narzucić sobie ograniczenie/reżim w używaniu konopi?',
             'Czy straciłeś kiedykolwiek przyjaciela lub dziewczynę z powodu używania konopi?',
             'Czy miałeś kiedykolwiek kłopoty w pracy z powodu używania konopi?',
             'Czy z powodu używania konopi zaniedbałeś kiedykolwiek swoje obowiązki, sprawy rodzinne lub opuściłeś pracę kilka dni pod rząd?',
             'Czy po użyciu konopi kiedykolwiek słyszałeś głosy lub widziałeś nie istniejące rzeczy?',
             'Czy z powodu używania konopi zwracałeś się kiedykolwiek z prośbą o radę',
             'Czy przebywałeś kiedykolwiek w szpitalu z powodu używania konopi?',
             'Czy kiedykolwiek popadłeś w konflikt z prawem z powodu konopi, byłeś zatrzymany za prowadzenie pojazdu po użyciu konopi lub czy kiedykolwiek prowadziłeś pojazd pod wpływem konopi?']
author = User.where(email: 'konrad.rycerz@cannabishouse.eu').first
single = QuestionType.find_by(name: 'single').id
study = Study.find_by(title: 'onboarding')
s = Survey.create(title: title, description: description, internal_name: internal_name, author: author, required: true, study_id: study.id)
questions.each_with_index do |q, i|
  q = Question.create(title: q, order: i, survey_id: s.id, question_type_id: single)
  QuestionOption.create(display: 'Yes', name: 'yes', question_id: q.id, score: 1)
  QuestionOption.create(display: 'No', name: 'no', question_id: q.id, score: 0)
end
