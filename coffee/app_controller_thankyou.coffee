###
app_controller_thankyou
###
interview.controller 'ThankYouController', ( $rootScope, $state, $stateParams, $scope, $timeout, $ionicLoading ) ->

    $scope.startButtonStatus = false

    $ionicLoading.hide()

    $scope.showStartButton = ->
        $scope.startButtonStatus = !$scope.startButtonStatus
        return

