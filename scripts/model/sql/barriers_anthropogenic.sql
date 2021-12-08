-- insert all barriers from aggregated crossings table
-- (pscis, dams, modelled xings)
-- no additonal logic required
DELETE FROM bcfishpass.barriers_anthropogenic;
INSERT INTO bcfishpass.barriers_anthropogenic
(
    aggregated_crossings_id,
    stream_crossing_id,
    dam_id,
    modelled_crossing_id,
    crossing_source,
    pscis_status,
    crossing_type_code,
    crossing_subtype_code,
    modelled_crossing_type_source,
    barrier_status,
    wcrp_barrier_type,
    linear_feature_id,
    blue_line_key,
    downstream_route_measure,
    wscode_ltree,
    localcode_ltree,
    watershed_group_code,
    geom
)
SELECT
    aggregated_crossings_id,
    stream_crossing_id,
    dam_id,
    modelled_crossing_id,
    crossing_source,
    pscis_status,
    crossing_type_code,
    crossing_subtype_code,
    modelled_crossing_type_source,
    barrier_status,
    wcrp_barrier_type,
    linear_feature_id,
    blue_line_key,
    downstream_route_measure,
    wscode_ltree,
    localcode_ltree,
    c.watershed_group_code as watershed_group_code,
    c.geom as geom
FROM bcfishpass.crossings c
WHERE barrier_status IN ('BARRIER', 'POTENTIAL')
AND c.watershed_group_code = ANY(
  ARRAY(
    SELECT watershed_group_code
    FROM bcfishpass.param_watersheds
  )
)
ON CONFLICT DO NOTHING;

CREATE INDEX ON bcfishpass.barriers_pscis (linear_feature_id);
CREATE INDEX ON bcfishpass.barriers_pscis (blue_line_key);
CREATE INDEX ON bcfishpass.barriers_pscis (watershed_group_code);
CREATE INDEX ON bcfishpass.barriers_pscis USING GIST (wscode_ltree);
CREATE INDEX ON bcfishpass.barriers_pscis USING BTREE (wscode_ltree);
CREATE INDEX ON bcfishpass.barriers_pscis USING GIST (localcode_ltree);
CREATE INDEX ON bcfishpass.barriers_pscis USING BTREE (localcode_ltree);
CREATE INDEX ON bcfishpass.barriers_pscis USING GIST (geom);