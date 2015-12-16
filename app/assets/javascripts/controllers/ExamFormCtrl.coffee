angular.module('infish').controller 'ExamFormCtrl', ($scope, $state, Exam) ->
  NUMBER_OF_ANSWERS = 2

  $scope.deleteQuestion = (question) ->
    delete $scope.exam.questions[question.id]

  $scope.deleteAnswer = (question, answer, isLast = false) ->
    if question.answers.length <= NUMBER_OF_ANSWERS || isLast
      answer.text = ''
    else
      question.answers.splice(question.answers.indexOf(answer), 1)

  $scope.send = ->
    Exam.createOrUpdate($scope.exam)
      .success ->
        $state.go 'exams.show', id: $scope.exam.id
      .error (e) ->
        $scope.errors = e.error

  $scope.onAnswerChange = (question) ->
    lastAnswer = question.answers[question.answers.length - 1]
    if lastAnswer.text != '' && question.answers.length < 9
      question.answers.push(newAnswer())
    else if lastAnswer.text == ''
      removeLastEmptyAnswers(question)

  $scope.addNewQuestion = ->
    pushNewQuestion()

  $scope.addNewFilledQuestion = (question, answers, states) ->
    q = newEmptyQuestion()
    q.text = question
    q.answers = for answer, i in answers
      a = newAnswer()
      a.text = answer
      a.correct = states[i]
      a
      
    $scope.exam.questions[q.id] = q

  removeLastEmptyAnswers = (question) ->
    return if question.answers.length <= NUMBER_OF_ANSWERS
    answers = question.answers
    return if answers[answers.length - 1].text != '' || answers[answers.length - 2].text != ''

    question.answers.splice(-1, 1)
    removeLastEmptyAnswers(question)

  newAnswer = ->
    id: UUIDjs.create().toString()
    text: ''
    correct: false

  newEmptyQuestion = ->
    date = new Date()

    id: UUIDjs.create().toString()
    text: ''
    answers: []
    created_at: date.toISOString().replace(date.getFullYear(), '4000') # hackish much? :)

  newQuestion = ->
    e = newEmptyQuestion()
    e.answers = (newAnswer() for num in [NUMBER_OF_ANSWERS..1])
    e

  pushNewQuestion = ->
    q = newQuestion()
    $scope.exam.questions[q.id] = q

  prepareQuestions = ->
    for id, question of $scope.exam.questions
      question.answers.push(newAnswer())

    pushNewQuestion() if Object.keys($scope.exam.questions).length == 0

  prepareQuestions()
