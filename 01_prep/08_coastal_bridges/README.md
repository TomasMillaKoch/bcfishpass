# Coastal Bridges Registry

Preliminary kml data provided by FLNRO regional staff.
Scripts are currently provided for reference/completeness only, request data from FLNRO to run.

- first, download provided kmz files to `/incoming`
- extract the kmzs to kmls so QGIS can see the html:

        cd incoming
        unzip  -p "Nadina 2017.kmz" > nadina.kml
        unzip  -p "Skeena Stikine 2017.kmz" > skeena_stikine.kml

- in QGIS, manually save each kml layer (4 total) as geojson, removing the internal kml attributes
- merge the files:

        mkdir ../data
        geojson-merge *geojson > ../data/coastal_bridge_registry.geojson

Finally, load features to the database and note any known bridges as passable (where not already modified by manual QA)


    ./cbr.sh

