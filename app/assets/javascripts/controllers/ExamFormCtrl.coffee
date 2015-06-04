angular.module('infish').controller 'ExamFormCtrl', ($scope, $state, Exam) ->
  $scope.send = ->
    Exam.createOrUpdate($scope.exam)
      .success ->
        $state.go 'exams.show', id: $scope.exam.id
      .error (e) ->
        $scope.errors = e.error

  $scope.deleteQuestion = (question) ->
    delete $scope.exam.questions[question.id]

  $scope.deleteAnswer = (question, answer) ->
    question.answers.splice(question.answers.indexOf(answer), 1)

