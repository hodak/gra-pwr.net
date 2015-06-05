angular.module('infish').factory 'Redirector', ($timeout) ->
  redirect = true

  @saveUrl = (hash) =>
    redirect = false
    localStorage.setItem('infish.hash', hash)

  @redirectToSavedUrl = ->
    return unless redirect
    redirect = false

    hash = localStorage.getItem('infish.hash')
    localStorage.removeItem('infish.hash')
    $timeout ->
      location.hash = hash if hash

  @

