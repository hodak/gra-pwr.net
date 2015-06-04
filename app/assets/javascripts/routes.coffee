angular.module('infish').config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    .state 'exams',
      abstract: true
      template: """<ui-view></ui-view>"""
      resolve:
        userExams: (UserExam) ->
          UserExam.index().then (response) -> response.data
    .state 'exams.index',
      url: '/',
      templateUrl: '/assets/index.html'
      controller: 'IndexCtrl'
    .state 'exams.create',
      url: '/exam/new'
      templateUrl: '/assets/create-exam.html'
      controller: 'CreateExamCtrl'
    .state 'exams.show',
      url: '/exam/:id'
      templateUrl: '/assets/show-exam.html'
      controller: 'ExamCtrl'
      resolve:
        # by injecting userExams we ensure it gets resolved
        # before going into this resolve function, very handy
        # http://www.jvandemo.com/how-to-resolve-application-wide-resources-centrally-in-angularjs-with-ui-router/
        userExam: ($stateParams, userExams, UserExam) ->
          UserExam.show($stateParams.id).then (response) -> response.data
