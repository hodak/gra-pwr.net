angular.module('infish').controller 'IndexCtrl', ($scope, userExams, $rootScope) ->
  $scope.userExams = userExams
  $rootScope.$on 'examAdded', (event, data) -> 
    $scope.userExams.push {exam: data}
