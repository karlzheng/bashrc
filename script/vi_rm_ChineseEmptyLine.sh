#!/bin/bash -

vi -c ":e ++enc=utf8" -c ":%s/\v.*[^\x00-\xff]+.*//g" -c ":g/^$/d" -c ":w!" -c ":q" $1
