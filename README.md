# 32 East Router — The Control

A small specialist that routes business tasks using a frozen copy of 32 East's Router.md. It preserves folder numbers, identifies named documents, and distinguishes a documented destination from verified contents or current status.

## Experiment

Eight questions and expected answers were committed first (`8b8e782`); specialist instructions and the runner were committed next (`300ba5a`), before either arm ran. Router.md already existed before this experiment. This is a test of a new instruction folder around an existing source, not a claim that the original router was authored after the questions.

Control receives the reference and question prompt with a minimal common system instruction. Treatment receives those same inputs plus identity.md, rules.md, and examples.md. Neither receives questions.md or its answer key. Both use fresh Claude Code print sessions, medium effort, tools disabled, safe mode, and no session persistence. All eight questions are asked together in the same order. The treatment is an explicit system-context bundle, rather than an upload to the Claude web Projects UI. This difference is disclosed for judges.

## Reproduce

Requires PowerShell 7 and an authenticated Claude Code installation. From this repository:

```powershell
./run.ps1 -Arm control -Model claude-sonnet-5 -Attempt rerun-01
./run.ps1 -Arm treatment -Model claude-sonnet-5 -Attempt rerun-01
```

For faithful replication, use the exact resolved model ID recorded in successful raw output rather than the moving `sonnet` alias. Reuse that ID for both arms. Record any provider/model availability differences. Each new attempt gets its own directory; the runner refuses to overwrite evidence.

Each attempt saves exact user and system prompts, raw stdout bytes, raw stderr bytes, and runtime metadata. Judge the response against questions.md; keep derived scoring in results.md and preserve the raw files. A failed attempt is evidence of execution failure, not a model answer. Do not discard failures or fill gaps with invented transcripts.

## Interpretation

Both arms have source access. Any gain measures the instruction folder's incremental benefit. One pair of runs cannot establish a reliable general advantage. Easy questions may tie; additional context can increase token use and latency. Unwritten holdout questions have not been tested. All source facts are claims about this frozen document, not a verification of the live repository or legal rules.

## Submission

The successful comparison is control/run-03 versus treatment/run-02. results.md reports eight accuracy ties, input overhead, and a treatment attribution flaw alongside observed output savings. Earlier failed attempts are preserved. Read results.md and submission-draft.md before submitting. This local repository has not been published or entered in the competition. Do not include the sheriff PDF or real lead data in this entry.
