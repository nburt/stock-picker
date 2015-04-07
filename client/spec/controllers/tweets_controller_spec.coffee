describe "TweetsController", ->
  $scope = undefined
  $httpBackend = undefined
  $controller = undefined

  beforeEach ->
    module("app")

  beforeEach inject(($injector) ->
    $scope = $injector.get("$rootScope")
    $httpBackend = $injector.get("$httpBackend")
    $controller = $injector.get("$controller")

    $controller("TweetsController", $scope: $scope)
  )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe "fetchTweets", ->
    it "makes a call to fetch tweets for a stock", ->
      $scope.id = 1
      $httpBackend.expectGET("/api/v1/stocks/1/tweets").respond(200, tweets.success)
      $scope.fetchTweets()
      $httpBackend.flush()

      expect($scope.tweets).toEqual(tweets.success)
