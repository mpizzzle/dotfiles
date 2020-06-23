#!/bin/sh

bc -l <<< "(((sqrt(5) + 1) / 2) ^ $1 - (-((sqrt(5) + 1) / 2)) ^ -$1) / sqrt(5)" | awk '{printf("%d\n", $1 + 0.5)}'
