#!/bin/bash

curl -H "Content-Type: application/json" -d '[
  {
    "labels": {
      "alertname": "TestYahooAlert",
      "severity": "critical"
    },
    "annotations": {
      "summary": "Testing Yahoo Mail Alerting!",
      "description": "Test test test"
    }
  }
]' http://localhost:9093/api/v2/alerts

echo -e "\n\n ! SENT ! Check Alertmanager (http://localhost:9093) and Yahoo email."
