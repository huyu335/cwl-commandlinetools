
class: CommandLineTool

cwlVersion: v1.0

id: mutect1

baseCommand:
  - java
  - '-Xmx8g'
  - '-jar'
  - muTect-1.1.5.jar 
  - '--analysis_type'
  - MuTect

inputs:

  - id: reference
    type: File?
    inputBinding:
      position: 0
      prefix: '--reference_sequence'

  - id: intervals
    type: File?
    inputBinding:
      position: 0
      prefix: '--intervals'
  - id: input
    type: File?
    inputBinding:
      position: 1
      prefix: '--input'
    secondaryFiles:
      - ^.bai
  - id: tumor_sample
    type: string?
    inputBinding:
      position: 2
      prefix: '--tumor-sample'
  - id: input_normal
    type: File?
    inputBinding:
      position: 3
      prefix: '--input'
    secondaryFiles:
      - ^.bai
  - id: normal_sample
    type: string?
    inputBinding:
      position: 4
      prefix: '--normal-sample'
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: >-
        $(inputs.tumor_sample)_vs_$(inputs.normal_sample)_$(inputs.intervals.basename).vcf.gz
label: Mutect2
arguments:
  - position: 5
    prefix: '--output'
    valueFrom: >-
      $(inputs.tumor_sample)_vs_$(inputs.normal_sample)_$(inputs.intervals.basename).vcf.gz
requirements:
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.1.0.0'
  - class: InlineJavascriptRequirement
