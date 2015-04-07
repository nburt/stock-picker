angular.module("app").controller("IndexController", [
  "$scope",
  "$http",
  "$location",
  ($scope, $http, $location) ->
    $scope.stocks = null

    $scope.init = ->
      $scope.fetchStocks()

    $scope.fetchStocks = ->
      $http.get(
        "/api/v1/stocks"
      ).success (response) ->
        $scope.stocks = response

    $scope.show = (id) ->
      $location.path("/stocks/" + id)
])