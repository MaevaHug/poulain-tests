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

# Compile the files
echo "Compiling the files..."
cc -Wall -Wextra -Werror -o ft_split ft_split.c main.c
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
longest_test="$> ./ft_split \"trailing spaces   \" | cat -e"
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to run a test and check the result
run_test() {
	local input=$1
	local expected=$2

	echo "$separator"
	if [ "$input" == "EMPTY_STRING" ]; then
		echo "$> ./ft_split \"\" | cat -e"
		output=$(./ft_split "" | cat -e)
	else
		echo "$> ./ft_split \"$input\" | cat -e"
		output=$(./ft_split "$input" | cat -e)
	fi

	if [ "$output" == "$expected" ]; then
		echo -e "${GREEN}Test passed${NC}"
		# echo -e "-> Actual output:\n$output"
		return 0
	else
		echo -e "${RED}Test failed${NC}"
		echo -e "-> Expected output:\n$expected"
		echo -e "-> Actual output:\n$output"
		return 1
	fi
}

# Run tests
all_tests_passed=true

# Test cases
run_test "Hello world" "[Hello][world][(null)]$" || all_tests_passed=false
run_test "   leading spaces" "[leading][spaces][(null)]$" || all_tests_passed=false
run_test "trailing spaces   " "[trailing][spaces][(null)]$" || all_tests_passed=false
run_test "multiple   spaces" "[multiple][spaces][(null)]$" || all_tests_passed=false
run_test $'tabs\tand\nnewlines' "[tabs][and][newlines][(null)]$" || all_tests_passed=false
run_test "EMPTY_STRING" "[(null)]$" || all_tests_passed=false # Test with empty string
run_test "singleword" "[singleword][(null)]$" || all_tests_passed=false # Test with single word

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm ft_split