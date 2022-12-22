package cache_aws_crossplane_io_replicationgroups

customresourcedefinition: "replicationgroups.cache.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "replicationgroups.cache.aws.crossplane.io"
	}
	spec: {
		group: "cache.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "ReplicationGroup"
			listKind: "ReplicationGroupList"
			plural:   "replicationgroups"
			singular: "replicationgroup"
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
				jsonPath: ".spec.forProvider.engineVersion"
				name:     "VERSION"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "A ReplicationGroup is a managed resource that represents an AWS ElastiCache Replication Group."

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
						description: "A ReplicationGroupSpec defines the desired state of a ReplicationGroup."
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
								description: "ReplicationGroupParameters define the desired state of an AWS ElastiCache Replication Group. Most fields map directly to an AWS ReplicationGroup: https://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_CreateReplicationGroup.html#API_CreateReplicationGroup_RequestParameters"

								properties: {
									applyModificationsImmediately: {
										description: """
		If true, this parameter causes the modifications in this request and any pending modifications to be applied, asynchronously and as soon as possible, regardless of the PreferredMaintenanceWindow setting for the replication group. 
		 If false, changes to the nodes in the replication group are applied on the next maintenance reboot, or the next failure reboot, whichever occurs first.
		"""

										type: "boolean"
									}
									atRestEncryptionEnabled: {
										description: """
		AtRestEncryptionEnabled enables encryption at rest when set to true. 
		 You cannot modify the value of AtRestEncryptionEnabled after the replication group is created. To enable encryption at rest on a replication group you must set AtRestEncryptionEnabled to true when you create the replication group. 
		 Only available when creating a replication group in an Amazon VPC using redis version 3.2.6 or 4.x.
		"""

										type: "boolean"
									}
									authEnabled: {
										description: """
		AuthEnabled enables mandatory authentication when connecting to the managed replication group. AuthEnabled requires TransitEncryptionEnabled to be true. 
		 While ReplicationGroupSpec mirrors the fields of the upstream replication group object as closely as possible, we expose a boolean here rather than requiring the operator pass in a string authentication token. Crossplane will generate a token automatically and expose it via a Secret.
		"""

										type: "boolean"
									}
									automaticFailoverEnabled: {
										description: """
		AutomaticFailoverEnabled specifies whether a read-only replica is automatically promoted to read/write primary if the existing primary fails. Must be set to true if Multi-AZ is enabled for this replication group. If false, Multi-AZ cannot be enabled for this replication group. 
		 AutomaticFailoverEnabled must be enabled for Redis (cluster mode enabled) replication groups. 
		 Amazon ElastiCache for Redis does not support Multi-AZ with automatic failover on: * Redis versions earlier than 2.8.6. * Redis (cluster mode disabled): T1 and T2 cache node types. * Redis (cluster mode enabled): T1 node types.
		"""

										type: "boolean"
									}
									cacheNodeType: {
										description: "CacheNodeType specifies the compute and memory capacity of the nodes in the node group (shard). For a complete listing of node types and specifications, see: * Amazon ElastiCache Product Features and Details (http://aws.amazon.com/elasticache/details) * Cache Node Type-Specific Parameters for Memcached (http://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/ParameterGroups.Memcached.html#ParameterGroups.Memcached.NodeSpecific) * Cache Node Type-Specific Parameters for Redis (http://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/ParameterGroups.Redis.html#ParameterGroups.Redis.NodeSpecific)"

										type: "string"
									}
									cacheParameterGroupName: {
										description: """
		CacheParameterGroupName specifies the name of the parameter group to associate with this replication group. If this argument is omitted, the default cache parameter group for the specified engine is used. 
		 If you are running Redis version 3.2.4 or later, only one node group (shard), and want to use a default parameter group, we recommend that you specify the parameter group by name. * To create a Redis (cluster mode disabled) replication group, use CacheParameterGroupName=default.redis3.2. * To create a Redis (cluster mode enabled) replication group, use CacheParameterGroupName=default.redis3.2.cluster.on.
		"""

										type: "string"
									}
									cacheSecurityGroupNameRefs: {
										description: "CacheSecurityGroupNameRefs are references to SecurityGroups used to set the CacheSecurityGroupNames."

										items: {
											description: "A Reference to a named object."
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
										type: "array"
									}
									cacheSecurityGroupNameSelector: {
										description: "CacheSecurityGroupNameSelector selects references to SecurityGroups."

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
									cacheSecurityGroupNames: {
										description: "CacheSecurityGroupNames specifies a list of cache security group names to associate with this replication group. Only for EC2-Classic mode."

										items: type: "string"
										type: "array"
									}
									cacheSubnetGroupName: {
										description: "CacheSubnetGroupName specifies the name of the cache subnet group to be used for the replication group. If you're going to launch your cluster in an Amazon VPC, you need to create a subnet group before you start creating a cluster. For more information, see Subnets and Subnet Groups (http://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/SubnetGroups.html)."

										type: "string"
									}
									cacheSubnetGroupNameRef: {
										description: "CacheSubnetGroupNameRef is a reference to a Subnet Group used to set the CacheSubnetGroupName."

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
									cacheSubnetGroupNameRefs: {
										description: """
		DeprecatedCacheSubnetGroupNameRef is a reference to a Subnet Group used to set the CacheSubnetGroupName. 
		 Deprecated: Use CacheSubnetGroupNameRef. This field exists because we introduced it with the JSON tag cacheSubnetGroupNameRefs (plural) when it should have been cacheSubnetGroupNameRef (singular). This is a bug that we need to avoid a breaking change to this v1beta1 API.
		"""

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
									cacheSubnetGroupNameSelector: {
										description: "CacheSubnetGroupNameSelector selects a reference to a CacheSubnetGroup."

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
									engine: {
										description: "Engine is the name of the cache engine (memcached or redis) to be used for the clusters in this replication group."

										type: "string"
									}
									engineVersion: {
										description: """
		EngineVersion specifies the version number of the cache engine to be used for the clusters in this replication group. To view the supported cache engine versions, use the DescribeCacheEngineVersions operation. 
		 Important: You can upgrade to a newer engine version (see Selecting a Cache Engine and Version (http://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/SelectEngine.html#VersionManagement)) in the ElastiCache User Guide, but you cannot downgrade to an earlier engine version. If you want to use an earlier engine version, you must delete the existing cluster or replication group and create it anew with the earlier engine version.
		"""

										type: "string"
									}
									multiAZEnabled: {
										description: "MultiAZEnabled specifies if Multi-AZ is enabled to enhance fault tolerance You must have nodes across two or more Availability Zones in order to enable this feature. If this feature is set, automaticFailoverEnabled must be set to true."

										type: "boolean"
									}
									nodeGroupConfiguration: {
										description: """
		NodeGroupConfigurationSpec specifies a list of node group (shard) configuration options. 
		 If you're creating a Redis (cluster mode disabled) or a Redis (cluster mode enabled) replication group, you can use this parameter to individually configure each node group (shard), or you can omit this parameter. However, when seeding a Redis (cluster mode enabled) cluster from a S3 rdb file, you must configure each node group (shard) using this parameter because you must specify the slots for each node group.
		"""

										items: {
											description: "A NodeGroupConfigurationSpec specifies the desired state of a node group."

											properties: {
												primaryAvailabilityZone: {
													description: "PrimaryAvailabilityZone specifies the Availability Zone where the primary node of this node group (shard) is launched."

													type: "string"
												}
												replicaAvailabilityZones: {
													description: "ReplicaAvailabilityZones specifies a list of Availability Zones to be used for the read replicas. The number of Availability Zones in this list must match the value of ReplicaCount or ReplicasPerNodeGroup if not specified."

													items: type: "string"
													type: "array"
												}
												replicaCount: {
													description: "ReplicaCount specifies the number of read replica nodes in this node group (shard)."

													type: "integer"
												}
												slots: {
													description: """
		Slots specifies the keyspace for a particular node group. Keyspaces range from 0 to 16,383. The string is in the format startkey-endkey. 
		 Example: \"0-3999\"
		"""

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									notificationTopicArn: {
										description: "NotificationTopicARN specifies the Amazon Resource Name (ARN) of the Amazon Simple Notification Service (SNS) topic to which notifications are sent. The Amazon SNS topic owner must be the same as the cluster owner."

										type: "string"
									}
									notificationTopicArnRef: {
										description: "NotificationTopicARNRef references an SNS Topic to retrieve its NotificationTopicARN"

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
									notificationTopicArnSelector: {
										description: "NotificationTopicARNSelector selects a reference to an SNS Topic to retrieve its NotificationTopicARN"

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
									notificationTopicStatus: {
										description: """
		NotificationTopicStatus is the status of the Amazon SNS notification topic for the replication group. Notifications are sent only if the status is active. 
		 Valid values: active | inactive
		"""

										type: "string"
									}
									numCacheClusters: {
										description: """
		NumCacheClusters specifies the number of clusters this replication group initially has. This parameter is not used if there is more than one node group (shard). You should use ReplicasPerNodeGroup instead. 
		 If AutomaticFailoverEnabled is true, the value of this parameter must be at least 2. If AutomaticFailoverEnabled is false you can omit this parameter (it will default to 1), or you can explicitly set it to a value between 2 and 6. 
		 The maximum permitted value for NumCacheClusters is 6 (1 primary plus 5 replicas).
		"""

										maximum: 6
										type:    "integer"
									}
									numNodeGroups: {
										description: """
		NumNodeGroups specifies the number of node groups (shards) for this Redis (cluster mode enabled) replication group. For Redis (cluster mode disabled) either omit this parameter or set it to 1. 
		 Default: 1
		"""

										type: "integer"
									}
									port: {
										description: "Port number on which each member of the replication group accepts connections."

										type: "integer"
									}
									preferredCacheClusterAzs: {
										description: """
		PreferredCacheClusterAZs specifies a list of EC2 Availability Zones in which the replication group's clusters are created. The order of the Availability Zones in the list is the order in which clusters are allocated. The primary cluster is created in the first AZ in the list. 
		 This parameter is not used if there is more than one node group (shard). You should use NodeGroupConfigurationSpec instead. 
		 If you are creating your replication group in an Amazon VPC (recommended), you can only locate clusters in Availability Zones associated with the subnets in the selected subnet group. 
		 The number of Availability Zones listed must equal the value of NumCacheClusters. 
		 Default: system chosen Availability Zones.
		"""

										items: type: "string"
										type: "array"
									}
									preferredMaintenanceWindow: {
										description: """
		PreferredMaintenanceWindow specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. 
		 Example: sun:23:00-mon:01:30
		"""

										type: "string"
									}
									primaryClusterId: {
										description: """
		PrimaryClusterId is the identifier of the cluster that serves as the primary for this replication group. This cluster must already exist and have a status of available. 
		 This parameter is not required if NumCacheClusters, NumNodeGroups or ReplicasPerNodeGroup is specified.
		"""

										type: "string"
									}
									region: {
										description: "Region is the region you'd like your ReplicationGroup to be created in."

										type: "string"
									}
									replicasPerNodeGroup: {
										description: "ReplicasPerNodeGroup specifies the number of replica nodes in each node group (shard). Valid values are 0 to 5."

										type: "integer"
									}
									replicationGroupDescription: {
										description: "ReplicationGroupDescription is the description for the replication group."

										type: "string"
									}
									securityGroupIdRefs: {
										description: "SecurityGroupIDRefs are references to SecurityGroups used to set the SecurityGroupIDs."

										items: {
											description: "A Reference to a named object."
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
										type: "array"
									}
									securityGroupIdSelector: {
										description: "SecurityGroupIDSelector selects references to SecurityGroups used to set the SecurityGroupIDs."

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
									securityGroupIds: {
										description: "SecurityGroupIDs specifies one or more Amazon VPC security groups associated with this replication group. Use this parameter only when you are creating a replication group in an Amazon VPC."

										items: type: "string"
										type: "array"
									}
									snapshotArns: {
										description: "SnapshotARNs specifies a list of Amazon Resource Names (ARN) that uniquely identify the Redis RDB snapshot files stored in Amazon S3. The snapshot files are used to populate the new replication group. The Amazon S3 object name in the ARN cannot contain any commas. The new replication group will have the number of node groups (console: shards) specified by the parameter NumNodeGroups or the number of node groups configured by NodeGroupConfigurationSpec regardless of the number of ARNs specified here."

										items: type: "string"
										type: "array"
									}
									snapshotName: {
										description: "SnapshotName specifies the name of a snapshot from which to restore data into the new replication group. The snapshot status changes to restoring while the new replication group is being created."

										type: "string"
									}
									snapshotRetentionLimit: {
										description: "SnapshotRetentionLimit specifies the number of days for which ElastiCache retains automatic snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, a snapshot that was taken today is retained for 5 days before being deleted. Default: 0 (i.e., automatic backups are disabled for this cluster)."

										type: "integer"
									}
									snapshotWindow: {
										description: """
		SnapshotWindow specifies the daily time range (in UTC) during which ElastiCache begins taking a daily snapshot of your node group (shard). 
		 Example: 05:00-09:00 
		 If you do not specify this parameter, ElastiCache automatically chooses an appropriate time range.
		"""

										type: "string"
									}
									snapshottingClusterID: {
										description: "SnapshottingClusterID is used as the daily snapshot source for the replication group. This parameter cannot be set for Redis (cluster mode enabled) replication groups."

										type: "string"
									}
									tags: {
										description: "A list of cost allocation tags to be added to this resource. A tag is a key-value pair."

										items: {
											description: "A Tag is used to tag the ElastiCache resources in AWS."

											properties: {
												key: {
													description: "Key for the tag."
													type:        "string"
												}
												value: {
													description: "Value of the tag."
													type:        "string"
												}
											}
											required: [
												"key",
												"value",
											]
											type: "object"
										}
										type: "array"
									}
									transitEncryptionEnabled: {
										description: """
		TransitEncryptionEnabled enables in-transit encryption when set to true. 
		 You cannot modify the value of TransitEncryptionEnabled after the cluster is created. To enable in-transit encryption on a cluster you must TransitEncryptionEnabled to true when you create a cluster. 
		 This parameter is valid only if the Engine parameter is redis, the EngineVersion parameter is 3.2.6 or 4.x, and the cluster is being created in an Amazon VPC. 
		 If you enable in-transit encryption, you must also specify a value for CacheSubnetGroup. 
		 Required: Only available when creating a replication group in an Amazon VPC using redis version 3.2.6 or 4.x. 
		 Default: false 
		 For HIPAA compliance, you must specify TransitEncryptionEnabled as true, an AuthToken, and a CacheSubnetGroup.
		"""

										type: "boolean"
									}
								}
								required: [
									"applyModificationsImmediately",
									"cacheNodeType",
									"engine",
									"replicationGroupDescription",
								]
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
								required: [
									"name",
								]
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
								required: [
									"name",
								]
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
										required: [
											"name",
										]
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
								required: [
									"name",
								]
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
						required: [
							"forProvider",
						]
						type: "object"
					}
					status: {
						description: "A ReplicationGroupStatus defines the observed state of a ReplicationGroup."

						properties: {
							atProvider: {
								description: "ReplicationGroupObservation contains the observation of the status of the given ReplicationGroup."

								properties: {
									automaticFailoverStatus: {
										description: "AutomaticFailover indicates the status of Multi-AZ with automatic failover for this Redis replication group."

										type: "string"
									}
									clusterEnabled: {
										description: "ClusterEnabled is a flag indicating whether or not this replication group is cluster enabled; i.e., whether its data can be partitioned across multiple shards (API/CLI: node groups)."

										type: "boolean"
									}
									configurationEndpoint: {
										description: "ConfigurationEndpoint for this replication group. Use the configuration endpoint to connect to this replication group."

										properties: {
											address: {
												description: "Address is the DNS hostname of the cache node."
												type:        "string"
											}
											port: {
												description: "Port number that the cache engine is listening on."

												type: "integer"
											}
										}
										type: "object"
									}
									memberClusters: {
										description: "MemberClusters is the list of names of all the cache clusters that are part of this replication group."

										items: type: "string"
										type: "array"
									}
									nodeGroups: {
										description: "NodeGroups is a list of node groups in this replication group. For Redis (cluster mode disabled) replication groups, this is a single-element list. For Redis (cluster mode enabled) replication groups, the list contains an entry for each node group (shard)."

										items: {
											description: "NodeGroup represents a collection of cache nodes in a replication group. One node in the node group is the read/write primary node. All the other nodes are read-only Replica nodes. Please also see https://docs.aws.amazon.com/goto/WebAPI/elasticache-2015-02-02/NodeGroup"

											properties: {
												nodeGroupID: {
													description: "NodeGroupID is the identifier for the node group (shard). A Redis (cluster mode disabled) replication group contains only 1 node group; therefore, the node group ID is 0001. A Redis (cluster mode enabled) replication group contains 1 to 15 node groups numbered 0001 to 0015."

													type: "string"
												}
												nodeGroupMembers: {
													description: "NodeGroupMembers is a list containing information about individual nodes within the node group (shard)."

													items: {
														description: "NodeGroupMember represents a single node within a node group (shard). Please also see https://docs.aws.amazon.com/goto/WebAPI/elasticache-2015-02-02/NodeGroupMember"

														properties: {
															cacheClusterId: {
																description: "CacheClusterID is the ID of the cluster to which the node belongs."

																type: "string"
															}
															cacheNodeId: {
																description: "CacheNodeID is the ID of the node within its cluster. A node ID is a numeric identifier (0001, 0002, etc.)."

																type: "string"
															}
															currentRole: {
																description: "CurrentRole is the role that is currently assigned to the node - primary or replica. This member is only applicable for Redis (cluster mode disabled) replication groups."

																type: "string"
															}
															preferredAvailabilityZone: {
																description: "PreferredAvailabilityZone is the name of the Availability Zone in which the node is located."

																type: "string"
															}
															readEndpoint: {
																description: "ReadEndpoint is the information required for client programs to connect to a node for read operations. The read endpoint is only applicable on Redis (cluster mode disabled) clusters."

																properties: {
																	address: {
																		description: "Address is the DNS hostname of the cache node."

																		type: "string"
																	}
																	port: {
																		description: "Port number that the cache engine is listening on."

																		type: "integer"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
												primaryEndpoint: {
													description: "PrimaryEndpoint is the endpoint of the primary node in this node group (shard)."

													properties: {
														address: {
															description: "Address is the DNS hostname of the cache node."

															type: "string"
														}
														port: {
															description: "Port number that the cache engine is listening on."

															type: "integer"
														}
													}
													type: "object"
												}
												slots: {
													description: "Slots is the keyspace for this node group (shard)."
													type:        "string"
												}
												status: {
													description: "Status of this replication group - creating, available, etc."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									pendingModifiedValues: {
										description: "PendingModifiedValues is a group of settings to be applied to the replication group, either immediately or during the next maintenance window."

										properties: {
											automaticFailoverStatus: {
												description: "AutomaticFailoverStatus indicates the status of Multi-AZ with automatic failover for this Redis replication group."

												type: "string"
											}
											primaryClusterId: {
												description: "PrimaryClusterID that is applied immediately or during the next maintenance window."

												type: "string"
											}
											resharding: {
												description: "Resharding is the status of an online resharding operation."

												properties: slotMigration: {
													description: "Represents the progress of an online resharding operation."

													properties: progressPercentage: {
														description: "ProgressPercentage is the percentage of the slot migration that is complete."

														type: "integer"
													}
													required: [
														"progressPercentage",
													]
													type: "object"
												}
												required: [
													"slotMigration",
												]
												type: "object"
											}
										}
										type: "object"
									}
									status: {
										description: "Status is the current state of this replication group - creating, available, modifying, deleting, create-failed, snapshotting."

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
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
	status: {
		acceptedNames: {
			kind:   ""
			plural: ""
		}
		conditions: []
		storedVersions: []
	}
}
