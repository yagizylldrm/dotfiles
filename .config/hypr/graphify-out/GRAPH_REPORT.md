# Graph Report - hypr  (2026-10-11)

## Corpus Check
- Corpus is ~24,435 words - fits in a single context window. You may not need a graph.

## Summary
- 89 nodes · 84 edges · 28 communities (4 shown, 24 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 19,481 input · 500 output

## Community Hubs (Navigation)
- Apache License Terms
- NWG Display Manager
- Ollama Model Scripts
- Zoom Functionality
- Utility Functions
- Workspace Actions
- Video Wallpaper
- AI Buffer Query
- Emoji Picker
- App Launcher
- Screen Search
- Geoclue Agent
- Caps Lock Warning

## God Nodes (most connected - your core abstractions)
1. `Apache License Version 2.0` - 8 edges
2. `Redistribution Conditions` - 6 edges
3. `Work` - 5 edges
4. `Contribution` - 5 edges
5. `show-loaded-ollama-models.sh script` - 4 edges
6. `Derivative Works` - 4 edges
7. `Contributor` - 4 edges
8. `Copyright License Grant` - 4 edges
9. `Patent License Grant` - 4 edges
10. `trim()` - 3 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (28 total, 24 thin omitted)

### Community 1 - "Apache License Terms"
Cohesion: 0.22
Nodes (16): Accepting Warranty or Additional Liability, Apache License Version 2.0, Contribution, Contributor, Copyright License Grant, Derivative Works, Limitation of Liability, NOTICE Attribution Requirements (+8 more)

### Community 2 - "NWG Display Manager"
Cohesion: 0.60
Nodes (3): fields(), generated_lines(), trim()

### Community 3 - "Ollama Model Scripts"
Cohesion: 0.70
Nodes (4): compare_running_models_and_modelfiles(), get_running_model_paths(), parse_modelfiles(), show-loaded-ollama-models.sh script

### Community 4 - "Zoom Functionality"
Cohesion: 0.70
Nodes (4): clamp(), get_zoom(), set_zoom(), zoom.sh script

## Knowledge Gaps
- **4 isolated node(s):** `NOTICE Attribution Requirements`, `Trademark Limitation`, `Warranty Disclaimer`, `Limitation of Liability`
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 51 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **24 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What connects `NOTICE Attribution Requirements`, `Trademark Limitation`, `Warranty Disclaimer` to the rest of the system?**
  _4 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Core Configuration` be split into smaller, more focused modules?**
  _Cohesion score 0.10526315789473684 - nodes in this community are weakly interconnected._