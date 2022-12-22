package cache_aws_crossplane_io_cacheclusters

customresourcedefinition: "cacheclusters.cache.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "cacheclusters.cache.aws.crossplane.io"
	}
	spec: {
		group: "cache.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "CacheCluster"
			listKind: "CacheClusterList"
			plural:   "cacheclusters"
			singular: "cachecluster"
		}
		scope: "Cluster"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.atProvider.cacheClusterStatus"
				name:     "STATUS"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type=='Ready')].status"
				name:     "READY"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type=='Synced')].status"
				name:     "SYNCED"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "A CacheCluster is a managed resource that represents an AWS ElastiCache Cache Cluster."

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
						description: "A CacheClusterSpec defines the desired state of a CacheCluster."
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
								description: "CacheClusterParameters define the desired state of an AWS ElastiCache Cache Cluster. Most fields map directly to an AWS ReplicationGroup: https://docs.aws.amazon.com/AmazonElastiCache/latest/APIReference/API_CreateReplicationGroup.html#API_CreateReplicationGroup_RequestParameters"

								properties: {
									applyImmediately: {
										description: "If true, this parameter causes the modifications in this request and any pending modifications to be applied, asynchronously and as soon as possible, regardless of the PreferredMaintenanceWindow setting for the cluster. If false, changes to the cluster are applied on the next maintenance reboot, or the next failure reboot, whichever occurs first."

										type: "boolean"
									}
									authToken: {
										description: "The password used to access a password protected server."

										type: "string"
									}
									authTokenUpdateStrategy: {
										description: "Specifies the strategy to use to update the AUTH token. This parameter must be specified with the auth-token parameter. Possible values:"

										type: "string"
									}
									azMode: {
										description: "Specifies whether the nodes in this Memcached cluster are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. This parameter is only supported for Memcached clusters."

										type: "string"
									}
									cacheNodeIdsToRemove: {
										description: "A list of cache node IDs to be removed."
										items: type: "string"
										type: "array"
									}
									cacheNodeType: {
										description: "The compute and memory capacity of the nodes in the node group (shard)."

										type: "string"
									}
									cacheParameterGroupName: {
										description: "The name of the parameter group to associate with this cluster. If this argument is omitted, the default parameter group for the specified engine is used."

										type: "string"
									}
									cacheSecurityGroupNames: {
										description: "A list of security group names to associate with this cluster."

										items: type: "string"
										type: "array"
									}
									cacheSubnetGroupName: {
										description: "The name of the subnet group to be used for the cluster."
										type:        "string"
									}
									cacheSubnetGroupNameRef: {
										description: "A referencer to retrieve the name of a CacheSubnetGroup"
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
										description: "A selector to select a referencer to retrieve the name of a CacheSubnetGroup"

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
										description: "The name of the cache engine to be used for this cluster."

										type: "string"
									}
									engineVersion: {
										description: "The version number of the cache engine to be used for this cluster."

										type: "string"
									}
									notificationTopicArn: {
										description: "The Amazon Resource Name (ARN) of the Amazon Simple Notification Service (SNS) topic to which notifications are sent."

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
									numCacheNodes: {
										description: "The initial number of cache nodes that the cluster has."

										format: "int32"
										type:   "integer"
									}
									port: {
										description: "The port number on which each of the cache nodes accepts connections."

										format: "int32"
										type:   "integer"
									}
									preferredAvailabilityZone: {
										description: "The EC2 Availability Zone in which the cluster is created. Default: System chosen Availability Zone."

										type: "string"
									}
									preferredAvailabilityZones: {
										description: "A list of the Availability Zones in which cache nodes are created."

										items: type: "string"
										type: "array"
									}
									preferredMaintenanceWindow: {
										description: "Specifies the weekly time range during which maintenance on the cluster is performed."

										type: "string"
									}
									region: {
										description: "Region is the region you'd like your CacheSubnetGroup to be created in."

										type: "string"
									}
									replicationGroupId: {
										description: "The ID of the replication group to which this cluster should belong."

										type: "string"
									}
									securityGroupIDRefs: {
										description: "A referencer to retrieve the ID of a Security group"
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
									securityGroupIDSelector: {
										description: "A selector to select a referencer to retrieve the ID of a Security Group"

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
										description: "One or more VPC security groups associated with the cluster."

										items: type: "string"
										type: "array"
									}
									snapshotArns: {
										description: "A single-element string list containing an Amazon Resource Name (ARN) that uniquely identifies a Redis RDB snapshot file stored in Amazon S3."

										items: type: "string"
										type: "array"
									}
									snapshotName: {
										description: "The name of a Redis snapshot from which to restore data into the new node group (shard)."

										type: "string"
									}
									snapshotRetentionLimit: {
										description: "The number of days for which ElastiCache retains automatic snapshots before deleting them."

										format: "int32"
										type:   "integer"
									}
									snapshotWindow: {
										description: "The daily time range (in UTC) during which ElastiCache begins taking a daily snapshot of your node group (shard)."

										type: "string"
									}
									tags: {
										description: "A list of cost allocation tags to be added to this resource."

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
											]
											type: "object"
										}
										type: "array"
									}
								}
								required: [
									"cacheNodeType",
									"numCacheNodes",
									"region",
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
						description: "A CacheClusterStatus defines the observed state of a CacheCluster."
						properties: {
							atProvider: {
								description: "CacheClusterObservation contains the observation of the status of the given Cache Cluster."

								properties: {
									atRestEncryptionEnabled: {
										description: "A flag that enables encryption at-rest when set to true. Default: false"

										type: "boolean"
									}
									authTokenEnabled: {
										description: "A flag that enables using an AuthToken (password) when issuing Redis commands. Default: false"

										type: "boolean"
									}
									cacheClusterStatus: {
										description: "The current state of this cluster."
										type:        "string"
									}
									cacheNodes: {
										description: "A list of cache nodes that are members of the cluster."
										items: {
											description: "CacheNode represents a node in the cluster"
											properties: {
												cacheNodeId: {
													description: "The cache node identifier."
													type:        "string"
												}
												cacheNodeStatus: {
													description: "The current state of this cache node, one of the following values:  available, creating, deleted, deleting, incompatible-network, modifying, rebooting cluster nodes, restore-failed, or snapshotting."

													type: "string"
												}
												customerAvailabilityZone: {
													description: "The Availability Zone where this node was created and now resides."

													type: "string"
												}
												endpoint: {
													description: "The hostname for connecting to this cache node."
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
												parameterGroupStatus: {
													description: "The status of the parameter group applied to this cache node."

													type: "string"
												}
												sourceCacheNodeId: {
													description: "The ID of the primary node to which this read replica node is synchronized."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									cacheParameterGroup: {
										description: "Status of the cache parameter group."
										properties: {
											cacheNodeIdsToReboot: {
												description: "A list of the cache node IDs which need to be rebooted for parameter changes to be applied."

												items: type: "string"
												type: "array"
											}
											cacheParameterGroupName: {
												description: "The name of the cache parameter group."
												type:        "string"
											}
											parameterApplyStatus: {
												description: "The status of parameter updates."
												type:        "string"
											}
										}
										type: "object"
									}
									clientDownloadLandingPage: {
										description: "The URL of the web page where you can download the latest ElastiCache client library."

										type: "string"
									}
									configurationEndpoint: {
										description: "Represents a Memcached cluster endpoint which, if Automatic Discovery is enabled on the cluster, can be used by an application to connect to any node in the cluster. The configuration endpoint will always have .cfg in it."

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
									notificationConfiguration: {
										description: "Describes a notification topic and its status. Notification topics are used for publishing ElastiCache events to subscribers using Amazon Simple Notification Service (SNS)."

										properties: {
											topicArn: {
												description: "The Amazon Resource Name (ARN) that identifies the topic."

												type: "string"
											}
											topicStatus: {
												description: "The current state of the topic."
												type:        "string"
											}
										}
										type: "object"
									}
									pendingModifiedValues: {
										description: "A group of settings that are applied to the cluster in the future, or that are currently being applied."

										properties: {
											authTokenStatus: {
												description: "The auth token status"
												type:        "string"
											}
											cacheNodeIdsToRemove: {
												description: "A list of cache node IDs that are being removed (or will be removed) from the cluster."

												items: type: "string"
												type: "array"
											}
											cacheNodeType: {
												description: "The cache node type that this cluster or replication group is scaled to."

												type: "string"
											}
											engineVersion: {
												description: "The new cache engine version that the cluster runs."

												type: "string"
											}
											numCacheNodes: {
												description: "The new number of cache nodes for the cluster."
												format:      "int64"
												type:        "integer"
											}
										}
										type: "object"
									}
									transitEncryptionEnabled: {
										description: "A flag that enables in-transit encryption when set to true."

										type: "boolean"
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
