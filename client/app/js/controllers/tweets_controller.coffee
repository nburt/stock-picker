angular.module("app").controller("TweetsController", [
  "$scope",
  "$http",
  "$controller",
  ($scope, $http, $controller) ->
    $controller('PagesController', {$scope: $scope})

    $scope.tweets = null

    $scope.fetchTweets = ->
      $http.get(
        "/api/v1/stocks/" + $scope.id + "/tweets"
      ).success (response) ->
        $scope.tweets = response

])