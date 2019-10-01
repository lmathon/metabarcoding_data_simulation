## define variables
#### number of cores
CORES=16
#### number of samples
NB_SAMPLE=30
#### number of replicats
NB_REPLICAT=12

## run NB_SAMPLE*NB_REPLICAT simulations with grinder
for ID_SAMPLE in `seq -w 1 $NB_SAMPLE`; do
	((i=i%CORES)); ((i++==0)) && wait
	##  grinder command to run with input files into folder 'Inputs'
	bash simulation_grinder.sh "${ID_SAMPLE}" &
done

## deinterleave grinder fastq
for ID_SAMPLE in `seq -w 1 $NB_SAMPLE`; do
	((i=i%CORES)); ((i++==0)) && wait
	for ID_REPLICAT in `seq -w 1 $NB_REPLICAT`; do
		bash deinterleave_fastq.sh < Outputs/sample"${ID_SAMPLE}"/sample"${ID_SAMPLE}"-"${ID_REPLICAT}"-reads.fastq \
		Outputs/grinder_teleo1/paired_end_R1/sample"${ID_SAMPLE}"-"${ID_REPLICAT}"_R1.fastq.gz \
		Outputs/grinder_teleo1/paired_end_R2/sample"${ID_SAMPLE}"-"${ID_REPLICAT}"_R2.fastq.gz \
		compress \
		1
	done &
done
wait