## Codes for numerically solving spatial positive plant-soil feedback model
# Corresponding manuscript at ...

# Files
* *parGen.sh*: Bash script to generate parameter files
* *main.m*: MATLAB function to numerically solve for a single parameter combination
* *fig2a.m*: Produce fig2a
* *fig2b.m*: Produce fig2b
* *fig3a.m*: Produce fig3a
* *fig3b.m*: Produce fig3b

# Instructions to find numerical solutions
1. Create *output* directory
2. Edit *parGen.sh* and run the bash script to create batch sub-directory under *output* and generate parameter files
> ./parGen.sh batch\_name
3. Run *main.m* in MATLAB to numerically solve for one parameter combination. Code requires *batch_name*, *run_number* and *vizuation status* (0 or 1 to indicate whether output should be plotted in runtime.
