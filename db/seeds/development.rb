hodak   = User.create! email: 'hodak@hodak.pl'
rafal   = User.create! email: 'rafal@rafal.pl'
piotrek = User.create! email: 'piotrek@piotrek.pl'

web = Exam.create! name: 'Webówka'
web.questions.create!(text: 'W modelu DOM elementy dokumentu zorganizowane są jako:').tap do |q|
  q.answers.create! text: 'Graf'
  q.answers.create! text: 'Drzewo', correct: true
  q.answers.create! text: 'Lista'
  q.answers.create! text: 'Zbiór'
end
web.questions.create!(text: 'Która czynność może być wykonywana przez skrypty po stronie klienta?').tap do |q|
  q.answers.create! text: 'Ansynchroniczne żądania HTTP', correct: true
  q.answers.create! text: 'Manipulacje DOM', correct: true
  q.answers.create! text: 'Walidacja pól formularza', correct: true
  q.answers.create! text: 'Manipulacja poufnymi danymi'
end
web.questions.create!(text: '_____ to szeroko wspierana, otwarta technologia wymiany danych rozwijana przez _____.').tap do |q|
  q.answers.create! text: 'SGML, The Mozilla Foundation'
  q.answers.create! text: 'XHTML, W3C'
  q.answers.create! text: 'XML, W3C', correct: true
  q.answers.create! text: 'XML, The Mozilla Foundation'
end
