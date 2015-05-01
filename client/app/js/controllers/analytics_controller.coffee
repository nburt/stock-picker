angular.module("app").controller("AnalyticsController", [
  "$scope",
  "$http",
  ($scope, $http) ->
    $scope.tweets = {}
    $scope.articles = {}
    $scope.reddits = {}

    $scope.init = ->
      $scope.tweetsAdded()
      $scope.tweetsTotal()
      $scope.tweetsTotalScored()
      $scope.articlesAdded()
      $scope.articlesTotal()
      $scope.articlesTotalScored()
      $scope.redditsAdded()
      $scope.redditsTotal()
      $scope.redditsTotalScored()

    $scope.tweetsAdded = ->
      $http.get(
        "/api/v1/analytics/tweets/added"
      ).success((response) ->
        $scope.tweets.added = response
      )

    $scope.tweetsTotal = ->
      $http.get(
        "/api/v1/analytics/tweets/total"
      ).success((response) ->
        $scope.tweets.total = response
      )

    $scope.tweetsTotalScored = ->
      $http.get(
        "/api/v1/analytics/tweets/total_scored"
      ).success((response) ->
        $scope.tweets.totalScored = response
      )

    $scope.articlesAdded = ->
      $http.get(
        "/api/v1/analytics/articles/added"
      ).success((response) ->
        $scope.articles.added = response
      )

    $scope.articlesTotal = ->
      $http.get(
        "/api/v1/analytics/articles/total"
      ).success((response) ->
        $scope.articles.total = response
      )

    $scope.articlesTotalScored = ->
      $http.get(
        "/api/v1/analytics/articles/total_scored"
      ).success((response) ->
        $scope.articles.totalScored = response
      )

    $scope.redditsAdded = ->
      $http.get(
        "/api/v1/analytics/reddits/added"
      ).success((response) ->
        $scope.reddits.added = response
      )

    $scope.redditsTotal = ->
      $http.get(
        "/api/v1/analytics/reddits/total"
      ).success((response) ->
        $scope.reddits.total = response
      )

    $scope.redditsTotalScored = ->
      $http.get(
        "/api/v1/analytics/reddits/total_scored"
      ).success((response) ->
        $scope.reddits.totalScored = response
      )

])