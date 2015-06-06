angular.module('infish').directive 'errors', ->
  template: """<span ng-repeat="error in errors" ng-bind="error" class="crs-input__alert-message"></span>"""
  scope:
    errors: '=errors'

