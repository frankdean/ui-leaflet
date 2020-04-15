###
jshint -W117
jshint globalstrict: true
jasmine specs for directives go here
###

describe 'Directive: leaflet: layers.overlays.markers', ->
    $timeout = $q = scope = leafletData = $rootScope = $compile = leafletMarkersHelper = undefined
    beforeEach ->

        module('ui-leaflet')


        inject (_$compile_, _$rootScope_, _leafletData_, _leafletMarkersHelpers_, _$q_, _$timeout_) ->
            $timeout = _$timeout_
            window.ngLeafLetTestGlobals.$timeout = $timeout
            $q = _$q_
            $compile = _$compile_
            $rootScope = _$rootScope_
            leafletData = _leafletData_
            leafletMarkersHelper = _leafletMarkersHelpers_
            scope = $rootScope.$new()

    afterEach inject ($rootScope) ->
        unless scope.$$phase
            $rootScope.$apply()

    describe 'marker isNested', ->
        it 'should check for a marker in the layer group that is visible', (done) ->
            angular.extend scope,
                layers:
                    baselayers: osm:
                        name: 'OpenStreetMap'
                        type: 'xyz'
                        url: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
                        layerOptions:
                            subdomains: [
                                'a'
                                'b'
                                'c'
                            ]
                            attribution:
                                '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                            continuousWorld: true
                    overlays:
                        cars:
                            name: 'cars'
                            type: 'group'
                            visible: true
                markers:
                    cars:
                        m1:
                            lat: 1.2
                            lng: 0.3
                        m2:
                            lat: 1.2
                            lng: 0.3

            element = angular.element('<leaflet layers="layers" markers="markers" markers-nested="true"></leaflet>')
            element = $compile(element)(scope)

            @digest $rootScope, ->
                $q.all([leafletData.getMap(),leafletData.getMarkers(),leafletData.getLayers()])
                .then (promiseArray) ->
                    [map, markers, layers] = promiseArray

                    expect(Object.keys(markers).length).toEqual 1
                    expect(Object.keys(markers.cars).length).toEqual 2
                    markerToCheck = markers.cars.m1
                    expect(markerToCheck instanceof L.Marker).toBe true
                    expect(map.hasLayer(markerToCheck)).toBe true
                    expect(layers.overlays.cars.hasLayer(markerToCheck)).toBe true
                    done()

        it 'should check for a marker in a wrong layer group', (done) ->
            angular.extend scope,
                layers:
                    baselayers: osm:
                        name: 'OpenStreetMap'
                        type: 'xyz'
                        url: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
                        layerOptions:
                            subdomains: [
                                'a'
                                'b'
                                'c'
                            ]
                            attribution:
                                '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                            continuousWorld: true
                    overlays:
                        cars:
                            name: 'cars'
                            type: 'group'
                            visible: true
                markers:
                    bikes:
                        m1:
                            lat: 1.2
                            lng: 0.3

            element = angular.element('<leaflet layers="layers" markers="markers" markers-nested="true"></leaflet>')
            element = $compile(element)(scope)

            @digest $rootScope, ->
                $q.all([leafletData.getMap(),leafletData.getMarkers(),leafletData.getLayers()])
                .then (promiseArray) ->
                    [map, markers, layers] = promiseArray

                    expect(Object.keys(markers).length).toEqual 1
                    expect(Object.keys(markers.bikes).length).toEqual 1
                    markerToCheck = markers.bikes.m1
                    expect(markerToCheck instanceof L.Marker).toBe true
                    expect(map.hasLayer(markerToCheck)).toBe false
                    expect(layers.overlays.cars.hasLayer(markerToCheck)).toBe false
                    done()


    describe 'marker', ->

        it 'should check for a marker in the layer group that is visible', (done) ->
            angular.extend scope,
                layers:
                    baselayers:
                        osm:
                            name: 'OpenStreetMap'
                            type: 'xyz'
                            url: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
                            layerOptions:
                                subdomains: [
                                    'a'
                                    'b'
                                    'c'
                                ]
                                attribution:
                                    '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                                continuousWorld: true
                    overlays:
                        cars:
                            name: 'cars'
                            type: 'group'
                            visible: true
                markers: m1:
                    lat: 1.2
                    lng: 0.3
                    layer: 'cars'
            element = angular.element('<leaflet layers="layers" markers="markers"></leaflet>')
            element = $compile(element)(scope)
            map = undefined
            leafletData.getMap().then (leafletMap) ->
                map = leafletMap

            markers = undefined
            leafletData.getMarkers().then (leafletMarkers) ->
                markers = leafletMarkers

            @digest $rootScope, ->
                leafletData.getLayers().then (layers) ->
                    expect(Object.keys(markers).length).toEqual 1
                    expect(markers.m1 instanceof L.Marker).toBe true
                    expect(layers.overlays.cars.hasLayer(markers.m1)).toBe true
                    expect(map.hasLayer(markers.m1)).toBe true
                    done()

        it 'should check for a marker in a wrong layer group', (done) ->
            angular.extend scope,
                layers:
                    baselayers: osm:
                        name: 'OpenStreetMap'
                        type: 'xyz'
                        url: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
                        layerOptions:
                            subdomains: [
                                'a'
                                'b'
                                'c'
                            ]
                            attribution:
                                '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                            continuousWorld: true
                    overlays:
                        cars:
                            name: 'cars'
                            type: 'group'
                            visible: true
                markers: m1:
                    lat: 1.2
                    lng: 0.3
                    layer: 'bikes'
            element = angular.element('<leaflet layers="layers" markers="markers"></leaflet>')
            element = $compile(element)(scope)

            @digest $rootScope, ->
                $q.all([leafletData.getMap(),leafletData.getMarkers(),leafletData.getLayers()])
                .then (promiseArray) ->
                    [map, markers, layers] = promiseArray

                    expect(Object.keys(markers).length).toEqual 1
                    expect(markers.m1 instanceof L.Marker).toBe true
                    expect(layers.overlays.cars.hasLayer(markers.m1)).toBe false
                    expect(map.hasLayer(markers.m1)).toBe false
                    done()

        it 'should check for a marker the old way', (done) ->
            angular.extend scope,
                layers:
                    baselayers:
                        osm:
                            name: 'OpenStreetMap'
                            type: 'xyz'
                            url: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
                            layerOptions:
                                subdomains: [
                                    'a'
                                    'b'
                                    'c'
                                ]
                                attribution:
                                    '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                                continuousWorld: true
                    overlays:
                        cars:
                            name: 'cars'
                            type: 'group'
                            visible: true
                markers: m1:
                    lat: 1.2
                    lng: 0.3
            element = angular.element('<leaflet layers="layers" markers="markers"></leaflet>')
            element = $compile(element)(scope)
            map = undefined
            leafletData.getMap().then (leafletMap) ->
                map = leafletMap

            @digest $rootScope, ->
                $q.all([leafletData.getMap(),leafletData.getMarkers(),leafletData.getLayers()])
                .then (promiseArray) ->
                    [map, markers, layers] = promiseArray

                    expect(Object.keys(markers).length).toEqual 1
                    expect(map.hasLayer(markers.m1)).toBe true
                    done()
