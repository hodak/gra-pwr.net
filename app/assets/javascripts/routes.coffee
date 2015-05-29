angular.module('DigApp').config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    .state 'index',
      url: '/',
      templateUrl: '/assets/index.html'

