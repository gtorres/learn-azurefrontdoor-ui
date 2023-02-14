az deployment group create -g rg-test -n dep-test-$date -f ./staticSite.bicep -p stage=learn siteName=test-site siteLocation=westus2 sku=Free skuCode=Free
