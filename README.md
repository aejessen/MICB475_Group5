# MICB475_Group5

# 31 Jan 2024 Meeting #1 Notes
Must have dataset and research question for our project set by next meeting on the 7th of Feb.
Must have agenda for next meeting created by us.

# 7 Feb 2024 Meeting Agenda
1. Discuss our research question options:
   Our main idea for our research question: Are the gut microbiomes of male and female infants with or without anemia differentially affected by diet?
   Our back up ideas:
   - Looking at anemia and gut microbiomes of stunted infants vs non stunted infants
   - Looking at the microbiomes of infants with anemia delivered via C section or vaginal birth (Note: will have to combine data sets)
2. Is this feasible? Have other teams done this before?
3. Discuss team proposal plans
4. Ask Evelyn about documentation procedures

Notes: 
- Looking at the relationship between stunted/non-stunted in anemic vs. healthy children
     - Anemia: 22 stunted vs 84 normal
     - Healthy: 8 stunted v 75 normal
- Step 1: Make a new metadata file with a new column that combines anemia and stunting
      - Missing data? --> probably keep it in there as N/A --> can get rid of it in R later
- Step 2: Qiime2 processing of the new metadata file --> upload to the server
     - she will give us team credentials
- Step 3: Alpha/beta diversity in Qiime/R --> need R for publishing
- Step 4: Core microbiome to compare between different states
- Step 5: Indicator taxa analysis --> microbes predictive of a disease state
- Step 6 (kind of aside): Perhaps add logistic regression to determine the likelihood of being stunted if you have anemia
      - can be done in parallel
- Have to do the initial processing stuff before the proposal --> make the metadata file
      - Steps 1/2 will be done for the proposal
- Make a Qiime2 folder and R folder --> sort files into them and Command line code (make this a .sh file)
- Can work on proposal on Docs

Action Items: 
- Proposal planning --> generate some .qzv files and such
- Initial processing to make the new metadata file
