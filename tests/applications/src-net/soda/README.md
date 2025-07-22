## Inference
- https://ska-telescope.gitlab.io/src/kb/ska-src-docs-operator/services/local/mandatory/soda-services/visivo-soda.html

## Prerequisites
- [SKA SODA](https://gitlab.com/ska-telescope/src/src-ia/ska-src-ia-vo-soda-deployment) service is up
- [Gatekeeper](https://ska-telescope.gitlab.io/src/kb/ska-src-docs-operator/services/local/mandatory/authorization/gatekeeper.html) service is up

## Running the Availability Test
To check the service is up, access availability end point which returns the status in a short xml response. In this example:

- using soda service directly
```bash
# root@ska132-01:~# kubectl -n soda get svc
# NAME           TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
# ska-src-soda   NodePort   10.108.133.210   <none>        8080:31102/TCP   14d
curl http://192.168.254.192:31102/ska/datasets/availability

curl  -H "Authorization: Bearer $SKA_TOKEN"  https://gatekeeper.ska.zverse.space/soda/ska/datasets/availability
```

Result:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<vosi:availability xmlns:vosi="http://www.ivoa.net/xml/VOSIAvailability/v1.0">
   <vosi:available>true</vosi:available>
   <vosi:note>service is accepting queries</vosi:note>
</vosi:availability>
```

- using gatekeeper ingress to redirect soda service
```bash
export DM_TOKEN=xxxx.xxx
export FILE_ID=ivo://src.skao.org/datasets/fits?chocolate/da/56/pi24_run_1_cleaned_reupload.fits
export CIRCLE="150.1147624510 2.3490950070 0.05"

curl --data-urlencode "ID=$FILE_ID" --data-urlencode "CIRCLE=$CIRCLE" --data-urlencode "RESPONSE_FORMAT=application/fits" -H "Authorization: Bearer $DM_TOKEN"  --output /tmp/output.fits http://192.168.254.192:31102/ska/datasets/soda

curl --data-urlencode "ID=$FILE_ID" --data-urlencode "CIRCLE=$CIRCLE" --data-urlencode "RESPONSE_FORMAT=application/fits" -H "Authorization: Bearer $SKA_TOKEN"  --output /tmp/output.fits https://gatekeeper.ska.zverse.space/soda/ska/datasets/soda
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<VOTABLE xmlns="http://www.ivoa.net/xml/VOTable/v1.3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.3">
   <RESOURCE type="meta" utype="adhoc:service" name="this">
      <PARAM name="standardID" datatype="char" arraysize="*" value="ivo://ivoa.net/std/SODA#sync-1.0" />
      <PARAM name="accessURL" datatype="char" arraysize="*" value="http://192.168.254.192:31102/ska/datasets/soda" />
      <GROUP name="inputParams">
         <PARAM name="ID" ucd="meta.id;meta.dataset" datatype="char" arraysize="*" value="" />
         <PARAM name="POS" ucd="pos.outline;obs" datatype="char" arraysize="*" value="" />
         <PARAM name="CIRCLE" ucd="phys.angArea;obs" unit="deg" datatype="double" arraysize="3" xtype="circle" value="" />
         <PARAM name="POLYGON" unit="deg" ucd="pos.outline;obs" datatype="double" arraysize="*" xtype="polygon" value="" />
         <PARAM name="BAND" ucd="stat.interval" unit="m" datatype="double" arraysize="2" xtype="interval" value="" />
         <PARAM name="TIME" ucd="time.interval;obs.exposure" unit="d" datatype="double" arraysize="2" xtype="interval" value="" />
         <PARAM name="POL" ucd="meta.code;phys.polarization" datatype="char" arraysize="*" value="" />
         <PARAM name="PIXELS" ucd="instr.pixel;meta.dataset" datatype="char" arraysize="*" value="" />
         <PARAM name="RESPONSEFORMAT" ucd="meta.code.mime" datatype="char" arraysize="*" value="application/fits" />
         <PARAM name="POSSYS" ucd="pos.frame" datatype="char" arraysize="*" value="">
            <DESCRIPTION>Coordinate system for POS values</DESCRIPTION>
            <VALUES>
               <OPTION>ICRS</OPTION>
               <OPTION>GALACTIC</OPTION>
               <OPTION>GRID</OPTION>
            </VALUES>
         </PARAM>
         <PARAM name="BANDSYS" ucd="spect;pos.frame" datatype="char" arraysize="*" value="">
            <DESCRIPTION>Coordinate system for BAND vlaues.</DESCRIPTION>
            <VALUES>
               <OPTION>WAVE_Barycentric</OPTION>
               <OPTION>VELO_LSRK</OPTION>
               <OPTION>GRID</OPTION>
            </VALUES>
         </PARAM>
      </GROUP>
   </RESOURCE>
</VOTABLE>
```

## Test History
### ska132
- 2025-07-21: [result1.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/soda/test-history/ska132-20250722/result1.png), [result2.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/soda/test-history/ska132-20250722/result2.png), [using gatekeeper step1](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/soda/test-history/ska132-20250722/gw_step1.png), [using gatekeeper step2](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/soda/test-history/ska132-20250722/gw_step2.png)