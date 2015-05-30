angular.module('infish').service 'UserExam', ($http, $q) ->
  base = '/api/user_exams'

  index: ->
    $http.get base

  show: (exam_id) ->
    $http.get "#{base}/#{exam_id}"

  syncUserAnswers: (userExam, userAnswers) ->
    $http.put "#{base}/#{userExam.id}/sync_user_answers",
      user_answers: userAnswers
