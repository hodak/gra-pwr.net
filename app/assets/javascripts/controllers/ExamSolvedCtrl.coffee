angular.module('infish').controller 'ExamSolvedCtrl', ($scope) ->
  $scope.isAbstinent = false

  $scope.abstinentify = ->
    $scope.isAbstinent = true

