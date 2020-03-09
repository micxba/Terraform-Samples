package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
	"time"
	// "github.com/stretchr/testify/assert"
	"github.com/gruntwork-io/terratest/modules/test-structure"
)
const tfDir = "../examples/virtualnetwork_creating_resourcegroup"
func TestVirtualnetwork_without_resourcegroup(t *testing.T) {
	t.Parallel()
	// using stages we can run only the stages we need and skip stages by setting environment variable SKIP_<stage_name>
	stage := test_structure.RunTestStage
	defer stage(t, "destroy", func(){destroy(t, tfDir)})
	stage(t, "plan", func(){plan(t, tfDir)})
	stage(t, "apply", func(){apply(t, tfDir)})
	stage(t, "validate", func(){validate(t, tfDir)})
}

func plan (t *testing.T, dir string){
	terraformOptions := &terraform.Options{
		// Providing the directory where Terraform files are located
		TerraformDir: dir,
		//  The var file paths to pass to Terraform commands using -var-file option.
		// if there is a terraform.tfvars file then we dont have to use this explicitly
	    // VarFiles: []string{"test.tfvars"},
	}
	// Save data to disk so that other test stages can read the same data. This makes the data be consistent among statges when we use skip stage
	test_structure.SaveTerraformOptions(t, dir, terraformOptions)
	plan:=terraform.InitAndPlan(t, terraformOptions)
	planAffected:=terraform.GetResourceCount(t, plan)
	t.Logf("The Resources that need to be added are %v, changed are %v, destroyed are %v", planAffected.Add, planAffected.Change, planAffected.Destroy)
}
func apply (t *testing.T, dir string){
	terraformOptions := test_structure.LoadTerraformOptions(t, tfDir)
	apply:=terraform.InitAndApply(t, terraformOptions)
	applyAffected:=terraform.GetResourceCount(t, apply)
	t.Logf("The Resources affected by Apply are %v added, %v changed, %v destroyed", applyAffected.Add, applyAffected.Change, applyAffected.Destroy)
	time.Sleep(20 * time.Second)
	// Outputs all the Output variables defined in the outputs.tf file
	terraform.OutputAll(t, terraformOptions)
}
func validate (t *testing.T, dir string){
	terraformOptions := test_structure.LoadTerraformOptions(t, dir)
	// checking if the resource group created exists
	resourcegroupToFind:=terraform.Output(t, terraformOptions, "test_resourcegroup_name")
	// containsresourcegroup function checks if a resource group exists. It takes resource group name to find and returns a boolean value
	if Containsresourcegroup(resourcegroupToFind){
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
func destroy (t *testing.T, dir string){
	terraformOptions := test_structure.LoadTerraformOptions(t, tfDir)
	// Destroy after Apply and giving the Outputs
	defer terraform.Destroy(t, terraformOptions)
	// destroyAffected:=terraform.GetResourceCount(t, destroy)
	// t.Logf("The resources affected by Destroy are %v added, %v changed, %v destroyed", destroyAffected.Add, destroyAffected.Change, destroyAffected.Destroy)
	// Does Tf init and Apply. So any of the resources in the Terraform Script will be deployed and may incur cost.	
}
	
