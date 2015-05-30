angular.module('infish').service 'UserExam', ($http, $q) ->
  base = '/api/user_exams'

  cachedUserExams = undefined

  index: ->
    deferred = $q.defer()

    if cachedUserExams?
      deferred.resolve cachedUserExams
    else
      $http.get(base).then (response) ->
        cachedUserExams = response.data
        deferred.resolve response.data

    deferred.promise

  show: (id) ->
    (e for e in cachedUserExams when e?.exam?.id == id)[0]

  syncUserAnswers: (userExam, userAnswers) ->
    $http.put "#{base}/#{userExam.id}/sync_user_answers",
      user_answers: userAnswers
