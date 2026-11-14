#!/usr/bin/env bash
set -euo pipefail

# Official grading command for the Python implementation.
python3 test.py --bin "python3 cpu.py"
