import os
import subprocess
from behave import when, then 
from behave.runner import Context

VALE_CMD = 'vale --output=line --sort --normalize --relative --no-global .'

@when('I test "{rule}"')
def step_impl(context: Context, rule: str):
    """
    Changes to the given rule directory and runs VALE_CMD.
    """
    
    context.execute_steps(f'When I cd to "fixtures/{rule}"')

    context.execute_steps(f'When I run `{VALE_CMD}`')

@then('the linter output should report the following issues:')
def step_impl(context: Context):
    """
    Parses the structured 'vale' output and compares it line-by-line 
    to the expected issues provided in the data table (context.table).
    """

    actual_output = getattr(context, 'stdout', '').replace('\r', '').strip()
    actual_lines = [line.strip() for line in actual_output.split('\n') if line.strip()]
    expected_lines_to_match = []
    
    # 1. Format the expected table rows into structured search components
    for row in context.table:
        # We look for a line that starts with the file and line number
        expected_prefix = f"{row['File']}:{row['Line']}:"
        # And ends with the rule and message
        expected_message_suffix = f"{row['Rule']}:{row['Message']}"
        expected_lines_to_match.append((expected_prefix, expected_message_suffix))
    
    
    # 2. Assert that all expected lines are present in the actual output
    found_expected_count = 0
    missing_expected_lines = []

    for expected_prefix, expected_message_suffix in expected_lines_to_match:
        found = False
        for actual_line in actual_lines:
            # Check if the line starts with the file:line prefix AND ends with rule:message suffix
            # This handles the unpredictable column number in the middle of the 'vale' output.
            if actual_line.startswith(expected_prefix) and actual_line.endswith(expected_message_suffix):
                found = True
                found_expected_count += 1
                break
        
        if not found:
            # Reconstruct the expected full string for clear error reporting
            missing_expected_lines.append(f"Line starting with '{expected_prefix}' and ending with '...{expected_message_suffix}'")
    
    # Final Assertion 1: Check for missing lines
    assert not missing_expected_lines, (
        f"The linter output is missing the following expected issues:{chr(10)}"  # Use chr(10) instead of \n
        f"{chr(10).join(missing_expected_lines)}{chr(10)}"  # Use chr(10).join() instead of '\n'.join()
        f"{chr(10)}Actual Output:{chr(10)}{actual_output}"
    )
    
    # Final Assertion 2: Check for extra lines (strict checking)
    assert found_expected_count == len(actual_lines), (
        f"The linter output reported {len(actual_lines)} issues, but only {found_expected_count} were expected.{chr(10)}"
        f"Extra output found:{chr(10)}{actual_output}"
    )

@when('I cd to "{directory}"')
def step_impl(context: Context, directory: str):
    """
    Changes the current working directory.
    """
    
    try:
        os.chdir(directory)
    except FileNotFoundError as e:
        raise FileNotFoundError(
            f"Directory not found: '{directory}'. "
            f"The absolute path attempted was: {os.path.abspath(directory)}. "
            "Please check the path relative to where you run 'behave'."
        ) from e


@when('I run `{command}`')
def step_impl(context: Context, command: str):
    """
    Runs a shell command and stores the result.
    """
    
    context.result = subprocess.run(
        command, 
        shell=True, 
        capture_output=True, 
        text=True,
        check=False
    )
    
    # Store the output for the 'Then' step
    context.stdout = context.result.stdout 
    context.stderr = context.result.stderr
    
    # Change directory back to root
    context.execute_steps(f'When I cd to "../../"')


