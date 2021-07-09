require 'json'

class PayloadParser
  def initialize(file_path)
    serialized_data = File.read(file_path)
    @payload = JSON.parse(serialized_data)
  end

  def get_order
    {
      "externalCode": @payload["id"].to_s,
      "storeId": @payload["store_id"],
      "subTotal": @payload["total_amount"].to_s,
      "deliveryFee": @payload["total_shipping"].to_s,
      "total_shipping": @payload["total_shipping"],
      "total": @payload["total_amount_with_shipping"].to_s,
      "country": @payload["shipping"]["receiver_address"]["country"]["id"],
      "state": @payload["shipping"]["receiver_address"]["state"]["name"],
      "city": @payload["shipping"]["receiver_address"]["city"]["name"],
      "district": @payload["shipping"]["receiver_address"]["neighborhood"]["name"],
      "street": @payload["shipping"]["receiver_address"]["street_name"],
      "complement": @payload["shipping"]["receiver_address"]["comment"],
      "latitude":  @payload["shipping"]["latitude"],
      "longitude":  @payload["shipping"]["longitude"],
      "dtOrderCreate": @payload["date_created"],
      "postalCode": @payload["shipping"]["receiver_address"]["zip_code"],
      "number": @payload["shipping"]["receiver_address"]["street_number"],
      "customer": {
          "externalCode": @payload["buyer"]["id"].to_s,
          "name": @payload["buyer"]["nickname"],
          "email": @payload["buyer"]["email"],
          "contact": "#{@payload['buyer']['phone']['area_code']}#{@payload['buyer']['phone']['number']}"
      },
      "items": [
          {
              "externalCode": @payload["order_items"][0]["id"],
              "name": @payload["order_items"][0]["title"],
              "price": @payload["order_items"][0]["unit_price"],
              "quantity": @payload["order_items"][0]["quantity"],
              "total": @payload["order_items"][0]["full_unit_price"],
              "subItems": []
          }
      ],
      "payments": [
          {
              "type": @payload["payments"][0]["payment_type"],
              "value": @payload["payments"][0]["installment_amount"]
          }
      ]
    }
  end

end