angular.module('infish').service 'Exam', ($http) ->
  base = '/api/exams'

  createOrUpdate: (exam) ->
    $http.put "#{base}/#{exam.id}",
      exam: exam
