angular.module('infish').controller 'ExamFormCtrl', ($scope, $state, Exam) ->
  NUMBER_OF_ANSWERS = 2

  $scope.deleteQuestion = (question) ->
    delete $scope.exam.questions[question.id]

  $scope.deleteAnswer = (question, answer) ->
    if question.answers.length > NUMBER_OF_ANSWERS
      question.answers.splice(question.answers.indexOf(answer), 1)
    else
      answer.text = ''

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

  newQuestion = ->
    date = new Date()

    id: UUIDjs.create().toString()
    text: ''
    answers: (newAnswer() for num in [NUMBER_OF_ANSWERS..1])
    created_at: date.toISOString().replace(date.getFullYear(), '4000') # hackish much? :)

  pushNewQuestion = ->
    q = newQuestion()
    $scope.exam.questions[q.id] = q

  prepareQuestions = ->
    for id, question of $scope.exam.questions
      question.answers.push(newAnswer())

    pushNewQuestion()

  prepareQuestions()
