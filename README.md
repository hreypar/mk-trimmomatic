# mk-trimmomatic #

## About  ##

Quality of base calls can fluctuate in a seuencing run. The reads of each compressed FASTQ file should befiltered to meet quality criteria; typically a quality and minimum length of at least 30 Phred score and 70bp.


## Module description ##

This modules relies on [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) to perform a set of well-accepted quality control steps at once on ILLUMINA sequencing fastq data. Here, it is used to trim from all reads bases that have substandard Phred quality scores; entirely remove reads that have a very short length; and remove sequencing adapters corresponding to library preparation.

As the strings representing sequencing reads are directly edited into the output files, the order of the processing steps (arguments) is important. For example, using the minimum length parameter (MINLEN) before the quality trimming (SLIDINGWINDOW) would be a mistake, as the reads that are too short after trimming would not be discarded.


## Input ##

Compressed FASTQ file pairs that contain Paired-End reads. These can be from single- or multiple- lane sequencers. An example of an input directory structure below. For clarity it should really be the case that **fastq.gz files are NOT found immediately under data/ directory**, this makes for a neat file structure and analysis.


## Output data ##

For each compressed fastq files input pair, *four output compressed fastq files* are obtained after the quality filter: (1) forward reads that remain paired, (2) the corresponding reverse reads that remain paired, (3) only forward surviving reads and (4) only reverse surviving reads. Adapter sequences are removed from the sequencing reads.

This typically corresponds to:
* four output files per saple in the case of single-lane data.
* sixteen output files per sample in the case of multi-lane data.

The directory structure created under the data/ directory is conserved for the output files.


### Requirements ###

- [`mk`](http://doc.cat-v.org/bell_labs/mk/mk.pdf "A successor for `make`.")

- [`Trimmomatic`](http://www.usadellab.org/cms/?page=trimmomatic)

- [`awk`](cm.bell-labs.com/cm/cs/awkbook/index.html)


### Configuration file ###

The file config.mk contains pre-selected options with their parameters to run Trimmomatic. Uncomment the desired options and modify the parameters values as convenient. The number of threads can also be specified in config.mk

See the [Trimmomatic Manual](http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf) for details.


### Author Info ###

Based in a 2017 version developed by HRG and [Israel Aguilar](https://www.linkedin.com/in/israel-aguilar-ba625949/) (iaguilaror@gmail.com), in collaboration with Joshua Haase(jihaase@inmegen.gob.mx).

