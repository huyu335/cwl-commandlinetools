#!/usr/bin/env cwl-runner

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/
  doap: http://usefulinc.com/ns/doap#

cwlVersion: v1.0

class: Workflow
id: msisensor-run-both
requirements:
  StepInputExpressionRequirement: {} 
  MultipleInputFeatureRequirement: {}
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  normal_bam:
    type: File
    secondaryFiles: [ ".bai" ] 
  tumor_bam:
    type: File
    secondaryFiles: [ ".bai" ] 
  output_prefix: string
  msi_file: File

outputs:
  msisensor_0.2_output:
    type: File
    outputSource: msisensor_0.2/output

  msisensor_0.5_output:
    type: File
    outputSource: msisensor_0.5/output

steps:
  msisensor_0.2:
    run: ../tools/msisensor/msisensor-0.2.cwl
    in:
      d: msi_file
      n: normal_bam
      t: tumor_bam
      o:
        valueFrom: ${ return inputs.output_prefix + "_0.2.txt"; }
    out: [ output ]

  msisensor_0.5:
    run: ../tools/msisensor/msisensor-0.5.cwl
    in:
      d: msi_file
      n: normal_bam
      t: tumor_bam
      o:
        valueFrom: ${ return inputs.output_prefix + "_0.5.txt"; }
    out: [ output ]
