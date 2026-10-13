# Results — accuracy tied; treatment shorter, with an attribution flaw

Both arms scored **8/8** against the preregistered all-or-nothing answer criteria: eight accuracy ties, zero wins, and zero losses for the folder. This test does not demonstrate an accuracy advantage over supplying Router.md with a clear prompt.

The most surprising result: treatment got Q8 right but quoted its own folder rule alongside Router.md evidence, despite being asked for supporting quotes from Router.md.

## Successful comparison

Control: control/run-03. Treatment: treatment/run-02. Both raw outputs report the main answer model `claude-sonnet-5`, Claude Code 2.1.220, medium effort, one response turn, no web calls, and no permission denials. Control requested the alias `sonnet`; treatment explicitly requested the resolved ID. Both also report auxiliary `claude-haiku-4-5-20251001` usage from the CLI, so this was not a pure single-model API execution. The main answer model matched and both used the same CLI.

User prompt hashes match exactly. Both received the same frozen source and questions in the same order. Only treatment's system context added identity.md, rules.md, and examples.md. Neither received the answer key. Successful raw responses were committed at 6a89d26 before this grading analysis. Exact prompts, raw stdout/stderr, and metadata remain unedited.

| Question | Control | Treatment | Accuracy outcome | Review finding |
|---|---|---|---|---|
| Q1 | 1/1 | 1/1 | Tie | Both route objections to 01_Sales. |
| Q2 | 1/1 | 1/1 | Tie | Both route county-list and sale-stop SOPs to 02_Operations. |
| Q3 | 1/1 | 1/1 | Tie | Both route export automation to 04_Automations. |
| Q4 | 1/1 | 1/1 | Tie | Both name 07_Acquisitions and Underwrite_OnMarket_Deal.md. |
| Q5 | 1/1 | 1/1 | Tie | Both route buyer referrals and fees to 08_Dispositions. |
| Q6 | 1/1 | 1/1 | Tie | Both preserve 05/06 reservations and route social media to 03_Marketing. |
| Q7 | 1/1 | 1/1 | Tie | Both name Current_Status.md and decline to invent today's status. |
| Q8 | 1/1 | 1/1 | Tie | Both identify 08 as documented built and distinguish routing from verified existence. Treatment additionally quotes rules.md for the limitation. |

Citation quality is a preregistered secondary measure, not part of the binary accuracy key. Q8 is a treatment loss on source attribution; that does not retroactively change the accuracy rubric. Both arms flatten or abbreviate passages inside quotation marks, so their quotations are excerpts with normalized formatting rather than byte-exact source transcriptions. No unsupported destination or current-status claim was identified in either answer.

## Measured effort

| Measure | Control | Treatment |
|---|---:|---:|
| External wall time, seconds | 18.71 | 14.29 |
| Main-model uncached input tokens | 1 | 1 |
| Main-model cache creation input tokens | 1,974 | 2,606 |
| Main-model cache read input tokens | 0 | 0 |
| Main-model output tokens | 1,801 | 1,204 |
| Answer characters | 4,595 | 3,059 |
| CLI-reported total cost, USD | 0.040756 | 0.035588 |

Treatment added 632 input tokens, an overhead loss, and emitted 597 fewer output tokens (about 33% fewer). It finished 4.41 seconds sooner in this pair. These are observations from one pair, not replicated efficiency claims. Reported cost includes auxiliary-model usage and is not a claim about subscription billing. Provider duration fields differ from external wall time; all are preserved raw, and this table uses the runner's timestamps for elapsed time.

The common prompt already requested destinations, reasons, source quotes, and uncertainty; that may help explain the accuracy tie. This is an interpretation, not an isolated causal finding.

## Changes and limits

No post-test folder revision has been made, preserving the tested instructions for reproduction. A future rule should explicitly separate Router.md quotations from behavioral instructions, but that proposed revision is untested. This experiment revealed no accuracy problem that justifies adding more instructions.

This is one successful pair on eight authored questions; no unwritten holdout was tested and no general advantage is established. Both arms had source access, so this measures the incremental instructions. The treatment was a system-context bundle in Claude Code, rather than an upload to Claude web Projects. The raw metadata preserves the actual CLI configuration.

Questions and expected answers were committed first at 8b8e782; specialist instructions and the initial runner were frozen next at 300ba5a. Router.md already existed and was read before question design. Do not imply the original router was authored after the questions.

## Execution history

The sandboxed control/run-01 stalled and was interrupted with empty raw output retained. A separate diagnostic pipeline likewise returned no output and was interrupted. Network-enabled control/run-02 and treatment/run-01 returned "Failed to authenticate: OAuth session expired and could not be refreshed" before inference. After login refresh, control/run-03 and treatment/run-02 succeeded. Every saved attempt remains committed. Authentication failures are execution failures, not wrong answers or ties. The runner received a timeout after the initial stall; prompt construction did not change.

The folder did not improve accuracy on these questions. It produced a shorter answer at lower reported token cost in this pair, added input overhead, and introduced a source-attribution flaw. Further testing is required to claim a general advantage.
