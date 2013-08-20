<?php
class Zukauskas_Accounting_Model_Accounting extends Varien_Object {
    function __construct() {
        parent::__construct();
    }

    function helloworld($arg) {
        echo "<br>Hello World! My argument is : " . $arg;
        error_reporting(E_ALL | E_STRICT);
        $mageFilename = 'app/Mage.php';
        require_once $mageFilename;
        Mage::setIsDeveloperMode(true);
        umask(0);
        Mage::app();
        Mage::app()->setCurrentStore(Mage::getModel('core/store')->load(Mage_Core_Model_App::ADMIN_STORE_ID));

        $setup = new Mage_Eav_Model_Entity_Setup('core_setup');

        try {
            $custAttr = 'website_id';  // here enter your attribute name which you want to remove

            $setup->removeAttribute('customer', $custAttr);
            echo $custAttr." attribute is removed";
        }
        catch (Mage_Core_Exception $e) {
            $this->_fault('data_invalid', $e->getMessage());
        }

    }
}