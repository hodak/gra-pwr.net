angular.module('infish').config ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $locationProvider.html5Mode false
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
    .state 'exams.edit',
      url: '/exam/:id/edit'
      templateUrl: '/assets/edit-exam.html'
      controller: 'EditExamCtrl'
      resolve:
        exam: ($stateParams, Exam) ->
          Exam.show($stateParams.id).then (response) -> response.data.exam
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

    .state 'exams.repeats',
      url: '/exam/:id/repeats'
      templateUrl: '/assets/exam-repeats.html'
      controller: 'UserExamChooseRepeats'
