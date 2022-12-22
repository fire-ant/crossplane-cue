package batch_aws_crossplane_io_computeenvironments

customresourcedefinition: "computeenvironments.batch.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "computeenvironments.batch.aws.crossplane.io"
	}
	spec: {
		group: "batch.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "ComputeEnvironment"
			listKind: "ComputeEnvironmentList"
			plural:   "computeenvironments"
			singular: "computeenvironment"
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
				description: "ComputeEnvironment is the Schema for the ComputeEnvironments API"

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
						description: "ComputeEnvironmentSpec defines the desired state of ComputeEnvironment"
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
								description: "ComputeEnvironmentParameters defines the desired state of ComputeEnvironment"

								properties: {
									computeResources: {
										description: "Details about the compute resources managed by the compute environment. This parameter is required for managed compute environments. For more information, see Compute Environments (https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html) in the Batch User Guide."

										properties: {
											allocationStrategy: type: "string"
											bidPercentage: {
												format: "int64"
												type:   "integer"
											}
											ec2Configuration: {
												items: {
													properties: {
														imageIDOverride: type: "string"
														imageType: type: "string"
													}
													type: "object"
												}
												type: "array"
											}
											ec2KeyPair: type: "string"
											instanceTypes: {
												items: type: "string"
												type: "array"
											}
											launchTemplate: {
												description: """
		An object representing a launch template associated with a compute resource. You must specify either the launch template ID or launch template name in the request, but not both. 
		 If security groups are specified using both the securityGroupIds parameter of CreateComputeEnvironment and the launch template, the values in the securityGroupIds parameter of CreateComputeEnvironment will be used. 
		 This object isn't applicable to jobs that are running on Fargate resources.
		"""

												properties: {
													launchTemplateID: type: "string"
													launchTemplateName: type: "string"
													version: type: "string"
												}
												type: "object"
											}
											maxvCPUs: {
												format: "int64"
												type:   "integer"
											}
											minvCPUs: {
												format: "int64"
												type:   "integer"
											}
											placementGroup: type: "string"
											tags: {
												additionalProperties: type: "string"
												type: "object"
											}
											type_: type: "string"
										}
										type: "object"
									}
									desiredState: {
										description: """
		Custom parameter to control the state of the compute environment. The valid values are ENABLED or DISABLED. 
		 If the state is ENABLED, then the Batch scheduler can attempt to place jobs from an associated job queue on the compute resources within the environment. If the compute environment is managed, then it can scale its instances out or in automatically, based on the job queue demand. 
		 If the state is DISABLED, then the Batch scheduler doesn't attempt to place jobs within the environment. Jobs in a STARTING or RUNNING state continue to progress normally. Managed compute environments in the DISABLED state don't scale out. However, they scale in to minvCpus value after instances become idle.
		"""

										enum: [
											"ENABLED",
											"DISABLED",
										]
										type: "string"
									}
									instanceRole: {
										description: """
		The Amazon ECS instance profile applied to Amazon EC2 instances in a compute environment. You can specify the short name or full Amazon Resource Name (ARN) of an instance profile. For example, ecsInstanceRole or arn:aws:iam::<aws_account_id>:instance-profile/ecsInstanceRole . For more information, see Amazon ECS Instance Role (https://docs.aws.amazon.com/batch/latest/userguide/instance_IAM_role.html) in the Batch User Guide. Only applicable to MANGED CE of type EC2 or SPOT. This field can be updated for CE only with Allocation Strategy BEST_FIT_PROGRESSIVE or SPOT_CAPACITY_OPTIMIZED. 
		 This parameter isn't applicable to jobs that are running on Fargate resources, and shouldn't be specified.
		"""

										type: "string"
									}
									instanceRoleRef: {
										description: "InstanceRoleRef is a reference to the IAM InstanceProfile used to set the InstanceRole."

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
									instanceRoleSelector: {
										description: "InstanceRoleSelector selects references to the IAM InstanceProfile used to set the InstanceRole."

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
										description: "Region is which region the ComputeEnvironment will be created."

										type: "string"
									}
									securityGroupIdRefs: {
										description: "SecurityGroupIDRefs is a list of references to SecurityGroups used to set the SecurityGroupIDs."

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
										description: "SecurityGroupIDsSelector selects references to SecurityGroupID used to set the SecurityGroupIDs."

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
										description: "The Amazon EC2 security groups associated with instances launched in the compute environment. One or more security groups must be specified, either in securityGroupIds or using a launch template referenced in launchTemplate. This parameter is required for jobs that are running on Fargate resources and must contain at least one security group. Fargate doesn't support launch templates. If security groups are specified using both securityGroupIds and launchTemplate, the values in securityGroupIds are used. For a MANGED CE of type EC2 or SPOT to be able to update this field Allocation Strategy BEST_FIT_PROGRESSIVE or SPOT_CAPACITY_OPTIMIZED is required."

										items: type: "string"
										type: "array"
									}
									serviceRoleARN: {
										description: "The full Amazon Resource Name (ARN) of the IAM role that allows Batch to make calls to other Amazon Web Services services on your behalf. For more information, see Batch service IAM role (https://docs.aws.amazon.com/batch/latest/userguide/service_IAM_role.html) If the compute environment has a service-linked role, it can't be changed to use a regular IAM role. Likewise, if the compute environment has a regular IAM role, it can't be changed to use a service-linked role. If your specified role has a path other than /, then you must either specify the full role ARN (this is recommended) or prefix the role name with the path. Depending on how you created your Batch service role, its ARN might contain the service-role path prefix. When you only specify the name of the service role, Batch assumes that your ARN doesn't use the service-role path prefix. Because of this, we recommend that you specify the full ARN of your service role when you create compute environments"

										type: "string"
									}
									serviceRoleARNRef: {
										description: "ServiceRoleARNRef is a reference to an ARN of the IAM role used to set the ServiceRoleARN."

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
									serviceRoleARNSelector: {
										description: "ServiceRoleARNSelector selects references to an ARN of the IAM role used to set the ServiceRoleARN."

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
									spotIAMFleetRoleRef: {
										description: "SpotIAMFleetRoleRef is a reference to an ARN of the IAM role used to set the SpotIAMFleetRole."

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
									spotIamFleetRole: {
										description: """
		The Amazon Resource Name (ARN) of the Amazon EC2 Spot Fleet IAM role applied to a SPOT compute environment. This role is required if the allocation strategy set to BEST_FIT or if the allocation strategy isn't specified. For more information, see Amazon EC2 Spot Fleet Role (https://docs.aws.amazon.com/batch/latest/userguide/spot_fleet_IAM_role.html) in the Batch User Guide. 
		 This parameter isn't applicable to jobs that are running on Fargate resources, and shouldn't be specified. 
		 To tag your Spot Instances on creation, the Spot Fleet IAM role specified here must use the newer AmazonEC2SpotFleetTaggingRole managed policy. The previously recommended AmazonEC2SpotFleetRole managed policy doesn't have the required permissions to tag Spot Instances. For more information, see Spot Instances not tagged on creation (https://docs.aws.amazon.com/batch/latest/userguide/troubleshooting.html#spot-instance-no-tag) in the Batch User Guide.
		"""

										type: "string"
									}
									spotIamFleetRoleSelector: {
										description: "SpotIAMFleetRoleSelector selects references to an ARN of the IAM role used to set the SpotIAMFleetRole."

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
									subnetIdRefs: {
										description: "SubnetIDRefs is a list of references to SubnetIDs used to set the SubnetIDs."

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
									subnetIdSelector: {
										description: "SubnetIDSelector selects references to SubnetIDs used to set the SubnetIDs."

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
										description: "The VPC subnets where the compute resources are launched. These subnets must be within the same VPC. Fargate compute resources can contain up to 16 subnets. For more information, see VPCs and Subnets (https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html) in the Amazon VPC User Guide. (Subnets is originally a field of ComputeResources) Subnets is a required field for CE type MANAGED. For a MANGED CE of type EC2 or SPOT to be able to update this field Allocation Strategy BEST_FIT_PROGRESSIVE or SPOT_CAPACITY_OPTIMIZED is required."

										items: type: "string"
										type: "array"
									}
									tags: {
										additionalProperties: type: "string"
										description: """
		The tags that you apply to the compute environment to help you categorize and organize your resources. Each tag consists of a key and an optional value. For more information, see Tagging Amazon Web Services Resources (https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html) in Amazon Web Services General Reference. 
		 These tags can be updated or removed using the TagResource (https://docs.aws.amazon.com/batch/latest/APIReference/API_TagResource.html) and UntagResource (https://docs.aws.amazon.com/batch/latest/APIReference/API_UntagResource.html) API operations. These tags don't propagate to the underlying compute resources.
		"""

										type: "object"
									}
									type_: {
										description: "The type of the compute environment: MANAGED or UNMANAGED. For more information, see Compute Environments (https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html) in the Batch User Guide."

										type: "string"
									}
									unmanagedvCPUs: {
										description: """
		The maximum number of vCPUs for an unmanaged compute environment. This parameter is only used for fair share scheduling to reserve vCPU capacity for new share identifiers. If this parameter isn't provided for a fair share job queue, no vCPU capacity is reserved. 
		 This parameter is only supported when the type parameter is set to UNMANAGED.
		"""

										format: "int64"
										type:   "integer"
									}
									updatePolicy: {
										description: """
		Specifies the infrastructure update policy for the compute environment. For more information about infrastructure updates, see Updating compute environments (https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the Batch User Guide. Only applicable to MANGED CE of type EC2 or SPOT. This field requires an update request to be set and it can be updated for CE only with Allocation Strategy BEST_FIT_PROGRESSIVE or SPOT_CAPACITY_OPTIMIZED. 
		 JobExecutionTimeoutMinutes specifies the job timeout (in minutes) when the compute environment infrastructure is updated. The default value is 30. 
		 TerminateJobsOnUpdate specifies whether jobs are automatically terminated when the computer environment infrastructure is updated. The default value is false.
		"""

										properties: {
											jobExecutionTimeoutMinutes: {
												format: "int64"
												type:   "integer"
											}
											terminateJobsOnUpdate: type: "boolean"
										}
										type: "object"
									}
									updateToLatestImageVersion: {
										description: """
		Specifies whether the AMI ID is updated to the latest one that's supported by Batch when the compute environment has an infrastructure update. The default value is false. Only applicable to MANGED CE of type EC2 or SPOT. This field requires an update request to be set and it can be updated for CE only with Allocation Strategy BEST_FIT_PROGRESSIVE or SPOT_CAPACITY_OPTIMIZED. Also to get this field changed, you need to include another change to trigger an update. 
		 If an AMI ID is specified in the imageIdOverride parameters or by the launch template specified in the launchTemplate parameter, this parameter is ignored. For more information on updating AMI IDs during an infrastructure update, see Updating the AMI ID (https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html#updating-compute-environments-ami) in the Batch User Guide. 
		 When updating a compute environment, changing this setting requires an infrastructure update of the compute environment. For more information, see Updating compute environments (https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the Batch User Guide.
		"""

										type: "boolean"
									}
								}
								required: [
									"region",
									"type_",
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
						description: "ComputeEnvironmentStatus defines the observed state of ComputeEnvironment."
						properties: {
							atProvider: {
								description: "ComputeEnvironmentObservation defines the observed state of ComputeEnvironment"

								properties: {
									computeEnvironmentARN: {
										description: "The Amazon Resource Name (ARN) of the compute environment."
										type:        "string"
									}
									computeEnvironmentName: {
										description: "The name of the compute environment. It can be up to 128 letters long. It can contain uppercase and lowercase letters, numbers, hyphens (-), and underscores (_)."

										type: "string"
									}
									ecsClusterARN: {
										description: "The Amazon Resource Name (ARN) of the underlying Amazon ECS cluster used by the compute environment."

										type: "string"
									}
									state: {
										description: """
		The state of the compute environment. The valid values are ENABLED or DISABLED. 
		 If the state is ENABLED, then the Batch scheduler can attempt to place jobs from an associated job queue on the compute resources within the environment. If the compute environment is managed, then it can scale its instances out or in automatically, based on the job queue demand. 
		 If the state is DISABLED, then the Batch scheduler doesn't attempt to place jobs within the environment. Jobs in a STARTING or RUNNING state continue to progress normally. Managed compute environments in the DISABLED state don't scale out. However, they scale in to minvCpus value after instances become idle.
		"""

										type: "string"
									}
									status: {
										description: "The current status of the compute environment (for example, CREATING or VALID)."

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
