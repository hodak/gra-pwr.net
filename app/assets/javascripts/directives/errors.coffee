angular.module('infish').directive 'errors', ->
  template: """<span ng-repeat="error in errors" ng-bind="error"></span>"""
  scope:
    errors: '=errors'

