angular.module('infish').service 'UserExam', ($http, $q) ->
  base = '/api/user_exams'

  index: ->
    $http.get base

  show: (examID) ->
    $http.get "#{base}/#{examID}"

  update: (userExam) ->
    $http.put "#{base}/#{userExam.id}",
      user_exam: userExam

  syncUserAnswers: (userExam, userAnswers) ->
    $http.put "#{base}/#{userExam.id}/sync_user_answers",
      user_answers: userAnswers
