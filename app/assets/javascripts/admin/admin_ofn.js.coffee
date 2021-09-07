angular.module("ofn.admin", [
  "ngResource",
  "mm.foundation",
  "angularFileUpload",
  "ngAnimate",
  "admin.utils",
  "admin.indexUtils",
  "admin.dropdown",
  "admin.products",
  "admin.taxons",
  "infinite-scroll",
  "admin.orders"
]).config ($httpProvider, $locationProvider, $qProvider) ->
  $httpProvider.defaults.headers.common["Accept"] = "application/json, text/javascript, */*"
  $locationProvider.hashPrefix('')
  $qProvider.errorOnUnhandledRejections(false)
