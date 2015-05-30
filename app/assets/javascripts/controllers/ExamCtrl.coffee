angular.module('infish').controller 'ExamCtrl', ($scope, $stateParams, userExam) ->
  $scope.userExam = userExam
  $scope.exam = userExam.exam

  $scope.current =
    question: userExam.exam.questions[0]
    answers: []
    check: false

  $scope.checkAnswers = ->
    $scope.current.check = true
    console.log 'check answers'

  $scope.shouldDisableCheckAnswersButton = ->
    $scope.current.answers.length == 0

  $scope.nextQuestion = ->
    console.log 'next question'

  $scope.shouldDisableNextQuestionButton = ->
    !$scope.current.check

  # TODO: probably should be a directive
  $scope.answerClass = (answer) ->
    return unless $scope.current.check
    answerInAnswers = (answer.id in $scope.current.answers)

    if answer.correct && answerInAnswers
      'correct-answer'
    else if (!answer.correct && answerInAnswers) || (answer.correct && !answerInAnswers)
      'incorrect-answer'
