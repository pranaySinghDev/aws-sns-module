package rules.pubsub_messaging_topics_organisation_key

__rego__metadoc__ := {
	"custom": {
		"controls": {
			"PubSub": [
				"PubSub_1.0"
			]
		},
		"severity": "Medium"
	},
	"description": "Document: Technology Engineering - PubSub - Best Practice - Version: 1",
	"id": "1.0",
	"title": "PubSub messaging topics should be encrypted using organisation standard key",
}

# Please write your OPA rule here
resource_type := "aws_sns_topic"

default allow = false

allow {
    input.kms_master_key_id != ""
}



