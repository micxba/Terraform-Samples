package main

import (
	"context"
	"github.com/Azure/azure-sdk-for-go/services/resources/mgmt/2019-05-01/resources"
	"github.com/Azure/go-autorest/autorest/azure/auth"
	"fmt"
)

func containsresourcegroup (find string) bool {
	// GetSettingsFromEnvironment returns EnvironmentSettings and error
	envSettings, _ := auth.GetSettingsFromEnvironment()
	// GetSubscriptionID works on EnvironmentSettings and returns a String
	subscriptionID := envSettings.GetSubscriptionID()
	fmt.Println("subscription is", subscriptionID)
	// NewGroupsClient takes the Subscription Id and create an instance of GroupsClient client. It returns a GroupsClient
	groupsClient := resources.NewGroupsClient(subscriptionID)
	// Get Authorizer creates a Authorizer configured from environment variables. It works on EnvironmentSettings and returns autorest.Authorizer and error
	authorizer, err := envSettings.GetAuthorizer()
	if err == nil {
		groupsClient.Authorizer = authorizer
		// t.log("authorizer is", groupsClient.Authorizer)
	} else {
		fmt.Println(err)
	}
	// Context carries deadlines, cancellation signals, and other request-scoped values.
	// Context is the input to groupsClient and hence it is being initialized. 
	// context.Background() returns a non-nil empty context. It is never canceled, has no values and has no deadline.
	ctx := context.Background()
	// fmt.Println("Context is", ctx)
	// groupsClient.List gets all the resource groups for a subscription. The parameters are context, filter example $filter=tagNAme eq 'tag1' and tagValue eq 'value1'. and top the number of results to return. If it is nil, it returns all results.
	// It returns GroupListResultPage and error
	groupListResultPage, err := groupsClient.List(ctx, "", nil)
	// groupListResult.Values takes GroupListResultPage and returns the slice of values for the current page or nil
	groups := groupListResultPage.Values()
	var resourcegroupName []string
	fmt.Println(len(groups), "Resource Groups in", subscriptionID)
	fmt.Println("and they are")
	for i:=0; i<len(groups); i++ {
		// fmt.Println(*groups[i].Name)
		resourcegroupName = append(resourcegroupName, *groups[i].Name)
	}
	for j:=0; j<len(resourcegroupName); j++{
		fmt.Println(resourcegroupName[j])
	}
	// fmt.Println(rgName)
	fmt.Println("attemp to finding Resource Group",find)
	// contains is a function which takes a Slice and string to find if the string exists in the slice. It returns a boolean value.
	for _, value := range resourcegroupName {
		if value==find{
			return true
		}
	}
	return false
}