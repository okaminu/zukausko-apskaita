<?php
//IndexController is the default controller
//EG: http://localhost/spinonesolutions/
//Notice there's no parameters being passed as a parameter (Nothing after trailing "/")
//IndexController will be called since it's the default.
//"spinonesolutions" is the frontname as defined in confg.xml
class Zukauskas_Accounting_IndexController extends Mage_Core_Controller_Front_Action {
    //indexAction is the default Action for any controller
    function indexAction() {
        echo "indexAction";
        $accounting = Mage::getModel("zukauskas_accounting/accounting");
        $accounting->helloworld('aaaa');
    }
}