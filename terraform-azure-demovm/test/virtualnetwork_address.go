package test

import (
	"context"
	"github.com/Azure/azure-sdk-for-go/services/network/mgmt/2019-09-01/network"
	"github.com/Azure/go-autorest/autorest/azure/auth"
	"fmt"
	 "os"
	 "strings"
)
// func main (){
// 	resourcegroup := "AOBLogsStorageResourceGroup"
// 	virtualnetwork := "xyz"
// 	address := virtualnetworkaddress(resourcegroup, virtualnetwork)
// 	fmt.Println(address)
// }
func virtualnetworkAddress (rg string, vn string)[]string{
	// GetSettingsFromEnvironment returns EnvironmentSettings and error
	envSettings, _ := auth.GetSettingsFromEnvironment()
	// GetSubscriptionID works on EnvironmentSettings and returns a String
	subscriptionID := envSettings.GetSubscriptionID()
	// fmt.Println("subscription is", subscriptionID)
	// NewVirtualNetworksClient takes the Subscription Id and create an instance of Client for resources. It returns a Client
	virtualnetworksClient := network.NewVirtualNetworksClient(subscriptionID)
	// Get Authorizer creates a Authorizer configured from environment variables. It works on EnvironmentSettings and returns autorest.Authorizer and error
	authorizer, err := envSettings.GetAuthorizer()
	if err == nil {
		virtualnetworksClient.Authorizer = authorizer
		// t.log("authorizer is", groupsClient.Authorizer)
	} else {
		fmt.Println(err)
	}
	// Context carries deadlines, cancellation signals, and other request-scoped values.
	// Context is the input to client and hence it is being initialized. 
	// context.Background() returns a non-nil empty context. It is never canceled, has no values and has no deadline.
	ctx := context.Background()
	virtualnetwork, err := virtualnetworksClient.Get(ctx,rg,vn,"")
	var address []string
	if err == nil {
		address = *virtualnetwork.AddressSpace.AddressPrefixes
	} else{
		fmt.Println(err)
		os.Exit(1)
	}
	return address
}
func virtualnetworkAddressCheck(expected string, actual []string) bool{
    expected = strings.Trim(expected,"[]")
	expected = strings.TrimSpace(expected)
	expected = expected[1:len(expected)-2]
	for i:=0; i<len(actual); i++ {
		// fmt.Println(actual[i])
		// fmt.Println(expected)
		if expected==actual[i] {
			return true
		}
	}
	return false
}