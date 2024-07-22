# Tests for Network Security

## Setup

To set up the test environment apply `00_setup_policy_deployment`. You may encounter the problem, that the filenames are too long. You may try to work around that by configuring long paths: `git config --global core.longpaths true`.

## Running tests

After the environment is set up you can run the tests. To run all tests that are expected successful, you can run `terraform test` in `tests\policy_definition\network_security`. 

Unfortunately terraform test doesn't support failing tests yet. So you need to run the other tests that are expected to be denied manually. 

One way to run the tests from vs code is right clicking all `*denied*` folders to `Open in integrated terminal` and then run `terraform init && terraform apply --auto-approve || terraform destroy --auto-approve`. After the resources are destroyed check that the resource was denied.