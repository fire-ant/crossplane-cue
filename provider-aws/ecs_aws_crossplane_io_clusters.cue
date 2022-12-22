package ecs_aws_crossplane_io_clusters

customresourcedefinition: "clusters.ecs.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "clusters.ecs.aws.crossplane.io"
	}
	spec: {
		group: "ecs.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
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
				jsonPath: ".metadata.annotations.crossplane\\.io/external-name"
				name:     "EXTERNAL-NAME"
				type:     "string"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "Cluster is the Schema for the Clusters API"
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
						description: "ClusterSpec defines the desired state of Cluster"
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
								description: "ClusterParameters defines the desired state of Cluster"
								properties: {
									capacityProviders: {
										description: """
		The short name of one or more capacity providers to associate with the cluster. A capacity provider must be associated with a cluster before it can be included as part of the default capacity provider strategy of the cluster or used in a capacity provider strategy when calling the CreateService or RunTask actions. 
		 If specifying a capacity provider that uses an Auto Scaling group, the capacity provider must be created but not associated with another cluster. New Auto Scaling group capacity providers can be created with the CreateCapacityProvider API operation. 
		 To use a Fargate capacity provider, specify either the FARGATE or FARGATE_SPOT capacity providers. The Fargate capacity providers are available to all accounts and only need to be associated with a cluster to be used. 
		 The PutClusterCapacityProviders API operation is used to update the list of available capacity providers for a cluster after the cluster is created.
		"""

										items: type: "string"
										type: "array"
									}
									clusterName: {
										description: "The name of your cluster. If you don't specify a name for your cluster, you create a cluster that's named default. Up to 255 letters (uppercase and lowercase), numbers, underscores, and hyphens are allowed."

										type: "string"
									}
									configuration: {
										description: "The execute command configuration for the cluster."
										properties: executeCommandConfiguration: {
											description: "The details of the execute command configuration."
											properties: {
												kmsKeyID: type: "string"
												logConfiguration: {
													description: "The log configuration for the results of the execute command actions. The logs can be sent to CloudWatch Logs or an Amazon S3 bucket."

													properties: {
														cloudWatchEncryptionEnabled: type: "boolean"
														cloudWatchLogGroupName: type: "string"
														s3BucketName: type: "string"
														s3EncryptionEnabled: type: "boolean"
														s3KeyPrefix: type: "string"
													}
													type: "object"
												}
												logging: type: "string"
											}
											type: "object"
										}
										type: "object"
									}
									defaultCapacityProviderStrategy: {
										description: """
		The capacity provider strategy to set as the default for the cluster. After a default capacity provider strategy is set for a cluster, when you call the RunTask or CreateService APIs with no capacity provider strategy or launch type specified, the default capacity provider strategy for the cluster is used. 
		 If a default capacity provider strategy isn't defined for a cluster when it was created, it can be defined later with the PutClusterCapacityProviders API operation.
		"""

										items: {
											properties: {
												base: {
													format: "int64"
													type:   "integer"
												}
												capacityProvider: type: "string"
												weight: {
													format: "int64"
													type:   "integer"
												}
											}
											type: "object"
										}
										type: "array"
									}
									region: {
										description: "Region is which region the Cluster will be created."
										type:        "string"
									}
									settings: {
										description: "The setting to use when creating a cluster. This parameter is used to turn on CloudWatch Container Insights for a cluster. If this value is specified, it overrides the containerInsights value set with PutAccountSetting or PutAccountSettingDefault."

										items: {
											properties: {
												name: type: "string"
												value: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									tags: {
										description: """
		The metadata that you apply to the cluster to help you categorize and organize them. Each tag consists of a key and an optional value. You define both. 
		 The following basic restrictions apply to tags: 
		 * Maximum number of tags per resource - 50 
		 * For each resource, each tag key must be unique, and each tag key can have only one value. 
		 * Maximum key length - 128 Unicode characters in UTF-8 
		 * Maximum value length - 256 Unicode characters in UTF-8 
		 * If your tagging schema is used across multiple services and resources, remember that other services may have restrictions on allowed characters. Generally allowed characters are: letters, numbers, and spaces representable in UTF-8, and the following characters: + - = . _ : / @. 
		 * Tag keys and values are case-sensitive. 
		 * Do not use aws:, AWS:, or any upper or lowercase combination of such as a prefix for either keys or values as it is reserved for Amazon Web Services use. You cannot edit or delete tag keys or values with this prefix. Tags with this prefix do not count against your tags per resource limit.
		"""

										items: {
											properties: {
												key: type: "string"
												value: type: "string"
											}
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
						description: "ClusterStatus defines the observed state of Cluster."
						properties: {
							atProvider: {
								description: "ClusterObservation defines the observed state of Cluster"
								properties: {
									activeServicesCount: {
										description: "The number of services that are running on the cluster in an ACTIVE state. You can view these services with ListServices."

										format: "int64"
										type:   "integer"
									}
									attachments: {
										description: "The resources attached to a cluster. When using a capacity provider with a cluster, the Auto Scaling plan that's created is returned as a cluster attachment."

										items: {
											properties: {
												details: {
													items: {
														properties: {
															name: type: "string"
															value: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												id: type: "string"
												status: type: "string"
												type_: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									attachmentsStatus: {
										description: """
		The status of the capacity providers associated with the cluster. The following are the states that are returned. 
		 UPDATE_IN_PROGRESS 
		 The available capacity providers for the cluster are updating. This occurs when the Auto Scaling plan is provisioning or deprovisioning. 
		 UPDATE_COMPLETE 
		 The capacity providers have successfully updated. 
		 UPDATE_FAILED 
		 The capacity provider updates failed.
		"""

										type: "string"
									}
									clusterARN: {
										description: "The Amazon Resource Name (ARN) that identifies the cluster. The ARN contains the arn:aws:ecs namespace, followed by the Region of the cluster, the Amazon Web Services account ID of the cluster owner, the cluster namespace, and then the cluster name. For example, arn:aws:ecs:region:012345678910:cluster/test."

										type: "string"
									}
									pendingTasksCount: {
										description: "The number of tasks in the cluster that are in the PENDING state."

										format: "int64"
										type:   "integer"
									}
									registeredContainerInstancesCount: {
										description: "The number of container instances registered into the cluster. This includes container instances in both ACTIVE and DRAINING status."

										format: "int64"
										type:   "integer"
									}
									runningTasksCount: {
										description: "The number of tasks in the cluster that are in the RUNNING state."

										format: "int64"
										type:   "integer"
									}
									statistics: {
										description: """
		Additional information about your clusters that are separated by launch type. They include the following: 
		 * runningEC2TasksCount 
		 * RunningFargateTasksCount 
		 * pendingEC2TasksCount 
		 * pendingFargateTasksCount 
		 * activeEC2ServiceCount 
		 * activeFargateServiceCount 
		 * drainingEC2ServiceCount 
		 * drainingFargateServiceCount
		"""

										items: {
											properties: {
												name: type: "string"
												value: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									status: {
										description: """
		The status of the cluster. The following are the possible states that are returned. 
		 ACTIVE 
		 The cluster is ready to accept tasks and if applicable you can register container instances with the cluster. 
		 PROVISIONING 
		 The cluster has capacity providers that are associated with it and the resources needed for the capacity provider are being created. 
		 DEPROVISIONING 
		 The cluster has capacity providers that are associated with it and the resources needed for the capacity provider are being deleted. 
		 FAILED 
		 The cluster has capacity providers that are associated with it and the resources needed for the capacity provider have failed to create. 
		 INACTIVE 
		 The cluster has been deleted. Clusters with an INACTIVE status may remain discoverable in your account for a period of time. However, this behavior is subject to change in the future. We don't recommend that you rely on INACTIVE clusters persisting.
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
