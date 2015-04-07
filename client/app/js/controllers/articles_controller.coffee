angular.module("app").controller("ArticlesController", [
  "$scope",
  "$http",
  "$controller",
  ($scope, $http, $controller) ->
    $controller('PagesController', {$scope: $scope})

    $scope.articles = null

    $scope.fetchArticles = ->
      $http.get(
        "/api/v1/stocks/" + $scope.id + "/articles"
      ).success (response) ->
        $scope.articles = response

])