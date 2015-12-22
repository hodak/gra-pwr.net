angular.module('infish').controller 'ExamSolvedCtrl', ($scope, $location) ->
  $scope.isAbstinent = false

  $scope.error = $location.search()['error']
  $scope.abstinentify = ->
    $scope.isAbstinent = true

