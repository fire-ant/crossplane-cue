package kinesis_aws_crossplane_io_streams

customresourcedefinition: "streams.kinesis.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "streams.kinesis.aws.crossplane.io"
	}
	spec: {
		group: "kinesis.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Stream"
			listKind: "StreamList"
			plural:   "streams"
			singular: "stream"
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
				jsonPath: ".metadata.annotations.crossplane\\.io/external-name"
				name:     "EXTERNAL-NAME"
				type:     "string"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "Stream is the Schema for the Streams API"
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
						description: "StreamSpec defines the desired state of Stream"
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
								description: "StreamParameters defines the desired state of Stream"
								properties: {
									enforceConsumerDeletion: {
										description: "If this parameter is unset (null) or if you set it to false, and the stream has registered consumers, the call to DeleteStream fails with a ResourceInUseException."

										type: "boolean"
									}
									enhancedMetrics: {
										description: """
		List of shard-level metrics. 
		 The following are the valid shard-level metrics. The value \"ALL\" enhances every metric. 
		 * IncomingBytes 
		 * IncomingRecords 
		 * OutgoingBytes 
		 * OutgoingRecords 
		 * WriteProvisionedThroughputExceeded 
		 * ReadProvisionedThroughputExceeded 
		 * IteratorAgeMilliseconds 
		 * ALL 
		 For more information, see Monitoring the Amazon Kinesis Data Streams Service with Amazon CloudWatch (https://docs.aws.amazon.com/kinesis/latest/dev/monitoring-with-cloudwatch.html) in the Amazon Kinesis Data Streams Developer Guide.
		"""

										items: {
											properties: shardLevelMetrics: {
												items: type: "string"
												type: "array"
											}
											type: "object"
										}
										type: "array"
									}
									kmsKeyARN: type: "string"
									kmsKeyARNRef: {
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
									kmsKeyARNSelector: {
										description: "A Selector selects an object."
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
									region: {
										description: "Region is which region the Stream will be created."
										type:        "string"
									}
									retentionPeriodHours: {
										description: "The retention period of the stream, in hours. Default: 24 hours"

										format: "int64"
										type:   "integer"
									}
									shardCount: {
										description: "The number of shards that the stream will use. The throughput of the stream is a function of the number of shards; more shards are required for greater provisioned throughput."

										format: "int64"
										type:   "integer"
									}
									streamModeDetails: {
										description: "Indicates the capacity mode of the data stream. Currently, in Kinesis Data Streams, you can choose between an on-demand capacity mode and a provisioned capacity mode for your data streams."

										properties: streamMode: type: "string"
										type: "object"
									}
									tags: {
										items: {
											description: "CustomTag contains the additional fields for Tag."
											properties: {
												key: {
													description: "A unique identifier for the tag."
													type:        "string"
												}
												value: {
													description: "An optional string, typically used to describe or define the tag."

													type: "string"
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
						description: "StreamStatus defines the observed state of Stream."
						properties: {
							atProvider: {
								description: "StreamObservation defines the observed state of Stream"
								properties: {
									encryptionType: {
										description: """
		The server-side encryption type used on the stream. This parameter can be one of the following values: 
		 * NONE: Do not encrypt the records in the stream. 
		 * KMS: Use server-side encryption on the records in the stream using a customer-managed Amazon Web Services KMS key.
		"""

										type: "string"
									}
									enhancedMonitoring: {
										description: "Represents the current enhanced monitoring settings of the stream."

										items: {
											properties: shardLevelMetrics: {
												items: type: "string"
												type: "array"
											}
											type: "object"
										}
										type: "array"
									}
									hasMoreShards: {
										description: "If set to true, more shards in the stream are available to describe."

										type: "boolean"
									}
									keyID: {
										description: """
		The GUID for the customer-managed Amazon Web Services KMS key to use for encryption. This value can be a globally unique identifier, a fully specified ARN to either an alias or a key, or an alias name prefixed by \"alias/\".You can also use a master key owned by Kinesis Data Streams by specifying the alias aws/kinesis. 
		 * Key ARN example: arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012 
		 * Alias ARN example: arn:aws:kms:us-east-1:123456789012:alias/MyAliasName 
		 * Globally unique key ID example: 12345678-1234-1234-1234-123456789012 
		 * Alias name example: alias/MyAliasName 
		 * Master key owned by Kinesis Data Streams: alias/aws/kinesis
		"""

										type: "string"
									}
									retentionPeriodHours: {
										description: "The current retention period, in hours. Minimum value of 24. Maximum value of 168."

										format: "int64"
										type:   "integer"
									}
									shards: {
										description: "The shards that comprise the stream."
										items: {
											properties: {
												adjacentParentShardID: type: "string"
												hashKeyRange: {
													description: "The range of possible hash key values for the shard, which is a set of ordered contiguous positive integers."

													properties: {
														endingHashKey: type: "string"
														startingHashKey: type: "string"
													}
													type: "object"
												}
												parentShardID: type: "string"
												sequenceNumberRange: {
													description: "The range of possible sequence numbers for the shard."

													properties: {
														endingSequenceNumber: type: "string"
														startingSequenceNumber: type: "string"
													}
													type: "object"
												}
												shardID: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									streamARN: {
										description: "The Amazon Resource Name (ARN) for the stream being described."

										type: "string"
									}
									streamStatus: {
										description: """
		The current status of the stream being described. The stream status is one of the following states: 
		 * CREATING - The stream is being created. Kinesis Data Streams immediately returns and sets StreamStatus to CREATING. 
		 * DELETING - The stream is being deleted. The specified stream is in the DELETING state until Kinesis Data Streams completes the deletion. 
		 * ACTIVE - The stream exists and is ready for read and write operations or deletion. You should perform read and write operations only on an ACTIVE stream. 
		 * UPDATING - Shards in the stream are being merged or split. Read and write operations continue to work while the stream is in the UPDATING state.
		"""

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
