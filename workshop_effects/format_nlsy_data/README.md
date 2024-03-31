# Conversion notes

nlsy.json is unusable without distinct ID field. 

From browser console after using SWR: 
Warning: Encountered two children with the same key, `NaN`. Keys should be unique so that components maintain their identity across updates. Non-unique keys may cause children to be duplicated and/or omitted — the behavior is unsupported and could change in a future version.
g

Need ID field. 