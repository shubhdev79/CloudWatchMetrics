resource "aws_cloudwatch_metric_alarm" "detection" {
  alarm_name                = "terraform-test-default"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  #threshold_metric_id       = "e1"
  threshold = "85"
  alarm_description         = "Average CPU utilization over last 10 minutes too high"
  alarm_actions = [ "${aws_sns_topic.sample_topic.arn}" ]
  insufficient_data_actions = []

  /*metric_query {
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1)"
    label       = "CPUUtilization (Expected)"
    return_data = "true"
  }*/

  metric_query {
    id          = "m1"
    return_data = "true"
    metric {
      metric_name = "CPUUtilization"
      namespace   = "AWS/EC2"
      period      = "600"
      stat        = "Average"
      unit        = "Percent"

      dimensions = {
        InstanceId = "i-XXXXXXXXXXXXX"
      }
    }
  }
}
#Recover Instance Alarm Code for StatusCheckFailed
resource "aws_cloudwatch_metric_alarm" "autorecover" {
  alarm_name          = "ec2-autorecover_statuscheck"
  namespace           = "AWS/EC2"
  evaluation_periods  = "2"
  period              = "60"
  alarm_description   = "This metric auto recovers EC2 instances"
  alarm_actions       = ["arn:aws:automate:eu-west-3:ec2:recover", "${aws_sns_topic.sample_topic.arn}" ]
  statistic           = "Minimum"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "1"
  metric_name         = "StatusCheckFailed"
  dimensions = {
      InstanceId = "i-XXXXXXXXXXXXX"
  }
}

#Instance Alarm Code for CPUUtilization for crossing [85% - WARNING Alert].
resource "aws_cloudwatch_metric_alarm" "autorecover_1" {
  alarm_name          = "ec2-autorecover_cpu-warning"
  namespace           = "AWS/EC2"
  evaluation_periods  = "2"
  period              = "60"
  alarm_description   = "Value is crossing 85%. WARNING Alert."
  alarm_actions       = [ "${aws_sns_topic.sample_topic.arn}" ]
  ok_actions          = [ "${aws_sns_topic.sample_topic.arn}" ]
  insufficient_data_actions = [ "${aws_sns_topic.sample_topic.arn}" ]
  statistic           = "Minimum"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "85"
  metric_name         = "CPUUtilization"
  dimensions = {
      InstanceId = "i-XXXXXXXXXXXXX"
  }
}
#Instance Alarm Code for CPUUtilization for crossing [90% - CRITICAL Alert].
resource "aws_cloudwatch_metric_alarm" "autorecover_2" {
  alarm_name          = "ec2-autorecover_cpu_critical"
  namespace           = "AWS/EC2"
  evaluation_periods  = "2"
  period              = "60"
  alarm_description   = "Value is crossing 90%. CRITICAL Alert. Perform some action to reduce."
  alarm_actions       = [ "${aws_sns_topic.sample_topic.arn}" ]
  ok_actions          = [ "${aws_sns_topic.sample_topic.arn}" ]
  insufficient_data_actions = [ "${aws_sns_topic.sample_topic.arn}" ]
  statistic           = "Minimum"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "90"
  metric_name         = "CPUUtilization"
  dimensions = {
      InstanceId = "i-XXXXXXXXXXXXX"
  }
}

resource "aws_cloudwatch_metric_alarm" "detection_1" {
  alarm_name                = "terraform-Custom-metric"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  #threshold_metric_id       = "e1"
  threshold = "50"
  alarm_description         = "This metric monitors ec2 memory utilization"
  alarm_actions = [ "${aws_sns_topic.sample_topic.arn}" ]
  insufficient_data_actions = []


  /*metric_query {
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1)"
    label       = "Memory % Committed Bytes In Use (Expected)"
    return_data = "true"
  }*/

  metric_query {
    id          = "m2"
    return_data = "true"
    metric {
      metric_name = "Memory % Committed Bytes In Use"
      namespace   = "CWAgent"
      period      = "60"
      stat        = "Average"
      dimensions = {
        InstanceId = "i-XXXXXXXXXXXXX"
        ImageId = "ami-XXXXXXXXXXXXX"
        InstanceType = "t3.xlarge"
        objectname = "Memory"
      }
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "detection_2" {
  alarm_name                = "terraform-Custom-metric-disk"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  #threshold_metric_id       = "e1"
  threshold = "70"
  alarm_description         = "This metric monitors ec2 disk utilization"
  alarm_actions = [ "${aws_sns_topic.sample_topic.arn}" ]
  insufficient_data_actions = []


  /*metric_query {
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1)"
    label       = "Memory % Committed Bytes In Use (Expected)"
    return_data = "true"
  }*/

  metric_query {
    id          = "m2"
    return_data = "true"
    metric {
      metric_name = "LogicalDisk % Free Space"
      namespace   = "CWAgent"
      period      = "60"
      stat        = "Average"
    
      dimensions = {
        InstanceId = "i-XXXXXXXXXXXXX"
        ImageId = "ami-XXXXXXXXXXXXX"
        InstanceType = "t3.xlarge"
        objectname = "LogicalDisk"
        instance = "C:"
      }
    }
  }
}
