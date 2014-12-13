###
app_controller_welcome
###

interview.controller 'WelcomeController', ( $rootScope, $state, $scope, $ionicLoading, $timeout )->

    $scope.show = ->
        $ionicLoading.show
            template: 'SOMETHING AWESOME IS LOADING'

        $timeout(->
            $ionicLoading.hide()
        , 3000)

        return

    $scope.hide = ->
        $ionicLoading.hide()
        return

    $scope.welcomeSubmit = ->
        $ionicLoading.show
            template: 'LOADING'
        $rootScope.email = $scope.email.replace '@', '_'

        $timeout(->
            $state.transitionTo 'intro',
        , 2000)

        return


    $scope.show()
