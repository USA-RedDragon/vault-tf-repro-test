locals {
  file_value = ["val1", "val2", "val3", "val4"]
}

data "http" "cert_dynamic" {
  for_each = toset("${local.file_value}")
  url = "http://127.0.0.1:8000/v1/secret/${each.value}"
  request_headers = {
    X-Vault-Token="xxxxxxx"
  }
}

output "val1" {
  value = jsondecode(data.http.cert_dynamic["val1"].response_body).data["foo"]
}
