import glob
import os

def get_sample_stems():
    stems = []
    for sp in config["species"]:
        fastqs = glob.glob(f"{config['fastq_dir']}/*_{sp}_*.fastq.gz")
        for fq in fastqs:
            stem = os.path.basename(fq).replace(".fastq.gz", "")
            stems.append(stem)
    return stems

SAMPLES = get_sample_stems()

rule all:
    input:
        expand("{bam_dir}/{sample}.sorted.bam", sample=SAMPLES, bam_dir=config["bam_dir"])

rule align_reads:
    input:
        fastq = lambda wildcards: f"{config['fastq_dir']}/{wildcards.sample}.fastq.gz",
        ref = config["reference"]["stygia"] + ".mmi"
    output:
        bam = f"{config['bam_dir']}/{{sample}}.sorted.bam",
        bai = f"{config['bam_dir']}/{{sample}}.sorted.bam.bai"
    log:
        f"{config['log_dir']}/alignment/{{sample}}.log"
    threads: 4
    conda:
        "envs/minimap2.yaml"
    shell:
        """
        minimap2 -ax map-ont {input.ref} {input.fastq} |
        samtools sort -@ {threads} -o {output.bam}
        samtools index {output.bam}
        """
