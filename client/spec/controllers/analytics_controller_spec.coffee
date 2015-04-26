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
      spyOn($scope, "articlesAdded")
      $scope.init()
      expect($scope.tweetsAdded).toHaveBeenCalled()
      expect($scope.articlesAdded).toHaveBeenCalled()

  describe "tweetsAdded", ->
    it "fetches analytics information about the number of tweets added", ->
      $httpBackend.expectGET("/api/v1/analytics/tweets/added").respond(
        200, analytics.tweetsAdded.success
      )

      $scope.tweetsAdded()

      $httpBackend.flush()

      expect($scope.tweets.added).toEqual(analytics.tweetsAdded.success)

  describe "articlesAdded", ->
    it "fetches analytics information about the number of articles added", ->
      $httpBackend.expectGET("/api/v1/analytics/articles/added").respond(
        200, analytics.articlesAdded.success
      )

      $scope.articlesAdded()

      $httpBackend.flush()

      expect($scope.articles.added).toEqual(analytics.articlesAdded.success)