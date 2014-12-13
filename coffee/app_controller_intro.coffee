###
app_controller_intro
###
interview.controller 'IntroController', ( $rootScope, $state, $stateParams, $scope, $timeout, $ionicLoading ) ->

    $scope.questions = [
        'Hi!'
        'Welcome to the introduction of this assessment'
        'We are going to ask you a few question'
        'wherein you need to answer using your voice'
        'Are you ready?'
        'Hope you are'
    ]

    $scope.startTheTutorial = ->
        $timeout(->
            $ionicLoading.show
                template: 'Now starting questions'
        , 2000)
        $timeout(->
            $state.transitionTo 'question',
                id: 0
        , 5000)
        return

    

    $ionicLoading.hide()
    return
