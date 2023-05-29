drop view if exists bcfishpass.streams_pk_vw;
create or replace view bcfishpass.streams_pk_vw as
select
  segmented_stream_id,
  linear_feature_id,
  edge_type,
  blue_line_key,
  watershed_key,
  watershed_group_code,
  downstream_route_measure,
  length_metre,
  waterbody_key,
  wscode_ltree::text as wscode,
  localcode_ltree::text as localcode,
  gnis_name,
  stream_order,
  stream_magnitude,
  gradient,
  feature_code,
  upstream_route_measure,
  upstream_area_ha,
  map_upstream,
  channel_width,
  mad_m3s,
  stream_order_parent,
  stream_order_max,
  array_to_string(barriers_ch_cm_co_pk_sk_dnstr, ';') as barriers_ch_cm_co_pk_sk_dnstr,
  array_to_string(barriers_anthropogenic_dnstr, ';') as barriers_anthropogenic_dnstr,
  array_to_string(barriers_pscis_dnstr, ';') as barriers_pscis_dnstr,
  array_to_string(barriers_dams_dnstr, ';') as barriers_dams_dnstr,
  array_to_string(barriers_dams_hydro_dnstr, ';') as barriers_dams_hydro_dnstr,
  array_to_string(crossings_dnstr, ';') as crossings_dnstr,
  array_to_string(obsrvtn_event_upstr, ';') as obsrvtn_event_upstr,
  array_to_string(obsrvtn_species_codes_upstr, ';') as obsrvtn_species_codes_upstr,
  remediated_dnstr,
  model_spawning_pk as spawning,
  null as rearing,
  mapping_code_pk as mapping_code,
  geom
from bcfishpass.streams s
where barriers_ch_cm_co_pk_sk_dnstr = array[]::text[];