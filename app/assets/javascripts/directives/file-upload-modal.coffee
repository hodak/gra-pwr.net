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
      regex = /// ^ #begin of line
        X(\d)(\d)(\d)(\d)[\r\n]{1,2}
        [\d.\s]*(.*):*[\r\n\t\s]+
         ///i      

      regex2 = /[a-j]\.[\s]*(.*)[\r\n\t\s]*/g

      question = content.match regex
      answers = content.match regex2

      addToForm question, answers if question && answers


    loadFile = (file) ->
      return if file.type != "text/plain"

      r = new FileReader()
      r.onload = (e) ->
        codes = new Uint8Array(e.target.result)
        encoding = jschardet.detect codes

        if encoding.encoding == "ascii"
          encoding = "CP1250"
        else
          encoding = encoding.encoding

        decoder = new TextDecoder(encoding)
        parseFile decoder.decode(codes)
       
      r.readAsArrayBuffer(file);

    $scope.sendFiles = () ->
      fileHandle = document.getElementById('file')
      loadFile f for f in fileHandle.files
      fileHandle.value = ""
      modalOpen = false