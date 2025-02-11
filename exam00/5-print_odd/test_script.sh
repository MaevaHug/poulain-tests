#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Run norminette check
echo "Running norminette check..."
output=$(norminette print_odd.c 2>&1)
if [ $? -ne 0 ]; then
	echo "$output" | grep -E --color=always "Error|Warning|Norme"
	echo -e "${RED}Norminette check failed${NC}"
else
	echo -e "${GREEN}Norminette check passed${NC}"
fi

# Compile the file
echo "Compiling the files..."
cc -Wall -Wextra -Werror -o print_odd print_odd.c
if [ $? -ne 0 ]; then
	echo -e "${RED}Compilation failed${NC}"
	exit 1
else
	echo -e "${GREEN}Compilation succeeded${NC}"
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
longest_test='$> ./print_odd "42 is the answer" | cat -e'
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to run a test and check the result
run_test() {
	local input=$1
	local expected=$2
	local description=$3

	echo "$separator"
	echo "$description"

	if [ -z "$input" ]; then
		output=$(./print_odd | cat -e)
	else
		output=$(./print_odd "$input" | cat -e)
	fi

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

# Run tests
all_tests_passed=true

run_test "Hello World" "HloWrd$" '$> ./print_odd "Hello World" | cat -e' || all_tests_passed=false
run_test "42 is the answer" "4 stease$" '$> ./print_odd "42 is the answer" | cat -e' || all_tests_passed=false
run_test "a" "a$" '$> ./print_odd "a" | cat -e' || all_tests_passed=false
run_test "" "$" '$> ./print_odd | cat -e' || all_tests_passed=false

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm print_odd