describe "ArticlesController", ->
  $scope = undefined
  $httpBackend = undefined
  $controller = undefined

  beforeEach ->
    module("app")

  beforeEach inject(($injector) ->
    $scope = $injector.get("$rootScope")
    $httpBackend = $injector.get("$httpBackend")
    $controller = $injector.get("$controller")

    $controller("ArticlesController", $scope: $scope)
  )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe "fetchArticles", ->
    it "makes a call to fetch articles for a stock", ->
      $scope.id = 1
      $httpBackend.expectGET("/api/v1/stocks/1/articles").respond(200, articles.success)
      $scope.fetchArticles()
      $httpBackend.flush()

      expect($scope.articles).toEqual(articles.success)
