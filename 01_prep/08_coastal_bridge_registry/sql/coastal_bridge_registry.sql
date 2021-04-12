-- compare CBR to modelled crossings
WITH cbr_bridges AS
(
  SELECT
    site__ as cbr_site,
    CASE WHEN a.structure_type_class IN ('Permanent Bridge', 'Woodbox/Log Culvert', 'Temporary Bridge') OR a.culvert_type IN ('Open Bottom', 'Box')
    THEN 'OBS'
    ELSE 'CBS' END as cbr_crossing_type,
    nn.modelled_crossing_id,
    nn.modelled_crossing_type,
    nn.watershed_group_code,
    nn.dist
  FROM bcfishpass.coastal_bridge_registry a
  CROSS JOIN LATERAL
    (SELECT
       modelled_crossing_id,
       modelled_crossing_type,
       watershed_group_code,
       ST_Distance(a.geom, b.geom) as dist
     FROM bcfishpass.modelled_stream_crossings b
     ORDER BY a.geom <-> b.geom
     LIMIT 1) as nn
  WHERE nn.dist < 50
)

SELECT * FROM cbr_bridges
WHERE cbr_crossing_type = 'OBS';
