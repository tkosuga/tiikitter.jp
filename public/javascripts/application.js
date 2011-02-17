function GoogleMap(){

    this.map = null;
    this.geocoder = null;
    
    this.loadMap = function(imagePath){
        if (GBrowserIsCompatible()) {
        
            this.map = new GMap2(document.getElementById("map"));
            this.map.addControl(new GLargeMapControl());
            this.map.addControl(new GOverviewMapControl());
            this.map.addControl(new GMapTypeControl());
            this.map.setCenter(new GLatLng(37.31, 138.11), 5);
            
            this.geocoder = new GClientGeocoder();
            
            var sw = new GLatLng(25.3352172918475, 121.234999895096);
            var ne = new GLatLng(47.6440214429838, 154.984999895096);
            var bounds = new GLatLngBounds(sw, ne);
            var goverlay = new GGroundOverlay(imagePath, bounds);
            
            this.map.addOverlay(goverlay);
        }
    }
    
    this.addMarkers = function(locations){
        for (var i = 0; i < locations.length; i++) {
            var location = locations[i];
            if (location) {
                this.addMarker(location)
            }
        }
    }
    
    this.addMarker = function(location){
        var marker = new GMarker(new GLatLng(eval(location["lat"]), eval(location["lng"])));
        GEvent.addListener(marker, "click", function(){
            marker.openInfoWindowHtml(location["name"] + "<br />" + location["timeline_text"]);
        });
        this.map.addOverlay(marker);
    }
}

