describe "StockPricesController", ->
  $scope = undefined
  $httpBackend = undefined
  $controller = undefined

  beforeEach ->
    module("app")

  beforeEach inject(($injector) ->
    $scope = $injector.get("$rootScope")
    $httpBackend = $injector.get("$httpBackend")
    $controller = $injector.get("$controller")

    $controller("StockPricesController", $scope: $scope)
  )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe "fetchStockPrices", ->
    it "makes a call to fetch stockPrices for a stock", ->
      $scope.id = 1
      $httpBackend.expectGET("/api/v1/stocks/1/stock_prices").respond(200, stockPrices.success)
      $scope.fetchStockPrices()
      $httpBackend.flush()

      expect($scope.stockPrices).toEqual(stockPrices.success)
