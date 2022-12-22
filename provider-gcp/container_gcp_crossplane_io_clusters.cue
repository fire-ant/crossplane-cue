package container_gcp_crossplane_io_clusters

customresourcedefinition: "clusters.container.gcp.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.2"
		creationTimestamp: null
		name:              "clusters.container.gcp.crossplane.io"
	}
	spec: {
		group: "container.gcp.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"gcp",
			]
			kind:     "Cluster"
			listKind: "ClusterList"
			plural:   "clusters"
			singular: "cluster"
		}
		scope: "Cluster"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.conditions[?(@.type=='Ready')].status"
				name:     "READY"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type=='Synced')].status"
				name:     "SYNCED"
				type:     "string"
			}, {
				jsonPath: ".status.atProvider.status"
				name:     "STATE"
				type:     "string"
			}, {
				jsonPath: ".status.atProvider.endpoint"
				name:     "ENDPOINT"
				type:     "string"
			}, {
				jsonPath: ".spec.forProvider.location"
				name:     "LOCATION"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1beta2"
			schema: openAPIV3Schema: {
				description: "A Cluster is a managed resource that represents a Google Kubernetes Engine cluster."

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "A ClusterSpec defines the desired state of a Cluster."
						properties: {
							deletionPolicy: {
								default:     "Delete"
								description: "DeletionPolicy specifies what will happen to the underlying external when this managed resource is deleted - either \"Delete\" or \"Orphan\" the external resource."

								enum: [
									"Orphan",
									"Delete",
								]
								type: "string"
							}
							forProvider: {
								description: "ClusterParameters define the desired state of a Google Kubernetes Engine cluster. Most of its fields are direct mirror of GCP Cluster object. See https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1/projects.locations.clusters#Cluster"

								properties: {
									addonsConfig: {
										description: "AddonsConfig: Configurations for the various addons available to run in the cluster."

										properties: {
											cloudRunConfig: {
												description: "CloudRunConfig: Configuration for the Cloud Run addon. The `IstioConfig` addon must be enabled in order to enable Cloud Run addon. This option can only be enabled at cluster creation time."

												properties: {
													disabled: {
														description: "Disabled: Whether Cloud Run addon is enabled for this cluster."

														type: "boolean"
													}
													loadBalancerType: {
														description: """
		LoadBalancerType: Which load balancer type is installed for Cloud Run. 
		 Possible values: \"LOAD_BALANCER_TYPE_UNSPECIFIED\" - Load balancer type for Cloud Run is unspecified. \"LOAD_BALANCER_TYPE_EXTERNAL\" - Install external load balancer for Cloud Run. \"LOAD_BALANCER_TYPE_INTERNAL\" - Install internal load balancer for Cloud Run.
		"""

														type: "string"
													}
												}
												required: [
													"disabled",
												]
												type: "object"
											}
											configConnectorConfig: {
												description: "ConfigConnectorConfig: Configuration for the ConfigConnector add-on, a Kubernetes extension to manage hosted GCP services through the Kubernetes API"

												properties: enabled: {
													description: "Enabled: Whether Cloud Connector is enabled for this cluster."

													type: "boolean"
												}
												required: [
													"enabled",
												]
												type: "object"
											}
											dnsCacheConfig: {
												description: "DNSCacheConfig: Configuration for NodeLocalDNS, a dns cache running on cluster nodes"

												properties: enabled: {
													description: "Enabled: Whether NodeLocal DNSCache is enabled for this cluster."

													type: "boolean"
												}
												required: [
													"enabled",
												]
												type: "object"
											}
											gcePersistentDiskCsiDriverConfig: {
												description: "GCEPersistentDiskCSIDriverConfig: Configuration for the GCP Compute Persistent Disk CSI driver."

												properties: enabled: {
													description: "Enabled: Whether the GCE PD CSI driver is enabled for this cluster."

													type: "boolean"
												}
												required: [
													"enabled",
												]
												type: "object"
											}
											horizontalPodAutoscaling: {
												description: "HorizontalPodAutoscaling: Configuration for the horizontal pod autoscaling feature, which increases or decreases the number of replica pods a replication controller has based on the resource usage of the existing pods."

												properties: disabled: {
													description: "Disabled: Whether the Horizontal Pod Autoscaling feature is enabled in the cluster. When enabled, it ensures that a Heapster pod is running in the cluster, which is also used by the Cloud Monitoring service."

													type: "boolean"
												}
												required: [
													"disabled",
												]
												type: "object"
											}
											httpLoadBalancing: {
												description: "HTTpLoadBalancing: Configuration for the HTTP (L7) load balancing controller addon, which makes it easy to set up HTTP load balancers for services in a cluster."

												properties: disabled: {
													description: "Disabled: Whether the HTTP Load Balancing controller is enabled in the cluster. When enabled, it runs a small pod in the cluster that manages the load balancers."

													type: "boolean"
												}
												required: [
													"disabled",
												]
												type: "object"
											}
											kubernetesDashboard: {
												description: "KubernetesDashboard: Configuration for the Kubernetes Dashboard. This addon is deprecated, and will be disabled in 1.15. It is recommended to use the Cloud Console to manage and monitor your Kubernetes clusters, workloads and applications. For more information, see: https://cloud.google.com/kubernetes-engine/docs/concepts/dashboards"

												properties: disabled: {
													description: "Disabled: Whether the Kubernetes Dashboard is enabled for this cluster."

													type: "boolean"
												}
												required: [
													"disabled",
												]
												type: "object"
											}
											networkPolicyConfig: {
												description: "NetworkPolicyConfig: Configuration for NetworkPolicy. This only tracks whether the addon is enabled or not on the Master, it does not track whether network policy is enabled for the nodes."

												properties: disabled: {
													description: "Disabled: Whether NetworkPolicy is enabled for this cluster."

													type: "boolean"
												}
												required: [
													"disabled",
												]
												type: "object"
											}
										}
										type: "object"
									}
									authenticatorGroupsConfig: {
										description: "AuthenticatorGroupsConfig: Configuration controlling RBAC group membership information."

										properties: {
											enabled: {
												description: "Enabled: Whether this cluster should return group membership lookups during authentication using a group of security groups."

												type: "boolean"
											}
											securityGroup: {
												description: "SecurityGroup: The name of the security group-of-groups to be used. Only relevant if enabled = true."

												type: "string"
											}
										}
										type: "object"
									}
									autopilot: {
										description: "Autopilot: Autopilot configuration for the cluster."
										properties: enabled: {
											description: "Enabled: Enable Autopilot"
											type:        "boolean"
										}
										required: [
											"enabled",
										]
										type: "object"
									}
									autoscaling: {
										description: "Autoscaling: Cluster-level autoscaling configuration."
										properties: {
											autoprovisioningLocations: {
												description: "AutoprovisioningLocations: The list of Google Compute Engine [zones](https://cloud.google.com/compute/docs/zones#available) in which the NodePool's nodes can be created by NAP."

												items: type: "string"
												type: "array"
											}
											autoprovisioningNodePoolDefaults: {
												description: "AutoprovisioningNodePoolDefaults: AutoprovisioningNodePoolDefaults contains defaults for a node pool created by NAP."

												properties: {
													bootDiskKmsKey: {
														description: "BootDiskKmsKey: The Customer Managed Encryption Key used to encrypt the boot disk attached to each node in the node pool. This should be of the form projects/[KEY_PROJECT_ID]/locations/[LOCATION]/keyRings/[RING_NAME]/cr yptoKeys/[KEY_NAME]. For more information about protecting resources with Cloud KMS Keys please see: https://cloud.google.com/compute/docs/disks/customer-managed-encryption"

														type: "string"
													}
													diskSizeGb: {
														description: "DiskSizeGb: Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. If unspecified, the default disk size is 100GB."

														format: "int64"
														type:   "integer"
													}
													diskType: {
														description: "DiskType: Type of the disk attached to each node (e.g. 'pd-standard', 'pd-ssd' or 'pd-balanced') If unspecified, the default disk type is 'pd-standard'"

														type: "string"
													}
													management: {
														description: "Management: Specifies the node management options for NAP created node-pools."

														properties: {
															autoRepair: {
																description: "AutoRepair: A flag that specifies whether the node auto-repair is enabled for the node pool. If enabled, the nodes in this node pool will be monitored and, if they fail health checks too many times, an automatic repair action will be triggered."

																type: "boolean"
															}
															autoUpgrade: {
																description: "AutoUpgrade: A flag that specifies whether node auto-upgrade is enabled for the node pool. If enabled, node auto-upgrade helps keep the nodes in your node pool up to date with the latest release version of Kubernetes."

																type: "boolean"
															}
														}
														type: "object"
													}
													minCpuPlatform: {
														description: "MinCpuPlatform: Minimum CPU platform to be used for NAP created node pools. The instance may be scheduled on the specified or newer CPU platform. Applicable values are the friendly names of CPU platforms, such as minCpuPlatform: Intel Haswell or minCpuPlatform: Intel Sandy Bridge. For more information, read how to specify min CPU platform (https://cloud.google.com/compute/docs/instances/specify-min-cpu-platform) To unset the min cpu platform field pass \"automatic\" as field value."

														type: "string"
													}
													oauthScopes: {
														description: "OauthScopes: Scopes that are used by NAP when creating node pools. If oauth_scopes are specified, service_account should be empty."

														items: type: "string"
														type: "array"
													}
													serviceAccount: {
														description: "ServiceAccount: The Google Cloud Platform Service Account to be used by the node VMs. If service_account is specified, scopes should be empty."

														type: "string"
													}
													shieldedInstanceConfig: {
														description: "ShieldedInstanceConfig: Shielded Instance options."

														properties: {
															enableIntegrityMonitoring: {
																description: "EnableIntegrityMonitoring: Defines whether the instance has integrity monitoring enabled. Enables monitoring and attestation of the boot integrity of the instance. The attestation is performed against the integrity policy baseline. This baseline is initially derived from the implicitly trusted boot image when the instance is created."

																type: "boolean"
															}
															enableSecureBoot: {
																description: "EnableSecureBoot: Defines whether the instance has Secure Boot enabled. Secure Boot helps ensure that the system only runs authentic software by verifying the digital signature of all boot components, and halting the boot process if signature verification fails."

																type: "boolean"
															}
														}
														type: "object"
													}
													upgradeSettings: {
														description: "UpgradeSettings: Specifies the upgrade settings for NAP created node pools"

														properties: {
															maxSurge: {
																description: "MaxSurge: The maximum number of nodes that can be created beyond the current size of the node pool during the upgrade process."

																format: "int64"
																type:   "integer"
															}
															maxUnavailable: {
																description: "MaxUnavailable: The maximum number of nodes that can be simultaneously unavailable during the upgrade process. A node is considered available if its status is Ready."

																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											enableNodeAutoprovisioning: {
												description: "EnableNodeAutoprovisioning: Enables automatic node pool creation and deletion."

												type: "boolean"
											}
											resourceLimits: {
												description: "ResourceLimits: Contains global constraints regarding minimum and maximum amount of resources in the cluster."

												items: {
													description: "ResourceLimit contains information about amount of some resource in the cluster. For memory, value should be in GB."

													properties: {
														maximum: {
															description: "Maximum: Maximum amount of the resource in the cluster."

															format: "int64"
															type:   "integer"
														}
														minimum: {
															description: "Minimum: Minimum amount of the resource in the cluster."

															format: "int64"
															type:   "integer"
														}
														resourceType: {
															description: "ResourceType: Resource name \"cpu\", \"memory\" or gpu-specific string."

															type: "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									binaryAuthorization: {
										description: "BinaryAuthorization: Configuration for Binary Authorization."
										properties: enabled: {
											description: "Enabled: Enable Binary Authorization for this cluster. If enabled, all container images will be validated by Google Binauthz."

											type: "boolean"
										}
										required: [
											"enabled",
										]
										type: "object"
									}
									clusterIpv4Cidr: {
										description: """
		ClusterIpv4Cidr: The IP address range of the container pods in this cluster, in [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) 
		 notation (e.g. `10.96.0.0/14`). Leave blank to have one automatically chosen or specify a `/14` block in `10.0.0.0/8`.
		"""

										type: "string"
									}
									confidentialNodes: {
										description: "ConfidentialNodes: Configuration of Confidential Nodes"

										properties: enabled: {
											description: "Enabled: Whether Confidential Nodes feature is enabled for all nodes in this cluster."

											type: "boolean"
										}
										required: [
											"enabled",
										]
										type: "object"
									}
									databaseEncryption: {
										description: "DatabaseEncryption: Configuration of etcd encryption."
										properties: {
											keyName: {
												description: "KeyName: Name of CloudKMS key to use for the encryption of secrets in etcd. Ex. projects/my-project/locations/global/keyRings/my-ring/cryptoKeys/my-ke y"

												type: "string"
											}
											state: {
												description: """
		State: Denotes the state of etcd encryption. 
		 Possible values: \"UNKNOWN\" - Should never be set \"ENCRYPTED\" - Secrets in etcd are encrypted. \"DECRYPTED\" - Secrets in etcd are stored in plain text (at etcd level) - this is unrelated to Google Compute Engine level full disk encryption.
		"""

												type: "string"
											}
										}
										type: "object"
									}
									defaultMaxPodsConstraint: {
										description: "DefaultMaxPodsConstraint: The default constraint on the maximum number of pods that can be run simultaneously on a node in the node pool of this cluster. Only honored if cluster created with IP Alias support."

										properties: maxPodsPerNode: {
											description: "MaxPodsPerNode: Constraint enforced on the max num of pods per node."

											format: "int64"
											type:   "integer"
										}
										required: [
											"maxPodsPerNode",
										]
										type: "object"
									}
									description: {
										description: "Description: An optional description of this cluster."
										type:        "string"
									}
									enableKubernetesAlpha: {
										description: "EnableKubernetesAlpha: Kubernetes alpha features are enabled on this cluster. This includes alpha API groups (e.g. v1alpha1) and features that may not be production ready in the kubernetes version of the master and nodes. The cluster has no SLA for uptime and master/node upgrades are disabled. Alpha enabled clusters are automatically deleted thirty days after creation."

										type: "boolean"
									}
									enableTpu: {
										description: "EnableTpu: Enable the ability to use Cloud TPUs in this cluster."

										type: "boolean"
									}
									initialClusterVersion: {
										description: """
		InitialClusterVersion: The initial Kubernetes version for this cluster.  Valid versions are those found in validMasterVersions returned by getServerConfig.  The version can be upgraded over time; such upgrades are reflected in currentMasterVersion and currentNodeVersion. 
		 Users may specify either explicit versions offered by Kubernetes Engine or version aliases, which have the following behavior: 
		 - \"latest\": picks the highest valid Kubernetes version - \"1.X\": picks the highest valid patch+gke.N patch in the 1.X version - \"1.X.Y\": picks the highest valid gke.N patch in the 1.X.Y version - \"1.X.Y-gke.N\": picks an explicit Kubernetes version - \"\",\"-\": picks the default Kubernetes version
		"""

										type: "string"
									}
									ipAllocationPolicy: {
										description: "IPAllocationPolicy: Configuration for cluster IP allocation."

										properties: {
											clusterIpv4CidrBlock: {
												description: """
		ClusterIpv4CidrBlock: The IP address range for the cluster pod IPs. If this field is set, then `cluster.cluster_ipv4_cidr` must be left blank. 
		 This field is only applicable when `use_ip_aliases` is true. 
		 Set to blank to have a range chosen with the default size. 
		 Set to /netmask (e.g. `/14`) to have a range chosen with a specific netmask. 
		 Set to a [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) 
		 notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g. `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range to use.
		"""

												type: "string"
											}
											clusterSecondaryRangeName: {
												description: """
		ClusterSecondaryRangeName: The name of the secondary range to be used for the cluster CIDR block.  The secondary range will be used for pod IP addresses. This must be an existing secondary range associated with the cluster subnetwork. 
		 This field is only applicable with use_ip_aliases is true and create_subnetwork is false.
		"""

												type: "string"
											}
											createSubnetwork: {
												description: """
		CreateSubnetwork: Whether a new subnetwork will be created automatically for the cluster. 
		 This field is only applicable when `use_ip_aliases` is true.
		"""

												type: "boolean"
											}
											nodeIpv4CidrBlock: {
												description: """
		NodeIpv4CidrBlock: The IP address range of the instance IPs in this cluster. 
		 This is applicable only if `create_subnetwork` is true. 
		 Set to blank to have a range chosen with the default size. 
		 Set to /netmask (e.g. `/14`) to have a range chosen with a specific netmask. 
		 Set to a [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) 
		 notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g. `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range to use.
		"""

												type: "string"
											}
											servicesIpv4CidrBlock: {
												description: """
		ServicesIpv4CidrBlock: The IP address range of the services IPs in this cluster. If blank, a range will be automatically chosen with the default size. 
		 This field is only applicable when `use_ip_aliases` is true. 
		 Set to blank to have a range chosen with the default size. 
		 Set to /netmask (e.g. `/14`) to have a range chosen with a specific netmask. 
		 Set to a [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) 
		 notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g. `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range to use.
		"""

												type: "string"
											}
											servicesSecondaryRangeName: {
												description: """
		ServicesSecondaryRangeName: The name of the secondary range to be used as for the services CIDR block.  The secondary range will be used for service ClusterIPs. This must be an existing secondary range associated with the cluster subnetwork. 
		 This field is only applicable with use_ip_aliases is true and create_subnetwork is false.
		"""

												type: "string"
											}
											subnetworkName: {
												description: "SubnetworkName: A custom subnetwork name to be used if `create_subnetwork` is true.  If this field is empty, then an automatic name will be chosen for the new subnetwork."

												type: "string"
											}
											tpuIpv4CidrBlock: {
												description: """
		TpuIpv4CidrBlock: The IP address range of the Cloud TPUs in this cluster. If unspecified, a range will be automatically chosen with the default size. 
		 This field is only applicable when `use_ip_aliases` is true. 
		 If unspecified, the range will use the default size. 
		 Set to /netmask (e.g. `/14`) to have a range chosen with a specific netmask. 
		 Set to a [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) 
		 notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g. `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range to use.
		"""

												type: "string"
											}
											useIpAliases: {
												description: "UseIPAliases: Whether alias IPs will be used for pod IPs in the cluster."

												type: "boolean"
											}
											useRoutes: {
												description: "UseRoutes: Whether routes will be used for pod IPs in the cluster. This is used in conjunction with use_ip_aliases. It cannot be true if use_ip_aliases is true. If both use_ip_aliases and use_routes are false, then the server picks the default IP allocation mode"

												type: "boolean"
											}
										}
										type: "object"
									}
									labelFingerprint: {
										description: "LabelFingerprint: The fingerprint of the set of labels for this cluster."

										type: "string"
									}
									legacyAbac: {
										description: "LegacyAbac: Configuration for the legacy ABAC authorization mode."

										properties: enabled: {
											description: "Enabled: Whether the ABAC authorizer is enabled for this cluster. When enabled, identities in the system, including service accounts, nodes, and controllers, will have statically granted permissions beyond those provided by the RBAC configuration or IAM."

											type: "boolean"
										}
										required: [
											"enabled",
										]
										type: "object"
									}
									location: {
										description: "Location: The name of the Google Compute Engine [zone](https://cloud.google.com/compute/docs/regions-zones/regions-zones#available) or [region](https://cloud.google.com/compute/docs/regions-zones/regions-zones#available) in which the cluster resides."

										type: "string"
									}
									locations: {
										description: "Locations: The list of Google Compute Engine [zones](https://cloud.google.com/compute/docs/zones#available) in which the cluster's nodes should be located."

										items: type: "string"
										type: "array"
									}
									loggingService: {
										description: """
		LoggingService: The logging service the cluster should use to write logs. Currently available options: 
		 * \"logging.googleapis.com/kubernetes\" - the Google Cloud Logging service with Kubernetes-native resource model in Stackdriver * `logging.googleapis.com` - the Google Cloud Logging service. * `none` - no logs will be exported from the cluster. * if left as an empty string,`logging.googleapis.com` will be used.
		"""

										type: "string"
									}
									maintenancePolicy: {
										description: "MaintenancePolicy: Configure the maintenance policy for this cluster."

										properties: window: {
											description: "Window: Specifies the maintenance window in which maintenance may be performed."

											properties: {
												dailyMaintenanceWindow: {
													description: "DailyMaintenanceWindow: DailyMaintenanceWindow specifies a daily maintenance operation window."

													properties: startTime: {
														description: "StartTime: Time within the maintenance window to start the maintenance operations. Time format should be in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format \"HH:MM\", where HH : [00-23] and MM : [00-59] GMT."

														type: "string"
													}
													required: [
														"startTime",
													]
													type: "object"
												}
												maintenanceExclusions: {
													additionalProperties: {
														description: "TimeWindow is a window of time."
														properties: {
															endTime: {
																description: "EndTime: The time that the window ends. The end time should take place after the start time."

																type: "string"
															}
															startTime: {
																description: "StartTime: The time that the window first starts."

																type: "string"
															}
														}
														type: "object"
													}
													description: "MaintenanceExclusions: Exceptions to maintenance window. Non-emergency maintenance should not occur in these windows."

													type: "object"
												}
												recurringWindow: {
													description: "RecurringWindow: RecurringWindow specifies some number of recurring time periods for maintenance to occur. The time windows may be overlapping. If no maintenance windows are set, maintenance can occur at any time."

													properties: {
														recurrence: {
															description: "Recurrence: An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this window reccurs. They go on for the span of time between the start and end time. For example, to have something repeat every weekday, you'd use: `FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR` To repeat some window daily (equivalent to the DailyMaintenanceWindow): `FREQ=DAILY` For the first weekend of every month: `FREQ=MONTHLY;BYSETPOS=1;BYDAY=SA,SU` This specifies how frequently the window starts. Eg, if you wanted to have a 9-5 UTC-4 window every weekday, you'd use something like: “` start time = 2019-01-01T09:00:00-0400 end time = 2019-01-01T17:00:00-0400 recurrence = FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR “` Windows can span multiple days. Eg, to make the window encompass every weekend from midnight Saturday till the last minute of Sunday UTC: “` start time = 2019-01-05T00:00:00Z end time = 2019-01-07T23:59:00Z recurrence = FREQ=WEEKLY;BYDAY=SA “` Note the start and end time's specific dates are largely arbitrary except to specify duration of the window and when it first starts. The FREQ values of HOURLY, MINUTELY, and SECONDLY are not supported."

															type: "string"
														}
														window: {
															description: "Window: The window of the first recurrence."
															properties: {
																endTime: {
																	description: "EndTime: The time that the window ends. The end time should take place after the start time."

																	type: "string"
																}
																startTime: {
																	description: "StartTime: The time that the window first starts."

																	type: "string"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										required: ["window"]
										type: "object"
									}
									masterAuth: {
										description: "MasterAuth: The authentication information for accessing the master endpoint. If unspecified, the defaults are used: For clusters before v1.12, if master_auth is unspecified, `username` will be set to \"admin\", a random password will be generated, and a client certificate will be issued."

										properties: {
											clientCertificateConfig: {
												description: "ClientCertificateConfig: Configuration for client certificate authentication on the cluster. For clusters before v1.12, if no configuration is specified, a client certificate is issued."

												properties: issueClientCertificate: {
													description: "IssueClientCertificate: Issue a client certificate."
													type:        "boolean"
												}
												required: ["issueClientCertificate"]
												type: "object"
											}
											username: {
												description: "Username: The username to use for HTTP basic authentication to the master endpoint. For clusters v1.6.0 and later, basic authentication can be disabled by leaving username unspecified (or setting it to the empty string)."

												type: "string"
											}
										}
										type: "object"
									}
									masterAuthorizedNetworksConfig: {
										description: "MasterAuthorizedNetworksConfig: The configuration options for master authorized networks feature."

										properties: {
											cidrBlocks: {
												description: "CidrBlocks: cidr_blocks define up to 50 external networks that could access Kubernetes master through HTTPS."

												items: {
													description: "CidrBlock contains an optional name and one CIDR block."

													properties: {
														cidrBlock: {
															description: "CidrBlock: cidr_block must be specified in CIDR notation."

															type: "string"
														}
														displayName: {
															description: "DisplayName: display_name is an optional field for users to identify CIDR blocks."

															type: "string"
														}
													}
													required: ["cidrBlock"]
													type: "object"
												}
												type: "array"
											}
											enabled: {
												description: "Enabled: Whether or not master authorized networks is enabled."

												type: "boolean"
											}
										}
										type: "object"
									}
									monitoringService: {
										description: """
		MonitoringService: The monitoring service the cluster should use to write metrics. Currently available options: 
		 * `monitoring.googleapis.com` - the Google Cloud Monitoring service. * `none` - no metrics will be exported from the cluster. * if left as an empty string, `monitoring.googleapis.com` will be used.
		"""

										type: "string"
									}
									network: {
										description: "Network: The name of the Google Compute Engine [network](https://cloud.google.com/vpc/docs/vpc#vpc_networks_and_subnets) to which the cluster is connected. If left unspecified, the `default` network will be used."

										type: "string"
									}
									networkConfig: {
										description: "NetworkConfig: Configuration for cluster networking."
										properties: {
											datapathProvider: {
												description: """
		DatapathProvider: The desired datapath provider for this cluster. By default, uses the IPTables-based kube-proxy implementation. 
		 Possible values: \"DATAPATH_PROVIDER_UNSPECIFIED\" - Default value. \"LEGACY_DATAPATH\" - Use the IPTables implementation based on kube-proxy. \"ADVANCED_DATAPATH\" - Use the eBPF based GKE Dataplane V2 with additional features. See the [GKE Dataplane V2 documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/dataplane-v2) for more.
		"""

												type: "string"
											}
											defaultSnatStatus: {
												description: "DefaultSnatStatus: Whether the cluster disables default in-node sNAT rules. In-node sNAT rules will be disabled when default_snat_status is disabled. When disabled is set to false, default IP masquerade rules will be applied to the nodes to prevent sNAT on cluster internal traffic."

												properties: disabled: {
													description: "Disabled: Disables cluster default sNAT rules."

													type: "boolean"
												}
												required: ["disabled"]
												type: "object"
											}
											dnsConfig: {
												description: "DNSConfig contains the desired set of options for configuring clusterDNS."

												properties: {
													clusterDns: {
														description: "ClusterDns indicates which in-cluster DNS provider should be used. Possible values: \"PROVIDER_UNSPECIFIED\" - indicates the default value. \"PLATFORM_DEFAULT\" - indicates using the GKE default DNS provider(kube-dns) for DNS resolution. \"CLOUD_DNS\" - indicates using CloudDNS for DNS resolution."

														enum: [
															"PROVIDER_UNSPECIFIED",
															"PLATFORM_DEFAULT",
															"CLOUD_DNS",
														]
														type: "string"
													}
													clusterDnsDomain: {
														description: "ClusterDnsDomain is the suffix used for all cluster service records."

														type: "string"
													}
													clusterDnsScope: {
														description: "ClusterDnsScope indicates the scope of access to cluster DNS records. Possible Values: \"DNS_SCOPE_UNSPECIFIED\" - indicates the default value, will be inferred as cluster scope. \"VPC_SCOPE\" - indicates that DNS records are accessible from within the VPC."

														enum: [
															"DNS_SCOPE_UNSPECIFIED",
															"VPC_SCOPE",
														]
														type: "string"
													}
												}
												type: "object"
											}
											enableIntraNodeVisibility: {
												description: "EnableIntraNodeVisibility: Whether Intra-node visibility is enabled for this cluster. This makes same node pod to pod traffic visible for VPC network."

												type: "boolean"
											}
											privateIpv6GoogleAccess: {
												description: """
		PrivateIpv6GoogleAccess: The desired state of IPv6 connectivity to Google Services. By default, no private IPv6 access to or from Google Services (all access will be via IPv4) 
		 Possible values: \"PRIVATE_IPV6_GOOGLE_ACCESS_UNSPECIFIED\" - Default value. Same as DISABLED \"PRIVATE_IPV6_GOOGLE_ACCESS_DISABLED\" - No private access to or from Google Services \"PRIVATE_IPV6_GOOGLE_ACCESS_TO_GOOGLE\" - Enables private IPv6 access to Google Services from GKE \"PRIVATE_IPV6_GOOGLE_ACCESS_BIDIRECTIONAL\" - Enables priate IPv6 access to and from Google Services
		"""

												type: "string"
											}
										}
										type: "object"
									}
									networkPolicy: {
										description: "NetworkPolicy: Configuration options for the NetworkPolicy feature."

										properties: {
											enabled: {
												description: "Enabled: Whether network policy is enabled on the cluster."

												type: "boolean"
											}
											provider: {
												description: """
		Provider: The selected network policy provider. 
		 Possible values: \"PROVIDER_UNSPECIFIED\" - Not set \"CALICO\" - Tigera (Calico Felix).
		"""

												type: "string"
											}
										}
										type: "object"
									}
									networkRef: {
										description: "NetworkRef references to a Network and retrieves its URI"

										properties: {
											name: {
												description: "Name of the referenced object."
												type:        "string"
											}
											policy: {
												description: "Policies for referencing."
												properties: {
													resolution: {
														default:     "Required"
														description: "Resolution specifies whether resolution of this reference is required. The default is 'Required', which means the reconcile will fail if the reference cannot be resolved. 'Optional' means this reference will be a no-op if it cannot be resolved."

														enum: [
															"Required",
															"Optional",
														]
														type: "string"
													}
													resolve: {
														description: "Resolve specifies when this reference should be resolved. The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile."

														enum: [
															"Always",
															"IfNotPresent",
														]
														type: "string"
													}
												}
												type: "object"
											}
										}
										required: ["name"]
										type: "object"
									}
									networkSelector: {
										description: "NetworkSelector selects a reference to a Network and retrieves its URI"

										properties: {
											matchControllerRef: {
												description: "MatchControllerRef ensures an object with the same controller reference as the selecting object is selected."

												type: "boolean"
											}
											matchLabels: {
												additionalProperties: type: "string"
												description: "MatchLabels ensures an object with matching labels is selected."

												type: "object"
											}
											policy: {
												description: "Policies for selection."
												properties: {
													resolution: {
														default:     "Required"
														description: "Resolution specifies whether resolution of this reference is required. The default is 'Required', which means the reconcile will fail if the reference cannot be resolved. 'Optional' means this reference will be a no-op if it cannot be resolved."

														enum: [
															"Required",
															"Optional",
														]
														type: "string"
													}
													resolve: {
														description: "Resolve specifies when this reference should be resolved. The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile."

														enum: [
															"Always",
															"IfNotPresent",
														]
														type: "string"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
									notificationConfig: {
										description: "NotificationConfig: Notification configuration of the cluster."

										properties: pubsub: {
											description: "Pubsub: Notification config for Pub/Sub."
											properties: {
												enabled: {
													description: "Enabled: Enable notifications for Pub/Sub."
													type:        "boolean"
												}
												topic: {
													description: "Topic: The desired Pub/Sub topic to which notifications will be sent by GKE. Format is `projects/{project}/topics/{topic}`."

													type: "string"
												}
											}
											required: [
												"enabled",
												"topic",
											]
											type: "object"
										}
										required: ["pubsub"]
										type: "object"
									}
									privateClusterConfig: {
										description: "PrivateClusterConfig: Configuration for private cluster."

										properties: {
											enablePrivateEndpoint: {
												description: "EnablePrivateEndpoint: Whether the master's internal IP address is used as the cluster endpoint."

												type: "boolean"
											}
											enablePrivateNodes: {
												description: "EnablePrivateNodes: Whether nodes have internal IP addresses only. If enabled, all nodes are given only RFC 1918 private addresses and communicate with the master via private networking."

												type: "boolean"
											}
											masterGlobalAccessConfig: {
												description: "MasterGlobalAccessConfig: Controls master global access settings."

												properties: enabled: {
													description: "Enabled: Whenever master is accessible globally or not."

													type: "boolean"
												}
												required: ["enabled"]
												type: "object"
											}
											masterIpv4CidrBlock: {
												description: "MasterIpv4CidrBlock: The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning internal IP addresses to the master or set of masters, as well as the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network."

												type: "string"
											}
										}
										type: "object"
									}
									releaseChannel: {
										description: "ReleaseChannel: Release channel configuration."
										properties: channel: {
											description: """
		Channel: channel specifies which release channel the cluster is subscribed to. 
		 Possible values: \"UNSPECIFIED\" - No channel specified. \"RAPID\" - RAPID channel is offered on an early access basis for customers who want to test new releases. WARNING: Versions available in the RAPID Channel may be subject to unresolved issues with no known workaround and are not subject to any SLAs. \"REGULAR\" - Clusters subscribed to REGULAR receive versions that are considered GA quality. REGULAR is intended for production users who want to take advantage of new features. \"STABLE\" - Clusters subscribed to STABLE receive versions that are known to be stable and reliable in production.
		"""

											type: "string"
										}
										required: ["channel"]
										type: "object"
									}
									resourceLabels: {
										additionalProperties: type: "string"
										description: "ResourceLabels: The resource labels for the cluster to use to annotate any related Google Compute Engine resources."

										type: "object"
									}
									resourceUsageExportConfig: {
										description: "ResourceUsageExportConfig: Configuration for exporting resource usages. Resource usage export is disabled when this config is unspecified."

										properties: {
											bigqueryDestination: {
												description: "BigqueryDestination: Configuration to use BigQuery as usage export destination."

												properties: datasetId: {
													description: "DatasetId: The ID of a BigQuery Dataset."
													type:        "string"
												}
												required: ["datasetId"]
												type: "object"
											}
											consumptionMeteringConfig: {
												description: "ConsumptionMeteringConfig: Configuration to enable resource consumption metering."

												properties: enabled: {
													description: "Enabled: Whether to enable consumption metering for this cluster. If enabled, a second BigQuery table will be created to hold resource consumption records."

													type: "boolean"
												}
												required: ["enabled"]
												type: "object"
											}
											enableNetworkEgressMetering: {
												description: "EnableNetworkEgressMetering: Whether to enable network egress metering for this cluster. If enabled, a daemonset will be created in the cluster to meter network egress traffic."

												type: "boolean"
											}
										}
										type: "object"
									}
									subnetwork: {
										description: "Subnetwork: The name of the Google Compute Engine [subnetwork](https://cloud.google.com/vpc/docs/subnets) to which the cluster is connected."

										type: "string"
									}
									subnetworkRef: {
										description: "SubnetworkRef references to a Subnetwork and retrieves its URI"

										properties: {
											name: {
												description: "Name of the referenced object."
												type:        "string"
											}
											policy: {
												description: "Policies for referencing."
												properties: {
													resolution: {
														default:     "Required"
														description: "Resolution specifies whether resolution of this reference is required. The default is 'Required', which means the reconcile will fail if the reference cannot be resolved. 'Optional' means this reference will be a no-op if it cannot be resolved."

														enum: [
															"Required",
															"Optional",
														]
														type: "string"
													}
													resolve: {
														description: "Resolve specifies when this reference should be resolved. The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile."

														enum: [
															"Always",
															"IfNotPresent",
														]
														type: "string"
													}
												}
												type: "object"
											}
										}
										required: ["name"]
										type: "object"
									}
									subnetworkSelector: {
										description: "SubnetworkSelector selects a reference to a Subnetwork and retrieves its URI"

										properties: {
											matchControllerRef: {
												description: "MatchControllerRef ensures an object with the same controller reference as the selecting object is selected."

												type: "boolean"
											}
											matchLabels: {
												additionalProperties: type: "string"
												description: "MatchLabels ensures an object with matching labels is selected."

												type: "object"
											}
											policy: {
												description: "Policies for selection."
												properties: {
													resolution: {
														default:     "Required"
														description: "Resolution specifies whether resolution of this reference is required. The default is 'Required', which means the reconcile will fail if the reference cannot be resolved. 'Optional' means this reference will be a no-op if it cannot be resolved."

														enum: [
															"Required",
															"Optional",
														]
														type: "string"
													}
													resolve: {
														description: "Resolve specifies when this reference should be resolved. The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile."

														enum: [
															"Always",
															"IfNotPresent",
														]
														type: "string"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
									verticalPodAutoscaling: {
										description: "VerticalPodAutoscaling: Cluster-level Vertical Pod Autoscaling configuration."

										properties: enabled: {
											description: "Enabled: Enables vertical pod autoscaling."
											type:        "boolean"
										}
										required: ["enabled"]
										type: "object"
									}
									workloadIdentityConfig: {
										description: "WorkloadIdentityConfig: Configuration for the use of Kubernetes Service Accounts in GCP IAM policies."

										properties: workloadPool: {
											description: "WorkloadPool: The workload pool to attach all Kubernetes service accounts to."

											type: "string"
										}
										type: "object"
									}
								}
								required: ["location"]
								type: "object"
							}
							providerConfigRef: {
								default: name: "default"
								description: "ProviderConfigReference specifies how the provider that will be used to create, observe, update, and delete this managed resource should be configured."

								properties: {
									name: {
										description: "Name of the referenced object."
										type:        "string"
									}
									policy: {
										description: "Policies for referencing."
										properties: {
											resolution: {
												default:     "Required"
												description: "Resolution specifies whether resolution of this reference is required. The default is 'Required', which means the reconcile will fail if the reference cannot be resolved. 'Optional' means this reference will be a no-op if it cannot be resolved."

												enum: [
													"Required",
													"Optional",
												]
												type: "string"
											}
											resolve: {
												description: "Resolve specifies when this reference should be resolved. The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile."

												enum: [
													"Always",
													"IfNotPresent",
												]
												type: "string"
											}
										}
										type: "object"
									}
								}
								required: ["name"]
								type: "object"
							}
							providerRef: {
								description: "ProviderReference specifies the provider that will be used to create, observe, update, and delete this managed resource. Deprecated: Please use ProviderConfigReference, i.e. `providerConfigRef`"

								properties: {
									name: {
										description: "Name of the referenced object."
										type:        "string"
									}
									policy: {
										description: "Policies for referencing."
										properties: {
											resolution: {
												default:     "Required"
												description: "Resolution specifies whether resolution of this reference is required. The default is 'Required', which means the reconcile will fail if the reference cannot be resolved. 'Optional' means this reference will be a no-op if it cannot be resolved."

												enum: [
													"Required",
													"Optional",
												]
												type: "string"
											}
											resolve: {
												description: "Resolve specifies when this reference should be resolved. The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile."

												enum: [
													"Always",
													"IfNotPresent",
												]
												type: "string"
											}
										}
										type: "object"
									}
								}
								required: ["name"]
								type: "object"
							}
							publishConnectionDetailsTo: {
								description: "PublishConnectionDetailsTo specifies the connection secret config which contains a name, metadata and a reference to secret store config to which any connection details for this managed resource should be written. Connection details frequently include the endpoint, username, and password required to connect to the managed resource."

								properties: {
									configRef: {
										default: name: "default"
										description: "SecretStoreConfigRef specifies which secret store config should be used for this ConnectionSecret."

										properties: {
											name: {
												description: "Name of the referenced object."
												type:        "string"
											}
											policy: {
												description: "Policies for referencing."
												properties: {
													resolution: {
														default:     "Required"
														description: "Resolution specifies whether resolution of this reference is required. The default is 'Required', which means the reconcile will fail if the reference cannot be resolved. 'Optional' means this reference will be a no-op if it cannot be resolved."

														enum: [
															"Required",
															"Optional",
														]
														type: "string"
													}
													resolve: {
														description: "Resolve specifies when this reference should be resolved. The default is 'IfNotPresent', which will attempt to resolve the reference only when the corresponding field is not present. Use 'Always' to resolve the reference on every reconcile."

														enum: [
															"Always",
															"IfNotPresent",
														]
														type: "string"
													}
												}
												type: "object"
											}
										}
										required: ["name"]
										type: "object"
									}
									metadata: {
										description: "Metadata is the metadata for connection secret."
										properties: {
											annotations: {
												additionalProperties: type: "string"
												description: "Annotations are the annotations to be added to connection secret. - For Kubernetes secrets, this will be used as \"metadata.annotations\". - It is up to Secret Store implementation for others store types."

												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Labels are the labels/tags to be added to connection secret. - For Kubernetes secrets, this will be used as \"metadata.labels\". - It is up to Secret Store implementation for others store types."

												type: "object"
											}
											type: {
												description: "Type is the SecretType for the connection secret. - Only valid for Kubernetes Secret Stores."

												type: "string"
											}
										}
										type: "object"
									}
									name: {
										description: "Name is the name of the connection secret."
										type:        "string"
									}
								}
								required: ["name"]
								type: "object"
							}
							writeConnectionSecretToRef: {
								description: "WriteConnectionSecretToReference specifies the namespace and name of a Secret to which any connection details for this managed resource should be written. Connection details frequently include the endpoint, username, and password required to connect to the managed resource. This field is planned to be replaced in a future release in favor of PublishConnectionDetailsTo. Currently, both could be set independently and connection details would be published to both without affecting each other."

								properties: {
									name: {
										description: "Name of the secret."
										type:        "string"
									}
									namespace: {
										description: "Namespace of the secret."
										type:        "string"
									}
								}
								required: [
									"name",
									"namespace",
								]
								type: "object"
							}
						}
						required: ["forProvider"]
						type: "object"
					}
					status: {
						description: "A ClusterStatus represents the observed state of a Cluster."
						properties: {
							atProvider: {
								description: "ClusterObservation is used to show the observed state of the GKE cluster resource on GCP."

								properties: {
									conditions: {
										description: "Conditions: Which conditions caused the current cluster state."

										items: {
											description: "StatusCondition describes why a cluster or a node pool has a certain status (e.g., ERROR or DEGRADED)."

											properties: {
												code: {
													description: """
		Code: Machine-friendly representation of the condition 
		 Possible values: \"UNKNOWN\" - UNKNOWN indicates a generic condition. \"GCE_STOCKOUT\" - GCE_STOCKOUT indicates a Google Compute Engine stockout. \"GKE_SERVICE_ACCOUNT_DELETED\" - GKE_SERVICE_ACCOUNT_DELETED indicates that the user deleted their robot service account. \"GCE_QUOTA_EXCEEDED\" - Google Compute Engine quota was exceeded. \"SET_BY_OPERATOR\" - Cluster state was manually changed by an SRE due to a system logic error. More codes TBA
		"""

													type: "string"
												}
												message: {
													description: "Message: Human-friendly representation of the condition"

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									createTime: {
										description: "CreateTime: The time the cluster was created, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format."

										type: "string"
									}
									currentMasterVersion: {
										description: "CurrentMasterVersion: The current software version of the master endpoint."

										type: "string"
									}
									currentNodeCount: {
										description: "CurrentNodeCount:  The number of nodes currently in the cluster. Deprecated. Call Kubernetes API directly to retrieve node information."

										format: "int64"
										type:   "integer"
									}
									currentNodeVersion: {
										description: "CurrentNodeVersion: Deprecated, use [NodePools.version](/kubernetes-engine/docs/reference/rest/v1/projects.zones.clusters.nodePools) instead. The current version of the node software components. If they are currently at multiple versions because they're in the process of being upgraded, this reflects the minimum version of all nodes."

										type: "string"
									}
									endpoint: {
										description: """
		Endpoint: The IP address of this cluster's master endpoint. The endpoint can be accessed from the internet at `https://username:password@endpoint/`. 
		 See the `masterAuth` property of this resource for username and password information.
		"""

										type: "string"
									}
									expireTime: {
										description: "ExpireTime: The time the cluster will be automatically deleted in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format."

										type: "string"
									}
									location: {
										description: "Location: The name of the Google Compute Engine [zone](https://cloud.google.com/compute/docs/regions-zones/regions-zones#available) or [region](https://cloud.google.com/compute/docs/regions-zones/regions-zones#available) in which the cluster resides."

										type: "string"
									}
									maintenancePolicy: {
										description: "MaintenancePolicy: Configure the maintenance policy for this cluster."

										properties: window: {
											description: "Window: Specifies the maintenance window in which maintenance may be performed."

											properties: dailyMaintenanceWindow: {
												description: "DailyMaintenanceWindow: DailyMaintenanceWindow specifies a daily maintenance operation window."

												properties: duration: {
													description: "Duration: Duration of the time window, automatically chosen to be smallest possible in the given scenario. Duration will be in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format \"PTnHnMnS\"."

													type: "string"
												}
												type: "object"
											}
											type: "object"
										}
										type: "object"
									}
									networkConfig: {
										description: "NetworkConfig: Configuration for cluster networking."
										properties: {
											network: {
												description: "Network: The relative name of the Google Compute Engine network(https://cloud.google.com/vpc/docs/vpc#vpc_networks_and_subnets) to which the cluster is connected. Example: projects/my-project/global/networks/my-network"

												type: "string"
											}
											subnetwork: {
												description: "Subnetwork: The relative name of the Google Compute Engine [subnetwork](https://cloud.google.com/vpc/docs/vpc) to which the cluster is connected. Example: projects/my-project/regions/us-central1/subnetworks/my-subnet"

												type: "string"
											}
										}
										type: "object"
									}
									nodeIpv4CidrSize: {
										description: "NodeIpv4CidrSize: The size of the address space on each node for hosting containers. This is provisioned from within the `container_ipv4_cidr` range. This field will only be set when cluster is in route-based network mode."

										format: "int64"
										type:   "integer"
									}
									nodePools: {
										description: "NodePools: The node pools associated with this cluster. This field should not be set if \"node_config\" or \"initial_node_count\" are specified."

										items: {
											description: "NodePoolClusterStatus is a subset of information about NodePools associated with a GKE cluster."

											properties: {
												autoscaling: {
													description: "Autoscaling: Autoscaler configuration for this NodePool. Autoscaler is enabled only if a valid configuration is present."

													properties: {
														autoprovisioned: {
															description: "Autoprovisioned: Can this node pool be deleted automatically."

															type: "boolean"
														}
														enabled: {
															description: "Enabled: Is autoscaling enabled for this node pool."

															type: "boolean"
														}
														maxNodeCount: {
															description: "MaxNodeCount: Maximum number of nodes in the NodePool. Must be >= min_node_count. There has to enough quota to scale up the cluster."

															format: "int64"
															type:   "integer"
														}
														minNodeCount: {
															description: "MinNodeCount: Minimum number of nodes in the NodePool. Must be >= 1 and <= max_node_count."

															format: "int64"
															type:   "integer"
														}
													}
													type: "object"
												}
												conditions: {
													description: "Conditions: Which conditions caused the current node pool state."

													items: {
														description: "StatusCondition describes why a cluster or a node pool has a certain status (e.g., ERROR or DEGRADED)."

														properties: {
															code: {
																description: """
		Code: Machine-friendly representation of the condition 
		 Possible values: \"UNKNOWN\" - UNKNOWN indicates a generic condition. \"GCE_STOCKOUT\" - GCE_STOCKOUT indicates a Google Compute Engine stockout. \"GKE_SERVICE_ACCOUNT_DELETED\" - GKE_SERVICE_ACCOUNT_DELETED indicates that the user deleted their robot service account. \"GCE_QUOTA_EXCEEDED\" - Google Compute Engine quota was exceeded. \"SET_BY_OPERATOR\" - Cluster state was manually changed by an SRE due to a system logic error. More codes TBA
		"""

																type: "string"
															}
															message: {
																description: "Message: Human-friendly representation of the condition"

																type: "string"
															}
														}
														type: "object"
													}
													type: "array"
												}
												config: {
													description: "Config: The node configuration of the pool."
													properties: {
														accelerators: {
															description: "Accelerators: A list of hardware accelerators to be attached to each node. See https://cloud.google.com/compute/docs/gpus for more information about support for GPUs."

															items: {
																description: "AcceleratorConfigClusterStatus represents a Hardware Accelerator request."

																properties: {
																	acceleratorCount: {
																		description: "AcceleratorCount: The number of the accelerator cards exposed to an instance."

																		format: "int64"
																		type:   "integer"
																	}
																	acceleratorType: {
																		description: "AcceleratorType: The accelerator type resource name. List of supported accelerators [here](https://cloud.google.com/compute/docs/gpus/#Introduction)"

																		type: "string"
																	}
																}
																type: "object"
															}
															type: "array"
														}
														diskSizeGb: {
															description: """
		DiskSizeGb: Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. 
		 If unspecified, the default disk size is 100GB.
		"""

															format: "int64"
															type:   "integer"
														}
														diskType: {
															description: """
		DiskType: Type of the disk attached to each node (e.g. 'pd-standard' or 'pd-ssd') 
		 If unspecified, the default disk type is 'pd-standard'
		"""

															type: "string"
														}
														imageType: {
															description: "ImageType: The image type to use for this node. Note that for a given image type, the latest version of it will be used."

															type: "string"
														}
														labels: {
															additionalProperties: type: "string"
															description: "Labels: The map of Kubernetes labels (key/value pairs) to be applied to each node. These will added in addition to any default label(s) that Kubernetes may apply to the node. In case of conflict in label keys, the applied set may differ depending on the Kubernetes version -- it's best to assume the behavior is undefined and conflicts should be avoided. For more information, including usage and the valid values, see: https://kubernetes.io/docs/concepts/overview/working-with-objects /labels/"

															type: "object"
														}
														localSsdCount: {
															description: """
		LocalSsdCount: The number of local SSD disks to be attached to the node. 
		 The limit for this value is dependant upon the maximum number of disks available on a machine per zone. See: https://cloud.google.com/compute/docs/disks/local-ssd#local_ssd_l imits for more information.
		"""

															format: "int64"
															type:   "integer"
														}
														machineType: {
															description: """
		MachineType: The name of a Google Compute Engine [machine type](https://cloud.google.com/compute/docs/machine-types) (e.g. `n1-standard-1`). 
		 If unspecified, the default machine type is `n1-standard-1`.
		"""

															type: "string"
														}
														metadata: {
															additionalProperties: type: "string"
															description: """
		Metadata: The metadata key/value pairs assigned to instances in the cluster. 
		 Keys must conform to the regexp [a-zA-Z0-9-_]+ and be less than 128 bytes in length. These are reflected as part of a URL in the metadata server. Additionally, to avoid ambiguity, keys must not conflict with any other metadata keys for the project or be one of the reserved keys: \"cluster-location\" \"cluster-name\" \"cluster-uid\" \"configure-sh\" \"containerd-configure-sh\" \"enable-oslogin\" \"gci-ensure-gke-docker\" \"gci-update-strategy\" \"instance-template\" \"kube-env\" \"startup-script\" \"user-data\" \"disable-address-manager\" \"windows-startup-script-ps1\" \"common-psm1\" \"k8s-node-setup-psm1\" \"install-ssh-psm1\" \"user-profile-psm1\" \"serial-port-logging-enable\" Values are free-form strings, and only have meaning as interpreted by the image running in the instance. The only restriction placed on them is that each value's size must be less than or equal to 32 KB. 
		 The total size of all keys and values must be less than 512 KB.
		"""

															type: "object"
														}
														minCpuPlatform: {
															description: "MinCpuPlatform: Minimum CPU platform to be used by this instance. The instance may be scheduled on the specified or newer CPU platform. Applicable values are the friendly names of CPU platforms, such as <code>minCpuPlatform: &quot;Intel Haswell&quot;</code> or <code>minCpuPlatform: &quot;Intel Sandy Bridge&quot;</code>. For more information, read [how to specify min CPU platform](https://cloud.google.com/compute/docs/instances/specify- min-cpu-platform)"

															type: "string"
														}
														oauthScopes: {
															description: """
		OauthScopes: The set of Google API scopes to be made available on all of the node VMs under the \"default\" service account. 
		 The following scopes are recommended, but not required, and by default are not included: 
		 * `https://www.googleapis.com/auth/compute` is required for mounting persistent storage on your nodes. * `https://www.googleapis.com/auth/devstorage.read_only` is required for communicating with **gcr.io** (the [Google Container Registry](/container-registry/)). 
		 If unspecified, no scopes are added, unless Cloud Logging or Cloud Monitoring are enabled, in which case their required scopes will be added.
		"""

															items: type: "string"
															type: "array"
														}
														preemptible: {
															description: "Preemptible: Whether the nodes are created as preemptible VM instances. See: https://cloud.google.com/compute/docs/instances/preemptible for more inforamtion about preemptible VM instances."

															type: "boolean"
														}
														sandboxConfig: {
															description: "SandboxConfig: Sandbox configuration for this node."

															properties: type: {
																description: "Type: Type of the sandbox to use for the node (e.g. 'gvisor')"

																type: "string"
															}
															type: "object"
														}
														serviceAccount: {
															description: "ServiceAccount: The Google Cloud Platform Service Account to be used by the node VMs. If no Service Account is specified, the \"default\" service account is used."

															type: "string"
														}
														shieldedInstanceConfig: {
															description: "ShieldedInstanceConfig: Shielded Instance options."

															properties: {
																enableIntegrityMonitoring: {
																	description: """
		EnableIntegrityMonitoring: Defines whether the instance has integrity monitoring enabled. 
		 Enables monitoring and attestation of the boot integrity of the instance. The attestation is performed against the integrity policy baseline. This baseline is initially derived from the implicitly trusted boot image when the instance is created.
		"""

																	type: "boolean"
																}
																enableSecureBoot: {
																	description: """
		EnableSecureBoot: Defines whether the instance has Secure Boot enabled. 
		 Secure Boot helps ensure that the system only runs authentic software by verifying the digital signature of all boot components, and halting the boot process if signature verification fails.
		"""

																	type: "boolean"
																}
															}
															type: "object"
														}
														tags: {
															description: "Tags: The list of instance tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls and are specified by the client during cluster or node pool creation. Each tag within the list must comply with RFC1035."

															items: type: "string"
															type: "array"
														}
														taints: {
															description: """
		Taints: List of kubernetes taints to be applied to each node. 
		 For more information, including usage and the valid values, see: https://kubernetes.io/docs/concepts/configuration/taint-and-toler ation/
		"""

															items: {
																description: "NodeTaintClusterStatus is a Kubernetes taint is comprised of three fields: key, value, and effect. Effect can only be one of three types:  NoSchedule, PreferNoSchedule or NoExecute."

																properties: {
																	effect: {
																		description: """
		Effect: Effect for taint. 
		 Possible values: \"EFFECT_UNSPECIFIED\" - Not set \"NO_SCHEDULE\" - NoSchedule \"PREFER_NO_SCHEDULE\" - PreferNoSchedule \"NO_EXECUTE\" - NoExecute
		"""

																		type: "string"
																	}
																	key: {
																		description: "Key: Key for taint."
																		type:        "string"
																	}
																	value: {
																		description: "Value: Value for taint."
																		type:        "string"
																	}
																}
																type: "object"
															}
															type: "array"
														}
													}
													type: "object"
												}
												initialNodeCount: {
													description: "InitialNodeCount: The initial node count for the pool. You must ensure that your Compute Engine <a href=\"https://cloud.google.com/compute/quotas\">resource quota</a> is sufficient for this number of instances. You must also have available firewall and routes quota."

													format: "int64"
													type:   "integer"
												}
												instanceGroupUrls: {
													description: "InstanceGroupUrls: The resource URLs of the [managed instance groups](https://cloud.google.com/compute/docs/instance-groups/creating-groups-of-managed-instances) associated with this node pool."

													items: type: "string"
													type: "array"
												}
												locations: {
													description: "Locations: The list of Google Compute Engine [zones](https://cloud.google.com/compute/docs/regions-zones#available) in which the NodePool's nodes should be located."

													items: type: "string"
													type: "array"
												}
												management: {
													description: "Management: NodeManagement configuration for this NodePool."

													properties: {
														autoRepair: {
															description: "AutoRepair: Whether the nodes will be automatically repaired."

															type: "boolean"
														}
														autoUpgrade: {
															description: "AutoUpgrade: Whether the nodes will be automatically upgraded."

															type: "boolean"
														}
														upgradeOptions: {
															description: "UpgradeOptions: Specifies the Auto Upgrade knobs for the node pool."

															properties: {
																autoUpgradeStartTime: {
																	description: "AutoUpgradeStartTime: This field is set when upgrades are about to commence with the approximate start time for the upgrades, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format."

																	type: "string"
																}
																description: {
																	description: "Description: This field is set when upgrades are about to commence with the description of the upgrade."

																	type: "string"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
												maxPodsConstraint: {
													description: "MaxPodsConstraint: The constraint on the maximum number of pods that can be run simultaneously on a node in the node pool."

													properties: maxPodsPerNode: {
														description: "MaxPodsPerNode: Constraint enforced on the max num of pods per node."

														format: "int64"
														type:   "integer"
													}
													required: ["maxPodsPerNode"]
													type: "object"
												}
												name: {
													description: "Name: The name of the node pool."
													type:        "string"
												}
												podIpv4CidrSize: {
													description: "PodIpv4CidrSize: The pod CIDR block size per node in this node pool."

													format: "int64"
													type:   "integer"
												}
												selfLink: {
													description: "SelfLink: Server-defined URL for the resource."
													type:        "string"
												}
												status: {
													description: """
		Status: The status of the nodes in this pool instance. 
		 Possible values: \"STATUS_UNSPECIFIED\" - Not set. \"PROVISIONING\" - The PROVISIONING state indicates the node pool is being created. \"RUNNING\" - The RUNNING state indicates the node pool has been created and is fully usable. \"RUNNING_WITH_ERROR\" - The RUNNING_WITH_ERROR state indicates the node pool has been created and is partially usable. Some error state has occurred and some functionality may be impaired. Customer may need to reissue a request or trigger a new update. \"RECONCILING\" - The RECONCILING state indicates that some work is actively being done on the node pool, such as upgrading node software. Details can be found in the `statusMessage` field. \"STOPPING\" - The STOPPING state indicates the node pool is being deleted. \"ERROR\" - The ERROR state indicates the node pool may be unusable. Details can be found in the `statusMessage` field.
		"""

													type: "string"
												}
												statusMessage: {
													description: "StatusMessage: Additional information about the current status of this node pool instance, if available."

													type: "string"
												}
												version: {
													description: "Version: The version of the Kubernetes of this node."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									privateClusterConfig: {
										description: "PrivateClusterConfig: Configuration for private cluster."

										properties: {
											privateEndpoint: {
												description: "PrivateEndpoint: The internal IP address of this cluster's master endpoint."

												type: "string"
											}
											publicEndpoint: {
												description: "PublicEndpoint: The external IP address of this cluster's master endpoint."

												type: "string"
											}
										}
										type: "object"
									}
									selfLink: {
										description: "SelfLink: Server-defined URL for the resource."
										type:        "string"
									}
									servicesIpv4Cidr: {
										description: """
		ServicesIpv4Cidr: The IP address range of the Kubernetes services in this cluster, in [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) 
		 notation (e.g. `1.2.3.4/29`). Service addresses are typically put in the last `/16` from the container CIDR.
		"""

										type: "string"
									}
									status: {
										description: """
		Status: The current status of this cluster. 
		 Possible values: \"STATUS_UNSPECIFIED\" - Not set. \"PROVISIONING\" - The PROVISIONING state indicates the cluster is being created. \"RUNNING\" - The RUNNING state indicates the cluster has been created and is fully usable. \"RECONCILING\" - The RECONCILING state indicates that some work is actively being done on the cluster, such as upgrading the master or node software. Details can be found in the `statusMessage` field. \"STOPPING\" - The STOPPING state indicates the cluster is being deleted. \"ERROR\" - The ERROR state indicates the cluster may be unusable. Details can be found in the `statusMessage` field. \"DEGRADED\" - The DEGRADED state indicates the cluster requires user action to restore full functionality. Details can be found in the `statusMessage` field.
		"""

										type: "string"
									}
									statusMessage: {
										description: "StatusMessage: Additional information about the current status of this cluster, if available."

										type: "string"
									}
									tpuIpv4CidrBlock: {
										description: """
		TpuIpv4CidrBlock: The IP address range of the Cloud TPUs in this cluster, in [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) 
		 notation (e.g. `1.2.3.4/29`).
		"""

										type: "string"
									}
									zone: {
										description: "Zone: The name of the Google Compute Engine [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster resides. This field is deprecated, use location instead."

										type: "string"
									}
								}
								required: ["location"]
								type: "object"
							}
							conditions: {
								description: "Conditions of the resource."
								items: {
									description: "A Condition that may apply to a resource."
									properties: {
										lastTransitionTime: {
											description: "LastTransitionTime is the last time this condition transitioned from one status to another."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "A Message containing details about this condition's last transition from one status to another, if any."

											type: "string"
										}
										reason: {
											description: "A Reason for this condition's last transition from one status to another."

											type: "string"
										}
										status: {
											description: "Status of this condition; is it currently True, False, or Unknown?"

											type: "string"
										}
										type: {
											description: "Type of this condition. At most one of each condition type may apply to a resource at any point in time."

											type: "string"
										}
									}
									required: [
										"lastTransitionTime",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
						}
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}, served:
				true, storage:
				true, subresources: status: {}
		}]
	}
}
