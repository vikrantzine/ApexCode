trigger AccTrigger on Account (After Update) {
    AccountCls.updOppSts(trigger.new);
}