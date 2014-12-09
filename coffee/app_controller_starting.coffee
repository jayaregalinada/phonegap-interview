###
app_controller_starting
###

interview.controller 'StartingController', ( $rootScope, $state, $scope, $ionicLoading, $timeout )->

    $scope.show = ->
        $ionicLoading.show
            template: 'SOMETHING AWESOME IS LOADING'

        

        return

    $scope.hide = ->
        $ionicLoading.hide()

    $scope.show()
