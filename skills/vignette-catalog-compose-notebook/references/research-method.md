# Being a research partner, not just a notebook author

The rest of this skill covers the mechanics of composing a notebook.
This reference covers the harder case: open-ended research questions such as "what does this data say about X?", "find me a better target", "is this hypothesis right?", or "do the best you can."

In those cases, the deliverable is an argument built from evidence, with clear limits.
Use whatever tools the question needs: catalog helpers, subagents, primary literature, web search, and live APIs.
The notebook is where the argument lands and stays re-runnable.
It should contain the claims, evidence, code, and limitations - not a transcript of every path explored.

## Principles

These are habits, not checklist items: the difference between summarizing the consensus and contributing something useful.

**1. Hypothesis first, then test its *other* predictions.** A claim earns trust from predictions you did *not* build it on.
State the mechanism, derive 3-5 independent consequences, check each, and report the misses as loudly as the hits - a failed sub-prediction shows exactly where the model is wrong and is often the most useful output.

**2. Don't stop at the consensus answer.** If your best answer is what everyone already says and the problem is still open, that's a signal: use the data to hunt the non-obvious thing nobody's on ("what else here is actionable that no one is looking at?").
A targeted, hypothesis-driven search over a chosen candidate set beats an unguided genome-wide scan - the candidate list *is* the theory you're testing, and that's a strength, not a caveat.

**3. Calibrate confidence to evidence, and name its kind.** Correlation *nominates* a hypothesis; it does not establish a mechanism - say "a tractable, testable handle", not "the answer".
Keep separate what you measured, assumed, borrowed from literature, and got-from-an-agent-but-haven't-verified.
Weak signals (rho 0.2-0.4) earn trust by *convergence across independent measures*, not one big number - so say which.

**4. Count the search, not just the survivor.** This method manufactures multiplicity - the several predictions you derive, the subagents all mining the same data, the hunt across many candidate handles - and the winner of an unrecorded search is the headline finding's natural failure mode.
Decide which predictions count before you look, keep a running tally of how many handles you tried, and discount a result by the search that found it: a rho past 0.3 means less as the fortieth thing tested than as the first.
"We tried twelve, one survived" is the honest unit - and convergence counts only when the measures are genuinely independent, not twelve re-cuts of one.

**5. Fan out subagents only when the work is genuinely parallel.** When a question splits cleanly into independent sub-questions - data mining, literature review, applied landscape, benchmark search - spawn one subagent per track, then synthesize the result yourself.

Each brief should include the exact tool/API context, what counts as a useful result, and the required return format: numbers with n, citations with line refs, negative findings, and limits.
Demand negatives; "this dataset does not cover our case" is a finding.
Do not relay an agent's conclusion.
Verify the load-bearing claims, reconcile disagreements, and own the final answer.

**6. Red-team your own result before the user does.** Answer the skeptic *inside* the artifact: "everyone knows this / it's been tried / correlation isn't causation / the drug doesn't exist / n is tiny / in-vitro artifact."
Address the sharpest objection head-on.
When the user pushes back, treat it as signal and be willing to concede and pivot - present your best answer *together with* the thing that would most undermine it, and make pivoting the easy move.

**7. Verify before you assert.** Check citations against primary sources (paper exists; year/venue/claim right), and dataset ids, feature labels, entity identities.
Fluent prose is an anti-signal - the cleaner a confabulation reads, the more it needs checking - so verify the claims that carry the argument.

**8. Ground everything; make it re-run.** Pull live, hand-enter nothing, keep the artifact self-contained.
A number you can point to in code beats one you assert, and it's what lets you honestly separate "shown" from "claimed".

**9. For any proposal, design the falsifier.** Name the one experiment or comparison that would prove it wrong, plus the controls that make the readout interpretable (an on-target rescue; a negative control that *should* show nothing).
A proposal that states what would disprove it convinces far more than one that only lists support.

**10. State the limits of the instrument.** Cross-sectional isn't causal; a knockout isn't a drug; a 5-day screen isn't a 48h assay; *missing data is itself a result*.
Name the weakest link - it's what the user most needs before acting.

**11. The user is the expert in the loop.** Surface decisions that are theirs (scope, naming, what to publish/submit), and confirm before any outward or hard-to-reverse action - submitting to a live benchmark, publishing something answer-revealing, registering an identity, sending anything externally.

**12. Watch for what must stay private.** Know what's an answer key, a held-out oracle, a secret - and that even an aggregate at small n can back-reveal it (one correlation over four points can pin a ranking).
Keep the contestant-facing artifact and the grader's private tooling separate.

## Safety note: shown-once secrets

When a tool returns a secret shown only once (a registration token, a one-time key), capture it in-process and surface it to the user before doing anything else.
Never pipe that command through `head`/`tail`/`grep` that can truncate it out of view - it is gone the moment it scrolls past.
