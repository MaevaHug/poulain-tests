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
cc -Wall -Wextra -Werror -o rotone rotone.c
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
longest_test="$> ./rotone \"Les stagiaires du staff ne sentent pas toujours tres bon.\" | cat -e"
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to run a test and check the result
run_test() {
	local args=$1
	local expected=$2

	echo "$separator"
	echo "$> ./rotone $args | cat -e"

	output=$(eval ./rotone $args | cat -e)
	echo -e "$expected" > expected_output.txt
	echo -e "$output" > actual_output.txt

	if diff -q expected_output.txt actual_output.txt > /dev/null; then
		echo -e "${GREEN}Test passed${NC}"
		#echo -e "-> Actual output:\n$output"
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

# Run tests
all_tests_passed=true

# Test cases
run_test "\"abc\"" "bcd\$" || all_tests_passed=false
run_test "\"Les stagiaires du staff ne sentent pas toujours tres bon.\"" "Mft tubhjbjsft ev tubgg of tfoufou qbt upvkpvst usft cpo.\$" || all_tests_passed=false
run_test "\"AkjhZ zLKIJz , 23y \"" "BlkiA aMLJKa , 23z \$" || all_tests_passed=false
run_test "\"\"" "\$" || all_tests_passed=false  # Test with empty string
run_test "" "\$" || all_tests_passed=false  # Test without argument

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm rotone