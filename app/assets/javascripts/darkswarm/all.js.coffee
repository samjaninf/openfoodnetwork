#= require jquery2
#= require jquery.ui.all
#
#= require angular
#= require angular-cookies
#= require angular-sanitize
#= require angular-animate
#= require angular-resource
#= require autocomplete.min.js
#= require leaflet-1.6.0.js
#= require leaflet-providers.js
#= require lodash.underscore.js
# bluebird.js and angular-simple-logger are dependencies of angular-google-maps.js 2.0.0
#= require bluebird.js
#= require angular-simple-logger.min.js
#= require angular-scroll.min.js
#= require angular-google-maps.min.js
#= require ../shared/mm-foundation-tpls-0.9.0-20180826174721.min.js
#= require ../shared/ng-infinite-scroll.min.js
#= require ../shared/angular-local-storage.js
#= require ../shared/angular-slideables.js
#= require ../shared/shared
#= require_tree ../shared/directives
#= require angularjs-file-upload
#= require i18n/translations

#= require angular-rails-templates
#= require_tree ../templates
#
#= require angular-flash.min.js
#
#= require moment/min/moment.min.js
#= require moment/locale/ar.js
#= require moment/locale/ca.js
#= require moment/locale/de.js
#= require moment/locale/en-gb.js
#= require moment/locale/es.js
#= require moment/locale/fil.js
#= require moment/locale/fr.js
#= require moment/locale/it.js
#= require moment/locale/nb.js
#= require moment/locale/nl-be.js
#= require moment/locale/pt-br.js
#= require moment/locale/pt.js
#= require moment/locale/ru.js
#= require moment/locale/sv.js
#= require moment/locale/tr.js
#= require moment/locale/pl.js
#
#= require modernizr
#
#= require foundation-sites/js/foundation.js
#= require ./darkswarm
#= require_tree ./mixins
#= require_tree ./directives
#= require_tree .

document.addEventListener "turbo:load", ->
  window.injector = angular.bootstrap document.body, ["Darkswarm"]
  true

document.addEventListener "turbo:before-render", ->
  if window.injector
    rootscope = window.injector.get("$rootScope")
    rootscope?.$destroy()
    rootscope = null
    window.injector = null
  true

document.addEventListener "ajax:beforeSend", (event) =>
  window.Turbo.navigator.adapter.progressBar.setValue(0)
  window.Turbo.navigator.adapter.progressBar.show()

document.addEventListener "ajax:complete", (event) =>
  window.Turbo.navigator.adapter.progressBar.setValue(100)
  window.Turbo.navigator.adapter.progressBar.hide()
