angular.module('infish').controller 'ExamFormCtrl', ($scope, Exam) ->
  console.log 'exam form ctrl'

  $scope.send = ->
    Exam.createOrUpdate($scope.exam)
      .success ->
        console.log 'success'
        # TODO redirect to newly created exam
      .error (e) ->
        console.log 'error', e
        # TODO some kind of global error handling?
