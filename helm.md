# add fields to a map
when there's a map in `Values.stripe.config` and you wanna add a couple of fields:
```
        stripe.json: |-
          {{- $stripe_config := .Values.stripe.config }}
          {{- $stripe_config := set $stripe_config "publishableKey" `{{.stripe_publishable_key}}` }}
          {{- $stripe_config := set $stripe_config "secretKey" `{{.stripe_secret_key}}` }}
          {{- $stripe_config := set $stripe_config "webhookSecret" `{{.stripe_webhook_secret}}` }}
          {{ $stripe_config | toPrettyJson | nindent 10 }}
```
