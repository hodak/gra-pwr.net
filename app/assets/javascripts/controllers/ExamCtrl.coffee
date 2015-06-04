angular.module('infish').controller 'ExamCtrl', ($scope, $stateParams, userExam, UserExam) ->
  $scope.userExam = userExam
  $scope.exam = userExam.exam

  console.log $scope.exam

  # here will go questions that have repeat = 0 so it's more efficient to
  # draw next question
  $scope.exam.masteredQuestions = []

  init = ->
    angular.forEach $scope.userExam.user_answers, (userAnswer) ->
      question = $scope.exam.questions[userAnswer.question_id]
      return unless question?
      question.repeat = $scope.userExam.repeat unless question.repeat?

      if wasQuestionAnsweredCorrectly(question, userAnswer.answers)
        question.repeat -= 1
      else
        question.repeat += $scope.userExam.repeat_wrong

      conditionallyMoveQuestionToMastered(question)

    angular.forEach $scope.exam.questions, (question) ->
      return if question.repeat?
      question.repeat = $scope.userExam.repeat

    drawNextQuestion() if $scope.questionsLeftCount() > 0

  $scope.current =
    question: null # init() draws next questions
    answers: []
    check: false

  # TODO: it probably doesn't have to be on $scope, just debugging
  # "new" user answers are the ones not yet saved on back-end
  $scope.newUserAnswers = []

  $scope.checkAnswers = ->
    $scope.current.check = true
    $scope.newUserAnswers.push buildUserAnswer()
    updateRepeatForQuestion()
    conditionallyMoveQuestionToMastered()

  $scope.shouldDisableCheckAnswersButton = ->
    $scope.current.answers.length == 0 || $scope.current.check

  $scope.nextQuestion = ->
    $scope.current.check = false
    $scope.current.answers = []
    drawNextQuestion()

  $scope.shouldDisableNextQuestionButton = ->
    !$scope.current.check

  # TODO: probably should be a directive
  $scope.answerClass = (answer) ->
    return unless $scope.current.check
    answerInAnswers = wasAnswerInAnswers(answer)

    if answer.correct && answerInAnswers
      'correct-answer'
    else if (!answer.correct && answerInAnswers) || (answer.correct && !answerInAnswers)
      'incorrect-answer'

  $scope.questionsLeftCount = ->
    Object.keys($scope.exam.questions).length

  buildUserAnswer = ->
    {
      id: UUIDjs.create().toString()
      question_id: $scope.current.question.id
      answers: angular.copy($scope.current.answers)
    }

  wasAnswerInAnswers = (answer, answers = $scope.current.answers) ->
    answer.id in answers

  updateRepeatForQuestion = ->
    if wasQuestionAnsweredCorrectly()
      $scope.current.question.repeat -= 1
    else
      $scope.current.question.repeat += $scope.userExam.repeat_wrong

  conditionallyMoveQuestionToMastered = (question = $scope.current.question) ->
    if question.repeat == 0
      $scope.exam.masteredQuestions.push question
      delete $scope.exam.questions[question.id]

  wasQuestionAnsweredCorrectly = (question = $scope.current.question, answers = $scope.current.answers) ->
    correctly = true
    angular.forEach question.answers, (answer) ->
      return unless correctly
      answerInAnswers = wasAnswerInAnswers(answer, answers)
      correctly = false if (!answer.correct && answerInAnswers) || (answer.correct && !answerInAnswers)

    return correctly

  drawNextQuestion = ->
    # TODO this probably should be called only once, not every draw
    keys = Object.keys($scope.exam.questions)
    randomlyPickedID = keys[Math.floor(Math.random() * keys.length)]

    question = $scope.exam.questions[randomlyPickedID]
    question.answers = question.answers.sort -> 0.5 - Math.random()
    question.id = randomlyPickedID

    $scope.current.question = question

  # SYNC
  $scope.syncUserAnswers = ->
    answers = angular.copy($scope.newUserAnswers)
    $scope.newUserAnswers = []
    UserExam.syncUserAnswers($scope.userExam, answers)
      .success (response) ->
        console.log 'success'
      .error (e) ->
        $scope.newUserAnswers = $scope.newUserAnswers.concat answers

  # INIT
  init()

