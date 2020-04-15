'use strict';

describe('Loading 0301-paths-types-example.html', function() {

    beforeEach(function() {
        browser.get('0301-paths-types-example.html');
        browser.wait(function() {
            return element(by.css('img.leaflet-tile-loaded')).isPresent();
        }, 5000);
    });

    it('should show a polyline on the map when clicked the polyline button', function() {
        element(by.xpath('//button[text()="polyline"]')).click();
        expect(element(by.xpath('//*[name()="svg"]//*[name()="path"]')).getAttribute("d")).toEqual("M592 240L572 331L664 320");
    });

    it('should show a multipolyline on the map when clicked the multipolyline button', function() {
        element(by.xpath('//button[text()="multiPolyline"]')).click();

        expect(element(by.xpath('(//*[name()="svg"]//*[name()="path"])[1]')).getAttribute("d")).toEqual("M592 240L541 344");
        expect(element(by.xpath('(//*[name()="svg"]//*[name()="path"])[2]')).getAttribute("d")).toEqual("M606 263L572 331");

    });

    it('should show a polygon on the map when clicked the polygon button', function() {
        element(by.xpath('//button[text()="polygon"]')).click();
        expect(element(by.xpath('(//*[name()="svg"]//*[name()="path"])[1]')).getAttribute("d")).toEqual("M592 240L541 344L572 331L606 263z");
    });

    it('should show a multipolygon on the map when clicked the multipolygon button', function() {
        element(by.xpath('//button[text()="multiPolygon"]')).click();
        expect(element(by.xpath('(//*[name()="svg"]//*[name()="path"])[1]')).getAttribute("d")).toEqual("M592 240L541 344L572 331L606 263z");
        expect(element(by.xpath('(//*[name()="svg"]//*[name()="path"])[2]')).getAttribute("d")).toEqual("M669 231L664 320L616 246z");
    });

    it('should show a rectangle on the map when clicked the rectangle button', function() {
        element(by.xpath('//button[text()="rectangle"]')).click();
        expect(element(by.xpath('(//*[name()="svg"]//*[name()="path"])[1]')).getAttribute("d")).toEqual("M541 344L541 231L669 231L669 344z");
    });

    it('should show a circle on the map when clicked the circle button', function() {
        element(by.xpath('//button[text()="circle"]')).click();
        expect(element(by.xpath('(//*[name()="svg"]//*[name()="path" and @stroke-linejoin="round"])[1]')).getAttribute("d")).toEqual("M616,205A41,41,0,1,1,615.9,205 z");
    });

    it('should show a circleMarker on the map when clicked the circleMarker button', function() {
        element(by.xpath('//button[text()="circleMarker"]')).click();
        expect(element(by.xpath('(//*[name()="svg"]//*[name()="path" and @stroke-linejoin="round"])[1]')).getAttribute("d")).toEqual("M664,270A50,50,0,1,1,663.9,270 z");
    });

});
