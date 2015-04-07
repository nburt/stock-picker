angular.module('app').config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode enabled: true

  $routeProvider.when '/',
    templateUrl: 'index.html'
    controller: 'IndexController'

  $routeProvider.when '/stocks/:id',
    templateUrl: 'show.html'
    controller: 'StocksShowController'

  $routeProvider.otherwise redirectTo: '/'
