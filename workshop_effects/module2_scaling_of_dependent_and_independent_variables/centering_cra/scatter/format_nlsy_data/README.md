# Conversion notes

nlsy_unusable_noID.json is unusable without distinct ID field. Chart is sees duplicates without ID. Reminder don't do this. 

From browser console after using SWR: 
Warning: Encountered two children with the same key, `NaN`. Keys should be unique so that components maintain their identity across updates. Non-unique keys may cause children to be duplicated and/or omitted — the behavior is unsupported and could change in a future version.
g

python pandas has reindex to reindex from 0 after removing NaN rows. R does same; remove rows w NaN

Run jupyter notebook to generate .json from csv