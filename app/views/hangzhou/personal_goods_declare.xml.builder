xml.mo(:version=>"1.0.0") do
  xml.head do
    xml.businessType("PERSONAL_GOODS_DECLAR")
  end
  xml.body do
    xml.goodsDeclareModuleList do
      xml.goodsDeclareModule do
        xml.jkfSign do
          xml.companyCode("发送方海关十位数编码")
          xml.businessNo("业务编码")
          xml.businessType("PERSONAL_GOODS_DECLAR")
          xml.declareType("1")
          xml.note("备注") #can be null
        end
        xml.goodsDeclare do
          xml.accountBookNo("账册编号") #optional
          xml.ieFlag("1")
          xml.preEntryNumber("预录入号码")
          xml.importType("进口类型") #0：一般进口, 1：保税进口
          xml.inOutDateStr("进出口日期") #格式：2014-02-18 20:33:33
          xml.iePort("进出口岸代码") #见参数表
          xml.destinationPort("指运港(抵运港)") #见参数表
          xml.trafName("运输工具名称") #包括字母和数字.可以填写中文.转关时填写@+16位转关单号. optional
          xml.voyageNo("运输工具航次(班)号") #新增，包括字母和数字，可以有中文. optional
          xml.trafMode("运输方式代码") #参照运输方式代码表(TRANSF)
          xml.declareCompanyType("申报单位类别") #个人委托电商企业申报;个人委托物流企业申报;个人委托第三方申报
          xml.declareCompanyCode("申报单位代码") #指委托申报单位代码
          xml.declareCompanyName("申报单位名称") #指委托申报单位名称
          xml.eCommerceCode("电商企业代码") 
          xml.eCommerceName("电商企业名称")
          xml.orderNo("订单编号")
          xml.wayBill("分运单号")
          xml.tradeCountry("贸易国别（起运地）") #参照国别代码表(COUNTRY)
          xml.packNo("件数") #只能有数字
          xml.grossWeight("毛重（公斤）") 
          xml.netWeight("净重（公斤）") #optional
          xml.warpType("包装种类") #参照包装种类代码表
          xml.remark("备注") #optional
          xml.declPort("申报口岸代码") #对应参数表
          xml.enteringPerson("录入人") #默认9999
          xml.enteringCompanyName("录入单位名称") #默认9999
          xml.declarantNo("报关员代码") #optional
          xml.customsField("码头/货场代码") #对应参数表
          xml.senderName("发件人")
          xml.consignee("收件人")
          xml.senderCountry("发件人国别") #参数表
          xml.senderCity("发件人城市")
          xml.paperType("支付人证件类型") #身份证（试点时期）
          xml.paperNumber("支付人证件号")
          xml.worth("价值") #只有数字，表体所有商品成交总价的和
          xml.currCode("币制")  #对应参数表
          xml.mainGName("主要货物名称")  #可以数字和字母或者中文
          xml.internalAreaCompanyNo("区内企业编码") #optional
          xml.internalAreaCompanyName("区内企业名称") #optional
          xml.applicationFormNo("申请单编号") #optional
          xml.isAuthorize("1")
        end
        xml.goodsDeclareDetails do
          #@goods.each do |good|
          xml.goodsDeclareDetail do
            xml.goodsOrder("商品序号")
            xml.codeTs("行邮税号")
            xml.goodsItemNo("商品货号")
            xml.goodsName("物品名称")
            xml.goodsModel("商品规格、型号")
            xml.originCountry("产销国") #参照国别代码表(COUNTRY)
            xml.tradeCurr("成交币制") #参照币制代码表(CURR)
            xml.tradeTotal("成交总价") 
            xml.declPrice("申报单价")
            xml.declTotalPrice("申报总价")
            xml.useTo("用途") #参照用途代码表
            xml.declareCount("申报数量")
            xml.goodsUnit("申报计量单位") #参照计量单位代码表(UNIT)
            xml.goodsGrossWeight("商品毛重") #optional
            xml.firstUnit("第一单位") #optional
            xml.firstCount("第一数量") #optional
            xml.secondUnit("第二单位") #optional
            xml.secondCount("第二数量") #optional
            xml.productRecordNo("产品国检备案编号") #通过向国检备案获取
            xml.webSite("商品网址") #optional
          end
          #end
        end
      end
    end
  end
end