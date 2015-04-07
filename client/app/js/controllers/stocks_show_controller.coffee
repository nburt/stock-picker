angular.module("app").controller("StocksShowController", [
  "$scope",
  "$http",
  "$controller",
  ($scope, $http, $controller) ->
    $controller('PagesController', {$scope: $scope})
    $scope.stock = null

    $scope.fetchStock = ->
      $http.get(
        "/api/v1/stocks/" + $scope.id
      ).success (response) ->
        $scope.stock = response

    $scope.formatKeywords = (keywords) ->
      keywordsArray = []
      angular.forEach(keywords, (keyword) ->
        keywordsArray.push(keyword.text)
      )

      keywordsArray.join(", ")

    $scope.newDate = (date) ->
      new Date(date)

])