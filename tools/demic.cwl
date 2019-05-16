#!/user/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: []
hints:
    DockerRequirement:
        dockerImageId: ajhjhaf/demic:1.0.2
        dockerFile:
            $include: ../containers/DEMIC/Dockerfile
inputs:
    "sam_dir":
        type: Directory
        inputBinding:
            position: 1
            prefix: "--sam_dir"
    "fasta_dir":
        type: Directory
        inputBinding:
            position: 2
            prefix: "--fasta_dir"
    "output_dir_name":
        type: string
        default: "demic_output_dir"
        inputBinding:
            position: 3
            prefix: "--out_dir"

    "window_size":
        type: int?
        doc: "size (nt) of window for calculation of coverage (default: 5000)"
        inputBinding:
            position: 4
            prefix: "--window_size"
    "window_step":
        type: int?
        doc: "step (nt) of window for calculation of coverage (default: 100)"
        inputBinding:
            position: 5
            prefix: "-window_step"
    "mapq_cutoff":
        type: int?
        doc: "cutoff of mapping quality when calculating coverages (default: 5)"
        inputBinding:
            position: 6
            prefix: "--mapq_cutoff"
    "mapl_cutoff":
        type: int?
        doc: "cutoff of mapping length when calculating coverages (default: 50)"
        inputBinding:
            position: 7
            prefix: "--mapl_cutoff"
    "max_mismatch_ratio":
        type: float?
        doc: "maximum of mismatch ratio for each read as a hit (default: 0.03)"
        inputBinding:
            position: 8
            prefix: "--max_mismatch_ratio"

    "log":
        type: string?
        inputBinding:
            position: 9
            prefix: "--log"
    "thread_num":
        type: int?
        inputBinding:
            position: 10
            prefix: "--thread_num"

outputs:
    "output_dir":
        type: Directory
        outputBinding:
            glob: $(inputs.output_dir_name)
    "log_file":
        type: File?
        outputBinding:
            glob: $(inputs.log)
