angular.module('app', [
  'ngResource'
  'ngRoute'
]).run ($rootScope) ->
  $rootScope.log = (thing) ->
    console.log thing

  $rootScope.alert = (thing) ->
    alert thing
