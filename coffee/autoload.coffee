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
  "angularTypewrite"
  "LocalStorageModule"
  "angularFileUpload"
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
  .state('welcome'
    url: '/'
    controller: 'WelcomeController'
    templateUrl: 'views/welcome.html'
  )
  .state('question'
    url: '/question/:id'
    controller: 'QuestionController'
    templateUrl: 'views/question.html'
  )
  .state('sending' 
    url: '/sending'
    controller: 'SendingController'
  )
  .state('thankyou'
    url: '/thankyou'
    controller: 'ThankYouController'
    templateUrl: 'views/thankyou.html'
  )
  .state('intro'
    url: '/intro'
    controller: 'IntroController'
    templateUrl: 'views/intro.html'
  )


  $urlRouterProvider
  .otherwise('/')
  return

###
angular-local-storage
###
interview.config (localStorageServiceProvider)->
  localStorageServiceProvider
  .setPrefix 'i_'
  .setStorageType 'sessionStorage'

  return

document.addEventListener "deviceready", onDeviceReady, false
document.addEventListener "DOMContentLoaded", onDeviceReady, false