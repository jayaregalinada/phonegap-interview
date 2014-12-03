###
app_controller_question
###
interview.controller "QuestionController", ( $state, $stateParams, $scope, $timeout, $interval, $window, Question ) ->

    mediaRecFile = null
    mediaInstance = null
    curPosition = undefined
    tapAgain = undefined
    media = undefined
    mic = 
        on: "img/ic_mic_24px.svg"
        off: "img/ic_mic_off_24px.svg"
    
    $scope.micState = false
    $scope.micStateText = "TAP THE MIC TO ANSWER"
    $scope.micIcon = "img/ic_mic_24px.svg"
    $scope.question = {}
        # title: "What is your name?"
        # number: 1

    $scope.timerStatus = 0
    $scope.deviceReady = true
    $scope.responseState = false
    $scope.stateParams = $stateParams
    $scope.state = $state
    $scope.debugText = null

    

    $scope.createQuestion = ->
        if( $stateParams.id > 4 )
            $state.transitionTo( 'sending' )
        else
            q = Question.get $stateParams.id
            console.log( q )
            $scope.question = 
                title: q.name
                id: parseInt($stateParams.id) + 1
                response: q.response[0]


    $scope.createMedia = (fileName) ->
        console.log('*** [trigger] createMedia() ***')
        console.log( mediaRecFile )
        console.log( cordova.file )
        console.log('*** CORDOVA FILE IS READY ***')
        $scope.debugText = fileName
        mediaInstance = new Media( cordova.file.externalDataDirectory + fileName, $scope.recordingSuccess, $scope.recordingError)
        console.log('*** SUCCESSFULLY createMedia ***')
        console.log( fileName )

    $scope.nowRecording = ->
        console.log "*** [trigger] nowRecording() ***"
        console.log "*** [status] micState: " + $scope.micState + " ***"
        mediaRecFile = "interview_record_" + Math.random().toString(36).substring(7) + ".mp3"
        if mediaInstance
            console.log "*** `mediaInstance` is still activated ***"
            mediaInstance.release()
            console.log "*** `mediaInstance` is now release() ***"
        


        # mediaInstance = new Media( mediaRecFile, $scope.recordingSuccess, $scope.recordingError );
        unless $scope.micState
            $scope.createMedia mediaRecFile
            $scope.startRecording mediaRecFile
        else
            $scope.endRecording mediaInstance
            return

    $scope.startRecording = (fileName) ->
        console.log fileName
        mediaInstance.release()  if mediaInstance
        console.log "*** [trigger] startRecording() ***"
        mediaInstance.startRecord()
        $scope.micIcon = mic.off
        $scope.micState = not $scope.micState
        $scope.micStateText = "SPEAK NOW"
        tapAgain = $timeout(->
            $scope.micStateText = "TAP AGAIN TO STOP"
            return
        , 4000)
        $scope.currentPosition()
        return

    $scope.endRecording = ( instance ) ->
        console.log "*** [trigger] endRecording() ***"
        if mediaInstance
            console.log instance
            mediaInstance.stopRecord()
        if angular.isDefined(curPosition)
            $interval.cancel curPosition
            curPosition = `undefined`
        if angular.isDefined(tapAgain)
            $timeout.cancel tapAgain
            tapAgain = `undefined`
        $scope.micIcon = mic.on
        $scope.micState = false
        $scope.micStateText = "NICELY DONE"
        $scope.timerStatus = 0 # restart timer
        $scope.responseState = true
        $scope.responseStateText = $scope.question.response

        $scope.nextQuestion()
        return

    $scope.nextQuestion = ->
        console.log('*** Next Question ***')
        nextNumber = parseInt($stateParams.id)  + 1
        nextState = $state.href( 'question', { id: nextNumber } )
        console.log( $state )
        $timeout(->
            $state.transitionTo( 'question', { id: nextNumber } )
        , 3000)

        return

    $scope.recordingSuccess = (record) ->
        console.log "*** [trigger] recordingSuccess() ***"
        console.log record
        return

    $scope.recordingError = (err) ->
        console.log "*** [trigger] recordingError() ***"
        $scope.micState = true
        $scope.micStateText = "ERROR"
        console.log err
        return

    $scope.currentPosition = ->
        console.log "*** [trigger] currentPosition() ***"
        curPosition = $interval(->
            $scope.timerStatus++
            return
        , 999)
        return

    $scope.micRecording = ->
        console.log "*** [trigger] micRecording() ***"
        mediaRecFile = "interview_record_" + Math.random().toString(36).substring(7) + ".mp3"
        mediaInstance = new Media(mediaRecFile, $scope.recordingSuccess, $scope.recordingError)
        mediaInstance.startRecord()
        return

    $scope.micDone = ->
        console.log "*** [trigger] micDone() ***"
        mediaInstance.stopRecord()
        mediaInstance.play()
        console.log mediaInstance
        return

    $scope.createQuestion()

