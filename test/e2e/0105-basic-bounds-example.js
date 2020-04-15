'use strict';

describe('Loading 0105-basic-bounds-example.html', function() {

    beforeEach(function() {
        browser.get('0105-basic-bounds-example.html');
        browser.wait(function() {
            return element(by.css('img.leaflet-tile-loaded')).isPresent();
        }, 5000);
    });

    it('should update the bounds values in the input if clicked the zoom control', function() {
        var i = 7, zoomOutControl = element(by.xpath('.//*[@title="Zoom out"]'));
        expect(element(by.model("bounds.southWest.lat")).getAttribute("value")).toBeCloseTo(51.507941142609155, 3);
        expect(element(by.model("bounds.southWest.lng")).getAttribute("value")).toBeCloseTo(-0.09059429168701172, 3);
        expect(element(by.model("bounds.northEast.lat")).getAttribute("value")).toBeCloseTo(51.50954376090435, 3);
        expect(element(by.model("bounds.northEast.lng")).getAttribute("value")).toBeCloseTo(-0.0851815938949585, 3);

        do {
            zoomOutControl.click();
            browser.driver.sleep(100);
        } while (i-- > 0);

        zoomOutControl.click().then(function() {
            browser.driver.sleep(400);
            expect(element(by.model("bounds.southWest.lat")).getAttribute("value")).toBeCloseTo(51.483, 3);
            expect(element(by.model("bounds.southWest.lng")).getAttribute("value")).toBeCloseTo(-0.189, 3);
            expect(element(by.model("bounds.northEast.lat")).getAttribute("value")).toBeCloseTo(51.534, 3);
            expect(element(by.model("bounds.northEast.lng")).getAttribute("value")).toBeCloseTo(0.014, 3);
        });

    });
});
