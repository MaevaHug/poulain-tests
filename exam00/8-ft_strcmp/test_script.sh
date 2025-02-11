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
cc -Wall -Wextra -Werror -o ft_strcmp main.c ft_strcmp.c
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
longest_test="$> ./ft_strcmp \"Special characters !@#$%^&*()_+\" \"Special characters !@#$%^&*()_+\""
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to run a test and check the result
run_test() {
	local input1=$1
	local input2=$2
	local expected=$3

	echo "$separator"
	echo "$> ./ft_strcmp \"$input1\" \"$input2\""

	output=$(./ft_strcmp "$input1" "$input2")
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
run_test "Hello, World!" "Hello, World!" "OK" || all_tests_passed=false
run_test "" "" "OK" || all_tests_passed=false
run_test "42" "42" "OK" || all_tests_passed=false
run_test "   " "   " "OK" || all_tests_passed=false
run_test "Special characters !@#$%^&*()_+" "Special characters !@#$%^&*()_+" "OK" || all_tests_passed=false
run_test "1234567890" "1234567890" "OK" || all_tests_passed=false
run_test "Hello" "World" "OK" || all_tests_passed=false
run_test "abc" "abcd" "OK" || all_tests_passed=false
run_test "abcd" "abc" "OK" || all_tests_passed=false
run_test "$(printf '\xFF')" "$(printf '\x7F')" "OK" || all_tests_passed=false  # Test with signed char negative values

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm ft_strcmp