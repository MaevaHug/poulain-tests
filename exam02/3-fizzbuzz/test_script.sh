#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Run norminette check
echo "Running norminette check..."
output=$(norminette 2>&1)
if [ $? -ne 0 ]; then
	echo "$output" | grep -E --color=always "Error|Warning|Norme"
	echo -e "${RED}Norminette check failed${NC}"
#	exit 1
else
	echo -e "${GREEN}Norminette check passed${NC}"
fi

# Compile the file
echo "Compiling the files..."
cc -Wall -Wextra -Werror -o fizzbuzz fizzbuzz.c
if [ $? -ne 0 ]; then
	echo -e "${RED}Compilation failed${NC}"
	exit 1
else
	echo -e "${GREEN}Compilation succeded${NC}"
fi

# Function to generate a separator line of a given length
generate_separator() {
	local length=$1
	local separator=""
	for ((i=0; i<length; i++)); do
		separator="${separator}="
	done
	echo "$separator"
}

# Assign the longest test to a variable
longest_test="$> ./fizzbuzz | cat -e"
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to run a test and check the result
run_test() {
	local expected=$1

	echo "$separator"
	echo "$> ./fizzbuzz | cat -e"

	output=$(./fizzbuzz | cat -e)
	echo -e "$expected" > expected_output.txt
	echo -e "$output" > actual_output.txt

	if diff -q expected_output.txt actual_output.txt > /dev/null; then
		echo -e "${GREEN}Test passed${NC}"
		rm expected_output.txt actual_output.txt
		return 0
	else
		echo -e "${RED}Test failed${NC}"
		echo -e "-> Expected output:\n$expected"
		echo -e "-> Actual output:\n$output"
		rm expected_output.txt actual_output.txt
		return 1
	fi
}

# Expected output for fizzbuzz
expected=$(for i in {1..100}; do
	if (( i % 3 == 0 && i % 5 == 0 )); then
		echo "fizzbuzz\$"
	elif (( i % 3 == 0 )); then
		echo "fizz\$"
	elif (( i % 5 == 0 )); then
		echo "buzz\$"
	else
		echo "$i\$"
	fi
done | tr '\n' '\n')

# Run tests
all_tests_passed=true

# Test case
run_test "$expected" || all_tests_passed=false

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm fizzbuzz