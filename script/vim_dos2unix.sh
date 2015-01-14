#!/bin/bash -
vim -c ':set ff=unix' -c ':%s#\s*$##g' -c ':%s#\r\n#\r#g' -c ':wq' "$@"
