library(flowCore)

# following this example:
# https://www.rdocumentation.org/packages/flowCore/versions/1.38.2/topics/spillover

# sample file of participant SUB135739.369 from SDY369 at baseline (0 day)
# https://www.immunespace.org/study/Studies/SDY369/dataset.view?datasetId=5019&Dataset.sample_file~contains=HIPCJDM064D0_4.468583.fcs
SAMPLE <- read.FCS("HIPCJDM064D0_4.468583.fcs")

# spillover matrix from sample
spill_answer <- SAMPLE@description[["SPILL"]]
spill_answer
dim(spill_answer)
colnames(spill_answer)

# compensation control files for the sample above (10 stained + 1 unstained)
CONTROLS <- read.flowSet(files = dir("controls"), path = "controls")

# compute spillover
spill <- spillover(
  x = CONTROLS,
  unstained = "12_7_11_Comp_Unstained.468567.fcs",
  patt = "Alexa Fluor 700-A|APC-H7-A|APC-A|ECD-A|FITC-A|Pacific Blue-A|PE-Cy5-A|PE-Cy7-A|PE-A|Pacific Orange-A",
  stain_match = "intensity"
)
# "Error: Unable to match stains with controls based on intensity: a single stain matches to several multiple controls."
# https://github.com/RGLab/flowCore/blob/2f27110e0f182842c5b343a861b6e4566ddb10f7/R/flowSet-accessors.R#L773

# spill
# dim(spill)
# colnames(spill)
# all.equal(spill_answer, spill)