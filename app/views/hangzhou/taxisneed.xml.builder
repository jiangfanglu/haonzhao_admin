xml.mo(:version=>"1.0.0") do
  xml.head do
    xml.businessType("TAXISNEED")
  end
  xml.body do
    xml.jkfSign do
      xml.companyCode("接收方企业代码")
      xml.businessNo("运单号")
      xml.businessType("TAXISNEED")
    end
     xml.jkfTaxIsNeedDto do
        xml.personalGoodsFormNo("个人物品申报单号")
        xml.taxAmount("支付交易号")
        xml.isNeed("税款划转指令")
      end 
  end
end