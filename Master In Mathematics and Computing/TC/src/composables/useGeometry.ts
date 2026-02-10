export const useGeometry = ({
    dataLayer,
    MapsLibrary,
    GeometryLibrary,
    CoreLibrary,
}: {
    dataLayer: google.maps.Data;
    MapsLibrary: google.maps.MapsLibrary;
    GeometryLibrary: google.maps.GeometryLibrary;
    CoreLibrary: google.maps.CoreLibrary;
}) => ({
    getCountyFromCoords(from: { lat: number; lng: number }) {
        let featureProperties: any = null;

        dataLayer.forEach((feature: google.maps.Data.Feature) => {
            if (feature.getProperty('type') == 'originalCounty' && !featureProperties) {
                // check if marker is inside the county, if not, move it to the previous coordinates
                const geometry = feature.getGeometry();
                if (geometry) {
                    // transform the geometry to a polygon using the coordinates of the geojson of the county
                    const coords: any[] = [];
                    geometry.forEachLatLng((latLng) => {
                        coords.push({
                            lat: latLng.lat(),
                            lng: latLng.lng(),
                        });
                    });
                    const polygon = new MapsLibrary.Polygon({
                        paths: coords,
                    });

                    if (GeometryLibrary.poly.containsLocation(new CoreLibrary.LatLng(from.lat, from.lng), polygon)) {
                        // return all the properties of the feature
                        feature.forEachProperty((value, key) => {
                            featureProperties = {
                                ...featureProperties,
                                [key]: value,
                            };
                        });
                    }
                }
            }
        });

        return featureProperties;
    },
});
