//Neil Davies 16/09/19
//This calculates the risk of default using a very simple simulation.
//The two biggest limitations of this simulation are a) it assumes independence of returns for equities and bonds
//and b) it assumes normally distributed returns. Both assumptions are implausible, but this simulation gives 
//an idea of the sort of model the USS is likely to use to model risk in their stochastic analysis.  


clear
set obs 10000

//We have two assset classes equities (mean return=8.3, SD=24.21) and bonds (mean return=2.79, SD=9.94)

gen cummulative_return_equities=1
gen cummulative_return_bonds=1

//Draw 10 years worth of return data
forvalues i=1(1)10{
	gen equities_return_`i'=rnormal(0.083,0.2421)
	gen bonds_return_`i'=rnormal(0.0279,0.0994)
	replace cummulative_return_equities=cummulative_return_equities*(equities_return_`i'+1)
	replace cummulative_return_bonds=cummulative_return_bonds*(bonds_return_`i'+1)
	}

cap drop weighted_return
gen weighted_return=0.4*cummulative_return_bonds+0.6*cummulative_return_equities

//So this gives us about a 1 in 8 chance of missing the funding target
//Taking out to 25 years
	
clear
set obs 10000

//We have two assset classes equities for total estimates (mean return=8.3, SD=24.21) and bonds (mean return=2.79, SD=9.94)

gen cummulative_return_equities=1
gen cummulative_return_bonds=1

forvalues i=1(1)25{
	gen equities_return_`i'=rnormal(0.083,0.2421)
	gen bonds_return_`i'=rnormal(0.0279,0.0994)
	replace cummulative_return_equities=cummulative_return_equities*(equities_return_`i'+1)
	replace cummulative_return_bonds=cummulative_return_bonds*(bonds_return_`i'+1)
	}

cap drop weighted_return
gen weighted_return=0.4*cummulative_return_bonds+0.6*cummulative_return_equities
