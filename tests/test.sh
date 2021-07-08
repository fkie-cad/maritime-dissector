#!/bin/sh

echo "Run initial checks before installation..."
echo

# Check if dependencies are installed and exit if not.
echo "Check if dependencies are installed..."
has_tshark=$(command -v tshark)
has_python3=$(command -v python3)
has_pytest3=$(command -v py.test-3)
has_lua=$(command -v lua)
has_luacov=$(command -v luacov)
has_luacovconsole=$(command -v luacov-console)
if [ ! $has_tshark ]; then
    echo "ERROR: tshark could not be found."
    echo "Please install tshark"
    exit 1
fi
if [ ! $has_python3 ]; then
    echo "ERROR: python3 could not be found."
    echo "Please install python3"
    exit 1
fi
if [ ! $has_pytest3 ]; then
    echo "ERROR: python3-pytest could not be found."
    echo "Please install python3-pytest"
    exit 1
fi
if [ ! $has_lua ]; then
    echo "ERROR: lua could not be found."
    echo "Please install lua5.2+"
    exit 1
fi
if [ ! $has_luacov ]; then
    echo "WARNING: luacov could not be found."
    echo "Please install luacov via luarocks for code coverage report"
fi
if [ ! $has_luacovconsole ]; then
    echo "WARNING: luacov-console could not be found."
    echo "Please install luacov-console via luarocks for code coverage report"
fi
echo "Success: Dependencies found. Continuing..."
echo

# Change working directory to directory of test script
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir

# Check if the dissector is already installed
WIRESHARK_PLUGIN_PATH=$HOME/.local/lib/wireshark/plugins/
if [ -f $WIRESHARK_PLUGIN_PATH/maritime-dissector.lua ] ; then
    echo
    echo "The dissector is already installed. Tests cannot be executed."
    echo "The already installed version may influence the test results."
    echo "Please uninstall the already installed version before running the tests to ensure reliable results."
    echo
    exit 1
fi


export TEST='true'
if [ $has_luacov ] && [ $has_luacovconsole ]; then
    export COVERAGETEST='true'
fi
if [ -f ./luacov.report.out ] ; then
    echo "rm luacov.report.out"
    rm ./luacov.report.out
fi
if [ -f ./luacov.report.out.index ] ; then
    echo "rm luacov.report.out.index"
    rm ./luacov.report.out.index
fi
if [ -f ./luacov.stats.out ] ; then
    echo "rm luacov.stats.out"
    rm ./luacov.stats.out
fi
py.test-3 -v

if [ $has_luacov ] && [ $has_luacovconsole ]; then
    echo
    echo "Generating code coverage report using luacov-console..."
    echo
    luacov-console ../
    luacov-console -s --no-colored
    echo
else
    echo
    echo "Cannot generate code coverage report without luacov and luacov-console."
    echo
fi
