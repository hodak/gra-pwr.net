App = angular.module 'infish', ['ui.router', 'checklist-model']

App.config ($locationProvider) ->
  $locationProvider.html5Mode true

App.config ($provide, $httpProvider, Rails) ->
  $provide.factory 'railsAssetsInterceptor', ->
    request: (config)->
      if assetUrl = Rails.templates[config.url]
        config.url = assetUrl
      config

  $httpProvider.interceptors.push 'railsAssetsInterceptor'

