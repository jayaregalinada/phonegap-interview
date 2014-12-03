interview.controller 'LoadingController', ( $scope, $ionicLoading, $timeout )->

    $scope.show = ->
        $ionicLoading.show
            template: 'Loading...'
        
        $timeout(->
            console.log('*** hide now ***')
            $ionicLoading.hide()
        , 5000)
        

        return

    $scope.hide = ->
        $ionicLoading.hide()

    $scope.show()
