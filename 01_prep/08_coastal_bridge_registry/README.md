# Coastal Bridge Registry

A sample kml extract (2017) was provided by FLNRO regional staff for Nadina and Skeena/Stikine.
Scripts are currently provided for reference/completeness only, request data from FLNRO to run.
Note that this script is likely to be moved and incorporated into `01_prep/01_modelled_stream_crossings`.

- first, download provided kmz files to `/incoming`
- extract the kmzs to kmls so QGIS can see the html:

        cd incoming
        unzip  -p "Nadina 2017.kmz" > nadina.kml
        unzip  -p "Skeena Stikine 2017.kmz" > skeena_stikine.kml

- in QGIS, manually save each kml layer (4 total) as geojson, removing the internal kml attributes
- merge the files:

        mkdir ../data
        ogrmerge.py -f GeoJSON -single data/*geojson -o data/coastal_bridge_registry.geojson -nln coastal_bridge_registry

Finally, load features to the database and note any known bridges as passable (where not already modified by manual QA)


    ./coastal_bridge_registry.sh

