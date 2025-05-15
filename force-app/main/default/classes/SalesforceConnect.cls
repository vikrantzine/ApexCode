public class SalesforceConnect {
    public static void getCasesFromAnotherOrg(){
        // Instantiate a new Http object
        Http http = new Http();
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFDCB/services/apexrest/Cases');
		request.setMethod('GET');
        // Send the request, and return a response
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            List<Object> results = (List <Object>)JSON.deserializeUntyped(response.getBody());
            for(Object result:results){
                Map<String, Object> caseProps=(Map<String, Object>)result;
                System.debug('CaseNumber:'+caseProps.get('CaseNumber')+'- Subject:'+caseProps.get('Subject'));
            }
        }
	}
    public static void createCasesFromAnotherOrg(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFDCB/services/apexrest/Cases');
		request.setMethod('POST');
        request.setHeader('Content-Type' , 'application/json;charset=UTF-8');
        request.setBody('{"subject":"Case From Salesfroce Org A","status":"New","origin":"Web","priority":"Medium"}');
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        if(response.getStatusCode() == 200){
            System.debug(response.getBody());
 	   }
    }
}