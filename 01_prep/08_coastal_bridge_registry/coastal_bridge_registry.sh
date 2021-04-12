#!/bin/bash
set -euxo pipefail

ogr2ogr -f PostgreSQL \
  "PG:host=$PGHOST user=$PGUSER dbname=$PGDATABASE port=$PGPORT" \
  -overwrite \
  -s_srs EPSG:4326 \
  -t_srs EPSG:3005 \
  -lco GEOMETRY_NAME=geom \
  -nln bcfishpass.coastal_bridge_registry \
  data/coastal_bridge_registry.geojson \
  coastal_bridge_registry


psql -f sql/coastal_bridge_registry.sql