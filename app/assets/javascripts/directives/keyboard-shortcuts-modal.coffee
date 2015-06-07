angular.module('infish').directive 'keyboardShortcutsModal', ($timeout) ->
  templateUrl: 'keyboard-shortcuts-modal.html'
  controller: ($scope) ->
    modalOpen = false

    $scope.ifShowModal = -> modalOpen
    $scope.showModal = -> modalOpen = true
    $scope.closeModal = -> modalOpen = false
    $scope.toggleModal = -> modalOpen = !modalOpen
  link: (scope, element) ->
    angular.element(window.document).on 'keypress', (e) ->
      if e.which == 63 # questionmark
        $timeout ->
          scope.toggleModal()
