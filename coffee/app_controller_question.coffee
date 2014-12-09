###
app_controller_question
###
interview.controller "QuestionController", ( $rootScope, $state, $stateParams, $scope, $timeout, $interval, $window, Question, $ionicLoading ) ->

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
    $scope.extension = '.mp3'

    

    $scope.createQuestion = ->
        if( $stateParams.id > 4 )
            $state.transitionTo( 'sending' )
        else
            q = Question.get $stateParams.id
            console.log( q )
            $scope.question = 
                title: q.name
                id: parseInt($stateParams.id) + 1
                response: q.response[ Math.floor Math.random() * q.response.length ]


    $scope.createMedia = (fileName) ->
        # console.log('*** [trigger] createMedia() ***')
        # console.log( mediaRecFile )
        # console.log( cordova.file )
        # console.log('*** CORDOVA FILE IS READY ***')
        $scope.debugText = fileName
        mediaInstance = new Media( cordova.file.externalDataDirectory + fileName, $scope.recordingSuccess, $scope.recordingError)
        # console.log('*** SUCCESSFULLY createMedia ***')
        # console.log( fileName )

    $scope.nowRecording = ->
        # console.log "*** [trigger] nowRecording() ***"
        # console.log "*** [status] micState: " + $scope.micState + " ***"
        # mediaRecFile = "i_" + $rootScope.email + "_" + Math.random().toString(36).substring(7) + ".mp3"
        time = new Date().getTime()
        mediaRecFile = "i_" + $rootScope.email + "_" + time + $scope.extension
        if mediaInstance
            # console.log "*** `mediaInstance` is still activated ***"
            mediaInstance.release()
            # console.log "*** `mediaInstance` is now release() ***"
        


        # mediaInstance = new Media( mediaRecFile, $scope.recordingSuccess, $scope.recordingError );
        unless $scope.micState
            $scope.createMedia mediaRecFile
            $scope.startRecording mediaRecFile
        else
            $scope.endRecording mediaInstance
            return

    $scope.startRecording = (fileName) ->
        # console.log fileName
        $ionicLoading.hide()
        mediaInstance.release()  if mediaInstance
        # console.log "*** [trigger] startRecording() ***"
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

    $scope.uploadQuestion = ->
        Question.upload(
            mediaInstance.src
            (success)->
                res = JSON.parse success.response 
                $rootScope.recordFile.push res.success.data.new 
                $ionicLoading.show
                    template: 'Successfully uploaded'
                $scope.nextQuestion()

            (error)->
                console.log '*** ERROR ***'
                $ionicLoading.show
                    template: 'LOADING'
                $scope.uploadQuestion()
        )
        return

    $scope.endRecording = ( instance ) ->
        # console.log "*** [trigger] endRecording() ***"
        if mediaInstance
            console.log instance
            mediaInstance.stopRecord()
            $scope.debugText = JSON.stringify( mediaInstance.src )
            $scope.uploadQuestion()
            # uploadingQuestion = Question.upload( 
            #     mediaInstance.src
            #     (success)->
            #         res = JSON.parse success.response 
            #         $rootScope.recordFile.push res.success.data.new 
            #         console.log $rootScope.recordFile
            #     (error)->
            #         console.log '*** ERROR ***'
            #         alert('error in uploading trying to upload again')
            # )

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

        return

    $scope.nextQuestion = ->
        $ionicLoading.hide()
        # console.log('*** Next Question ***')
        nextNumber = parseInt($stateParams.id)  + 1
        # console.log( $state )
        $timeout(->
            $state.transitionTo( 'question', { id: nextNumber } )
            return
        , 3000)

        return

    $scope.recordingSuccess = (record) ->
        # console.log "*** [trigger] recordingSuccess() ***"
        # console.log record
        return

    $scope.recordingError = (err) ->
        # console.log "*** [trigger] recordingError() ***"
        $scope.micState = true
        $scope.micStateText = "ERROR"
        # console.log err
        return

    $scope.currentPosition = ->
        # console.log "*** [trigger] currentPosition() ***"
        curPosition = $interval(->
            $scope.timerStatus++
            return
        , 999)
        return

    $scope.micRecording = ->
        # console.log "*** [trigger] micRecording() ***"
        mediaRecFile = "interview_record_" + Math.random().toString(36).substring(7) + ".mp3"
        mediaInstance = new Media(mediaRecFile, $scope.recordingSuccess, $scope.recordingError)
        mediaInstance.startRecord()
        return

    $scope.micDone = ->
        # console.log "*** [trigger] micDone() ***"
        mediaInstance.stopRecord()
        mediaInstance.play()
        console.log mediaInstance
        return

    $scope.createQuestion()

