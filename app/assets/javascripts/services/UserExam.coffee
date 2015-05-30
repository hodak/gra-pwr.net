angular.module('infish').service 'UserExam', ($http) ->
  base = '/api/user_exams/'

  index: ->
    $http.get base
