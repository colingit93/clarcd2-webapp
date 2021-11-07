az login --tenant db9bb29f-b9ec-4a37-81d4-5cf38b748984
az resource delete --resource-group CLARCD2_Jochum --name jochumclarcd-pe3rjptmp52s4 --resource-type "Microsoft.Web/sites"
az deployment group create -f ./webdeployment.bicep -g CLARCD2_Jochum