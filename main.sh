## run grinder 30 simulations 12 replicats
singularity exec -B .:/simulations grinder.img bash -c "cd /simulations ; bash script_grinder.sh"
wait
## paired end final files
zcat Outputs/grinder_teleo1/paired_end_R1/*fastq.gz | gzip -c > Outputs/grinder_teleo1/grinder_teleo1_R1.fastq.gz &
zcat Outputs/grinder_teleo1/paired_end_R2/*fastq.gz | gzip -c > Outputs/grinder_teleo1/grinder_teleo1_R2.fastq.gz &
