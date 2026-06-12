# graphify-windows Skill

This is a local copy of the graphify-windows skill located at:
`C:\Users\amnua\.gemini\config\skills\graphify\SKILL.md`

## Frontmatter
name: graphify-windows
description: "Use for any question about a codebase, its architecture, file relationships, or project content — especially when graphify-out/ exists, where the question should be treated as a graphify query first. Turns any input (code, docs, papers, images, videos) into a persistent knowledge graph with god nodes, community detection, and query/path/explain tools."

## Core Instructions
This skill provides instructions for building, querying, and updating a codebase knowledge graph using the `graphify` tool. It details:
- File detection, AST extraction, semantic extraction (via LLM or parallel subagents), community clustering, report generation.
- Running queries on the graph using `graphify query`.
- Incrementally updating the graph using `graphify update`.
- Honesty rules for the knowledge graph.
