angular.module("app").controller("StockPricesController", [
  "$scope",
  "$http",
  "$controller",
  ($scope, $http, $controller) ->
    $controller('PagesController', {$scope: $scope})

    $scope.stockPrices = null

    $scope.fetchStockPrices = ->
      $http.get(
        "/api/v1/stocks/" + $scope.id + "/stock_prices"
      ).success (response) ->
        $scope.stockPrices = response

])