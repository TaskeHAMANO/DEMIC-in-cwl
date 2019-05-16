# DEMIC-in-cwl

Wrapper tool of [DEMIC](https://sourceforge.net/projects/demic/) by [CWL](https://github.com/common-workflow-language/common-workflow-language) and [Docker](https://www.docker.com)

## Requirements

* Python3
* cwl-runner such as [cwltool](https://github.com/common-workflow-language/cwltool)
* Docker
    * If you cannot use docker, this tool runs with `--no-container` options.
    * However, you have to install dependent tools of RaGOO, such as R, R libraries(reshape2, lme4, FactoMineR), and perl.

## How to use

Before performing DEMIC, you have to assemble fragmented metagenome sequences, map reads, and bin them. See [official instruction manual](https://sourceforge.net/projects/demic/files/) and its [research manuscript](https://www.nature.com/articles/s41592-018-0182-0).

With the [CWL reference implementation](https://github.com/common-workflow-language/cwltool/) (`cwltool`), [`toil-cwl-runner`](https://toil.readthedocs.io/en/latest/running/cwl.html), or [`arvados-cwl-runner`](https://dev.arvados.org/projects/arvados/wiki/Running_Common_Workflow_Language_%28CWL%29_workflows_on_Arvados) as your `cwl-runner`:

```
cwl-runner --outdir ${PATH_TO_OUTPUT_DIR} \
           demic.cwl.cwl \
           --fasta_dir ${PATH_TO_FASTA_DIRECTORY} \
           --sam_dir  ${PATH_TO_SAM_DIRECTORY}
```

For other runners an input object is required:
> inputs.yml
```
fasta_dir:
  class: Directory
  path: path/to/fasta_dir
sam_dir:
  class: Directory
  path: path/to/sam_dir
```

```
cwl-runner --outdir ${PATH_TO_OUTPUT_DIR} \
           demic.cwl \
           inputs.yml
```

For other optional argument, please see the help message.

```sh
$cwl-runner demic.cwl --help

usage: demic.cwl [-h] --fasta_dir FASTA_DIR [--log LOG]
                 [--mapl_cutoff MAPL_CUTOFF] [--mapq_cutoff MAPQ_CUTOFF]
                 [--max_mismatch_ratio MAX_MISMATCH_RATIO]
                 [--output_dir_name OUTPUT_DIR_NAME] --sam_dir SAM_DIR
                 [--thread_num THREAD_NUM] [--window_size WINDOW_SIZE]
                 [--window_step WINDOW_STEP]
                 [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --fasta_dir FASTA_DIR
  --log LOG
  --mapl_cutoff MAPL_CUTOFF
                        cutoff of mapping length when calculating coverages
                        (default: 50)
  --mapq_cutoff MAPQ_CUTOFF
                        cutoff of mapping quality when calculating coverages
                        (default: 5)
  --max_mismatch_ratio MAX_MISMATCH_RATIO
                        maximum of mismatch ratio for each read as a hit
                        (default: 0.03)
  --output_dir_name OUTPUT_DIR_NAME
  --sam_dir SAM_DIR
  --thread_num THREAD_NUM
  --window_size WINDOW_SIZE
                        size (nt) of window for calculation of coverage
                        (default: 5000)
  --window_step WINDOW_STEP
                        step (nt) of window for calculation of coverage
                        (default: 100)
```