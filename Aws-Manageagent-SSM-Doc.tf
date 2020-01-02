
# Configuration file for Cloudwatch-agent

resource "aws_ssm_document" "Sandeep-Manageagent" {
name    		= "Sandeep-Manageagent"
document_type   = "Command"
content = <<DOC
{
  "schemaVersion": "2.2",
  "description": "Send commands to Amazon CloudWatch Agent",
  "parameters": {
    "action": {
      "description": "The action CloudWatch Agent should take.",
      "type": "String",
      "default": "configure",
      "allowedValues": [
        "configure",
        "configure (append)",
        "start",
        "status",
        "stop"
      ]
    },
    "mode": {
      "description": "Controls platform-specific default behavior such as whether to include EC2 Metadata in metrics.",
      "type": "String",
      "default": "ec2",
      "allowedValues": [
        "ec2",
        "onPremise",
        "auto"
      ]
    },
    "optionalConfigurationSource": {
      "description": "Only for 'configure' action. Store of the configuration. For CloudWatch Agent's defaults, use 'default'",
      "type": "String",
      "allowedValues": [
        "default",
        "ssm"
      ],
      "default": "ssm"
    },
    "optionalConfigurationLocation": {
      "description": "Only for 'configure' actions. Required if loading CloudWatch Agent config from other locations except 'default'. The value is like ssm parameter store name for ssm config source.",
      "type": "String",
      "default": "AmazonCloudWatch-windows",
      "allowedPattern": "[^\"]*"
    },
    "optionalRestart": {
      "description": "Only for 'configure' actions. If 'yes', restarts the agent to use the new configuration. Otherwise the new config will only apply on the next agent restart.",
      "type": "String",
      "default": "yes",
      "allowedValues": [
        "yes",
        "no"
      ]
    }
  },
  "mainSteps": [
    {
      "name": "ControlCloudWatchAgentWindows",
      "action": "aws:runPowerShellScript",
      "precondition": {
        "StringEquals": [
          "platformType",
          "Windows"
        ]
      },
      "inputs": {
        "runCommand": [
          " Set-StrictMode -Version 2.0",
          " $ErrorActionPreference = 'Stop'",
          " $Cmd = \"$Env:ProgramFiles\\Amazon\\AmazonCloudWatchAgent\\amazon-cloudwatch-agent-ctl.ps1\"",
          " if (!(Test-Path -LiteralPath \"$Cmd\")) {",
          "     Write-Output 'CloudWatch Agent not installed.  Please install it using the AWS-ConfigureAWSPackage SSM Document.'",
          "     exit 1",
          " }",
          " $Params = @()",
          " $Action = '{{action}}'",
          " if ($Action -eq 'configure') {",
          "     $Action = 'fetch-config'",
          " } elseif ($Action -eq 'configure (append)') {",
          "     $Action = 'append-config'",
          " }",
          " if ($Action -eq 'fetch-config' -Or $Action -eq 'append-config') {",
          "     $Config = '{{optionalConfigurationLocation}}'",
          "     if ('{{optionalConfigurationSource}}' -eq 'ssm') {",
          "         if (!(\"$Config\")) {",
          "             Write-Output 'SSM Parameter Store name is required when configuring from Parameter Store.'",
          "             exit 1",
          "         } else {",
          "             $Config = \"ssm:$Config\"",
          "         }",
          "     } else {",
          "         $Config = 'default'",
          "     }",
          "     $Params += ('-c', \"$Config\")",
          "     if ('{{optionalRestart}}' -eq 'yes') {",
          "         $Params += '-s'",
          "     }",
          " }",
          " $Params += ('-a', \"$Action\", '-m', '{{mode}}')",
          " Invoke-Expression \"& '$Cmd' $Params\"",
          " Set-StrictMode -Off",
          " exit $LASTEXITCODE"
        ]
      }
    } 
  ]
}
DOC
}
