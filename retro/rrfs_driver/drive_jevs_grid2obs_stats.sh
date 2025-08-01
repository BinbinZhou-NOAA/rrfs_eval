#!/bin/bash
#
###########################################################
# Called on a cron to run EVS jobs                        #
###########################################################

set -x

now=`date -u +%Y%m%d%H`
vhr=${vhr:-`echo $now | cut -c 9-10`}
models=${models:-"rrfs"}

LOGDIR=${LOGDIR:-"/lfs/h2/emc/ptmp/${USER}/output/retros/${retro_name}"}
mkdir -p $LOGDIR
cd $LOGDIR

module reset

for model in ${models}; do
    if [ "${model}" = "nam" ]; then
        echo "submitting jevs_mesoscale_grid2obs_stats.sh for ${VDATE}${vhr}"
        qsub -v vhr=$vhr,VDATE=$VDATE,retro_name=$retro_name,COMINccpa=$COMINccpa,COMINobsproc=$COMINobsproc,DCOMINmrms=$DCOMINmrms,DCOMINsnow=$DCOMINsnow,COMINnam=$COMINnam,COMINhrrr=$COMINhrrr,COMINhiresw=$COMINhiresw,COMINrrfs=$COMINrrfs ${RRFSevs}/dev/drivers/scripts/stats/mesoscale/jevs_mesoscale_${model}_grid2obs_stats.sh
    else
        echo "submitting jevs_cam_grid2obs_stats.sh for ${VDATE}${vhr}"
        qsub -v vhr=$vhr,VDATE=$VDATE,retro_name=$retro_name,COMINccpa=$COMINccpa,COMINobsproc=$COMINobsproc,DCOMINmrms=$DCOMINmrms,DCOMINsnow=$DCOMINsnow,COMINnam=$COMINnam,COMINhrrr=$COMINhrrr,COMINhiresw=$COMINhiresw,COMINrrfs=$COMINrrfs ${RRFSevs}/dev/drivers/scripts/stats/cam/jevs_cam_${model}_grid2obs_stats.sh
    fi
done
sleep 1

exit

