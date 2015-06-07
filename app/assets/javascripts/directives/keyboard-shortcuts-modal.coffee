angular.module('infish').directive 'keyboardShortcutsModal', ->
  templateUrl: 'keyboard-shortcuts-modal.html'
  controller: ($scope) ->
    modalOpen = false

    $scope.ifShowModal = -> modalOpen
    $scope.showModal = -> modalOpen = true
    $scope.closeModal = -> modalOpen = false
  link: (scope, element) ->
    console.log 'element'
