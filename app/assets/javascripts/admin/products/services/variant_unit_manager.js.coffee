angular.module("admin.products").factory "VariantUnitManager", ->
  class VariantUnitManager
    # @unitNames:
    #   'weight':
    #     1.0: 'g'
    #     1000.0: 'kg'
    #     1000000.0: 'T'
    #     28.34952: 'oz'
    #     453.6: 'lb'
    #   'volume':
    #     0.001: 'mL'
    #     1.0: 'L'
    #     1000.0: 'kL'
      'weight':
        1.0:
          name: 'g'
          system: 'metric'
        1000.0:
          name: 'kg'
          system: 'metric'
        1000000.0:
          name: 'T'
          system: 'metric'
        453.6:
          name: 'lb'
          system: 'imperial'
        28.35:
          name: 'oz'
          system: 'imperial'
      'volume':
        0.001:
          name: 'mL'
          system: 'metric'
        1.0:
          name: 'L'
          system: 'metric'
        1000.0:
          name: 'kL'
          system: 'metric'

    @variantUnitOptions: ->
      # options = for unit_type, scale_with_name of @unitNames
      options = for unit_type, _ of @units
        for scale in @unitScales(unit_type)
          name = @getUnitName(scale, unit_type)
          ["#{I18n.t(unit_type)} (#{name})", "#{unit_type}_#{scale}"]
      options.push [[I18n.t('items'), 'items']]
      [].concat options...

    @getScale: (value, unitType) ->
      scaledValue = null
      validScales = []
      unitScales = VariantUnitManager.unitScales(unitType)

      validScales.unshift scale for scale in unitScales when value/scale >= 1
      if validScales.length > 0
        validScales[0]
      else
        unitScales[0]

    @getUnitName: (scale, unitType) ->
      # @unitNames[unitType][scale]
      if @units[unitType][scale]
        @units[unitType][scale]['name']
      else
        ''


    @unitScales: (unitType) ->
      (parseFloat(scale) for scale in Object.keys(@unitNames[unitType])).sort (a, b) ->
        a - b
      # (parseFloat(scale) for scale in Object.keys(@unitNames[unitType])).sort()

    @compatibleUnitScales: (scale, unitType) ->
      scaleSystem = @units[unitType][scale]['system']
      (parseFloat(scale) for scale, scaleInfo of @units[unitType] when scaleInfo['system'] == scaleSystem).sort (a, b) ->
        a - b