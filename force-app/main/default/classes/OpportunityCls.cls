public class OpportunityCls {
    public static void createOppChilds() {
        List<Opportunity> oppList = new List<Opportunity>();
        for (Integer i = 1; i <= 150; i++) {
            Opportunity opp = new Opportunity(Name = 'Opp' + i,StageName='Prospecting',CloseDate=System.today());
            oppList.add(opp);
        }
        insert oppList;
        for (Integer i = 1; i <= 150; i++) {
            Opportunity childOpp = oppList[i - 1];
            if (i == 1) {
                childOpp.Parent_Opportunity__c = null;
            } else if (i == 2 || i == 3) {
                childOpp.Parent_Opportunity__c = oppList[0].Id;
            } else if (Math.mod(i,2)==0) {
                childOpp.Parent_Opportunity__c = oppList[(i / 2) - 1].Id;
            } else if (Math.mod(i,2)!=0 && i != 3) {
                childOpp.Parent_Opportunity__c = oppList[(i / 2)].Id;
            }
        }
        update oppList;
    }
}