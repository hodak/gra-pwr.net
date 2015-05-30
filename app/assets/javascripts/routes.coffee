angular.module('infish').config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    .state 'exams',
      abstract: true
      template: """<ui-view></ui-view>"""
      resolve:
        userExams: (UserExam) ->
          # TODO: what if there's an error? e.g. 401?
          UserExam.index().then (response) ->
            response.data
    .state 'exams.index',
      url: '/',
      templateUrl: '/assets/index.html'
      controller: 'IndexCtrl'
