angular.module("app").controller("PagesController", [
  "$scope",
  "$location",
  ($scope, $location) ->
    $scope.fetchId = ->
      array = $location.path().split("/")
      array[array.length - 1]

    $scope.id = $scope.fetchId()

])