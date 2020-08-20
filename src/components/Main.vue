<template>
  <div class="container-fluid">
    <h2 class="text-underline copy-on-click" @click="copyToClipboard">
      <u id="ResourceName">
        <p>{{resourceName}}</p>
      </u>
    </h2>
    <p>&lt;Customer&gt;-&lt;Environment&gt;-&lt;Location&gt;-&lt;Service&gt;-&lt;InstanceNumber&gt;-&lt;Resource&gt;</p>

    <div class="row">
      <div class="col">
        <b-input v-model="customer" placeholder="Customer name..." />
      </div>
      <div class="col">
        <b-input v-model="environment" placeholder="Demo, dev, test, live..." />
      </div>
      <div class="col">
        <b-form-select v-model="location" :options="locations" text-field="name" value-field="name"></b-form-select>
      </div>
      <div class="col">
        <b-input v-model="serviceName" placeholder="Service name..." />
      </div>
      <div class="col">
        <b-input v-model="instanceNumber" placeholder="Instance number..." />
      </div>
      <div class="col">
        <b-form-select v-model="service" :options="services" text-field="name" value-field="name"></b-form-select>
      </div>
    </div>
  </div>
</template>

<script>
import _ from "lodash";
export default {
  name: "Main",

  data() {
    return {
      customer: "",
      environment: "",
      location: null,
      service: "",
      serviceName: "",
      instanceNumber: "",
      resourceType: "",
      azureConfig: {
        environments: [],
        locations: [
          {
            name: "(Asia-Pacific) East Asia (Hong Kong)",
            shortCode: "ASE",
          },
          {
            name: "(Asia-Pacific) Southeast Asia (Singapore)",
            shortCode: "ASS",
          },
          {
            name: "(Europe) North Europe (Ireland)",
            shortCode: "EUN",
          },
          {
            name: "(Europe) West Europe (Netherlands)",
            shortCode: "EUW",
          },
        ],
        services: [
          { name: "Subscription", shortCode: "sub", longCode: "sub" },
          { name: "Resource Group", shortCode: "rg", longCode: "rg" },
          { name: "Virtual Machine", shortCode: "vm", longCode: "vm" },
          { name: "Availability Set", shortCode: "avs", longCode: "avset" },
          { name: "Virtual Network", shortCode: "vn", longCode: "vnet" },
          { name: "Subnet", shortCode: "sub", longCode: "subnet" },
          { name: "Public IP Address", shortCode: "pip", longCode: "publicip" },
          {
            name: "Network Security Group",
            shortCode: "nsg",
            longCode: "Networksg",
          },
          { name: "Storage Account", shortCode: "stg", longCode: "storage" },
          { name: "TrafficManager", shortCode: "tm", longCode: "trafficmgmr" },
          { name: "Load Balancer", shortCode: "lb", longCode: "loadbalancer" },
          {
            name: "Application Gateway",
            shortCode: "agw",
            longCode: "appgateway",
          },
          { name: "App Service", shortCode: "svc", longCode: "appsvc" },
          { name: "Key Vault", shortCode: "kv", longCode: "kv" },
          { name: "App Service Plan", shortCode: "asp", longCode: "appplan" },
          { name: "Sql Database", shortCode: "sdb", longCode: "sqldatabase" },
          { name: "Sql Server", shortCode: "sql", longCode: "sqlserver" },
          { name: "Disk", shortCode: "dsk", longCode: "disk" },
          { name: "DNS Zone", shortCode: "dns", longCode: "dnszone" },
          { name: "Log Analytics", shortCode: "loa", longCode: "loganalytics" },
          { name: "Logic App", shortCode: "log", longCode: "logapp" },
          {
            name: "Network Interface",
            shortCode: "nif",
            longCode: "netinterface",
          },
        ],
        instanceNumber: [],
      },
    };
  },
  methods: {
    copyToClipboard() {
      var input = document.createElement("textarea");
      input.innerHTML = this.resourceName;
      document.body.appendChild(input);
      input.select();
      var result = document.execCommand("copy");
      document.body.removeChild(input);
      return result;
    },
  },
  computed: {
    locations() {
      return _.orderBy(this.azureConfig.locations, (d) => d.name);
    },
    services() {
      return _.orderBy(this.azureConfig.services, (d) => d.name);
    },

    resourceName() {
      let location = this.azureConfig.locations.find(
        (x) => x.name == this.location
      );
      let service = this.azureConfig.services.find(
        (x) => x.name == this.service
      );

      let arr = [
        this.customer,
        this.environment,
        location?.shortCode,
        this.serviceName,
        this.instanceNumber.length == 0
          ? ""
          : this.instanceNumber?.padStart(5, "0"),
        service?.shortCode,
        this.resourceType,
      ];
      return arr
        .filter((x) => x && x != null && x != "")
        .map((x) => x.toLowerCase().replace(/\s+/g, ""))
        .join("-");
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.copy-on-click {
  cursor: pointer;
  min-height: 60px;
}
.copy-on-click:active {
  color: #0089d6;
}
</style>
