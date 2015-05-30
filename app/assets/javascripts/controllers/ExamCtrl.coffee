angular.module('infish').controller 'ExamCtrl', ($scope, $stateParams, userExam) ->
  $scope.userExam = userExam
  $scope.exam = userExam.exam

  # here will go questions that have repeat = 0 so it's more efficient to
  # draw next question
  $scope.exam.masteredQuestions = []

  init = ->
    angular.forEach $scope.exam.questions, (question) ->
      # TODO:
      # * how many times question is repeated -> should take user's answers from back-end into consideration
      # * split questions into questions and answered questions
      question.repeat = $scope.userExam.repeat

    drawNextQuestion()

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

  buildUserAnswer = ->
    {
      id: UUIDjs.create().toString()
      question_id: $scope.current.question.id
      answers: angular.copy($scope.current.answers)
    }

  wasAnswerInAnswers = (answer) ->
    answer.id in $scope.current.answers

  updateRepeatForQuestion = ->
    if wasQuestionAnsweredCorrectly()
      $scope.current.question.repeat -= 1
    else
      $scope.current.question.repeat += $scope.userExam.repeat_wrong

  conditionallyMoveQuestionToMastered = ->
    current = $scope.current.question
    if current.repeat == 0
      $scope.exam.masteredQuestions.push current
      $scope.exam.questions = $scope.exam.questions.filter (question) ->
        question != current

  wasQuestionAnsweredCorrectly = ->
    correctly = true
    angular.forEach $scope.current.question.answers, (answer) ->
      return unless correctly
      answerInAnswers = wasAnswerInAnswers(answer)
      correctly = false if (!answer.correct && answerInAnswers) || (answer.correct && !answerInAnswers)

    return correctly

  drawNextQuestion = ->
    $scope.current.question = $scope.exam.questions[Math.floor(Math.random() * $scope.exam.questions.length)]

  init()

