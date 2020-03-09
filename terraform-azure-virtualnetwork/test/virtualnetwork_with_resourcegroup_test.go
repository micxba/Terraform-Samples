package main

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
	"time"
)
func TestVirtualnetwork_with_resourcegroup(t *testing.T) {
	// Not using Parallel as it has a single test
	// Providing Address of Terraform Files
	terraformOptions := &terraform.Options{
		// Providing the directory where Terraform files are located
		TerraformDir: "../examples/virtualnetwork_with_resourcegroup",
		//  The var file paths to pass to Terraform commands using -var-file option.
		// if there is a terraform.tfvars file then we dont have to use this explicitly
	    // VarFiles: []string{"test.tfvars"},
	}
	//  Destroy after Apply and giving the Outputs
	defer terraform.Destroy(t, terraformOptions)
	// destroyAffected:=terraform.GetResourceCount(t, destroy)
	// t.Logf("The resources affected by Destroy are %v added, %v changed, %v destroyed", destroyAffected.Add, destroyAffected.Change, destroyAffected.Destroy)
	// Does Tf init and Apply. So any of the resources in the Terraform Script will be deployed and may incur cost.
	plan:=terraform.InitAndPlan(t, terraformOptions)
	planAffected:=terraform.GetResourceCount(t, plan)
	t.Logf("The Resources that need to be added are %v, changed are %v, destroyed are %v", planAffected.Add, planAffected.Change, planAffected.Destroy)
	apply:=terraform.InitAndApply(t, terraformOptions)
	applyAffected:=terraform.GetResourceCount(t, apply)
	t.Logf("The Resources affected by Apply are %v added, %v changed, %v destroyed", applyAffected.Add, applyAffected.Change, applyAffected.Destroy)
	time.Sleep(20 * time.Second)
	// Outputs all the Output variables defined in the outputs.tf file
	terraform.OutputAll(t, terraformOptions)
	resourcegroupToFind:=terraform.Output(t, terraformOptions, "test_virtualnetwork_rg_name")
	// containsresourcegroup function checks if a resource group exists. It takes resource group name to find and returns a boolean value
	if containsresourcegroup(resourcegroupToFind){
		t.Log("Resource Group", resourcegroupToFind,"found")
	}else {
		// t.Log(resourcegroupToFind,"not found")
		t.Fatal("ResourceGroup", resourcegroupToFind,"not found")
	}	
	virtualnetworkToFind:= terraform.Output(t, terraformOptions, "test_virtualnetwork_vnet_name")
	// containsresource checks if a resource exist in a resource group. It takes resource grouop name and resource name. It returns a boolean value
	if containsresource (resourcegroupToFind,virtualnetworkToFind){
		t.Logf("Vitual Network %v found in %v", virtualnetworkToFind, resourcegroupToFind)
	} else {
		t.Fatalf("Virtual Network %v not found in %v", virtualnetworkToFind,resourcegroupToFind)
	}
	virtualnetworkAddressExpected := terraform.Output(t, terraformOptions, "test_virtualnetwork_vnet_address_space")
	virtualnetworkAddressActual := virtualnetworkAddress(resourcegroupToFind,virtualnetworkToFind)
 	if virtualnetworkAddressCheck(virtualnetworkAddressExpected,virtualnetworkAddressActual)==false{
		 t.Fail()
	 }else {
		 t.Log("Same Address Space")
	 }
 }