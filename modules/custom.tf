# module "configure_access_log_bucket" {
#   source              = "github.com/binhoul/terraform-aws-lambda-exec.git?ref=1.0.4"
#   name                = "ConfigureAccessLogBucket"
#   lambda_function_arn = "${aws_lambda_function.custom_resource.arn}"
#   custom_name         = "ConfigureAccessLogBucket"

#   lambda_inputs = {
#     Region                     = "${var.aws_region}"
#     AccessLogBucket            = "${var.access_log_bucket}"
#     LambdaWAFLogParserFunction = "${aws_lambda_function.log_parser.arn}"
#   }

#   lambda_outputs = []
# }

data "aws_lambda_invocation" "configure_access_log_bucket" {
  function_name = "${aws_lambda_function.custom_resource.function_name}"
  input = <<EOF
{
  "Region": "${var.aws_region}",
  "AccessLogBucket": "${var.access_log_bucket}",
  "LambdaWAFLogParserFunction": "${aws_lambda_function.log_parser.arn}"
}
EOF
}

# module "configure_rate_based_rule" {
#   source              = "github.com/binhoul/terraform-aws-lambda-exec.git?ref=1.0.4"
#   name                = "ConfigureRateBasedRule"
#   lambda_function_arn = "${aws_lambda_function.custom_resource.arn}"
#   custom_name         = "ConfigureRateBasedRule"

#   lambda_inputs = {
#     StackName        = " ${var.stack_name}"
#     RequestThreshold = "${var.request_threshold}"
#     MetricNamePrefix = "${var.waf_prefix}"
#   }

#   lambda_outputs = [
#     "RateBasedRuleId",
#   ]
# }

# data "aws_lambda_invocation" "configure_rate_based_rule" {
#   function_name = "${aws_lambda_function.custom_resource.function_name}"
#   input = <<EOF
# {
#   "StackName": "${var.stack_name}",
#   "RequestThreshold": "${var.request_threshold}",
#   "MetricNamePrefix": "${var.waf_prefix}"
# }
# EOF
# }

# module "configure_web_acl" {
#   source              = "github.com/binhoul/terraform-aws-lambda-exec.git?ref=1.0.4"
#   name                = "ConfigureWebAcl"
#   lambda_function_arn = "${aws_lambda_function.custom_resource.arn}"
#   custom_name         = "ConfigureWebAcl"

#   lambda_inputs = {
#     SqlInjectionProtectionActivated       = "${var.sql_injection_protection_activated}"
#     CrossSiteScriptingProtectionActivated = "${var.cross_site_scripting_protection_activated}"
#     HttpFloodProtectionActivated          = "${var.http_flood_protection_activated}"
#     ScannersProbesProtectionActivated     = "${var.scanner_probe_protection_activated}"
#     ReputationListsProtectionActivated    = "${var.reputation_lists_protection_activated}"
#     BadBotProtectionActivated             = "${var.bad_bot_protection_activated}"

#     # AWS WAF Web ACL
#     WAFWebACL = "${local.waf_web_acl}"

#     # AWS WAF Rules
#     WAFWhitelistRule         = "${aws_waf_rule.waf_whitelist.id}"
#     WAFBlacklistRule         = "${aws_waf_rule.waf_blacklist.id}"
#     WAFSqlInjectionRule      = "${aws_waf_rule.waf_sql_injection.id}"
#     WAFXssRule               = "${aws_waf_rule.waf_xss.id}"
#     #RateBasedRule            = "${module.configure_rate_based_rule.result["RateBasedRuleId"]}"
#     RateBasedRule            = "${data.aws_lambda_invocation.configure_rate_based_rule.result_map["rule_id"]}"
#     WAFScannersProbesRule    = "${aws_waf_rule.waf_scanner_probe.id}"
#     WAFIPReputationListsRule = "${aws_waf_rule.waf_reputation.id}"
#     WAFBadBotRule            = "${aws_waf_rule.waf_bad_bot.id}"

#     # AWS WAF IP Sets
#     WAFWhitelistSet       = "${aws_waf_ipset.waf_whitelist_set.id}"
#     WAFBlacklistSet       = "${aws_waf_ipset.waf_blacklist_set.id}"
#     WAFScannersProbesSet  = "${aws_waf_ipset.waf_scanner_probe_set.id}"
#     WAFReputationListsSet = "${aws_waf_ipset.waf_reputation_set.id}"
#     WAFBadBotSet          = "${aws_waf_ipset.waf_bad_bot_set.id}"

#     # Extra Info
#     UUID                   = "${random_uuid.uuid.result}"
#     Region                 = "${var.aws_region}"
#     RequestThreshold       = "${var.request_threshold}"
#     ErrorThreshold         = "${var.error_threshold}"
#     WAFBlockPeriod         = "${var.waf_block_period}"
#     SendAnonymousUsageData = "${var.send_anonymous_usage_data}"
#   }

#   lambda_outputs = []
# }

# module "populate_reputation_list" {
#   source              = "github.com/binhoul/terraform-aws-lambda-exec.git?ref=1.0.4"
#   name                = "PopulateReputationList"
#   lambda_function_arn = "${aws_lambda_function.custom_resource.arn}"
#   custom_name         = "PopulateReputationList"

#   lambda_inputs = {
#     Region                                 = "${var.aws_region}"
#     LambdaWAFReputationListsParserFunction = "${aws_lambda_function.reputation_lists_parser.arn}"
#     WAFReputationListsSet                  = "${aws_waf_ipset.waf_reputation_set.id}"
#   }

#   lambda_outputs = []
# }


