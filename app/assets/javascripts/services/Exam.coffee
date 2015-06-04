angular.module('infish').service 'Exam', ($http) ->
  base = '/api/exams'

  show: (id) ->
    $http.get "#{base}/#{id}"

  createOrUpdate: (exam) ->
    $http.put "#{base}/#{exam.id}",
      exam: exam
