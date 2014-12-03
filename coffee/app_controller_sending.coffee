###
app_controller_sending
###
interview.controller 'SendingController', ( $scope, $state, $stateParams, $ionicLoading, $http )->
    
    $scope.sendingState = false

    mailConfig = 
        email: [
            'jayaregalinada@gmail.com'
        ]
        subject: 'New Applicant :: Interview App'
        body: 'Hey another applicant'

    $scope.sendForm = ->
        $scope.sendingState = !$scope.sendingState


        $ionicLoading.show
            template: 'SENDING YOUR APPLICATION'

        window.plugin.email.addAlias('gmail', 'com.google.android.gm');

        window.plugin.email.open
            app: 'gmail'
            to: mailConfig.email
            subject: mailConfig.subject
            body: mailConfig.body
            isHtml: true
        , ->
            $ionicLoading.hide()
            $ionicLoading.show
                template: 'SENT'

        # $scope.send()


        return

    $scope.send = ->
        window.plugin.email.open
            to: mailConfig.email
            subject: mailConfig.subject
            body: mailConfig.body
            isHtml: true
        , ->
            $ionicLoading.hide()
            $ionicLoading.show
                template: 'SENT'

            return

        return

    return


