angular.module('infish').directive 'fileUploadModal', ($timeout) ->
  templateUrl: 'file-upload-modal.html'
  controller: ($scope) ->
    modalOpen = false

    $scope.ifShowModal = -> modalOpen
    $scope.showModal = -> modalOpen = true
    $scope.closeModal = -> modalOpen = false
    $scope.toggleModal = -> modalOpen = !modalOpen


    addToForm = (states_text, question, answers) ->
      states = []
      states.push (states_text[i] == '1') for i in [0..states_text.length]

      $scope.addNewFilledQuestion(question, answers, states)
      $scope.$apply()

    parseFile = (content) ->
      states_and_question_regex = /// ^ #begin of line
        X(\d+)[\r\n]{1,2}
        [\d.\s\t]*(.*)[\r\n\t\s]+
         ///i
      line_split_regex = /[^\r\n]+/g

      states_question_result = content.match states_and_question_regex
      question = states_question_result[2]
      states_text = states_question_result[1]

      answers = content.match(line_split_regex).slice(2).map (item) ->
        item = item.replace /[(]{0,1}[a-j]{1}[\.);]/i, ""
        item.trim()

      addToForm states_text, question, answers if states_question_result && answers.length == states_text.length


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
