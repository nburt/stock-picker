describe "AnalyticsController", ->
  $scope = undefined
  $httpBackend = undefined
  $controller = undefined

  beforeEach ->
    module("app")

  beforeEach inject(($injector) ->
    $scope = $injector.get("$rootScope")
    $httpBackend = $injector.get("$httpBackend")
    $controller = $injector.get("$controller")

    $controller("AnalyticsController", $scope: $scope)
  )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe "initialize", ->
    it "calls tweetsAdded on init()", ->
      spyOn($scope, "tweetsAdded")
      spyOn($scope, "tweetsTotal")
      spyOn($scope, "tweetsTotalScored")
      spyOn($scope, "articlesAdded")
      spyOn($scope, "articlesTotal")
      spyOn($scope, "articlesTotalScored")
      spyOn($scope, "redditsAdded")
      spyOn($scope, "redditsTotal")
      spyOn($scope, "redditsTotalScored")

      $scope.init()

      expect($scope.tweetsAdded).toHaveBeenCalled()
      expect($scope.tweetsTotal).toHaveBeenCalled()
      expect($scope.tweetsTotalScored).toHaveBeenCalled()
      expect($scope.articlesAdded).toHaveBeenCalled()
      expect($scope.articlesTotal).toHaveBeenCalled()
      expect($scope.articlesTotalScored).toHaveBeenCalled()
      expect($scope.redditsAdded).toHaveBeenCalled()
      expect($scope.redditsTotal).toHaveBeenCalled()
      expect($scope.redditsTotalScored).toHaveBeenCalled()

  describe "tweetsAdded", ->
    it "fetches analytics information about the number of tweets added", ->
      $httpBackend.expectGET("/api/v1/analytics/tweets/added").respond(
        200, analytics.tweetsAdded.success
      )

      $scope.tweetsAdded()

      $httpBackend.flush()

      expect($scope.tweets.added).toEqual(analytics.tweetsAdded.success)

  describe "tweetsTotal", ->
    it "fetches analytics information about the total number of tweets", ->
      $httpBackend.expectGET("/api/v1/analytics/tweets/total").respond(
        200, analytics.tweetsTotal.success
      )

      $scope.tweetsTotal()

      $httpBackend.flush()

      expect($scope.tweets.total).toEqual(analytics.tweetsTotal.success)

  describe "tweetsTotalScored", ->
    it "fetches analytics information about the total number of tweets scored", ->
      $httpBackend.expectGET("/api/v1/analytics/tweets/total_scored").respond(
        200, analytics.tweetsTotal.success
      )

      $scope.tweetsTotalScored()

      $httpBackend.flush()

      expect($scope.tweets.totalScored).toEqual(analytics.tweetsTotal.success)

  describe "articlesAdded", ->
    it "fetches analytics information about the number of articles added", ->
      $httpBackend.expectGET("/api/v1/analytics/articles/added").respond(
        200, analytics.articlesAdded.success
      )

      $scope.articlesAdded()

      $httpBackend.flush()

      expect($scope.articles.added).toEqual(analytics.articlesAdded.success)

  describe "articlesTotal", ->
    it "fetches analytics information about the total number of articles", ->
      $httpBackend.expectGET("/api/v1/analytics/articles/total").respond(
        200, analytics.articlesTotal.success
      )

      $scope.articlesTotal()

      $httpBackend.flush()

      expect($scope.articles.total).toEqual(analytics.articlesTotal.success)

  describe "articlesTotalScored", ->
    it "fetches analytics information about the total number of articles scored", ->
      $httpBackend.expectGET("/api/v1/analytics/articles/total_scored").respond(
        200, analytics.articlesTotal.success
      )

      $scope.articlesTotalScored()

      $httpBackend.flush()

      expect($scope.articles.totalScored).toEqual(analytics.articlesTotal.success)

  describe "redditsAdded", ->
    it "fetches analytics information about the number of reddits added", ->
      $httpBackend.expectGET("/api/v1/analytics/reddits/added").respond(
        200, analytics.redditsAdded.success
      )

      $scope.redditsAdded()

      $httpBackend.flush()

      expect($scope.reddits.added).toEqual(analytics.redditsAdded.success)

  describe "redditsTotal", ->
    it "fetches analytics information about the total number of reddits", ->
      $httpBackend.expectGET("/api/v1/analytics/reddits/total").respond(
        200, analytics.redditsTotal.success
      )

      $scope.redditsTotal()

      $httpBackend.flush()

      expect($scope.reddits.total).toEqual(analytics.redditsTotal.success)

  describe "redditsTotalScored", ->
    it "fetches analytics information about the total number of reddits scored", ->
      $httpBackend.expectGET("/api/v1/analytics/reddits/total_scored").respond(
        200, analytics.redditsTotal.success
      )

      $scope.redditsTotalScored()

      $httpBackend.flush()

      expect($scope.reddits.totalScored).toEqual(analytics.redditsTotal.success)