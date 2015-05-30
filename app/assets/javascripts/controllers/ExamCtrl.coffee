angular.module('infish').controller 'ExamCtrl', ($scope, $stateParams, userExam) ->
  $scope.userExam = userExam
  $scope.exam = userExam.exam
