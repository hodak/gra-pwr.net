angular.module('infish').directive 'fileUploadModal', ($timeout) ->
  templateUrl: 'file-upload-modal.html'
  controller: ($scope) ->
    modalOpen = false

    $scope.ifShowModal = -> modalOpen
    $scope.showModal = -> modalOpen = true
    $scope.closeModal = -> modalOpen = false
    $scope.toggleModal = -> modalOpen = !modalOpen