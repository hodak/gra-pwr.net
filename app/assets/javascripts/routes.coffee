angular.module('infinish').config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    .state 'index',
      url: '/',
      templateUrl: '/assets/index.html'

