<?php
class Zukauskas_Accounting_Adminhtml_Block_Sales_Order_Totals extends Mage_Adminhtml_Block_Sales_Order_Totals
{
    /**
     * Initialize order totals array
     *
     * @return Mage_Sales_Block_Order_Totals
     */
    protected function _initTotals()
    {
        parent::_initTotals();
        $amount = INSURANCE_FEE;
        if ($amount) {
            $this->addTotalBefore(new Varien_Object(array(
                'code'      => 'turnkeye_insurance',
                'value'     => $amount,
                'base_value'=> $amount,
                'label'     => $this->helper('turnkeye_insurance')->__('Insurance'),
            ), array('shipping', 'tax')));
        }

        return $this;
    }

}