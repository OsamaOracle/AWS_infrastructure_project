### region
"us-east-1"

### name_prefix
name prefix to use when creating resources

### tags

### rules 
WAF rules. e.g:
```hcl
rules = [
  {
    name     = "blacklist"
    priority = "0"
    action   = "block"
    ip_set_reference_statement = {
      arn = ""
    }
    visibility_config = {
      cloudwatch_metrics_enabled = true
      metric_name                = "blacklist"
      sampled_requests_enabled   = true
    }
  },
  {
    name     = "AWS-AWSManagedRulesAdminProtectionRuleSet"
    priority = "1"

    override_action = "none"

    managed_rule_group_statement = {
      name        = "AWSManagedRulesAdminProtectionRuleSet"
      vendor_name = "AWS"
    }
    visibility_config = {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesAdminProtectionRuleSet"
      sampled_requests_enabled   = true
    }
  }
]
```

### visibility_config
visibility_config for WAF, e.g:
```hcl
visibility_config = {
  cloudwatch_metrics_enabled = true
  metric_name                = "waf-setup-waf-main-metrics"
  sampled_requests_enabled   = true
}
```

### create_alb_association
Associate WAF
alb_arn                = ""
add_blacklist_rule     = true
blacklist_ips          = ["10.1.1.1/32"]