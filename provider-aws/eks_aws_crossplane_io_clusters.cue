package eks_aws_crossplane_io_clusters

customresourcedefinition: "clusters.eks.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "clusters.eks.aws.crossplane.io"
	}
	spec: {
		group: "eks.aws.crossplane.io"
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
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "A Cluster is a managed resource that represents an AWS Elastic Kubernetes Service cluster."

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
						description: "A ClusterSpec defines the desired state of an EKS Cluster."
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
								description: "ClusterParameters define the desired state of an AWS Elastic Kubernetes Service cluster."

								properties: {
									encryptionConfig: {
										description: "The encryption configuration for the cluster."
										items: {
											description: "EncryptionConfig is the encryption configuration for a cluster."

											properties: {
												provider: {
													description: "AWS Key Management Service (AWS KMS) customer master key (CMK). Either the ARN or the alias can be used."

													properties: keyArn: {
														description: "Amazon Resource Name (ARN) or alias of the customer master key (CMK). The CMK must be symmetric, created in the same region as the cluster, and if the CMK was created in a different account, the user must have access to the CMK. For more information, see Allowing Users in Other Accounts to Use a CMK (https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-modifying-external-accounts.html) in the AWS Key Management Service Developer Guide."

														type: "string"
													}
													required: [
														"keyArn",
													]
													type: "object"
												}
												resources: {
													description: "Specifies the resources to be encrypted. The only supported value is \"secrets\"."

													items: type: "string"
													type: "array"
												}
											}
											required: [
												"provider",
												"resources",
											]
											type: "object"
										}
										type: "array"
									}
									logging: {
										description: """
		Enable or disable exporting the Kubernetes control plane logs for your cluster to CloudWatch Logs. By default, cluster control plane logs aren't exported to CloudWatch Logs. For more information, see Amazon EKS Cluster Control Plane Logs (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) in the Amazon EKS User Guide . 
		 CloudWatch Logs ingestion, archive storage, and data scanning rates apply to exported control plane logs. For more information, see Amazon CloudWatch Pricing (http://aws.amazon.com/cloudwatch/pricing/).
		"""

										properties: clusterLogging: {
											description: "The cluster control plane logging configuration for your cluster."

											items: {
												description: "LogSetup specifies the logging types that are enabled."

												properties: {
													enabled: {
														description: "If a log type is enabled, that log type exports its control plane logs to CloudWatch Logs. If a log type isn't enabled, that log type doesn't export its control plane logs. Each individual log type can be enabled or disabled independently."

														type: "boolean"
													}
													types: {
														description: "The available cluster control plane log types."

														items: {
															description: "LogType is a type of logging."
															type:        "string"
														}
														type: "array"
													}
												}
												type: "object"
											}
											type: "array"
										}
										required: [
											"clusterLogging",
										]
										type: "object"
									}
									outpostConfig: {
										description: "An object representing the configuration of your local Amazon EKS cluster on an Amazon Web Services Outpost. Before creating a local cluster on an Outpost, review Creating an Amazon EKS cluster on an Amazon Web Services Outpost (https://docs.aws.amazon.com/eks/latest/userguide/create-cluster-outpost.html) in the Amazon EKS User Guide. This object isn't available for creating Amazon EKS clusters on the Amazon Web Services cloud."

										properties: {
											controlPlaneInstanceType: {
												description: """
		The Amazon EC2 instance type that you want to use for your local Amazon EKS cluster on Outposts. The instance type that you specify is used for all Kubernetes control plane instances. The instance type can't be changed after cluster creation. Choose an instance type based on the number of nodes that your cluster will have. If your cluster will have: 
		 * 1–20 nodes, then we recommend specifying a large instance type. 
		 * 21–100 nodes, then we recommend specifying an xlarge instance type. 
		 * 101–250 nodes, then we recommend specifying a 2xlarge instance type. 
		 For a list of the available Amazon EC2 instance types, see Compute and storage in Outposts rack features (http://aws.amazon.com/outposts/rack/features/). The control plane is not automatically scaled by Amazon EKS. 
		 This member is required.
		"""

												type: "string"
											}
											outpostArns: {
												description: """
		The ARN of the Outpost that you want to use for your local Amazon EKS cluster on Outposts. Only a single Outpost ARN is supported. 
		 This member is required.
		"""

												items: type: "string"
												type: "array"
											}
										}
										required: [
											"controlPlaneInstanceType",
											"outpostArns",
										]
										type: "object"
									}
									region: {
										description: "Region is the region you'd like your Cluster to be created in."

										type: "string"
									}
									resourcesVpcConfig: {
										description: """
		The VPC configuration used by the cluster control plane. Amazon EKS VPC resources have specific requirements to work properly with Kubernetes. For more information, see Cluster VPC Considerations (https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html) and Cluster Security Group Considerations (https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html) in the Amazon EKS User Guide. You must specify at least two subnets. You can specify up to five security groups, but we recommend that you use a dedicated security group for your cluster control plane. 
		 ResourcesVpcConfig is a required field
		"""

										properties: {
											endpointPrivateAccess: {
												description: "Set this value to true to enable private access for your cluster's Kubernetes API server endpoint. If you enable private access, Kubernetes API requests from within your cluster's VPC use the private VPC endpoint. The default value for this parameter is false, which disables private access for your Kubernetes API server. For more information, see Amazon EKS Cluster Endpoint Access Control (https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html) in the Amazon EKS User Guide."

												type: "boolean"
											}
											endpointPublicAccess: {
												description: "Set this value to false to disable public access for your cluster's Kubernetes API server endpoint. If you disable public access, your cluster's Kubernetes API server can receive only requests from within the cluster VPC. The default value for this parameter is true, which enables public access for your Kubernetes API server. For more information, see Amazon EKS Cluster Endpoint Access Control (https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html) in the Amazon EKS User Guide."

												type: "boolean"
											}
											publicAccessCidrs: {
												description: "The CIDR blocks that are allowed access to your cluster's public Kubernetes API server endpoint. Communication to the endpoint from addresses outside of the CIDR blocks that you specify is denied. The default value is 0.0.0.0/0. If you've disabled private endpoint access and you have worker nodes or AWS Fargate pods in the cluster, then ensure that you specify the necessary CIDR blocks. For more information, see Amazon EKS Cluster Endpoint Access Control (https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html) in the Amazon EKS User Guide."

												items: type: "string"
												type: "array"
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
													required: ["name"]
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
												description: "Specify one or more security groups for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane. If you don't specify a security group, the default security group for your VPC is used."

												items: type: "string"
												type: "array"
											}
											subnetIdRefs: {
												description: "SubnetIDRefs are references to Subnets used to set the SubnetIDs."

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
													required: ["name"]
													type: "object"
												}
												type: "array"
											}
											subnetIdSelector: {
												description: "SubnetIDSelector selects references to Subnets used to set the SubnetIDs."

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
											subnetIds: {
												description: "Specify subnets for your Amazon EKS worker nodes. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."

												items: type: "string"
												type: "array"
											}
										}
										type: "object"
									}
									roleArn: {
										description: """
		The Amazon Resource Name (ARN) of the IAM role that provides permissions for Amazon EKS to make calls to other AWS API operations on your behalf. For more information, see Amazon EKS Service IAM Role (https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html) in the Amazon EKS User Guide . 
		 RoleArn is a required field
		"""

										type: "string"
									}
									roleArnRef: {
										description: "RoleArnRef is a reference to an IAMRole used to set the RoleArn."

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
									roleArnSelector: {
										description: "RoleArnSelector selects references to IAMRole used to set the RoleArn."

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
									tags: {
										additionalProperties: type: "string"
										description: "The metadata to apply to the cluster to assist with categorization and organization. Each tag consists of a key and an optional value, both of which you define."

										type: "object"
									}
									version: {
										description: "The desired Kubernetes version for your cluster. If you don't specify a value here, the latest version available in Amazon EKS is used. Example: 1.15"

										type: "string"
									}
								}
								required: ["resourcesVpcConfig"]
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
						description: "A ClusterStatus represents the observed state of an EKS Cluster."
						properties: {
							atProvider: {
								description: "ClusterObservation is the observed state of a cluster."
								properties: {
									arn: {
										description: "The Amazon Resource Name (ARN) of the cluster."
										type:        "string"
									}
									certificateAuthorityData: {
										description: "The Base64-encoded certificate data required to communicate with your cluster."

										type: "string"
									}
									createdAt: {
										description: "The Unix epoch timestamp in seconds for when the cluster was created."

										format: "date-time"
										type:   "string"
									}
									endpoint: {
										description: "The endpoint for your Kubernetes API server."
										type:        "string"
									}
									identity: {
										description: "The identity provider information for the cluster."
										properties: oidc: {
											description: "The OpenID Connect (https://openid.net/connect/) identity provider information for the cluster."

											properties: issuer: {
												description: "The issuer URL for the OpenID Connect identity provider."

												type: "string"
											}
											type: "object"
										}
										type: "object"
									}
									outpostConfig: {
										description: "An object representing the configuration of your local Amazon EKS cluster on an Amazon Web Services Outpost. This object isn't available for clusters on the Amazon Web Services cloud."

										properties: {
											controlPlaneInstanceType: {
												description: """
		The Amazon EC2 instance type used for the control plane. The instance type is the same for all control plane instances. 
		 This member is required.
		"""

												type: "string"
											}
											outpostArns: {
												description: """
		The ARN of the Outpost that you specified for use with your local Amazon EKS cluster on Outposts. 
		 This member is required.
		"""

												items: type: "string"
												type: "array"
											}
										}
										type: "object"
									}
									platformVersion: {
										description: "The platform version of your Amazon EKS cluster. For more information, see Platform Versions (https://docs.aws.amazon.com/eks/latest/userguide/platform-versions.html) in the Amazon EKS User Guide ."

										type: "string"
									}
									resourcesVpcConfig: {
										description: "The VPC configuration used by the cluster control plane. Amazon EKS VPC resources have specific requirements to work properly with Kubernetes. For more information, see Cluster VPC Considerations (https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html) and Cluster Security Group Considerations (https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html) in the Amazon EKS User Guide."

										properties: {
											clusterSecurityGroupId: {
												description: "The cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication."

												type: "string"
											}
											vpcId: {
												description: "The VPC associated with your cluster."
												type:        "string"
											}
										}
										type: "object"
									}
									status: {
										description: "The current status of the cluster."
										type:        "string"
									}
									version: {
										description: "The kubernetes version of your Amazon EKS cluster. For more information, see Kubernetes Versions (https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html) in the Amazon EKS User Guide ."

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
			}, served:
				true, storage:
				true, subresources: status: {}
		}]
	}, status: {
		acceptedNames: {
			kind:
				"", plural:
				""
		}, conditions: [], storedVersions: []
	}
}
