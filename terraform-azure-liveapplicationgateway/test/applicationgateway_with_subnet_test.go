package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
	"time"
	// "github.com/stretchr/testify/assert"
	"github.com/gruntwork-io/terratest/modules/test-structure"
	// "github.com/Azure/azure-sdk-for-go/services/web/mgmt/2016-09-01/web/appserviceplans.go"
)
const tfDir = "../examples/applicationgateway_with_subnet"

func TestAppplan_inside_ase (t *testing.T) {
	t.Parallel()
	stage := test_structure.RunTestStage
	defer stage(t, "destroy", func(){destroy(t, tfDir)})
	stage(t, "plan", func(){plan(t, tfDir)})
	stage(t, "apply", func(){apply(t, tfDir)})
	// stage(t, "validate", func(){validate(t, tfDir)})
}
func plan (t *testing.T, dir string){
	terraformOptions := &terraform.Options{
		TerraformDir: dir,
	}
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
// func validate (t *testing.T, dir string){
// 	// GetSettingsFromEnvironment returns EnvironmentSettings and error
// 	envSettings, _ := auth.GetSettingsFromEnvironment()
// 	// GetSubscriptionID works on EnvironmentSettings and returns a String
// 	subscriptionID := envSettings.GetSubscriptionID()
// 	fmt.Println("subscription is", subscriptionID)
// 	// NewAppServicePlansClient creates an instance of the AppServicePlansClient client.
// 	// appserviceplanClient := NewAppServicePlanClient(subscriptionID)
// 	// authorizer, err := envSettings.GetAuthorizer()
// 	// if err == nil {
// 	// 	appserviceplanClient.Authorizer = authorizer
// 	// } else {
// 	// 	t.Log(err)
// 	// }
// 	// // Context carries deadlines, cancellation signals, and other request-scoped values.
// 	// // Context is the input to groupsClient and hence it is being initialized. 
// 	// // context.Background() returns a non-nil empty context. It is never canceled, has no values and has no deadline.
// 	// // ctx := context.Background()
// 	// // appserviceplanCollectionPage, err :=appserviceplanClient.List(ctx, true)
// 	// // appserviceplans := appserviceplanCollectionPage.Values()
// }
func destroy (t *testing.T, dir string){
	terraformOptions := test_structure.LoadTerraformOptions(t, tfDir)
	// Destroy after Apply and giving the Outputs
	defer terraform.Destroy(t, terraformOptions)
	// destroyAffected:=terraform.GetResourceCount(t, destroy)
	// t.Logf("The resources affected by Destroy are %v added, %v changed, %v destroyed", destroyAffected.Add, destroyAffected.Change, destroyAffected.Destroy)
	// Does Tf init and Apply. So any of the resources in the Terraform Script will be deployed and may incur cost.	
}