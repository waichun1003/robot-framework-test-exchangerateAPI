robot --output Results/001_exchange_rate.xml --log none --report none  --exclude ignore Tests\001_exchange_rate\001_get_base_currency_exchange_rate.robot
robot --output Results/002_enriched_data.xml --log none --report none  --exclude ignore Tests\002_enriched_data\002_get_the_target_currency_enriched_data.robot
robot --output Results/003_pair_conversation.xml --log none --report none  --exclude ignore Tests\003_pair_conversation\003_get_currency_pair_conversion.robot
robot --output Results/004_historical_data.xml --log none --report none  --exclude ignore Tests\004_historical_data\004_get_the_historical_exchange_rate.robot
robot --output Results/005_supported_code.xml --log none --report none  --exclude ignore Tests\005_supported_code\005_get_the_supported_codes.robot
robot --output Results/006_api_request_quota.xml --log none --report none  --exclude ignore Tests\006_api_request_quota\006_get_the_plan_quota.robot

rebot --name ExchangeRate-API-RF --outputdir Results --output ExchangeRate-API-RF Results/001_exchange_rate.xml Results/002_enriched_data.xml Results/003_pair_conversation.xml Results/004_historical_data.xml Results/005_supported_code.xml Results/006_api_request_quota.xml