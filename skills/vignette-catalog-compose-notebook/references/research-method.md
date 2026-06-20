# Being a research partner, not just a notebook author

The rest of this skill covers the mechanics of composing a notebook.
This reference covers open-ended research questions: "what does this data say about X?", "find me a better target", "is this hypothesis right?", or "do the best you can."

For those questions, the deliverable is an argument built from evidence, with clear limits.
Use whatever tools the question needs: catalog helpers, subagents, primary literature, web search, and live APIs.
The notebook is where the argument lands and stays re-runnable.
It should contain the claims, evidence, code, and limitations - not a transcript of every path explored.

## Principles

These are habits, not checklist items: the difference between summarizing the consensus and contributing something useful.

**1. Hypothesis first, then test its other predictions.**
State the mechanism, derive 3-5 independent consequences, check each, and report misses as clearly as hits.
A failed sub-prediction shows where the model is wrong and is often the most useful output.
When backfitting is a real risk, split prediction generation and prediction testing into separate passes.

**2. Do not stop at the consensus answer.**
If the best answer is what everyone already says and the problem is still open, use the data to hunt for the non-obvious actionable thing.
A targeted search over a chosen candidate set beats an unguided genome-wide scan.
The candidate list is the theory being tested.
When needed, use a literature or landscape subagent to map the consensus and prior failures before looking for the opening.

**3. Calibrate confidence to evidence, and name its kind.**
Correlation nominates a hypothesis; it does not establish a mechanism.
Say "a tractable, testable handle", not "the answer."
Keep separate what was measured, assumed, borrowed from literature, and returned by an agent but not yet verified.
Weak signals earn trust by convergence across genuinely independent measures.
Lead with effect size and what it would change, not just significance.

**4. Count the search, not just the survivor.**
This method creates multiplicity: multiple predictions, multiple candidate handles, and sometimes multiple agents mining related data.
Decide which tests count before looking, track how many handles were tried, and discount results by the search that found them.
"We tried twelve, one survived" is the honest unit.
For important findings, use a separate audit pass to reconstruct the search path and check whether the measures are truly independent.

**5. Fan out subagents only when the work is genuinely parallel.**
When a question splits cleanly into independent tracks - data mining, literature review, applied landscape, benchmark search - spawn one subagent per track, then synthesize the result yourself.
Each brief should include the exact tool/API context, what counts as useful, and the required return format: numbers with n, citations with line refs, negative findings, and limits.
For every load-bearing number, require provenance: query, dataset id/version, seed, filters, and parameters needed for the notebook to re-derive it.
Demand negatives; "this dataset does not cover our case" is a finding.
Do not pass through an agent's conclusion unchanged; verify the load-bearing claims, reconcile disagreements, and own the final answer.

**6. Red-team the result before the user does.**
For high-stakes or non-obvious conclusions, use a separate adversarial pass to attack the argument.
Have it test obviousness, prior failures, confounding, weak n, missing controls, unavailable interventions, and in-vitro artifacts.
Answer the strongest objections inside the artifact.
When the user pushes back, treat it as signal: concede when needed, pivot cleanly, and state what would most undermine the current answer.

**7. Verify before you assert.**
Check citations against primary sources, dataset ids, feature labels, and entity identities.
For many claims or citations, use a verifier subagent that returns primary-source evidence and line refs.
Fluent prose is an anti-signal; the cleaner a confabulation reads, the more it needs checking.
Verify the claims that carry the argument.

**8. Ground everything; make it re-run.**
Pull live, hand-enter nothing, and keep the artifact self-contained.
A number produced by code beats a number asserted in prose.
This is what lets you separate "shown" from "claimed."

**9. For any proposal, design the falsifier.**
Name the experiment or comparison that would prove the proposal wrong, plus the controls that make the readout interpretable.
For real follow-up work, use a skeptical experimental-design pass to sharpen the falsifier and controls.
A proposal that states what would disprove it is stronger than one that only lists support.

**10. State the limits of the instrument.**
Cross-sectional is not causal; a knockout is not a drug; a 5-day screen is not a 48h assay.
Missing data is itself a result.
Name the weakest link before the user acts on the finding.

**11. The user is the expert in the loop.**
Surface decisions that belong to the user: scope, naming, what to publish, what to submit, and what to send externally.
Confirm before any outward or hard-to-reverse action, including live benchmark submission, answer-revealing publication, identity registration, or external messages.

**12. Run the post-hoc self-check.**
After any clean-sounding result, ask: would I have predicted this, at this confidence, before I saw the answer? If the explanation only sharpened once the result was in view, it is post-hoc - label it that way.
When a held-out answer key exists (a benchmark oracle, a future value), the operator should keep it out of the working context, including your own memory and notes; prose discipline is only the weak backup to actually withholding it.

**13. Do not confirm your own model.**
When a prediction comes from a model you built on your own assumptions, running that model is not a test of those assumptions - it can only reproduce them, however rigorous the output looks.
The real experiment is data *independent* of the model: find a measurement that could contradict the load-bearing assumption and go get it.
A combination model with a hand-set synergy rule will always "find" the synergy it was given; only an external screen can refute it.
The tell is an experiment whose result was determined the moment you wrote the model - if nothing in the world could have come back and surprised you, you have a restatement, not evidence.
This is the most seductive failure in this method, because the self-confirming version looks identical to real work: a hypothesis, a computation, a table, a conclusion. The difference is whether the middle step could have failed.

## Safety note: shown-once secrets

When a tool returns a secret shown only once, such as a registration token or one-time key, capture it in-process and surface it to the user before doing anything else.
Never pipe that command through `head`, `tail`, or `grep`; truncating the output can lose the secret permanently.
