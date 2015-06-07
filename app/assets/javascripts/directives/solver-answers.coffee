angular.module('infish').directive 'solverAnswers', ($timeout) ->
  keyBindings =
    49: 1
    50: 2
    51: 3
    52: 4
    53: 5
    54: 6
    55: 7
    56: 8
    57: 9

  templateUrl: 'solver/_answers.html'
  link: (scope, element) ->
    tryPressInput = (e) ->
      keyPressed = keyBindings[e.which]
      return unless keyPressed?
      element.find('input')[keyPressed - 1]?.click()

    angular.element(window.document).on 'keypress', (e) ->
      if e.which in [13, 32] # Enter or Space
        $timeout ->
          if scope.current.check
            scope.nextQuestion()
          else
            scope.checkAnswers()
      else
        tryPressInput(e)
