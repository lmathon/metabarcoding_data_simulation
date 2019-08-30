# METABARCODING DATA SIMULATIONS

[![https://www.singularity-hub.org/static/simg/hosted-singularity--hub-%23e32929.svg](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/2878)

In this project, we use [Grinder](https://sourceforge.net/projects/biogrinder/) (Angly et al 2012) to simulate data from metabarcoding sequencing, and to reproduce real dataset from Illumina sequencing with the highest fidelity.

This simulator allows the user to specify the species (=sequence) list for each sample, the species relative abundance in each sample, to simulate sample replicates and to simulate PCR and sequencing errors similar to reality. 

Here we simulated 30 samples, with 12 replicates, containing between 18 and 83 species of fish. The sequences used are fragments of the mitochondrial gene 12S, amplified by the primers Teleo_F and Teleo_R used in Valentini et al 2016. 

## Grinder's [inputs](grinder_simulations/Inputs) :

- one fasta file per sample containing the species names and their sequences : species have been selected randomly from a dataset of 2076 sequences of Actinopteri, Chondrichthyes, Cladistia, Cyclostomata, Myxini and Sarcopterygii extracted from GenBank.

- one text file per sample containing the relative abundances of each species (identical between the 12 replicates) : abondances are different for each sample and have been chosen to represent natural samples from marine and freshwater ecosystems (some species very abundant and some very rare). In samples 10 and 26, all species have equal abundances. 

- one fasta file per sample containing the tags to be added to the sequences (12 different tags for the 12 replicates) : tags are sequences of 8 nucleotides, all tags are differing by 3 nucleotides. Tags are unique for each replicate of each samples, in order to assign each sequence to the sample and the replicate it comes from.

## Grinder Environment

Download the singularity container to run grinder
```
singularity pull --name grinder.img shub://Grelot/bioinfo_singularity_recipes:grindermbb
```
 Spawn an interactive shell within the container bound to your current directory
```
singularity shell -B .:/mnt grinder.img
## then into the container
cd /mnt
## check if grinder is working
grinder -h
```
When you finished simulations, to leave this environnement simply type `exit`.

or alternatively to run a COMMAND using grinder
```
singularity exec -B .:/simulations grinder.img bash -c "cd /simulations ; COMMAND"
```

## Grinder simulations

To simulate fastq.gz paired-end illumina metabarcoding data, simply run the commands in [main.sh](grinder_simulations/main.sh).

```
bash grinder_simulations/main.sh
```
Parameters are written in [script_grinder.sh](grinder_simulations/script_grinder.sh)

variable    | description                           | default value
------------|---------------------------------------|---------------
CORES       | number of cores                       | 16
NB_SAMPLE   | number of samples                     | 30
NB_REPLICAT | number of replicats (for each sample) | 12


## Grinder command

The grinder command is as follow :

```
grinder -rf grinder_simulations/Inputs/seq_sample01.fasta \
    -tr 90000 -nl 12 -di 0 -af grinder_simulations/Inputs/abund_sample01.txt \
    -id 150 -rd 150 -fq 1 -ql 36 30 -mo FR \
    -dc '-' -un 1 -md poly4 3e-3 3.3e-8 -mr 98 2 \
    -cp 1 -ck 0 -mi grinder_simulations/Inputs/tag_sample01.fasta \
    -bn sample01 -od grinder_simulations/Outputs/sample01/ 
```

options :

-rf	sequence fasta file

-tr	number of reads to simulate for each replicate

-nl	number of replicate for each sample

-sp	percentage of shared sequences between replicates

-af	abundance text file

-id	size of the insert sequence

-rd	amplicon size

-fq	FASTQ output

-ql	score for good and bad quality nucleotides

-mo	paired-end read orientation

-dc	remove specified characters

-un	forward read producing

-md	error production model (here Illumina errors)

-mr	percentage of substitution and indels

-ck	length of kmers for chimera production

-mi	tag fasta file

-bn	output prefix

-od	output directory

## Grinder's [outputs](grinder_simulations/Outputs)

Grinder creates a fastq file for each replicate of each sample, containing interleaved forward and reverse reads.
The forward and reverse reads are then separated and all the forward reads are concatenated in a file grinder_teleo1_R1.fastq, and same for the reverse reads (grinder_teleo1_R2.fastq).

Grinder also generates an abundance text file for each sample and each replicate, indicating the composition of each sample and the relative abundance of the sequences. [species_abundance_per_sample](grinder_simulations/Outputs/species_abundance_per_sample).
