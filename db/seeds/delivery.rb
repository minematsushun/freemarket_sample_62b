# 送料込み
postage_included = Delivery.create(name: "送料込み(出品者負担)")
postage_included_1 = postage_included.children.create(name: "未定")
postage_included_2 = postage_included.children.create(name: "らくらくメルカリ便")
postage_included_3 = postage_included.children.create(name: "ゆうメール")
postage_included_4 = postage_included.children.create(name: "レターパック")
postage_included_5 = postage_included.children.create(name: "普通郵便(定形、定形外")
postage_included_6 = postage_included.children.create(name: "クロネコヤマト")
postage_included_7 = postage_included.children.create(name: "ゆうパック")
postage_included_8 = postage_included.children.create(name: "クリックポスト")
postage_included_9 = postage_included.children.create(name: "ゆうパケット")

# 着払い
cash_on_delivery = Delivery.create(name: "着払い(購入者負担)")
cash_on_delivery_1 = cash_on_delivery.children.create(name: "未定")
cash_on_delivery_2 = cash_on_delivery.children.create(name: "クロネコヤマト")
cash_on_delivery_3 = cash_on_delivery.children.create(name: "ゆうパック")
cash_on_delivery_4 = cash_on_delivery.children.create(name: "ゆうメール")