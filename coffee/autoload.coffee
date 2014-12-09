###
autoload
###

_i =
  init: ->
    angular.bootstrap document, ["app"]
    console.log('*** App initializing ***')
    return

onDeviceReady = ->
  console.log "*** Device is READY ***"
  angular.bootstrap document, ["app"]
  
  return


interview = angular.module("app", [ 
  "ionic"
  "ngMaterial"
]).run ( $ionicPlatform, $rootScope ) ->
  $rootScope.recordFile = []
  $rootScope.email = null
  $ionicPlatform.ready ->
    cordova.plugins.Keyboard.hideKeyboardAccessoryBar true  if window.cordova and window.cordova.plugins.Keyboard

    StatusBar.styleDefault()  if window.StatusBar

    return

  return

###
routes
###
interview.config ($stateProvider, $urlRouterProvider)->

  $stateProvider
  .state('initializing'
    url: '/'
    controller: 'StartingController'
  )
  .state('question'
    url: '/question/:id'
    controller: 'QuestionController'
    templateUrl: 'templates/question.html'
  )
  .state( 'sending' 
    url: '/sending'
    controller: 'SendingController'
    templateUrl: 'templates/sending.html'
  )


  $urlRouterProvider
  .otherwise('/')
  return

document.addEventListener "deviceready", onDeviceReady, false