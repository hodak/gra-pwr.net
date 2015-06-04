angular.module('infish').controller 'CreateExamCtrl', ($scope) ->
  $scope.exam =
    id: UUIDjs.create().toString()
