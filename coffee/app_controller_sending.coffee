###
app_controller_sending
###
interview.controller 'SendingController', ( localStorageService, $timeout, $rootScope, $scope, $state, $stateParams, $ionicLoading, $http )->
    
    $scope.sendingState = false
    $scope.sender = 'mail' #'http://i.ubl.ph/mail.php'

    mailConfig = 
        email: [
            'jayaregalinada@gmail.com'
        ]
        subject: 'New Applicant :: Interview App'
        body: 'Hey another applicant'

    $scope.data = {}

    $scope.sendForm = ->
        $scope.sendingState = !$scope.sendingState

        $ionicLoading.show
            template: 'PLEASE WAIT WE ARE SENDING YOUR APPLICATION'

        $scope.data =
            email:
                localStorageService.get 'applicant_email'
            records:
                localStorageService.get 'record'


        $http.post( 
            $scope.sender
            data: $scope.data
        )
        .success( (data, status, headers, config)->
            $ionicLoading.show
                template: 'APPLICATION SENT'
            $rootScope.recordFile = []
            $timeout(->
                $state.transitionTo 'thankyou'
            , 3000)
            console.log data
            return
        )
        .error( (data, status)->
            console.log data
            alert 'ERROR IN SENDING FORM'
            $scope.sendForm()
            return
        )


        return

    $scope.sendForm()

    return


