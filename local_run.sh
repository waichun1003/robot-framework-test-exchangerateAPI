#!/bin/bash

# Set the number of retries
#num_retries=2

# Run the tests and save the output to a log file
robot --loglevel DEBUG --outputdir results --exclude smoke --include TestCase -N "Functional Test" tests

#
#robot --output results/001_exchange_rate.xml --log none --report none  --exclude ignore Tests/001_exchange_rate/001_get_base_currency_exchange_rate.robot
#robot --output results/002_enriched_data.xml --log none --report none  --exclude ignore Tests/002_enriched_data/002_get_the_target_currency_enriched_data.robot
#robot --output results/003_pair_conversation.xml --log none --report none  --exclude ignore Tests/003_pair_conversation/003_get_currency_pair_conversion.robot
#robot --output results/004_historical_data.xml --log none --report none  --exclude ignore Tests/004_historical_data/004_get_the_historical_exchange_rate.robot
#robot --output results/005_supported_code.xml --log none --report none  --exclude ignore Tests/005_supported_code/005_get_the_supported_codes.robot
#robot --output results/006_api_request_quota.xml --log none --report none  --exclude ignore Tests/006_api_request_quota/006_get_the_plan_quota.robot

#
#rebot --name ExchangeRate-API-RF --outputdir Results --output ExchangeRate-API-RF Results/001_exchange_rate.xml Results/002_enriched_data.xml Results/003_pair_conversation.xml Results/004_historical_data.xml Results/005_supported_code.xml Results/006_api_request_quota.xml

# Get the number of failed test cases
#num_failures=$(grep -c 'FAIL' results/test.log)
#
#If there were any failures, rerun the tests up to the specified number of retries
#if [ $num_failures -gt 0 ]
#then
#    echo "There were $num_failures test failures. Rerunning tests..."
#    for i in $(seq 1 $num_retries)
#    do
#        robot --rerunfailed results/output.xml --outputdir results --exclude smoke --include Test Case -N "Functional Test" tests > test.log
#        num_failures=$(grep -c 'FAIL' results/test.log)
#        if [ $num_failures -eq 0 ]
#        then
#            break
#        fi
#    done
#fi

# Print the final results
#robot --loglevel DEBUG:INFO --outputdir results --exclude smoke --include Test Case -N "Functional Test" tests