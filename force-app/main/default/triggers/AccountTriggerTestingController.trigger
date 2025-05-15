trigger AccountTriggerTestingController on Account (after insert, after update) {
    WelcomeController ec=new WelcomeController();
}