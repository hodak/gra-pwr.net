angular.module('infinish').service 'Test', ($http) ->
  base = '/api/tests/'

  index: ->
    $http.get base
