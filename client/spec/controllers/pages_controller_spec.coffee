describe "PagesController", ->
  $scope = undefined
  $controller = undefined
  $location = undefined

  beforeEach ->
    module("app")

  beforeEach inject(($injector) ->
    $scope = $injector.get("$rootScope")
    $controller = $injector.get("$controller")
    $location = $injector.get("$location")

    $location.path = ->
      "/stocks/1"

    $controller("PagesController", $scope: $scope)
  )

  describe "initialize", ->
    it "fetches the stock id from the path", ->
      expect($scope.id).toEqual('1')
