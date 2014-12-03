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

  window.plugins.emailComposer.showEmailComposer(
    'Interview app'
    'Someone is attempting to email'
    ['jayaregalinada@gmail.com']
  )

  if( ! window.plugin.email )
    alert('sorry I can not run the email plugin')

  window.plugin.email.isServiceAvailable( (isAvailable) ->
    if( !isAvailable )
      alert('Email service is unavailable')
  )

  if( Media or window.Media )
    console.log "*** Media is [enabled] ***"
  
  return


interview = angular.module("app", [ 
  "ionic"
  "ngMaterial"
]).run ( $ionicPlatform, $rootScope ) ->
  $rootScope.recordFile = []
  $ionicPlatform.ready ->
    cordova.plugins.Keyboard.hideKeyboardAccessoryBar true  if window.cordova and window.cordova.plugins.Keyboard

    StatusBar.styleDefault()  if window.StatusBar

    console.log "*** Media is READY ***"  if window.Media
    
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