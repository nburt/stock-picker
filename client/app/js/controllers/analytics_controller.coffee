angular.module("app").controller("AnalyticsController", [
  "$scope",
  "$http",
  ($scope, $http) ->
    $scope.tweets = {}

    $scope.init = ->
      $scope.tweetsAdded()

    $scope.tweetsAdded = ->
      $http.get(
        "/api/v1/analytics/tweets_added"
      ).success((response) ->
        $scope.tweets.added = response
      )
])