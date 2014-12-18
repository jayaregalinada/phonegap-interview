###
app_controller_question
###
interview.controller "QuestionController", ( $http, $rootScope, $state, $stateParams, $scope, $timeout, $interval, $window, Question, $ionicLoading, localStorageService ) ->

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
    $scope.constraints = 
        audio: true
        video: false
    $scope.userMedia = null



    $scope.createQuestion = ->
        $ionicLoading.hide()
        if( $stateParams.id > Question.length() - 1 )
            $state.transitionTo 'sending' 
        else
            q = Question.get $stateParams.id
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

    $scope.createMediaForBrowser = (fileName) ->

        navigator.getUserMedia( $scope.constraints, (stream) ->
            $scope.userMedia = stream
            mediaInstance = RecordRTC( stream,
                type: 'audio'
                autoWriteToDisk: true
            )
            mediaInstance.startRecording()
            $scope.startRecording( fileName )

        , (err)->
            console.log err
        )

    $scope.nowRecording = ->
        # console.log "*** [trigger] nowRecording() ***"
        # console.log "*** [status] micState: " + $scope.micState + " ***"
        # mediaRecFile = "i_" + $rootScope.email + "_"+ Math.random().toString(36).substring(7) + ".mp3"
        time = new Date().getTime()
        mediaRecFile = $rootScope.email + "_" + time + $scope.extension
        if mediaInstance
            # console.log "*** `mediaInstance` is still activated ***"
            if( phoneCheck.android )
                mediaInstance.release()
            # console.log "*** `mediaInstance` is now release() ***"
        


        # mediaInstance = new Media( mediaRecFile, $scope.recordingSuccess, $scope.recordingError );
        unless $scope.micState
            if( phoneCheck.android )
                $scope.createMedia mediaRecFile
                $scope.startRecording mediaRecFile
            else
                $scope.createMediaForBrowser mediaRecFile
        else
            $scope.endRecording mediaInstance
            return

    $scope.startRecording = (fileName) ->
        # console.log fileName
        $ionicLoading.hide()
        # console.log "*** [trigger] startRecording() ***"
        if( phoneCheck.android )

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
            file: mediaInstance.src
            name: mediaRecFile
            (success)->
                if phoneCheck.android
                    res = JSON.parse success.response
                        template: 'Successfully uploaded'

                console.log success
                $rootScope.recordFile.push success.success.new
                localStorageService.set 'record', JSON.stringify $rootScope.recordFile
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
            if( phoneCheck.android )
                mediaInstance.stopRecord()
            else

                mediaInstance.stopRecording((callback)->
                    # console.log( callback )
#                    mediaInstance.src = callback
                    console.log('*** stopRecording() ***')
                    mediaInstance.src = mediaInstance.getBlob()
                    $scope.userMedia.stop()
#                    mediaInstance.save()
#                    mediaInstance.writeToDisk()
#                    mediaInstance.stop()


                    # console.log mediaInstance.writeToDisk()

                    # console.log( mediaInstance.getBlob() )
                    
                    return
                    # console.log( callback.toURL() )
                    
                    # mediaInstance.getDataURL((dataURL)->
                    #     console.log( dataURL )
                    # )
                )



            # $scope.debugText = JSON.stringify( mediaInstance.src )
            $scope.uploadQuestion()

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



    $scope.createQuestion()

