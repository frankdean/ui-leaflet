'use strict';

describe('Loading 0100-basic-first-example.html', function() {

    beforeEach(function() {
        browser.get('0100-basic-first-example.html');
        browser.wait(function() {
            return element(by.css('img.leaflet-tile-loaded')).isPresent();
        }, 5000);
    }, 30000);


  // <div class="leaflet-control-attribution leaflet-control"><a href="http://leafletjs.com" title="A JS library for interactive maps">Leaflet</a> | © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors</div>
    it('should load the Leaflet map inside the directive tag', function() {
        element(by.className('leaflet-control-attribution')).getText().then(function(text) {
            expect(text).toBe("Leaflet | © OpenStreetMap contributors");
        });
    });

});
