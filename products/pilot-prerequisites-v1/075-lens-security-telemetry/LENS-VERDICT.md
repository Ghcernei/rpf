---
lens_atom: ATOM-075
lens: security-telemetry
question: "Дают ли эти пререквизиты пилоту стартовать и быть измеренным безопасно?"
answer: yes-with-conditions
findings_count:
  blocking_for_pilot: 3
  significant: 1
  minor: 3
---

# LENS-VERDICT — security-telemetry (ATOM-075)

## 1. Answer

**Yes, with conditions.** Line-by-line, the whitelist mechanism in `push.sh` is real
deny-by-default code (not intent) and its OFF-switch is a real, tested mechanism —
today, nothing can leave a founder's machine through these scripts because
`push_to_remote()` is a hard stub (confirmed: no network call, no `git push`
anywhere in the build; `workspace/run.log` DECISION line confirms this was an
explicit scope boundary, not an oversight). But "let the pilot **start and be
measured** safely" requires more than a safe stub: it requires the promise the
founder signs to hold once telemetry actually runs. As specified across these
exact files, it does not, in four concrete places: there is no wiring anywhere
that installs or schedules `push.sh` on a founder's real machine; the deletion-date
and revocation-triggers-deletion promise has zero enforcing code; four of the five
whitelisted files (`VERDICT.md`, `STATUS.md`, `run.log`, `status.yaml`) are copied
whole-file with **no** content filtering while the consent text promises zero
product content ever leaves; and `render.sh`, in the same product, opens
`INPUT.md` — the exact file `push.sh`'s own header names as the canonical example
of a file that must never be opened. None of these are gaps in the underlying
idea (whitelist + consent + OFF-switch is a sound design); they are gaps between
what is promised in `consent/CONSENT.ro.md` / `CONSENT.ru.md` and what the code in
front of me actually enforces. Close F1–F4 below before a founder's signature on
this consent text is honest.

## 2. Findings

| # | Severity | Artifact / location | What | What I would change |
| :- | :---- | :---- | :---- | :---- |
| F1 | **blocking-for-pilot** | `071-setup-kit/setup/bootstrap.sh` (whole file — no reference anywhere to `telemetry/`, `push.sh`, or a scheduler) vs `072-telemetry-showcase/telemetry/push.sh` header, lines 38-44 ("A production build (ATOM-071 setup kit) wires `push_to_remote()`... Once a day, it looks through your Qroky repo") | I read all 7 files under `071-setup-kit/setup/` end to end. None of them install `push.sh`/`consent/` into the founder's new workspace, none register a cron/launchd job, and `push.sh`'s own default `REPO_ROOT` (`$SCRIPT_DIR/../../../..`, i.e. this framework meta-repo's root) is a self-test default, not a founder-workspace path. The claim that ATOM-071 "wires" daily telemetry is not true of the ATOM-071 deliverable I actually read. Today there is no path from "founder said yes" to telemetry ever running. | Have bootstrap.sh (or a named sibling script) install `push.sh` + `consent/` into the founder's workspace and register a real daily scheduler invoking `push.sh <founder-workspace-root>` with an explicit `REPO_ROOT`, not the 4-levels-up self-test default. |
| F2 | **blocking-for-pilot** | `consent/CONSENT.ro.md` / `CONSENT.ru.md`, "Ștergere" / "Удаление" paragraph ("toată telemetria... este ștearsă la data de **[____]**... Revocarea oprește trimiterea de date și declanșează ștergerea.") | Nowhere in `push.sh`, `negative-test.sh`, `bootstrap.sh`, or `render.sh` is there any code that purges data already sent to `qroky/pilot-telemetry`, on the fixed date or on revocation. The OFF switch (`push.sh` lines 64-76) only stops **future** pushes — it deletes nothing already staged/sent. The consent text's "revocation... **triggers deletion**" is a paper promise with no enforcing line anywhere in the examined scripts. | Implement (or, at minimum, explicitly document as a dated, owner-executed Flow Support runbook step, tracked and auditable) a deletion job keyed to the signed date; make OFF actually trigger a delete request against `qroky/pilot-telemetry`, not just a stop-sending state. |
| F3 | **blocking-for-pilot** | `telemetry/push.sh` lines 101-108 (`WHITELIST_FILENAMES`) + line 170 (`if [[ "$base" == "RESULT.md" ]]` — every other whitelisted name falls through to the plain `cp "$file" ...` at line 173, unfiltered) | Only `RESULT.md` gets content-level extraction (`copy_result_cost_block()`). `VERDICT.md`, `STATUS.md`, `run.log`, `status.yaml` are whole-file copies with **zero** content filtering. This matters concretely for `VERDICT.md`: the very format I am bound to for this deliverable ("each: artifact, exact location, what... Specific, never vibes") is the FEV-PROTOCOL VERDICT format — verify verdicts are built to quote exact lines from the reviewed product as evidence. A whole-file, unfiltered `VERDICT.md` will routinely carry business-descriptive quotes into telemetry, directly against "Мы никогда не получаем: содержание вашего продукта, спецификации, код, решения." `status.yaml`'s free-text closure `note:` field and `STATUS.md`'s progress lines carry the same risk (both are described elsewhere in this repo as often naming what was delivered). `negative-test.sh` never plants a realistic descriptive `VERDICT.md`/`STATUS.md` to test this — it only proves the two non-whitelisted decoy files (`INPUT.md`, `secret.txt`) are rejected, which is a narrower claim than "no product content ever leaves." | Either content-filter `VERDICT.md` (structural fields only: `verdict`, `round`, `returns_used` — no Findings body) and `STATUS.md`/`run.log`/`status.yaml` (strip free-text notes) the same way `RESULT.md` is filtered, or amend the consent text to disclose plainly that these four files are copied whole and may contain quoted excerpts — so the signature is accurate. |
| F4 | significant | `072-telemetry-showcase/showcase/render.sh` lines 156-164 (`summary_para=$(awk '/^## Summary/...' "$atom_result")`, `fan_decision_line=$(grep -oE '\*\*Fan decision:\*\*.*' "$input_md" ...)`) vs `telemetry/push.sh` lines 26-28 (INPUT.md named as the canonical example of "found... logged as SKIPPED... and never opened") | Two sibling scripts in the **same product** make opposite promises about `INPUT.md`: `push.sh` treats it as the forbidden case; `render.sh` opens it directly and republishes a line from it, plus RESULT.md's `## Summary` first sentence (a plain-English description of what was built), into the TEAM-summary artifact — which ATOM-007's own INPUT §3.3 calls a "selling artifact" Startup Moldova "must see... from day one." `workspace/run.log`'s RS1-SOURCES line confirms this was a deliberate choice ("needed to make render.sh operate on real data"), not an oversight — which makes it a real, acknowledged design tension rather than a bug (see SY9 below), but it is still a concrete promise-vs-mechanism gap as written: nothing marks these render outputs as perimeter-crossing or not, and nothing stops the Summary-sentence/Fan-decision fields from carrying product substance if they ever are shown externally. | Mark `showcase/example-*` outputs explicitly local-only (never crossing the perimeter) in `render.sh`'s own header and in the consent text — or, if they are meant to be shown externally, drop the Summary-sentence and Fan-decision-line fields specifically (they are exactly "what the founder built"). |
| F5 | minor | `telemetry/push.sh` lines 110-119 (`is_whitelisted()` compares only `basename "$file"`, no path/directory scoping) | Whitelist matching is basename-only. A founder's own unrelated file coincidentally named `STATUS.md`, `run.log`, `status.yaml`, `RESULT.md`, or `VERDICT.md` anywhere under `REPO_ROOT` — e.g. a personal `notes/STATUS.md` — is swept and copied with the same treatment as a real atom record. `negative-test.sh` TEST 1 never plants this decoy case, so the mechanism's scoping (as opposed to its filename-exclusion) is untested. | Scope the whitelist match to the expected atom-record path shape (e.g. `products/*/*/STATUS.md`, `*/workspace/run.log`) instead of basename-only; add a negative-test case for a whitelisted-name decoy file outside that shape. |
| F6 | minor | `setup/QUICKSTART.ro.md` / `QUICKSTART.ru.md` (silent on telemetry entirely) vs `consent/CONSENT.ro.md` / `.ru.md` "Отзыв... останавливает отправку данных" | The OFF-switch mechanism is real and code-tested (`push.sh` lines 64-76, `negative-test.sh` TEST 2), but nothing founder-facing, in either language, names the actual action ("create a file named `OFF` inside `telemetry/`"). A non-technical founder who wants to revoke has no instructions anywhere in the read files for how to actually do it. | Add one paragraph to the consent doc or QUICKSTART naming the exact action, or route it through the assistant ("ask the assistant to turn telemetry off" — machinery hidden, per §3.1, but the effect must still be reachable). |
| F7 | minor / info | `071-setup-kit/setup/bootstrap.sh` lines 35-40, 119-133 | `QROKY_FRAMEWORK_REF` pins to a raw commit SHA fetched over `git submodule add`/`fetch` from a public GitHub URL, with no signature verification beyond the SHA match itself. Not a founder-data exfiltration path (this is inbound, not outbound), so out of my lens's core question, but adjacent supply-chain-integrity note worth recording since it is the one place the founder's machine reaches outward at all. | No action required for pilot start; note for a later touch if `qroky/framework` adds signed tags. |

## 3. Named contradiction (SY9)

**Моя линза требует, чтобы `render.sh` (и любой будущий telemetry-путь) никогда не
читал `## Summary` / `INPUT.md`-текст — даже если это разрушает саму цель
TEAM-summary как «продающего» и «человеческого» артефакта, ради которого он был
создан.**

INFO-007's "invisible team" lesson — the reason the TEAM-summary artifact exists at
all — explicitly wants a founder (and, per ATOM-007 INPUT §3.3, Startup Moldova) to
see *what was built*, in plain language, one line per contribution. That is
`render.sh`'s entire job: `summary_para` from `RESULT.md`'s `## Summary`, distilled
to the first sentence. My lens reads that exact same design choice as a leak
surface — the first sentence of a `## Summary` is, structurally, the most
business-descriptive line in the whole record, and `fan_decision_line` pulled
straight from `INPUT.md` compounds it (`INPUT.md` is the one file `push.sh` singles
out by name as never-to-be-opened). If I get my way — strip both fields, or wall
the whole showcase render off from anything that ever crosses the perimeter — the
TEAM-summary stops answering the lesson it was built to answer: a founder reading
it would see roles and pass/fail counts, not "what they did." Security wins that
trade by default in my verdict (F4), but I am naming the cost explicitly rather
than pretending the two lenses agree: legibility for the founder and silence
outside the founder's machine are, in this one artifact, the same feature pulling
in opposite directions.

## 4. Cost of my own look

Estimated ~62k tokens for this atom (role file + 5 §3-listed input paths — 7 files
under `071-setup-kit/setup/`, 10 files under `072-telemetry-showcase/{telemetry,
consent,showcase}/`, `007-pilot-prerequisites/PLAN.md`, `007-pilot-prerequisites/
INPUT.md` §2-4 — plus this verdict's authoring and the three obligation files),
against the ~90k budget envelope (INPUT frontmatter) and the ~30k line-item in
PLAN.md's product tree; came in under both.
