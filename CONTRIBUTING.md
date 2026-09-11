# Contributing to HYVOR

Thanks for your interest in contributing to HYVOR! This repository is the
starting point for HYVOR development and contains our other repositories as
submodules (see the table in [README.md](README.md)). Some of these
repositories are open-source (`relay`, `internal`, `design`) and accept
outside contributions; others are proprietary and closed to outside
contributions.

This guide covers contributions to any of our open-source repositories.

## Before you start

-   For anything beyond a small fix (a new feature, a behavior change, a
    large refactor), please open an issue or discussion first to make sure
    the change is wanted before you spend time on it.
-   Check existing issues and pull requests to avoid duplicate work.

## AI usage

We allow AI-assisted contributions under certain conditions. Read our
[AI Usage Policy](AI_POLICY.md) before using AI tools (Claude Code, Cursor,
Copilot, etc.) to work on a contribution.

<!-- ## CLA (Contributor License Agreement)

Our AGPL-licensed repositories require a signed Contributor License
Agreement (CLA) before we can accept your contribution. If you open a pull
request and haven't signed the CLA yet, our CLA bot will comment on the PR
with instructions. This only needs to be done once. -->

## AGPL-licensed repositories do not accept contributions yet

At this moment, we are not accepting contributions to any of our AGPL-licensed
repositories since we are still in the process of finalizing our CLA.
We will update this section when we are ready to accept contributions to these
repositories.    

## Development setup

See [README.md](README.md) for instructions on setting up the local
development environment.

## Making a change

1. Fork the repository you want to contribute to and create a branch off
   `main` for your change.
2. Make your change, following the existing code style and conventions of
   the repository.
3. Add or update tests where relevant.
4. Make sure existing tests, linters, and static analysis pass.
5. Write clear, descriptive commit messages.
6. Open a pull request against `main`, describing what the change does and
   why. If it fixes an open issue, reference it (e.g. `Fixes #123`).
7. If any part of your contribution was AI-assisted, disclose it in the PR
   description as required by the [AI Usage Policy](AI_POLICY.md).

## Reporting bugs

When filing a bug report, please include:

-   Steps to reproduce the issue.
-   What you expected to happen vs. what actually happened.
-   Relevant logs, screenshots, or error messages.
-   Your environment (OS, browser, versions) where relevant.

## Security issues

Please do **not** report security vulnerabilities through public GitHub
issues. Refer to [`SECURITY.md`](SECURITY.md) for how to
report them responsibly, or contact us directly.

## Code of conduct

Be respectful and constructive. We want HYVOR's projects to be a welcoming
place to contribute to.
