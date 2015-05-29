angular.module('infinish').service 'UserExam', ($http) ->
  base = '/api/user_exams/'

  index: ->
    $http.get base
