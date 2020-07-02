#!/bin/sh

psql spanish-dictionary -c "SELECT * FROM dictionary WHERE next_appearance < current_timestamp ORDER BY next_appearance" | tail -n 2 | sed q
