angular.module('infish').controller 'UserExamChooseRepeats', ($scope, $stateParams, $state, userExams, UserExam) ->
  $scope.userExam = (ue for ue in userExams when ue.exam.id == $stateParams.id)[0]

  return $state.go 'exams.index' unless $scope.userExam?

  $scope.oneToNine = [1..9]

  $scope.userExam.repeat ||= 3
  $scope.userExam.repeat_wrong ||= 3

  $scope.submit = ->
    UserExam.update($scope.userExam)
      .then ->
        $state.go 'exams.show', id: $scope.userExam.exam.id

