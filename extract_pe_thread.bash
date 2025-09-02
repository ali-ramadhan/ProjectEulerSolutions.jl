#!/bin/bash

# Script to fetch Project Euler thread pages
# Usage: ./fetch_euler_thread.sh [OPTIONS]

# Default values
THREAD_ID=""
START_PAGE=1
END_PAGE=8
COOKIES_FILE="cookies.txt"
OUTPUT_FILE=""
SLEEP_TIME=1
KEEP_HTML=false

# Help function
show_help() {
    cat << EOF
Usage: $0 -t THREAD_ID [OPTIONS]

Fetch Project Euler thread pages and extract text content.

Required:
  -t, --thread THREAD_ID    Thread ID to fetch (e.g., 81)

Options:
  -s, --start START_PAGE    Starting page number (default: 1)
  -e, --end END_PAGE        Ending page number (default: 8)
  -c, --cookies FILE        Path to cookies file (default: cookies.txt)
  -o, --output FILE         Output text file (default: project_euler_THREAD.txt)
  -d, --delay SECONDS       Delay between requests (default: 1)
  -k, --keep-html           Keep downloaded HTML files
  -h, --help                Show this help message

Examples:
  $0 -t 81                           # Fetch thread 81, pages 1-8
  $0 -t 81 -s 1 -e 15                # Fetch thread 81, pages 1-15
  $0 -t 42 -c my_cookies.txt -o thread42.txt
  $0 -t 81 -d 2 -k                   # 2 second delay, keep HTML files

Requirements:
  - curl
  - html2text
  - cookies.txt file with valid Project Euler session cookies

EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--thread)
            THREAD_ID="$2"
            shift 2
            ;;
        -s|--start)
            START_PAGE="$2"
            shift 2
            ;;
        -e|--end)
            END_PAGE="$2"
            shift 2
            ;;
        -c|--cookies)
            COOKIES_FILE="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        -d|--delay)
            SLEEP_TIME="$2"
            shift 2
            ;;
        -k|--keep-html)
            KEEP_HTML=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information."
            exit 1
            ;;
    esac
done

# Validate required arguments
if [[ -z "$THREAD_ID" ]]; then
    echo "Error: Thread ID is required."
    echo "Use -h or --help for usage information."
    exit 1
fi

# Set default output file if not provided
if [[ -z "$OUTPUT_FILE" ]]; then
    OUTPUT_FILE="project_euler_${THREAD_ID}.txt"
fi

# Validate numeric arguments
if ! [[ "$START_PAGE" =~ ^[0-9]+$ ]] || ! [[ "$END_PAGE" =~ ^[0-9]+$ ]] || ! [[ "$SLEEP_TIME" =~ ^[0-9]+$ ]]; then
    echo "Error: Page numbers and sleep time must be positive integers."
    exit 1
fi

if [[ $START_PAGE -gt $END_PAGE ]]; then
    echo "Error: Start page cannot be greater than end page."
    exit 1
fi

# Check dependencies
for cmd in curl html2text; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: $cmd is not installed or not in PATH."
        exit 1
    fi
done

# Check cookies file
if [[ ! -f "$COOKIES_FILE" ]]; then
    echo "Error: Cookies file '$COOKIES_FILE' not found."
    echo "Please export your Firefox cookies to this file first."
    exit 1
fi

# Create output directory if needed
OUTPUT_DIR=$(dirname "$OUTPUT_FILE")
if [[ ! -d "$OUTPUT_DIR" ]]; then
    mkdir -p "$OUTPUT_DIR"
fi

# Clear output file
> "$OUTPUT_FILE"

echo "Fetching Project Euler thread $THREAD_ID, pages $START_PAGE-$END_PAGE"
echo "Output file: $OUTPUT_FILE"
echo "Cookies file: $COOKIES_FILE"
echo "Delay between requests: ${SLEEP_TIME}s"
echo

# Fetch pages
FAILED_PAGES=()
for ((i=START_PAGE; i<=END_PAGE; i++)); do
    url="https://projecteuler.net/thread=${THREAD_ID};page=$i"
    html_file="page_${THREAD_ID}_${i}.html"

    echo -n "Fetching page $i... "

    if curl -s -b "$COOKIES_FILE" "$url" -o "$html_file"; then
        # Check if we got actual content (not an error page)
        if grep -q "thread" "$html_file" 2>/dev/null; then
            echo "✓"
        else
            echo "⚠ (possibly blocked or no content)"
            FAILED_PAGES+=($i)
        fi
    else
        echo "✗ (curl failed)"
        FAILED_PAGES+=($i)
    fi

    # Sleep between requests (except for last page)
    if [[ $i -lt $END_PAGE ]]; then
        sleep "$SLEEP_TIME"
    fi
done

echo

# Extract text from HTML files
echo "Extracting text content..."
for ((i=START_PAGE; i<=END_PAGE; i++)); do
    html_file="page_${THREAD_ID}_${i}.html"
    page_text_file="project_euler_${THREAD_ID}_page${i}.txt"

    if [[ -f "$html_file" ]]; then
        echo -n "Processing page $i... "

        # Extract text to individual page file
        html2text "$html_file" > "$page_text_file" 2>/dev/null || echo "Error: Could not extract text from page $i" > "$page_text_file"

        # Add page separator and content to combined file
        {
            echo "================== PAGE $i =================="
            echo
            cat "$page_text_file"
            echo
            echo
        } >> "$OUTPUT_FILE"

        echo "✓"

        # Clean up HTML file unless keeping
        if [[ "$KEEP_HTML" = false ]]; then
            rm "$html_file"
        fi
    fi
done

echo

# Report results
TOTAL_PAGES=$((END_PAGE - START_PAGE + 1))
FAILED_COUNT=${#FAILED_PAGES[@]}
SUCCESS_COUNT=$((TOTAL_PAGES - FAILED_COUNT))

echo "Results:"
echo "  Successfully fetched: $SUCCESS_COUNT/$TOTAL_PAGES pages"

if [[ $FAILED_COUNT -gt 0 ]]; then
    echo "  Failed pages: ${FAILED_PAGES[*]}"
    echo "  This might indicate expired cookies or access restrictions."
fi

if [[ -f "$OUTPUT_FILE" ]]; then
    WORD_COUNT=$(wc -w < "$OUTPUT_FILE")
    echo "  Combined output: $OUTPUT_FILE ($WORD_COUNT words)"
    echo "  Individual pages: project_euler_${THREAD_ID}_page*.txt"

    if [[ "$KEEP_HTML" = true ]]; then
        echo "  HTML files: page_${THREAD_ID}_*.html (preserved)"
    fi
else
    echo "  No output file created."
fi

echo
echo "Done!"
