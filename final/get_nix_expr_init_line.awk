#!/usr/bin/awk -f

BEGIN {
    depth = 0
    inside_let = 0
    inside_in = 0
}

{
    for (i=1; i<=NF; i++) {
        if ($i == "let") {
            depth++
            if (depth == 1) {
                inside_let = 1
                output = NR-1
            }
        }

        if ($i == "in") {
            if (depth == 1) {
                inside_in = 1
            }
            depth--
            
            if (depth == 0 && inside_let && inside_in) {
                print NR+1
                inside_let = 0
                inside_in = 0
            }
        }
    }
}
