## DESCRIPTION:
## Use trimmomatic on Illumina reads
## Quality thresholds can be modified in config.mk file
##
## Load configurations from file
< config.mk

# Pre-process reads.
# ====================
# Pre-process PAIRED END reads from a compressed fastq file.
#
'results/%_R1.paired.fastq.gz' \
'results/%_R1.unpaired.fastq.gz' \
'results/%_R2.paired.fastq.gz' \
'results/%_R2.unpaired.fastq.gz' \
: 'data/%_R1.fastq.gz' 'data/%_R2.fastq.gz'
	mkdir -p $(dirname $target)
	set -x
	java -jar "$TRIMMOMATIC_PATH"/trimmomatic.jar \
		PE \
		$TRIMMOMATIC_OPTARGS \
		$prereq \
		'results/'$stem'_R1.paired.build.fastq.gz' \
		'results/'$stem'_R1.unpaired.build.fastq.gz' \
		'results/'$stem'_R2.paired.build.fastq.gz' \
		'results/'$stem'_R2.unpaired.build.fastq.gz' \
		$TRIMMOMATIC_ANALYSIS \
	&& {
		mv 'results/'$stem'_R1.paired.build.fastq.gz' 'results/'$stem'_R1.paired.fastq.gz'
		mv 'results/'$stem'_R1.unpaired.build.fastq.gz' 'results/'$stem'_R1.unpaired.fastq.gz'
		mv 'results/'$stem'_R2.paired.build.fastq.gz' 'results/'$stem'_R2.paired.fastq.gz'
		mv 'results/'$stem'_R2.unpaired.build.fastq.gz' 'results/'$stem'_R2.unpaired.fastq.gz'
	}

# Pre-process SINGLE END reads from a compressed fastq file.
#
'results/%.fastq.gz':	'data/%.fastq.gz'
	mkdir -p $(dirname $target)
	set -x
	java -jar "$TRIMMOMATIC_PATH"/trimmomatic.jar \
		SE \
		$TRIMMOMATIC_OPTARGS \
		$prereq \
		'results/'$stem'.build.fastq.gz' \
		$TRIMMOMATIC_ANALYSIS \
	&& {
		mv 'results/'$stem'.build.fastq.gz' 'results/'$stem'.fastq.gz'
	}

