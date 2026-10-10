#!/bin/bash

set -uo pipefail

BIN=link-scanner

if ! command -v $BIN > /dev/null
then
    echo -e "$WARN ${BOLD}${BIN}${OFF} is not present on the system..."
    exit 0
fi

EXIT_CODE=0
FILES=$(git diff-index --cached --name-only HEAD 2> /dev/null | grep ".md\b")

if [ -n "$FILES" ]
then
    echo -e "$INFO Running ${BOLD}${BIN}${OFF} pre-commit hook..."

    for file in $FILES
    do
        title=$(awk -F\" '/title/ {print$2}' <(cat "$file"))

        # Note that the benjamintoll.com.service must be running!
        # systemctl --user status benjamintoll.com.service
        # Getting the link from the html page is better than getting it from the filename,
        # because the filename doesn't always match the title of the article!
        #
        # <article class="archive-item">
		#     <a href="/2026/10/09/on-cgroups/" class="archive-item-link">On cgroups</a>
		#     <span class="archive-item-date">
		#         October 9, 2026
		#     </span>
		# </article>
        if ! $BIN -url "http://localhost:8000$(curl http://localhost:8000 2> /dev/null | grep -i "$title" | awk -F\" '{print $2}')" -quiet
        then
            EXIT_CODE=1
        fi
    done

    if [ $EXIT_CODE -eq 0 ]
    then
        echo -e "$SUCCESS Completed successfully."
    fi
fi

exit $EXIT_CODE

