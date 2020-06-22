#!/bin/bash
declare -a CfgFiles=("/opt/flexran/bin/lte/l1/phycfg_timer.xml" "/opt/flexran/bin/lte/l1/phycfg.xml")

for val in ${CfgFiles[@]}; do
  sed -i 's#<dpdkBasebandFecMode>.*</dpdkBasebandFecMode>#<dpdkBasebandFecMode>1</dpdkBasebandFecMode>#' $val
  sed -i "s#<dpdkBasebandDevice>.*</dpdkBasebandDevice>#<dpdkBasebandDevice>${PCIDEVICE_INTEL_COM_INTEL_FEC}</dpdkBasebandDevice>#" $val
done
