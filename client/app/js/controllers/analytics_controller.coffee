angular.module("app").controller("AnalyticsController", [
  "$scope",
  "$http",
  ($scope, $http) ->
    $scope.tweets = {}
    $scope.articles = {}

    $scope.init = ->
      $scope.tweetsAdded()
      $scope.articlesAdded()

    $scope.tweetsAdded = ->
      $http.get(
        "/api/v1/analytics/tweets/added"
      ).success((response) ->
        $scope.tweets.added = response
      )

    $scope.articlesAdded = ->
      $http.get(
        "/api/v1/analytics/articles/added"
      ).success((response) ->
        $scope.articles.added = response
      )
])