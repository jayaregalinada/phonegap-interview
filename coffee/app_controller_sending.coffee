###
app_controller_sending
###
interview.controller 'SendingController', ( $timeout, $rootScope, $scope, $state, $stateParams, $ionicLoading, $http )->
    
    $scope.sendingState = false
    $scope.sender = 'http://i.ubl.ph/mail.php'

    mailConfig = 
        email: [
            'jayaregalinada@gmail.com'
        ]
        subject: 'New Applicant :: Interview App'
        body: 'Hey another applicant'

    $scope.startSession = ->
        $rootScope.email = $scope.email.replace '@', '_'
        return

    $scope.sendForm = ->
        $scope.sendingState = !$scope.sendingState

        $ionicLoading.show
            template: 'SENDING YOUR APPLICATION'

        $http.post( 
            $scope.sender
            records:
                $rootScope.recordFile
            email:
                $scope.email
        )
        .success( (data, status, headers, config)->
            $ionicLoading.show
                template: 'APPLICATION SENT'
            $rootScope.recordFile = []
            $timeout(->
                $state.transitionTo 'initializing'
            , 3000)
            return
        )
        .error( (data, status)->
            console.log( data )
            return
        )


        return

    return


