#!/bin/bash
# Authors: M.G. Caron & L.C. Dawson
#
###########################################################
# Called on a cron to run EVS jobs                        #
###########################################################

now=`date -u +%Y%m%d%H`
vhr=${vhr:-`echo $now | cut -c 9-10`}

LOGDIR=${LOGDIR:-"/lfs/h2/emc/ptmp/${USER}/output/retros/${retro_name}"}
mkdir -p $LOGDIR
cd $LOGDIR

module reset

LINE_TYPES="nbrcnt nbrctc"

for x in ${LINE_TYPES}; do
    echo "submitting jevs_cam_radar_plots.sh for ${x} linetype at ${VDATE}${vhr} for ${retro_name}"
    echo "vhr ${vhr}, LINE_TYPE ${x}, VDATE ${VDATE}, retro_name ${retro_name}, RRFSevs ${RRFSevs}"
    qsub -v vhr=$vhr,LINE_TYPE=$x,VDATE=$VDATE,retro_name=$retro_name ${RRFSevs}/dev/drivers/scripts/plots/cam/jevs_cam_radar_${x}_plots_last31days.sh
done
sleep 1

exit

