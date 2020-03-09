# Terraform Module: Resource Group
-------------------------------------------------
This module  creates a Resource Group in Azure. Resource Group is usually provisioned as a container of resources. It is a good practice to tie up all the resources to a Resource Group based on thier lifecycle.

**TO Do:** 
* Have to add Authorization as well Policy module to test a Resource Group with Policy and Authorization assignments (WIP). This will cover the Integration testing for Resource group. So, There will be more nested modules for Custom RoleAssignmnet, Builtin RoleAssignment, Enforcing Policy
* Creating tests for Integration testing with Policy and authorization modules

### **Versions:**
Current Version = 0.1.0

This Repository follows Git Flow Model. The release branches and hotfix branches are to be named with the version number. For example release/0.2.0 hotfix/0.1.1, to increase the version of the module the tag on release and hotfix branches are use.

### **Inputs**:
The input arguments are required by the module to create Resource Group
```
1. name
 The name variable can be randomized according to the product specific configuration
2. location
 location specifies where to create the Resource Group.
3. tags
 Provide tags to be passed to the Resource Group
**To DO:** Some of the tags are envisoned to be enforced using Policy
```

### **Outputs:**
The Output variables can be referenced in other resources.
```
1. resourcegroup_name
This Outputs the Name of the Resource Group created

2. resourcegroup_location
This variable gives the location of the Resource Group

3. resourcegroup_id
It gices the Id of the Resource Group created.
```

### **Usage:**
```
provider "azurerm" {
  version = "=1.36.0"
}
module "Azure_ResourceGroup" {
  source   = "git::https://__PATTF__@dev.azure.com/Trial-Org/IacTF/_git/terraform-azure-ResourceGroup"
  name     = "${var.product}_${var.component}_${var.environment}_${random_id.randomid.hex}"
  location = "${var.location}"
  tags     = "${var.tags}"
}
```
`Points to Note:`
* Here the source link has PATTF for authorizing access permission to the repository. However in Pipelines we can replace that token with Pipeline Shared Variables.

* The name can be a variable or group of variables as you wish .The randomness can be added by creating a random_id resource and adding it to the name as:
  ```
    resource "random_id" "id" {
    byte_length = 4
    }
    And use the reference of random_id to be passed to the name.
    name = "<ProductName><ComponentName><Environment>${random_id.id.hex}RG"
  ```
* All the arguments are parameterized with variables that are defined in Product specific varibles files as provided in the Repository under /examples/resourcegroup/variables.tf. 

* When defining variables we can set default values so that only variables with (Required) have to be passed and the the variables with (Optional Default) in description can be skipped unless it requires something other than Default value.

* The values can be passed using .tfvars So now we can create multiple environments with multiple .tfvars file 

### **Build and Test**
 Terratest does automated Unit and Integration testing and e2e testing. And hence a Test folder is created which will contain test for unit tests of the Modules, Integration tests and e2e test.
 The Module is being tested using Azure Pipelines which has the following tasks:
 
              *  Go Installer Task with specifird version
              *  Terraform Installer Task with specified version
              *  Powershell script which does the following:
                       *  Copies files to GOENV Path
                       *  Installs Dep 
                       *  Sets environmental variables for the Service Principal 
                       *  Set the location to the test folder
                       *  Runs go test
To test this run the pipeline https://dev.azure.com/Trial-Org/IacTF/_apps/hub/ms.vss-ciworkflow.build-ci-hub?_a=edit-build-definition&id=40

**To Do:** 
* Can we have format and validate in the go test script so that we dont need to have more steps for running terraform fmt, validate and tflint.
* Converting the classic Pipeline in to YAML Pipeline.

The scripts for tests is a WIP.

The Working Unit Test for Resource Group is done and is located under /test/resourcegroup_test.go

`Points to Note:`

* If there is a resource that already exists in the portal with same name provided in the test file scripts, it will destroy it in the process if we use terraform.Destroy in the test.
Therefore it is required to add some randomness to the names of resources that the test creates.


