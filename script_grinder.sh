## define variables
#### number of cores
CORES=16
#### number of samples
NB_SAMPLE=30
#### number of replicats
NB_REPLICAT=12

for ID_SAMPLE in `seq -w 1 $NB_SAMPLE`; do
	((i=i%CORES)); ((i++==0)) && wait
	##  grinder command to run with input files into folder 'Inputs'
	#bash grinder_simulations/simulation_grinder.sh "${ID_SAMPLE}" &
	for ID_REPLICAT in `seq -w 1 $NB_REPLICAT`; do
		bash grinder_simulations/deinterleave_fastq.sh < grinder_simulations/Outputs/sample"${ID_SAMPLE}"/sample"${ID_SAMPLE}"-"${ID_REPLICAT}"-reads.fastq \
		grinder_simulations/Outputs/grinder_teleo1/paired_end_R1/sample"${ID_SAMPLE}"-"${ID_REPLICAT}"_R1.fastq.gz \
		grinder_simulations/Outputs/grinder_teleo1/paired_end_R2/sample"${ID_SAMPLE}"-"${ID_REPLICAT}"_R2.fastq.gz \
		compress
	done &
done