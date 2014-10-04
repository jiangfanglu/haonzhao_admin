xml.instruct!
xml.mo(:version=>"1.0.0") do
	xml.head do
		xml.businessType("IMPORTORDER")
	end
	xml.body do
		xml.orderInfoList do
			- @orders.each do |order|
				xml.orderInfo do
					xml.jkfSign do
						xml.companyCode(HZ_COMPANY_NO)
						xml.businessNo(order.order_sn) #order number
						xml.businessType("IMPORTORDER")
						xml.declareType("1")
						xml.note("") #optional
					end
					xml.jkfOrderImportHead do
						xml.eCommerceCode(HZ_ECOMMERCE_COMPANY_NO)
						xml.eCommerceName(HZ_ECOMMERCE_COMPANY_NAME)
						xml.ieFlag("I")
						xml.payType(order.hz_order.pay_type)
						xml.payCompanyCode(order.hz_order.pay_company_code)
						xml.payNumber(order.hz_order.pay_number)
						xml.orderTotalAmount(order.total)
						xml.orderNo(order.order_sn)
						xml.orderTaxAmount(order.order_totals.where("code = 'tax'").sum("value").to_f) #according to goods amount, can be 0
						xml.orderGoodsAmount(order.order_totals.where("code = 'sub_total'").sum("value").to_f) 
						xml.feeAmount(order.order_totals.where("code = 'shipping'").sum("value").to_f) #can be 0, optional
						xml.companyName(HZ_COMPANY_NO)
						xml.companyCode(HZ_ECOMMERCE_COMPANY_NO)
						xml.tradeTime(order.date_added.strftime("%Y-%m-%d %H:%M:%S")) #格式：2014-02-18 20:33:33
						xml.currCode(order.hz_order.currency_code) #见参数表
						xml.totalAmount(order.total)
						xml.consigneeEmail(order.email)
						xml.consigneeTel(order.telephone)
						xml.consignee(order.firstname)
						xml.consigneeAddress("#{order.shipping_country}#{order.shipping_zone}#{order.shipping_city}#{order.shipping_address_1}")
						xml.totalCount(order.order_products.sum("oc_order_product.quantity"))
						xml.postMode(order.hz_order.post_mode) #见参数表
						xml.senderCountry(order.hz_order.sender_country) #见参数表
						xml.senderName(order.hz_order.sender_name)
						xml.purchaserId(order.customer_id)
						xml.logisCompanyName(order.hz_order.logistic_company_name)
						xml.logisCompanyCode(order.hz_order.logistic_company_code)
						xml.zipCode(order.shipping_postcode) #optional
						xml.note("") #optional
						xml.wayBills(order.hz_order.way_bills) #optional
					end
					xml.jkfOrderDetailList do
						@order.order_products.each do |order_product|
							xml.jkfOrderDetail do 
								xml.goodsOrder(order_product.product_id)
								xml.goodsName(order_product.name)
								xml.goodsModel(order_product.model) #optional
								xml.codeTs(order_product.product.hz_product.post_tax_no) #必须已备案，且与 参数说明文档中的行邮税号 中的税号一致
								xml.grossWeight(order_product.product.weight) #optional
								xml.unitPrice(order_product.price)
								xml.goodsUnit(order_product.product.hz_product.unit_code) #见参数表
								xml.goodsCount(order_product.quantity)
								xml.originCountry(order_product.product.shop.hz_manufacturer.hz_country_code) #见参数表
							end
						end
					end
					xml.jkfGoodsPurchaser do
						xml.id(order.customer_id)
						xml.name(order.firstname)
						xml.email(order.email) #optional
						xml.telNumber(order.telephone)
						xml.address("#{order.shipping_country}#{order.shipping_zone}#{order.shipping_city}#{order.shipping_address_1}")
						xml.paperType(order.cutomer.user.customer_identifications.identity_type) 
						xml.paperNumber(order.cutomer.user.customer_identifications.identity_no)
					end
				end
			end
		end
	end  
end
