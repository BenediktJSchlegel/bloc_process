

Look at decision and breakout flow. 

decision should probably always force 1 breakout. a chain should
likely not support full branching. A decision has 1 breakout branch (which might
lead to a new process being started after the chain is completed), and one "continuation branch"
that continues in the chain. Decision in that way should be more like "early exits" rather
than full branching.