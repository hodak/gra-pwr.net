angular.module('infish').directive 'fileUploadModal', ($timeout) ->
  templateUrl: 'file-upload-modal.html'
  controller: ($scope) ->
    modalOpen = false

    $scope.ifShowModal = -> modalOpen
    $scope.showModal = -> modalOpen = true
    $scope.closeModal = -> modalOpen = false
    $scope.toggleModal = -> modalOpen = !modalOpen


    addToForm = (question, answers) ->
      states = []
      states.push (question[i] == '1') for i in [1..4]
      question = question[5]

      $scope.addNewFilledQuestion(question, answers, states)
      $scope.$apply()

    parseFile = (content) ->
      states_and_question_regex = /// ^ #begin of line
        X(\d)(\d)(\d)(\d)[\r\n]{1,2}
        [\d.\s]*(.*):*[\r\n\t\s]+
         ///i

      answers_regex = /[a-j]\.[\s]*(.*)[\r\n\t\s]*/g

      question = content.match states_and_question_regex
      answers = content.match answers_regex

      addToForm question, answers if question && answers


    loadFile = (file) ->
      return if file.type != "text/plain"

      reader = new FileReader()
      reader.onload = (e) ->
        codes = new Uint8Array(e.target.result)
        encoding = jschardet.detect(codes).encoding
        if encoding == "ascii"
          encoding = "CP1250"

        decoder = new TextDecoder(encoding)
        parseFile decoder.decode(codes)

      reader.readAsArrayBuffer(file);

    $scope.sendFiles = () ->
      fileHandle = document.getElementById('file')
      loadFile f for f in fileHandle.files
      fileHandle.value = ""
      modalOpen = false
