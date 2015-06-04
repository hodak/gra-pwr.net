angular.module('infish').controller 'ExamFormCtrl', ($scope, $state, Exam) ->
  console.log 'exam form ctrl'

  $scope.send = ->
    Exam.createOrUpdate($scope.exam)
      .success ->
        $state.go 'exams.show', id: $scope.exam.id
      .error (e) ->
        console.log 'error', e
        # TODO some kind of global error handling?

  $scope.deleteQuestion = (question) ->
    delete $scope.exam.questions[question.id]
