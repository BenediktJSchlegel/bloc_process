
1. Initial input values for process controller
2. process chaining. pass output -> input -> output -> input through chain
optional "transformer" function between chain steps

chain as stream -> fires events with next process, transform, chainbreak, injected callback etc.