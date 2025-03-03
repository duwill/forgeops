import { Config } from "@pulumi/pulumi";
import { clusterProvider, primaryPool } from "./cluster";
import * as cm from "@forgerock/pulumi-cert-manager"

// Get access to stack configuration values
const config = new Config();

// Define cert-manager values
const certManagerValues: cm.ChartArgs = {
    tlsKey: config.require("tls-key"),
    tlsCrt: config.require("tls-crt"),
    clusterProvider: clusterProvider,
    cloudDnsSa: config.require("clouddns"),
    nodePoolDependency: primaryPool
}

// Deploy cert-manager
export const certManager = new cm.CertManager(certManagerValues);
