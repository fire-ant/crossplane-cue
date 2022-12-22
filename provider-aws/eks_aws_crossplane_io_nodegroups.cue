package eks_aws_crossplane_io_nodegroups

customresourcedefinition: "nodegroups.eks.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "nodegroups.eks.aws.crossplane.io"
	}
	spec: {
		group: "eks.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "NodeGroup"
			listKind: "NodeGroupList"
			plural:   "nodegroups"
			singular: "nodegroup"
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
				jsonPath: ".spec.forProvider.clusterName"
				name:     "CLUSTER"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "A NodeGroup is a managed resource that represents an AWS Elastic Kubernetes Service NodeGroup."

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
						description: "A NodeGroupSpec defines the desired state of an EKS NodeGroup."
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
								description: "NodeGroupParameters define the desired state of an AWS Elastic Kubernetes Service NodeGroup."

								properties: {
									amiType: {
										description: "The AMI type for your node group. GPU instance can use AL2_x86_64_GPU AMI type, which uses the Amazon EKS-optimized Linux AMI with GPU support. Non-GPU instances can use AL2_x86_64 (default) AMI type, which uses the Amazon EKS-optimized Linux AMI or, BOTTLEROCKET_ARM_64 AMI type, which uses the Amazon Bottlerocket AMI for ARM instances, or BOTTLEROCKET_x86_64 AMI type, which uses the Amazon Bottlerocket AMI fir x86_64 instances."

										type: "string"
									}
									capacityType: {
										description: "CapacityType for your node group."
										enum: [
											"ON_DEMAND",
											"SPOT",
										]
										type: "string"
									}
									clusterName: {
										description: """
		The name of the cluster to create the node group in. 
		 ClusterName is a required field
		"""

										type: "string"
									}
									clusterNameRef: {
										description: "ClusterNameRef is a reference to a Cluster used to set the ClusterName."

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
									clusterNameSelector: {
										description: "ClusterNameSelector selects references to a Cluster used to set the ClusterName."

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
									diskSize: {
										description: "The root device disk size (in GiB) for your node group instances. The default disk size is 20 GiB."

										format: "int32"
										type:   "integer"
									}
									instanceTypes: {
										description: "The instance type to use for your node group. Currently, you can specify a single instance type for a node group. The default value for this parameter is t3.medium. If you choose a GPU instance type, be sure to specify the AL2_x86_64_GPU with the amiType parameter."

										items: type: "string"
										type: "array"
									}
									labels: {
										additionalProperties: type: "string"
										description: "The Kubernetes labels to be applied to the nodes in the node group when they are created."

										type: "object"
									}
									launchTemplate: {
										description: "An object representing a node group's launch template specification. If specified, then do not specify instanceTypes, diskSize, or remoteAccess and make sure that the launch template meets the requirements in launchTemplateSpecification."

										properties: {
											id: {
												description: "The ID of the launch template."
												type:        "string"
											}
											name: {
												description: "The name of the launch template."
												type:        "string"
											}
											nameRef: {
												description: "NameRef is a reference to a LaunchTemplate used to set the Name."

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
											nameSelector: {
												description: "NameSelector selects references to a LaunchTemplate used to set the Name."

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
											version: {
												description: "The version of the launch template to use. If no version is specified, then the template's default version is used."

												type: "string"
											}
											versionRef: {
												description: "VersionRef is a reference to a LaunchTemplateVersion used to set the Version."

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
											versionSelector: {
												description: "VersionSelector selects references to a LaunchTemplateVersion used to set the Version."

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
										}
										type: "object"
									}
									nodeRole: {
										description: """
		The Amazon Resource Name (ARN) of the IAM role to associate with your node group. The Amazon EKS worker node kubelet daemon makes calls to AWS APIs on your behalf. Worker nodes receive permissions for these API calls through an IAM instance profile and associated policies. Before you can launch worker nodes and register them into a cluster, you must create an IAM role for those worker nodes to use when they are launched. For more information, see Amazon EKS Worker Node IAM Role (https://docs.aws.amazon.com/eks/latest/userguide/worker_node_IAM_role.html) in the Amazon EKS User Guide . 
		 NodeRole is a required field
		"""

										type: "string"
									}
									nodeRoleRef: {
										description: "NodeRoleRef is a reference to a Cluster used to set the NodeRole."

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
									nodeRoleSelector: {
										description: "NodeRoleSelector selects references to a Cluster used to set the NodeRole."

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
										description: "Region is the region you'd like  the NodeGroup to be created in."

										type: "string"
									}
									releaseVersion: {
										description: "The AMI version of the Amazon EKS-optimized AMI to use with your node group. By default, the latest available AMI version for the node group's current Kubernetes version is used. For more information, see Amazon EKS-Optimized Linux AMI Versions (https://docs.aws.amazon.com/eks/latest/userguide/eks-linux-ami-versions.html) in the Amazon EKS User Guide."

										type: "string"
									}
									remoteAccess: {
										description: "The remote access (SSH) configuration to use with your node group."

										properties: {
											ec2SSHKey: {
												description: "The Amazon EC2 SSH key that provides access for SSH communication with the worker nodes in the managed node group. For more information, see Amazon EC2 Key Pairs (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) in the Amazon Elastic Compute Cloud User Guide for Linux Instances."

												type: "string"
											}
											sourceSecurityGroupRefs: {
												description: "SourceSecurityGroupRefs are references to SecurityGroups used to set the SourceSecurityGroups."

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
											sourceSecurityGroupSelector: {
												description: "SourceSecurityGroupSelector selects references to SecurityGroups used to set the SourceSecurityGroups."

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
											sourceSecurityGroups: {
												description: "The security groups that are allowed SSH access (port 22) to the worker nodes. If you specify an Amazon EC2 SSH key but do not specify a source security group when you create a managed node group, then port 22 on the worker nodes is opened to the internet (0.0.0.0/0). For more information, see Security Groups for Your VPC (https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) in the Amazon Virtual Private Cloud User Guide."

												items: type: "string"
												type: "array"
											}
										}
										type: "object"
									}
									scalingConfig: {
										description: "The scaling configuration details for the Auto Scaling group that is created for your node group."

										properties: {
											desiredSize: {
												description: "The current number of worker nodes that the managed node group should maintain. This value should be left unset if another controller, such as cluster-autoscaler, is expected to manage the desired size of the node group. If not set, the initial desired size will be the configured minimum size of the node group."

												format: "int32"
												type:   "integer"
											}
											maxSize: {
												description: "The maximum number of worker nodes that the managed node group can scale out to. Managed node groups can support up to 100 nodes by default."

												format: "int32"
												type:   "integer"
											}
											minSize: {
												description: "The minimum number of worker nodes that the managed node group can scale in to. This number must be greater than zero."

												format: "int32"
												type:   "integer"
											}
										}
										type: "object"
									}
									subnetRefs: {
										description: "SubnetRefs are references to Subnets used to set the Subnets."

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
									subnetSelector: {
										description: "SubnetSelector selects references to Subnets used to set the Subnets."

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
									subnets: {
										description: """
		The subnets to use for the Auto Scaling group that is created for your node group. These subnets must have the tag key kubernetes.io/cluster/CLUSTER_NAME with a value of shared, where CLUSTER_NAME is replaced with the name of your cluster. 
		 Subnets is a required field
		"""

										items: type: "string"
										type: "array"
									}
									tags: {
										additionalProperties: type: "string"
										description: "The metadata to apply to the node group to assist with categorization and organization. Each tag consists of a key and an optional value, both of which you define. Node group tags do not propagate to any other resources associated with the node group, such as the Amazon EC2 instances or subnets."

										type: "object"
									}
									taints: {
										description: "The Kubernetes taints to be applied to the nodes in the node group."

										items: {
											description: "Taint is a property that allows a node to repel a set of pods."

											properties: {
												effect: {
													description: "The effect of the taint."
													enum: [
														"NO_SCHEDULE",
														"NO_EXECUTE",
														"PREFER_NO_SCHEDULE",
													]
													type: "string"
												}
												key: {
													description: "The key of the taint."
													type:        "string"
												}
												value: {
													description: "The value of the taint."
													type:        "string"
												}
											}
											required: [
												"effect",
											]
											type: "object"
										}
										type: "array"
									}
									updateConfig: {
										description: "Specifies details on how the Nodes in this NodeGroup should be updated."

										properties: {
											force: {
												description: "Force the update if the existing node group's pods are unable to be drained due to a pod disruption budget issue. If an update fails because pods could not be drained, you can force the update after it fails to terminate the old node whether any pods are running on the node."

												type: "boolean"
											}
											maxUnavailable: {
												description: "The maximum number of nodes unavailable at once during a version update. Nodes will be updated in parallel. The maximum number is 100. This value or maxUnavailablePercentage is required to have a value, but not both."

												format:  "int32"
												maximum: 100
												minimum: 1
												type:    "integer"
											}
											maxUnavailablePercentage: {
												description: "The maximum percentage of nodes unavailable during a version update. This percentage of nodes will be updated in parallel, up to 100 nodes at once. This value or maxUnavailable is required to have a value, but not both."

												format:  "int32"
												maximum: 100
												minimum: 1
												type:    "integer"
											}
										}
										type: "object"
									}
									version: {
										description: "The Kubernetes version to use for your managed nodes. By default, the Kubernetes version of the cluster is used, and this is the only accepted specified value."

										type: "string"
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
						description: "A NodeGroupStatus represents the observed state of an EKS NodeGroup."

						properties: {
							atProvider: {
								description: "NodeGroupObservation is the observed state of a NodeGroup."
								properties: {
									createdAt: {
										description: "The Unix epoch timestamp in seconds for when the managed node group was created."

										format: "date-time"
										type:   "string"
									}
									modifiedAt: {
										description: "The Unix epoch timestamp in seconds for when the managed node group was last modified."

										format: "date-time"
										type:   "string"
									}
									nodeGroupArn: {
										description: "The Amazon Resource Name (ARN) associated with the managed node group."

										type: "string"
									}
									nodeGroupHealth: {
										description: "The health status of the node group. If there are issues with your node group's health, they are listed here."

										properties: issues: {
											description: "Any issues that are associated with the node group."

											items: {
												description: "Issue is an issue with a NodeGroup."
												properties: {
													code: {
														description: """
		A brief description of the error. 
		 * AutoScalingGroupNotFound: We couldn't find the Auto Scaling group associated with the managed node group. You may be able to recreate an Auto Scaling group with the same settings to recover. 
		 * Ec2SecurityGroupNotFound: We couldn't find the cluster security group for the cluster. You must recreate your cluster. 
		 * Ec2SecurityGroupDeletionFailure: We could not delete the remote access security group for your managed node group. Remove any dependencies from the security group. 
		 * Ec2LaunchTemplateNotFound: We couldn't find the Amazon EC2 launch template for your managed node group. You may be able to recreate a launch template with the same settings to recover. 
		 * Ec2LaunchTemplateVersionMismatch: The Amazon EC2 launch template version for your managed node group does not match the version that Amazon EKS created. You may be able to revert to the version that Amazon EKS created to recover. 
		 * IamInstanceProfileNotFound: We couldn't find the IAM instance profile for your managed node group. You may be able to recreate an instance profile with the same settings to recover. 
		 * IamNodeRoleNotFound: We couldn't find the IAM role for your managed node group. You may be able to recreate an IAM role with the same settings to recover. 
		 * AsgInstanceLaunchFailures: Your Auto Scaling group is experiencing failures while attempting to launch instances. 
		 * NodeCreationFailure: Your launched instances are unable to register with your Amazon EKS cluster. Common causes of this failure are insufficient worker node IAM role (https://docs.aws.amazon.com/eks/latest/userguide/worker_node_IAM_role.html) permissions or lack of outbound internet access for the nodes. 
		 * InstanceLimitExceeded: Your AWS account is unable to launch any more instances of the specified instance type. You may be able to request an Amazon EC2 instance limit increase to recover. 
		 * InsufficientFreeAddresses: One or more of the subnets associated with your managed node group does not have enough available IP addresses for new nodes. 
		 * AccessDenied: Amazon EKS or one or more of your managed nodes is unable to communicate with your cluster API server. 
		 * InternalFailure: These errors are usually caused by an Amazon EKS server-side issue.
		"""

														type: "string"
													}
													message: {
														description: "The error message associated with the issue."
														type:        "string"
													}
													resourceIds: {
														description: "The AWS resources that are afflicted by this issue."

														items: type: "string"
														type: "array"
													}
												}
												type: "object"
											}
											type: "array"
										}
										type: "object"
									}
									releaseVersion: {
										description: "The AMI version of the Amazon EKS-optimized AMI to use with your node group. By default, the latest available AMI version for the node group's current Kubernetes version is used. For more information, see Amazon EKS-Optimized Linux AMI Versions (https://docs.aws.amazon.com/eks/latest/userguide/eks-linux-ami-versions.html) in the Amazon EKS User Guide."

										type: "string"
									}
									resources: {
										description: "The resources associated with the node group, such as Auto Scaling groups and security groups for remote access."

										properties: {
											autoScalingGroup: {
												description: "The Auto Scaling groups associated with the node group."

												items: {
													description: "AutoScalingGroup is an autoscaling group associated with a NodeGroup."

													properties: name: {
														description: "The name of the Auto Scaling group associated with an Amazon EKS managed node group."

														type: "string"
													}
													type: "object"
												}
												type: "array"
											}
											remoteAccessSecurityGroup: {
												description: "The remote access security group associated with the node group. This security group controls SSH access to the worker nodes."

												type: "string"
											}
										}
										type: "object"
									}
									scalingConfig: {
										description: "The scaling configuration details for the Auto Scaling group that is created for your node group."

										properties: desiredSize: {
											description: "The current number of worker nodes for the managed node group."

											format: "int32"
											type:   "integer"
										}
										type: "object"
									}
									status: {
										description: "The current status of the managed node group."
										type:        "string"
									}
									updateConfig: {
										description: "The current update configuration of the node group"
										properties: {
											maxUnavailable: {
												description: "The current maximum number of nodes unavailable at once during a version update."

												format: "int32"
												type:   "integer"
											}
											maxUnavailablePercentage: {
												description: "The current maximum percentage of nodes unavailable during a version update. This percentage of nodes will be updated in parallel."

												format: "int32"
												type:   "integer"
											}
										}
										type: "object"
									}
									version: {
										description: "The Kubernetes version to use for your managed nodes. By default, the Kubernetes version of the cluster is used, and this is the only accepted specified value."

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
