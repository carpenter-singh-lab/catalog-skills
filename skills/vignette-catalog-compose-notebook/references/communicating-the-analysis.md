# Communicating the analysis

The notebook is the argument, and how you present it decides whether a reader can trust it.
A correct result told as a pile of tables is weak; the same result told as a reasoned line - claim, evidence, limit - is strong.
These are the presentation habits that go with [research-method.md](research-method.md); that file is about *doing* the research, this one is about *showing* it.

## Structure each question as a hypothesis-experiment-observation loop

Work and present each question as the loop it actually was: state a hypothesis, run an experiment (a live pull, a literature check, a calculation), look at what came back, revise, repeat.
The loop terminates when no further experiment would change the answer; the terminal state is the **final hypothesis = the prediction or conclusion** you commit to.
This mirrors how the work is genuinely done, and it lets the reader audit each step instead of taking the conclusion on faith.

The most valuable cell is often a **falsified** hypothesis.
When an early belief collides with data and loses - a "wild-type" assumption that the genetics pull contradicts - that falsification is the engine of the analysis, not an embarrassment to hide.
Lead with it: "H0 was X; the experiment showed not-X; that forced the real model."

## Narrate the world, not your own iteration

There are two kinds of revision, and only one belongs in the notebook as a narrated loop.

- A hypothesis **about the world** that data falsified (the cell line was not what I assumed) - narrate it.
  It is a finding.
- A change to **your own modeling choice** (you first tried an additive model, then switched to a better one) - do *not* narrate it as if it were a discovery.

Present the model directly, as the conclusion the analysis supports - never as "the recalibrated model", "the revised approach", or "my earlier version put X at Y".
Phrasing like that narrates your own path as though you were correcting a published prior; the reader does not know or care about your drafts, and it reads as a confession log rather than science.
The notebook is the argument artifact, not a transcript of every path you explored.
The test: would this sentence still make sense to a reader who never saw your earlier attempt?
If it only makes sense as a correction of *you*, cut the framing and state the model plainly.

## Separate the robust result from the fragile one

Most analyses produce an output you can defend strongly and one you can't, and they are usually different parts of the same table.
Rankings and directions tend to be robust; absolute magnitudes and fine orderings within a near-tie tend to be fragile.
Say which is which, in the artifact, before the reader has to ask. "The A375-vs-LOXIMVI contrast is high-confidence; the fine ordering within the BRAFi cluster is near-tied and not resolvable here" is worth more than a single uniform confidence over everything.
When a model produces a tie it cannot break, say so and make the choice on explicit mechanistic grounds rather than dressing up a coin-flip as precision.

## Define the instrument when you introduce it

The first time a dataset, screen, or metric appears, say what it is, what its values mean, and why it is the right tool for this question - in one or two sentences, inline.
A reader who hits "GDSC combination screen" or "AUC" without a definition cannot judge the evidence.
This is the inline-definition habit from the global writing guidance, applied to data sources and instruments, not just terms.

## Plain language

Follow the global writing style: plain over clever, hyphens not arrows, no flowery phrasing.
Memorable metaphors ("the escape hatch becomes a kill switch", "this is a trap", "the consensus-buster") cost clarity; this is science and it should read clearly.
Keep the domain terms that carry precise meaning (cytostatic, Bliss independence, dose-matched) and drop the ones that are there to sound good.
