# Results — execution blocked, no comparison yet

The questions were committed before both attempts, followed by a commit freezing the specialist folder. No successful model answers have been obtained. There is no evidence yet that the folder improves routing.

The sandboxed initial control attempt stalled with empty output and was interrupted. The network-enabled control retry returned an authentic provider error: "Failed to authenticate: OAuth session expired and could not be refreshed". Its raw stdout, stderr, exact prompts, and metadata are preserved in control/run-02. A signed-in status check did not guarantee working authentication.

The network-enabled treatment attempt also failed before inference; its raw output and metadata are preserved in treatment/run-01. These are execution records, not successful experimental transcripts.

| Question | Control accuracy | Treatment accuracy | Outcome |
|---|---|---|---|
| Q1 | Not evaluated | Not evaluated | Pending |
| Q2 | Not evaluated | Not evaluated | Pending |
| Q3 | Not evaluated | Not evaluated | Pending |
| Q4 | Not evaluated | Not evaluated | Pending |
| Q5 | Not evaluated | Not evaluated | Pending |
| Q6 | Not evaluated | Not evaluated | Pending |
| Q7 | Not evaluated | Not evaluated | Pending |
| Q8 | Not evaluated | Not evaluated | Pending |

An authentication failure is neither an incorrect answer nor a tie. Runtime on failed attempts does not measure answer latency. Token counts of zero do not measure task efficiency. No folder changes have been made in response to answer performance because no answers exist. The runner was given a timeout after the initial stall; this does not change the experimental prompts.

## Remaining work

Refresh Claude Code authentication with `claude auth login`. Then run both arms with new attempt names, preserve all previous attempts, and confirm the resolved model ID matches in both successful outputs. If availability causes the alias to resolve differently, retain those attempts and repeat with one exact model ID. Grade Q1–Q8 against questions.md and replace pending cells with every win, tie, and loss. Report citations, unsupported claims, elapsed time, and token costs separately. Retain this execution history. Commit the raw transcripts before publishing; do not submit this pending results file as a completed comparison.
