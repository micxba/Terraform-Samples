package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
)

func TestSimple(t *testing.T) {
	// Not using Parallel as it has a single test

	// Providing Address of Terraform Files
	terraformOptions := &terraform.Options{
		// Providing the directory where Terraform files are located
		TerraformDir: "../examples/resourcegroup",
		//  The var file paths to pass to Terraform commands using -var-file option.
		// if there is a terraform.tfvars file then we dont have to use this explicitly
	    VarFiles: []string{"test.tfvars"},
	}
	//  Destroy after Apply and giving the Outputs  		
	defer terraform.Destroy(t, terraformOptions)
	// Does Tf init and Apply. So any of the resources in the Terraform Script will be deployed and may incur cost.
	terraform.InitAndApply(t, terraformOptions)
	// Outputs all the Output variables defined in the outputs.tf file
	terraform.OutputAll(t, terraformOptions)
}
