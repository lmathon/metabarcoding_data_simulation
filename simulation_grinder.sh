ID_SAMPLE=$1
echo "Simulating sample${ID_SAMPLE}..." 
grinder -rf grinder_simulations/Inputs/seq_sample"${ID_SAMPLE}".fasta \
    -tr 90000 -nl 12 -di 0 -af grinder_simulations/Inputs/abund_sample"${ID_SAMPLE}".txt \
    -id 150 -rd 150 -fq 1 -ql 36 30 -mo FR \
    -dc '-' -un 1 -md poly4 3e-3 3.3e-8 -mr 98 2 \
    -cp 1 -ck 0 -mi grinder_simulations/Inputs/tag_sample"${ID_SAMPLE}".fasta \
    -bn sample"${ID_SAMPLE}" -od grinder_simulations/Outputs/sample"${ID_SAMPLE}"/

cp grinder_simulations/Outputs/sample"${ID_SAMPLE}"/*ranks.txt grinder_simulations/Outputs/species_abundance_per_sample/
