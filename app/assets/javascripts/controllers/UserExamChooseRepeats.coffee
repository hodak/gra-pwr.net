angular.module('infish').controller 'UserExamChooseRepeats', ($scope, $stateParams, $state, userExam, UserExam) ->
  $scope.userExam = userExam

  return $state.go 'exams.index' unless $scope.userExam?

  $scope.oneToNine = [1..9]

  $scope.userExam.repeat ||= 3
  $scope.userExam.repeat_wrong ||= 3

  $scope.submit = ->
    UserExam.update($scope.userExam)
      .then ->
        $state.go 'exams.show', id: $scope.userExam.exam.id

