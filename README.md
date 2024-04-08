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

- # 6 March 2024 Meeting Minutes
- Feedback from Proposal: Avril suggested that results were not novel enough, but we already did the analysis, so we should keep it in & consider adding another aim (e.g., differential abundance analysis)
- Discussing the results from our alpha diversity, PCoA plots, and logistic regression:
   - Logistic regression results
      - Display our results (stunting and anemia) as a table, only use Forest plots for more than 2 categories
   - PCoA plots:
      - Bray Curtis: didn't take out NAs yet, not a lot of clustering
      - Jacquard: follows the same trend
      - Unifrac:
      - Weighted Unifrac: follows the same trend
      - Dana already has the phyloseq object made, but will need to take NAs out & update with new metadata file
   - Alpha and beta diversity analysis:
      - Redid the same thing as last week, but looked at just stunted group for this week's analysis
      - Have not yet redone rarefaction curve
- Moving forward
   - What analyses we need to get done by next week's meeting:
      - Core microbiome analysis
      - Indicator taxa analysis
      - Differential abundance analysis
   - What dataset are we using? The old one (4 groups) or the new one (stunted vs non-stunted)
      - Use new one if we can adjust sampling depth with stunting vs non-stunting & see significance
      - Use old one if we cannot
    
- Action Items:
   - Redo alpha beta diversity (Faith - will take max 1-2h on Friday morning)
      - Change parameters by redoing rarefaction curve: decrease sampling depth to 16,888
   - Redo rooted-tree and phyloseq, etc for going into phyloseq object (Alec - will work on it by Friday morning)
   - Redo phyloseq object using new metadata file & take out NAs (Erica - will message group when done so Annie can do her part)
      - anemia_phyloseq.zip -> contains all the inputs
   - Core microbiome (Erica)
   - Indicator taxa (Annie)
   - Differential abundance
   - Proposal Revisions (Dana)
 
- Most people will be working on it Friday it seems
- Please move old files into "OLD" folder and working files into "WORKING"

# 13 March 2024 Meeting 
Weekly Update
- Redid the rarefaction curve and decreased our sampling depth --> made new phyloseq object
- Completed new alpha/beta diversity tests
- Completed core microbiome and indicator taxa analyses (genus and species levels)
- Revised proposal according to Avril's feedback

Meeting Agenda
- Review alpha/beta diversity tests
- Review core microbiome analyses
- Review ISA 
- Annie spoke with Dr. Sun --> she is strongly recommending that we do a functional analysis given that we have not found any taxonomic patterns
   - Piecrust??
- Talk about what should be done moving forward --> have now completed all of our aims

Meeting Minutes
- Definitely use PiCrust2!
- 1 month and 2 days until draft manuscript 😥
- No Alpha or Beta diversity measures that are significant
- Note that a bunch of papers for UJEMI 28 show "no significance" so it is fine if we fail to reject the null hypothesis
- No clearly great indicator species results, but there are some that are significant
   - Can include and just mention that the stat values are fairly low (<8)
   - "Stunted healthy" appears to have the most notable indicator species
   - Include them all. Though note that we don't appear to be in stunted anemic. Maybe b/c of the changes in microbiome due to anemia

- What do we want our figues to be in the paper?
   - Look at UJEMI 28 and UJEMI+ volume 9 for inspo with ones that do not have sig differences
  
   - Q: What are the effects of anemia and stunting on the infant gut microbiome
   - HAVE: Logistic reg, coremicrobiome, ISA, alpha/beta div, etc. 

   - Fig. 1: Logistic Regression
      - Set the stage for the study - why are we investigating?   
   - Fig. 2: Diversity (α/β):
      - Tells: "No significance"
      - We can choose to include specific alpha and beta metrics
         - Figure out which alpha div. one is connected to core microbiome and include that for sure, the rest are optional (can put the others in supplementary)
   - Fig. 3: Core Micro
      - To support Fig. 2
      - Show similarities between all the groups
      - Print out the list of ASVs unique to stunted and healthy seperately
   - Fig. 4: Indicator species analysis of indicator of healthy stunting
      - "Maybe stunting has indic. sp. that are disrupted by anemia"
         - Rationalize via the fact that maybe there are differences in anemic microbiome
         - So look at the microbiome changes in the general anemic microbiome as compared to healthy subjects?
      - BLAST all relevant species even if they show that they are NA or uncultured in the table
         - So pretty much all of them that Annie found.
   - Fig. 5: Differential Abundance Species Analysis
      - btwn anemic and healthy to support fig. 4
   - Fig. 5: Functional Analysis
      - Of all 4 groups
    
- Rec. that we get started on results since we already have a bunch of the figures and data that we need
- We can repurpose the intro from our proposal

- Have done for next week:
   - Differential Abundance Analysis
      - Code is given in module god bless Dr. Sun
      - Start writing up results if possible
   - Functional Analysis for sure (via PICRUST2)
      - Code is also given in module (I think) god BLESS Dr. Sun
      - Start writing up results if possible
   - Start writing up the results that we do have so far. 

# 20 March 2024 
Weekly Update
- Began writing up results from past analyses
- performed differential abundance analysis and PICRUSt2
  
Meeting Agenda
- Discuss results of some analyses (how to interpret, what to include in write-up)
   - Core microbiome analysis
   - Indicator species analysis
 
Meeting Minutes

Core microbiome analysis: 
- keep as one figure
- more differences in stunting, not much in anemia

Indicator species analysis:
- There are many species for stunted healthy, but not for others. It's possible that anemia has a larger effect on the microbiome in comparison to stunting. Could be masking the effects of stunting.

- Idea: are we trying to say that anemia is decreasing microbial diversity? This could possibly explain the difference between the core microbiome analysis and indicator species.
- Look at UJEMI paper before, it supports this idea (Pontual et al.)

Differential species analysis:
- stunted would be expected to have more than non stunted, but we don't really see anything
- not going to use this

Functional analysis:
- Didn't talk about this

Diversity analysis:
- Important ones are related to the main question

Action items:
- Look at papers about anemia and stunting and see what they say about the microbiome
- Try to find another analysis to tie everything together
- Make sure we are using the right data set

# 27 March 2024
Meeting Agenda
- Discuss which diversity tests to do with Dr. Sun
- Discuss how to portray the diversity test results. Ex. Should I use my R graphs and QIIME 2 significance data? Do we just say in the paper: there's no significance?
- Discuss presentation prep and manuscript writing

Meeting Minutes
- Try diversity analyses in R
- Not doing a figure for logistic regression
- Run diversity statistical analysis for Chao1
- Ask Erica what's the parameters to the core microbiome photos
- All results seem to support this: anemia seems to be skewing the data for stunting
- Perhaps put PiCrust in the supplemental? Up to us

Figures:
1. Heat map (mosaic plot) for logistic regression (look up figure on Google: Chi-square test of independence)
2. Just the Chao1, and Shannon and one beta diversity in the supplemental
3. Core microbiome: the one that shows that there's 25 unique to the stunted
4. Table 1: indicator taxa species (the specific 22 for stunted healthy)
5. DeSeq: just for 2 groups - stunting vs non stunted, one for healthy, one for anemic

Action items:
1. See if the 22 species in indicator taxa species have literature about them regarding stunting and our research
2. Chao1 diversity analyses in R - Use Wilcoxon
3. Indicator taxa species: BLAST ASVs in the ref seqs, and it'll give you taxonomic levels
4. Figure out how many individuals are in each of the 4 groups for logistic regression: try and create a figure (mosaic plot)

# 3 April 2024
Meeting Agenda
- Discuss DeSeq results
- Plan presentation slides
- Discuss Chao1 results
Meeting Notes
- Volcano plots
     - seems to go with the rest of the story... anemia leads to a dysbiotic microbiome
     - have 4 plots for the figure (anemic, not anemic, bar plots, volcano)
- Shannon + beta diversity together in one supplemental
- ISA glom to genus only, since the species are mostly uncultured
- Still use the significant value for Chao1
      - "approaching significance" for 0.06
     - hard to make conclusions here... differences could be due to anemia
- Meeting on monday at 12 to go over slides
- No .zip files in the repo
      - Group files into scripts and outputs

# 7 April 2024
Meeting Agenda
- Go over oral presentation slides
- Decide whether to have a meeting on Wednesday
