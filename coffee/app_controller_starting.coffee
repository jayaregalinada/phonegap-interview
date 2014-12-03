###
app_controller_starting
###

interview.controller 'StartingController', ( $state, $scope, $ionicLoading, $timeout )->

    $scope.show = ->
        $ionicLoading.show
            template: 'SOMETHING AWESOME IS LOADING'
        
        $timeout(->
            console.log('*** hide now ***')
            $ionicLoading.hide()
            $state.transitionTo( 'question', { id: 0 } )
        , 5000)
        

        return

    $scope.hide = ->
        $ionicLoading.hide()

    $scope.show()
