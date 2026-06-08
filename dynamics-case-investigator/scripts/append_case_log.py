#!/usr/bin/env python3
"""Append a Dynamics case investigation summary row to a CSV log."""

from __future__ import annotations

import argparse
import csv
import os
from datetime import datetime, timezone
from pathlib import Path


COLUMNS = [
    "Run Date",
    "Agent",
    "Case Number",
    "Customer",
    "Product",
    "Similar Cases Found",
    "Jira Records Found",
    "Confidence",
    "Recommended Action",
    "Time Saved Estimate",
    "Agent Rating",
    "Outcome",
    "Notes",
]


DEFAULT_LOG_FILE = "~/codex-case-investigation-logs/case-investigations.csv"
LOG_FILE_ENV_VAR = "CODEX_CASE_LOG_FILE"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Append a row to the Dynamics case investigation CSV log."
    )
    parser.add_argument(
        "--log-file",
        default=os.environ.get(LOG_FILE_ENV_VAR, DEFAULT_LOG_FILE),
        help=(
            "CSV log path. Defaults to CODEX_CASE_LOG_FILE when set, "
            f"otherwise {DEFAULT_LOG_FILE}."
        ),
    )
    parser.add_argument(
        "--run-date",
        default=datetime.now(timezone.utc).astimezone().isoformat(timespec="seconds"),
    )
    parser.add_argument("--agent", default="Unknown")
    parser.add_argument("--case-number", required=True)
    parser.add_argument("--customer", default="")
    parser.add_argument("--product", default="")
    parser.add_argument("--similar-cases-found", default="0")
    parser.add_argument("--jira-records-found", default="0")
    parser.add_argument("--confidence", choices=["High", "Medium", "Low"], default="Low")
    parser.add_argument("--recommended-action", default="")
    parser.add_argument("--time-saved-estimate", default="")
    parser.add_argument("--agent-rating", default="")
    parser.add_argument("--outcome", default="")
    parser.add_argument("--notes", default="")
    return parser.parse_args()


def append_row(args: argparse.Namespace) -> Path:
    log_path = Path(args.log_file).expanduser()
    log_path.parent.mkdir(parents=True, exist_ok=True)
    needs_header = not log_path.exists() or log_path.stat().st_size == 0

    row = {
        "Run Date": args.run_date,
        "Agent": args.agent,
        "Case Number": args.case_number,
        "Customer": args.customer,
        "Product": args.product,
        "Similar Cases Found": args.similar_cases_found,
        "Jira Records Found": args.jira_records_found,
        "Confidence": args.confidence,
        "Recommended Action": args.recommended_action,
        "Time Saved Estimate": args.time_saved_estimate,
        "Agent Rating": args.agent_rating,
        "Outcome": args.outcome,
        "Notes": args.notes,
    }

    with log_path.open("a", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=COLUMNS)
        if needs_header:
            writer.writeheader()
        writer.writerow(row)

    return log_path


def main() -> None:
    log_path = append_row(parse_args())
    print(f"Appended case investigation log row to {log_path}")


if __name__ == "__main__":
    main()
