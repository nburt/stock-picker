describe "IndexController", ->
  $scope = undefined
  $httpBackend = undefined
  $location = undefined
  $controller = undefined

  beforeEach ->
    module("app")

  beforeEach inject(($injector) ->
    $scope = $injector.get("$rootScope")
    $httpBackend = $injector.get("$httpBackend")
    $location = $injector.get("$location")
    $controller = $injector.get("$controller")

    $controller("IndexController", $scope: $scope)
  )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe "initialize", ->
    it "calls fetchStocks on init()", ->
      spyOn($scope, "fetchStocks")
      $scope.init()
      expect($scope.fetchStocks).toHaveBeenCalled()

  describe "fetchStocks", ->
    it "makes a call to fetch all the stocks", ->
      $httpBackend.expectGET("/api/v1/stocks").respond(200, stocks.success)
      $scope.fetchStocks()
      $httpBackend.flush()

      expect($scope.stocks).toEqual(stocks.success)

  describe "show", ->
    it "redirects to the show path for a stock", ->
      spyOn($location, "path")
      $scope.show("1")

      expect($location.path).toHaveBeenCalledWith("/stocks/1")