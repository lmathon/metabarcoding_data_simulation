## remove Outputs
## remove sample folder
rm -Rf Outputs/sample*
## remove species abundance per sample
rm Outputs/species_abundance_per_sample/*
## remove interleaved fastq
rm Outputs/grinder_teleo1/*_R*.fastq.gz
## remove sample paired end fastq
rm Outputs/grinder_teleo1/paired_end_R1/*_R1.fastq.gz
rm Outputs/grinder_teleo1/paired_end_R2/*_R2.fastq.gz

