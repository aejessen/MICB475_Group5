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

# 7 Feb 2024 Meeting Minutes
Among our ideas, we chose to look at the relationship between stunted/non-stunted in anemic vs. healthy children
Current data set sample size:
     - Anemia: 22 stunted vs 84 normal
     - Healthy: 8 stunted v 75 normal
- Aim 1: Make a new metadata file with a new column that combines anemia and stunting
      - Missing data? --> probably keep it in there as N/A --> can get rid of it in R later
- Aim 2: Qiime2 processing of the new metadata file --> upload to the server
     - she will give us team credentials
- Aim 3: Alpha/beta diversity in Qiime/R --> need R for publishing
- Aim 4: Core microbiome to compare between different states
- Aim 5: Indicator taxa analysis --> microbes predictive of a disease state
- Aim 6 (can be done parallel): Logistic regression to determine the correlation of stunting and anemia presence

Proposal-relevant items:
- Have to do the initial processing stuff before the proposal --> make the metadata file
      - Steps 1/2 will be done for the proposal
- Make a Qiime2 folder and R folder --> sort files into them and Command line code (make this a .sh file)
- Can work on proposal on Docs

Action Items: 
- Proposal planning --> generate some .qzv files and such
- Initial processing to make the new metadata file

# 12 Feb 2024 Meeting Minutes
1. Respond to Simanpreet with Github link and research question
2. Another paper found no association between prevalence of stunting and anemia in infant, so discuss feasibility of logistic regression (aim #6) with Dr. Sun (note: they did not look into the microbiome)
3.    May work for our dataset since we include 6 month infants, just not 12 months (as the original paper)
4. Divy up the team proposal
5.   Ask about alpha and beta diversity - what tests to choose?
6.   Hypothesis will need to be changed as we go on -> create the most basic question we can ask and then re-adjust as we do research
7. References: use comments to indicate where our references are
8.    Can't go alphabetical for ASM


# 14 Feb 2024 
Meeting Agenda
- talk to Dr. Sun about aim #6
-    paper found no association at 12 months.... 6 months vs 12 months?
- what alpha and beta diversity test do we use for aim #3?
- go over our preliminary data
- ask about timeline of this project and how much planning each stage will take

Meeting Minutes
- Probably just proceed with the logistical regression... leave it for last and we can see if it is necessary
- Metadata is done --> on GitHub!
   - Non-Stunted Anemic= 84, Non-Stunted Healthy = 75, Stunted Anemic = 22, Stunted Healthy = 8
- Run all alpha/beta diversity tests --> some will be helpful, some will not
   - Generate in qiime first and then once we know which will go in the paper, re-do it in R
   - Filter mitco/chloro and NAs in either R or qiime --> depends what we want
- Not super picky about the timeline --> maybe be a little generous
- Do not include diversity metrics in proposal --> go up to alpha rarefaction curve
- Do not use the repetitive proposal model
- Rareify so that we do not lose the stunted healthy group --> treat as the limiting factor (want at least 5)
   - Reach out to teaching team to check things over
- Output of logistic regression == odds ratio --> table w/ p-values telling us whether group x has a higher likelihood of getting anemia + how many times more likely it is
- Starting giving a little progress report before the agenda so they know what we have done!!
- Generate alpha and beta diversity figures before next meeting (when we come back from reading break)

# 27 Feb 2024 
Weekly Update
- Finished proposal!
- Completed alpha and beta diversity tests
Meeting Agenda
- discuss the alpha and beta diversity analyses that were performed
   - few significant differences were found
- determine what analyses we should move forward with based on the diversity analyses
   - picrust2
   - excluding certain factors
Meeting Notes
- Going over the alpha/beta diversity results...
   - nothing is significant:/
   - Simran thinks that we can re-do this analysis to only look at stunted/non-stunted (start with simplest)
   - Other studies have not found significance between anemic/non-anemic
   - The two categories do not have to be exclusive
        - Look at anemic vs non-anemic, stunted vs non-stunted --> do a differential abundance analysis 
        - Maybe still include anemia at the end (mention how it was not carried forward bc of previous studies showing there was no difference) 
   - pcoa plot could be helpful here --> regardless of VOI, we can use the dropdown to see if anything stands out
   - maybe get going with the logistic regression --> she will give us the code
   - For next meeting:
        - do the logistic regression with stunting
        - do stunted/non-stunted for alpha/beta
        - pcoa plot
    
# 4 March 2024
Weekly Update 
- Completed the redone alpha and beta diversity tests (with stunted/non-stunted)
- Created the pcoa plots
- Completed the logistic regression --> 2.57x more likely to be stunted if anemic

Meeting Agenda
- Discuss diversity test results --> no significance
   - What should we do from here?
- Have a look at the pcoa plots
- Discuss the logistic regression results
  - Best way to visualize these? Forest plot?
- Discuss doing the revisions for the proposal
- Discuss approach for manuscript (how we want to move through the sections, which sections should be done first->last, who wants to do what)
