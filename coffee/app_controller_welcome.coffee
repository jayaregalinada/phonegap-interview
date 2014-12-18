###
app_controller_welcome
###

interview.controller 'WelcomeController', ( localStorageService, $rootScope, $state, $scope, $ionicLoading, $timeout )->

    $scope.show = ->
        $ionicLoading.show
            template: 'SOMETHING AWESOME IS LOADING'

        $timeout(->
            $ionicLoading.hide()
        , 3000)

        localStorageService.clearAll()
        return

    $scope.hide = ->
        $ionicLoading.hide()
        return

    $scope.welcomeSubmit = ->
        $ionicLoading.show
            template: 'LOADING'

        localStorageService.set 'applicant_email', $scope.email
        localStorageService.set 'email', $scope.email.replace '@', '_'

        $rootScope.email = localStorageService.get 'email'
        $rootScope.applicantEmail = localStorageService.get 'applicant_email'

        $timeout(->
            $state.transitionTo 'intro',
        , 2000)

        return


    $scope.show()
