package test

import (
	"context"
	"github.com/Azure/azure-sdk-for-go/services/resources/mgmt/2019-05-01/resources"
	"github.com/Azure/go-autorest/autorest/azure/auth"
	"fmt"
)

func containsresource (rg string, find string) bool {
	// GetSettingsFromEnvironment returns EnvironmentSettings and error
	envSettings, _ := auth.GetSettingsFromEnvironment()
	// GetSubscriptionID works on EnvironmentSettings and returns a String
	subscriptionID := envSettings.GetSubscriptionID()
	fmt.Println("subscription is", subscriptionID)
	// NewClient takes the Subscription Id and create an instance of Client for resources. It returns a Client
	client := resources.NewClient(subscriptionID)
	// Get Authorizer creates a Authorizer configured from environment variables. It works on EnvironmentSettings and returns autorest.Authorizer and error
	authorizer, err := envSettings.GetAuthorizer()
	if err == nil {
		client.Authorizer = authorizer
		// t.log("authorizer is", groupsClient.Authorizer)
	} else {
		fmt.Println(err)
	}
	// Context carries deadlines, cancellation signals, and other request-scoped values.
	// Context is the input to client and hence it is being initialized. 
	// context.Background() returns a non-nil empty context. It is never canceled, has no values and has no deadline.
	ctx := context.Background()
	// fmt.Println("Context is", ctx)
	//client.ListByResourceGroup gets all the resourcess in a resource group. 
	// The parameters are context, resource group, 
	// filter - the filter to apply on the operation.<br><br>The properties you can use for eq (equals) or ne (not
	// equals) are: location, resourceType, name, resourceGroup, identity, identity/principalId, plan,
	// plan/publisher, plan/product, plan/name, plan/version, and plan/promotionCode.<br><br>For example, to filter
	// by a resource type, use: $filter=resourceType eq 'Microsoft.Network/virtualNetworks'<br><br>You can use
	// substringof(value, property) in the filter. The properties you can use for substring are: name and
	// resourceGroup.<br><br>For example, to get all resources with 'demo' anywhere in the name, use:
	// $filter=substringof('demo', name)<br><br>You can link more than one substringof together by adding and/or
	// operators.<br><br>You can filter by tag names and values. For example, to filter for a tag name and value,
	// use $filter=tagName eq 'tag1' and tagValue eq 'Value1'<br><br>You can use some properties together when
	// filtering. The combinations you can use are: substringof and/or resourceType, plan and plan/publisher and
	// plan/name, identity and identity/principalId.
	// expand - the $expand query parameter. You can expand createdTime and changedTime. For example, to expand
	// both properties, use $expand=changedTime,createdTime
	// top - the number of results to return. If null is passed, returns all resources.
	// It returns ListResultPage and error
	ListResultPage, err := client.ListByResourceGroup(ctx,rg,"","",nil)
	// groupListResult.Values takes GroupListResultPage and returns the slice of values for the current page or nil
	resourcesList := ListResultPage.Values()
	var resourcesName []string
	fmt.Println(len(resourcesList), "Resources in", rg)
	fmt.Println("and they are")
	for i:=0; i<len(resourcesList); i++ {
		// fmt.Println(*groups[i].Name)
		resourcesName = append(resourcesName, *resourcesList[i].Name)
	}
	for j:=0; j<len(resourcesName); j++{
		fmt.Println(resourcesName[j])
	}
	// fmt.Println(rgName)
	fmt.Println("attempt to finding resource",find)
	// contains is a function which takes a Slice and string to find if the string exists in the slice. It returns a boolean value.
	for _, value := range resourcesName {
		if value==find{
			return true
		}
	}
	return false
}
