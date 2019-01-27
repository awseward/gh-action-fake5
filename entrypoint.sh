#!/bin/sh

set -eu

export PATH="/root/.dotnet/tools:$PATH"

fake build -t "$1"
