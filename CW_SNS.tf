resource "aws_sns_topic" "sample_topic" {
  name = "voice-vault_topic"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
      provisioner "local-exec" {
      command = "aws sns subscribe --region eu-west-3 --topic-arn ${self.arn} --protocol email --notification-endpoint XXXXXXXXXXXXX@X.com"
}
}
