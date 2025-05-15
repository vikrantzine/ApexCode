Public class Demo{
 public static void dm(List<Contact> conList){
 List<Account>createAcc=new List<Account>();
 Map<Contact,Account>mapOfCon = new Map<Contact,Account>();
  for(Contact con:conList){
      if(con.AccountId == NULL && con.LastName != NULL){
          Account acc=new Account();
   		  acc.Name=con.LastName;
   	 	  acc.Id=con.AccountId;
    	  createAcc.add(acc);
   	 	  mapOfCon.put(con,acc);
      }
  }
  if(!createAcc.isEmpty()){
   insert createAcc;
      for(Contact con:mapOfCon.keySet()){
          con.AccountId=mapOfCon.get(con).id;
      }
  }
 }
}