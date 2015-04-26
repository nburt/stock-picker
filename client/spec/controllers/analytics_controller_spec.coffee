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
      $scope.init()
      expect($scope.tweetsAdded).toHaveBeenCalled()

  describe "tweetsAdded", ->
    it "fetches analytics information about the number of tweets added", ->
      $httpBackend.expectGET("/api/v1/analytics/tweets_added").respond(
        200, analytics.tweetsAdded.success
      )

      $scope.tweetsAdded()

      $httpBackend.flush()

      expect($scope.tweets.added).toEqual(analytics.tweetsAdded.success)