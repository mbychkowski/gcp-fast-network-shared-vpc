/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# tfdoc:file:description Production spoke DNS zones and peerings setup.

# GCP-specific environment zone

module "prod-dns-private-zone" {
  source = "git@github.com:mbychkowski/gcp-fast-modules.git//dns"
  project_id      = module.prod-spoke-project.project_id
  type            = "private"
  name            = "prod-gcp-example-com"
  domain          = "prod.gcp.example.com."
  client_networks = [module.prod-spoke-vpc.self_link]
  recordsets = {
    "A localhost" = { type = "A", ttl = 300, records = ["127.0.0.1"] }
  }
}

module "prod-onprem-example-dns-forwarding" {
  source = "git@github.com:mbychkowski/gcp-fast-modules.git//dns"
  project_id      = module.prod-spoke-project.project_id
  type            = "forwarding"
  name            = "example-com"
  domain          = "onprem.example.com."
  client_networks = [module.prod-spoke-vpc.self_link]
  forwarders      = { for ip in var.dns.prod : ip => null }
}

module "prod-reverse-10-dns-forwarding" {
  source = "git@github.com:mbychkowski/gcp-fast-modules.git//dns"
  project_id      = module.prod-spoke-project.project_id
  type            = "forwarding"
  name            = "root-reverse-10"
  domain          = "10.in-addr.arpa."
  client_networks = [module.prod-spoke-vpc.self_link]
  forwarders      = { for ip in var.dns.prod : ip => null }
}


module "prod-googleapis-private-zone" {
  source = "git@github.com:mbychkowski/gcp-fast-modules.git//dns"
  project_id      = module.prod-spoke-project.project_id
  type            = "private"
  name            = "googleapis-com"
  domain          = "googleapis.com."
  client_networks = [module.prod-spoke-vpc.self_link]
  recordsets = {
    "A private" = { type = "A", ttl = 300, records = [
      "199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"
    ] }
    "A restricted" = { type = "A", ttl = 300, records = [
      "199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"
    ] }
    "CNAME *" = { type = "CNAME", ttl = 300, records = ["private.googleapis.com."] }
  }
}
