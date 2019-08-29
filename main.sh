## run grinder 30 simulations 12 replicats
singularity exec -B .:/simulations grinder.img bash -c "cd /simulations ; bash grinder_simulations/script_grinder.sh"
## paired end final files
zcat grinder_simulations/Outputs/grinder_teleo1/paired_end_R1/*fastq.gz | gzip -c > grinder_simulations/Outputs/grinder_teleo1/grinder_teleo1_R1.fastq.gz &
zcat grinder_simulations/Outputs/grinder_teleo1/paired_end_R2/*fastq.gz | gzip -c > grinder_simulations/Outputs/grinder_teleo1/grinder_teleo1_R2.fastq.gz &
