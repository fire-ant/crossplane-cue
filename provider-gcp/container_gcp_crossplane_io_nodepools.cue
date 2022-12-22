package container_gcp_crossplane_io_nodepools

customresourcedefinition: "nodepools.container.gcp.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.2"
		creationTimestamp: null
		name:              "nodepools.container.gcp.crossplane.io"
	}
	spec: {
		group: "container.gcp.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"gcp",
			]
			kind:     "NodePool"
			listKind: "NodePoolList"
			plural:   "nodepools"
			singular: "nodepool"
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
				jsonPath: ".spec.forProvider.clusterRef.name"
				name:     "CLUSTER-REF"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "A NodePool is a managed resource that represents a Google Kubernetes Engine node pool."

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
						description: "A NodePoolSpec defines the desired state of a NodePool."
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
								description: "NodePoolParameters define the desired state of a Google Kubernetes Engine node pool."

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
									cluster: {
										description: "Cluster: The resource link for the GKE cluster to which the NodePool will attach. Must be of format projects/projectID/locations/clusterLocation/clusters/clusterName. Must be supplied if ClusterRef is not."

										type: "string"
									}
									clusterRef: {
										description: "ClusterRef sets the Cluster field by resolving the resource link of the referenced Crossplane GKECluster managed resource."

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
										required: [
											"name",
										]
										type: "object"
									}
									clusterSelector: {
										description: "ClusterSelector selects a reference to resolve the resource link of the referenced Crossplane GKECluster managed resource."

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
									config: {
										description: "Config: The node configuration of the pool."
										properties: {
											accelerators: {
												description: "Accelerators: A list of hardware accelerators to be attached to each node. See https://cloud.google.com/compute/docs/gpus for more information about support for GPUs."

												items: {
													description: "AcceleratorConfig represents a Hardware Accelerator request."

													properties: {
														acceleratorCount: {
															description: "AcceleratorCount: The number of the accelerator cards exposed to an instance."

															format: "int64"
															type:   "integer"
														}
														acceleratorType: {
															description: "AcceleratorType: The accelerator type resource name. List of supported accelerators [here](/compute/docs/gpus/#Introduction)"

															type: "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
											bootDiskKmsKey: {
												description: "BootDiskKmsKey:  The Customer Managed Encryption Key used to encrypt the boot disk attached to each node in the node pool. This should be of the form projects/[KEY_PROJECT_ID]/locations/[LOCATION]/keyRings/[RING_NAME]/cr yptoKeys/[KEY_NAME]. For more information about protecting resources with Cloud KMS Keys please see: https://cloud.google.com/compute/docs/disks/customer-managed-encryption"

												type: "string"
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
											kubeletConfig: {
												description: "KubeletConfig: Node kubelet configs."
												properties: {
													cpuCfsQuota: {
														description: "CpuCfsQuota: Enable CPU CFS quota enforcement for containers that specify CPU limits. This option is enabled by default which makes kubelet use CFS quota (https://www.kernel.org/doc/Documentation/scheduler/sched-bwc.txt) to enforce container CPU limits. Otherwise, CPU limits will not be enforced at all. Disable this option to mitigate CPU throttling problems while still having your pods to be in Guaranteed QoS class by specifying the CPU limits. The default value is 'true' if unspecified."

														type: "boolean"
													}
													cpuCfsQuotaPeriod: {
														description: "CpuCfsQuotaPeriod: Set the CPU CFS quota period value 'cpu.cfs_period_us'. The string must be a sequence of decimal numbers, each with optional fraction and a unit suffix, such as \"300ms\". Valid time units are \"ns\", \"us\" (or \"µs\"), \"ms\", \"s\", \"m\", \"h\". The value must be a positive duration."

														type: "string"
													}
													cpuManagerPolicy: {
														description: "CpuManagerPolicy: Control the CPU management policy on the node. See https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/ The following values are allowed. - \"none\": the default, which represents the existing scheduling behavior. - \"static\": allows pods with certain resource characteristics to be granted increased CPU affinity and exclusivity on the node. The default value is 'none' if unspecified."

														type: "string"
													}
												}
												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Labels: The map of Kubernetes labels (key/value pairs) to be applied to each node. These will added in addition to any default label(s) that Kubernetes may apply to the node. In case of conflict in label keys, the applied set may differ depending on the Kubernetes version -- it's best to assume the behavior is undefined and conflicts should be avoided. For more information, including usage and the valid values, see: https://kubernetes.io/docs/concepts/overview/working-with-objects /labels/"

												type: "object"
											}
											linuxNodeConfig: {
												description: "LinuxNodeConfig: Parameters that can be configured on Linux nodes."

												properties: sysctls: {
													additionalProperties: type: "string"
													description: "Sysctls: The Linux kernel parameters to be applied to the nodes and all pods running on the nodes. The following parameters are supported. net.core.netdev_max_backlog net.core.rmem_max net.core.wmem_default net.core.wmem_max net.core.optmem_max net.core.somaxconn net.ipv4.tcp_rmem net.ipv4.tcp_wmem net.ipv4.tcp_tw_reuse"

													type: "object"
												}
												required: ["sysctls"]
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
		MachineType: The name of a Google Compute Engine [machine type](/compute/docs/machine-types) (e.g. `n1-standard-1`). 
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
											nodeGroup: {
												description: "NodeGroup: Setting this field will assign instances of this pool to run on the specified node group. This is useful for running workloads on sole tenant nodes (https://cloud.google.com/compute/docs/nodes/sole-tenant-nodes)."

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
											reservationAffinity: {
												description: "ReservationAffinity: The optional reservation affinity. Setting this field will apply the specified Zonal Compute Reservation (https://cloud.google.com/compute/docs/instances/reserving-zonal-resources) to this node pool."

												properties: {
													consumeReservationType: {
														description: """
		ConsumeReservationType: Corresponds to the type of reservation consumption. 
		 Possible values: \"UNSPECIFIED\" - Default value. This should not be used. \"NO_RESERVATION\" - Do not consume from any reserved capacity. \"ANY_RESERVATION\" - Consume any reservation available. \"SPECIFIC_RESERVATION\" - Must consume from a specific reservation. Must specify key value fields for specifying the reservations.
		"""

														type: "string"
													}
													key: {
														description: "Key: Corresponds to the label key of a reservation resource. To target a SPECIFIC_RESERVATION by name, specify \"googleapis.com/reservation-name\" as the key and specify the name of your reservation as its value."

														type: "string"
													}
													values: {
														description: "Values: Corresponds to the label value(s) of reservation resource(s)."

														items: type: "string"
														type: "array"
													}
												}
												type: "object"
											}
											sandboxConfig: {
												description: "SandboxConfig: Sandbox configuration for this node."

												properties: type: {
													description: """
		Type: Type of the sandbox to use for the node. 
		 Possible values: \"UNSPECIFIED\" - Default value. This should not be used. \"GVISOR\" - Run sandbox using gvisor.
		"""

													type: "string"
												}
												required: ["type"]
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
													description: """
		NodeTaint is a Kubernetes taint is comprised of three fields: key, value, and effect. Effect can only be one of three types:  NoSchedule, PreferNoSchedule or NoExecute. 
		 For more information, including usage and the valid values, see: https://kubernetes.io/docs/concepts/configuration/taint-and-toler ation/
		"""

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
													required: [
														"effect",
														"key",
														"value",
													]
													type: "object"
												}
												type: "array"
											}
											workloadMetadataConfig: {
												description: "WorkloadMetadataConfig: The workload metadata configuration for this node."

												properties: mode: {
													description: """
		Mode: Mode is the configuration for how to expose metadata to workloads running on the node pool. 
		 Possible values: \"MODE_UNSPECIFIED\" - Not set. \"GCE_METADATA\" - Expose all Compute Engine metadata to pods. \"GKE_METADATA\" - Run the GKE Metadata Server on this node. The GKE Metadata Server exposes a metadata API to workloads that is compatible with the V1 Compute Metadata APIs exposed by the Compute Engine and App Engine Metadata Servers. This feature can only be enabled if Workload Identity is enabled at the cluster level.
		"""

													type: "string"
												}
												required: ["mode"]
												type: "object"
											}
										}
										type: "object"
									}
									initialNodeCount: {
										description: "InitialNodeCount: The initial node count for the pool. You must ensure that your Compute Engine <a href=\"/compute/docs/resource-quotas\">resource quota</a> is sufficient for this number of instances. You must also have available firewall and routes quota."

										format: "int64"
										type:   "integer"
									}
									locations: {
										description: "Locations: The list of Google Compute Engine [zones](/compute/docs/zones#available) in which the NodePool's nodes should be located."

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
									upgradeSettings: {
										description: "UpgradeSettings: Upgrade settings control disruption and speed of the upgrade."

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
									version: {
										description: "Version: The version of the Kubernetes of this node."
										type:        "string"
									}
								}
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
						description: "A NodePoolStatus represents the observed state of a NodePool."
						properties: {
							atProvider: {
								description: "NodePoolObservation is used to show the observed state of the GKE Node Pool resource on GCP."

								properties: {
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
									instanceGroupUrls: {
										description: "InstanceGroupUrls: The resource URLs of the [managed instance groups](/compute/docs/instance-groups/creating-groups-of-mana ged-instances) associated with this node pool."

										items: type: "string"
										type: "array"
									}
									management: {
										description: "Management: NodeManagement configuration for this NodePool."

										properties: upgradeOptions: {
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
										type: "object"
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
								}
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
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
