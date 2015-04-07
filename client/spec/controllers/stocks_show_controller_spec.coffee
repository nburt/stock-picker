describe "StocksShowController", ->
  $scope = undefined
  $httpBackend = undefined
  $controller = undefined

  beforeEach ->
    module("app")

  beforeEach inject(($injector) ->
    $scope = $injector.get("$rootScope")
    $httpBackend = $injector.get("$httpBackend")
    $controller = $injector.get("$controller")

    $controller("StocksShowController", $scope: $scope)
  )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe "fetchStock", ->
    it "makes a call to fetch a stock", ->
      $scope.id = 1
      $httpBackend.expectGET("/api/v1/stocks/1").respond(200, stock.success)
      $scope.fetchStock()
      $httpBackend.flush()

      expect($scope.stock).toEqual(stock.success)

  describe "formatKeywords", ->
    it "takes an array of keywords and joins them to a single string", ->
      keywords = [{text: 'hi'}, {text: 'bye'}]

      expect($scope.formatKeywords(keywords)).toEqual('hi, bye')
