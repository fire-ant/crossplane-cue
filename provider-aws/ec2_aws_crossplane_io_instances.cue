package ec2_aws_crossplane_io_instances

customresourcedefinition: "instances.ec2.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "instances.ec2.aws.crossplane.io"
	}
	spec: {
		group: "ec2.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Instance"
			listKind: "InstanceList"
			plural:   "instances"
			singular: "instance"
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
				name:     "ID"
				type:     "string"
			}, {
				jsonPath: ".status.atProvider.state"
				name:     "STATE"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "Instance is a managed resource that represents a specified number of AWS EC2 Instance"

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
						description: "An InstanceSpec defines the desired state of Instances."
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
								description: "InstanceParameters define the desired state of the Instances"
								properties: {
									ElasticGpuSpecification: {
										description: "An elastic GPU to associate with the instance. An Elastic GPU is a GPU resource that you can attach to your Windows instance to accelerate the graphics performance of your applications. For more information, see Amazon EC2 Elastic GPUs (https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/elastic-graphics.html) in the Amazon Elastic Compute Cloud User Guide."

										items: {
											description: "ElasticGPUSpecification is a specification for an Elastic Graphics accelerator."

											properties: type: {
												description: """
		The type of Elastic Graphics accelerator. For more information about the values to specify for Type, see Elastic Graphics Basics (https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/elastic-graphics.html#elastic-graphics-basics), specifically the Elastic Graphics accelerator column, in the Amazon Elastic Compute Cloud User Guide for Windows Instances. 
		 Type is a required field
		"""

												type: "string"
											}
											required: [
												"type",
											]
											type: "object"
										}
										type: "array"
									}
									blockDeviceMappings: {
										description: "The block device mapping entries."
										items: {
											description: "BlockDeviceMapping describes a block device mapping."
											properties: {
												deviceName: {
													description: "The device name (for example, /dev/sdh or xvdh)."
													type:        "string"
												}
												ebs: {
													description: "Parameters used to automatically set up EBS volumes when the instance is launched."

													properties: {
														deleteOnTermination: {
															description: "Indicates whether the EBS volume is deleted on instance termination. For more information, see Preserving Amazon EBS Volumes on Instance Termination (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#preserving-volumes-on-termination) in the Amazon Elastic Compute Cloud User Guide."

															type: "boolean"
														}
														encrypted: {
															description: """
		Indicates whether the encryption state of an EBS volume is changed while being restored from a backing snapshot. The effect of setting the encryption state to true depends on the volume origin (new or from a snapshot), starting encryption state, ownership, and whether encryption by default is enabled. For more information, see Amazon EBS Encryption (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html#encryption-parameters) in the Amazon Elastic Compute Cloud User Guide. 
		 In no case can you remove encryption from an encrypted volume. 
		 Encrypted volumes can only be attached to instances that support Amazon EBS encryption. For more information, see Supported Instance Types (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html#EBSEncryption_supported_instances). 
		 This parameter is not returned by .
		"""

															type: "boolean"
														}
														iops: {
															description: """
		The number of I/O operations per second (IOPS) that the volume supports. For io1 volumes, this represents the number of IOPS that are provisioned for the volume. For gp2 volumes, this represents the baseline performance of the volume and the rate at which the volume accumulates I/O credits for bursting. For more information, see Amazon EBS Volume Types (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html) in the Amazon Elastic Compute Cloud User Guide. 
		 Constraints: Range is 100-16,000 IOPS for gp2 volumes and 100 to 64,000IOPS for io1 volumes in most Regions. Maximum io1 IOPS of 64,000 is guaranteed only on Nitro-based instances (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#ec2-nitro-instances). Other instance families guarantee performance up to 32,000 IOPS. For more information, see Amazon EBS Volume Types (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html) in the Amazon Elastic Compute Cloud User Guide. 
		 Condition: This parameter is required for requests to create io1 volumes; it is not used in requests to create gp2, st1, sc1, or standard volumes.
		"""

															format: "int32"
															type:   "integer"
														}
														kmsKeyId: {
															description: """
		Identifier (key ID, key alias, ID ARN, or alias ARN) for a customer managed CMK under which the EBS volume is encrypted. 
		 This parameter is only supported on BlockDeviceMapping objects called by RunInstances (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html), RequestSpotFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RequestSpotFleet.html), and RequestSpotInstances (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RequestSpotInstances.html).
		"""

															type: "string"
														}
														kmsKeyIdRef: {
															description: "KMSKeyIDRef is a reference to a KMS Key used to set KMSKeyID."

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
														kmsKeyIdSelector: {
															description: "KMSKeyIDSelector selects a reference to a KMS Key used to set KMSKeyID."

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
														snapshotId: {
															description: "The ID of the snapshot."
															type:        "string"
														}
														volumeSize: {
															description: """
		The size of the volume, in GiB. 
		 Default: If you're creating the volume from a snapshot and don't specify a volume size, the default is the snapshot size. 
		 Constraints: 1-16384 for General Purpose SSD (gp2), 4-16384 for Provisioned IOPS SSD (io1), 500-16384 for Throughput Optimized HDD (st1), 500-16384 for Cold HDD (sc1), and 1-1024 for Magnetic (standard) volumes. If you specify a snapshot, the volume size must be equal to or larger than the snapshot size.
		"""

															format: "int32"
															type:   "integer"
														}
														volumeType: {
															description: """
		The volume type. If you set the type to io1, you must also specify the Iops parameter. If you set the type to gp2, st1, sc1, or standard, you must omit the Iops parameter. 
		 Default: gp2
		"""

															type: "string"
														}
													}
													required: [
														"volumeSize",
													]
													type: "object"
												}
												noDevice: {
													description: "Suppresses the specified device included in the block device mapping of the AMI."

													type: "string"
												}
												virtualName: {
													description: """
		The virtual device name (ephemeralN). Instance store volumes are numbered starting from 0. An instance type with 2 available instance store volumes can specify mappings for ephemeral0 and ephemeral1. The number of available instance store volumes depends on the instance type. After you connect to the instance, you must mount the volume. 
		 NVMe instance store volumes are automatically enumerated and assigned a device name. Including them in your block device mapping has no effect. 
		 Constraints: For M3 instances, you must specify instance store volumes in the block device mapping for the instance. When you launch an M3 instance, we ignore any instance store volumes specified in the block device mapping for the AMI.
		"""

													type: "string"
												}
											}
											required: [
												"deviceName",
												"ebs",
											]
											type: "object"
										}
										type: "array"
									}
									capacityReservationSpecification: {
										description: "Information about the Capacity Reservation targeting option. If you do not specify this parameter, the instance's Capacity Reservation preference defaults to open, which enables it to run in any open Capacity Reservation that has matching attributes (instance type, platform, Availability Zone)."

										properties: {
											capacityReservationTarget: {
												description: "Information about the target Capacity Reservation."
												properties: capacityReservationId: {
													description: "The ID of the Capacity Reservation."
													type:        "string"
												}
												type: "object"
											}
											capacityReservationsPreference: {
												description: """
		Indicates the instance's Capacity Reservation preferences. Possible preferences include: 
		 * open - The instance can run in any open Capacity Reservation that has matching attributes (instance type, platform, Availability Zone). 
		 * none - The instance avoids running in a Capacity Reservation even if one is available. The instance runs as an On-Demand Instance.
		"""

												enum: [
													"open",
													"none",
												]
												type: "string"
											}
										}
										required: [
											"capacityReservationsPreference",
										]
										type: "object"
									}
									clientToken: {
										description: """
		Unique, case-sensitive identifier you provide to ensure the idempotency of the request. If you do not specify a client token, a randomly generated token is used for the request to ensure idempotency. 
		 For more information, see Ensuring Idempotency (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html). 
		 Constraints: Maximum 64 ASCII characters
		"""

										type: "string"
									}
									cpuOptions: {
										description: "The CPU options for the instance. For more information, see Optimizing CPU Options (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html) in the Amazon Elastic Compute Cloud User Guide."

										properties: {
											coreCount: {
												description: "The number of CPU cores for the instance."
												format:      "int32"
												type:        "integer"
											}
											threadsPerCore: {
												description: "The number of threads per CPU core. To disable multithreading for the instance, specify a value of 1. Otherwise, specify the default value of 2."

												format: "int32"
												type:   "integer"
											}
										}
										required: [
											"coreCount",
											"threadsPerCore",
										]
										type: "object"
									}
									creditSpecification: {
										description: """
		The credit option for CPU usage of the burstable performance instance. Valid values are standard and unlimited. To change this attribute after launch, use ModifyInstanceCreditSpecification (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyInstanceCreditSpecification.html). For more information, see Burstable Performance Instances (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html) in the Amazon Elastic Compute Cloud User Guide. 
		 Default: standard (T2 instances) or unlimited (T3/T3a instances)
		"""

										properties: cpuCredits: {
											description: """
		The credit option for CPU usage of a T2 or T3 instance. Valid values are standard and unlimited. 
		 CPUCredits is a required field
		"""

											type: "string"
										}
										required: [
											"cpuCredits",
										]
										type: "object"
									}
									disableAPITermination: {
										description: """
		If you set this parameter to true, you can't terminate the instance using the Amazon EC2 console, CLI, or API; otherwise, you can. To change this attribute after launch, use ModifyInstanceAttribute (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyInstanceAttribute.html). Alternatively, if you set InstanceInitiatedShutdownBehavior to terminate, you can terminate the instance by running the shutdown command from the instance. 
		 Default: false
		"""

										type: "boolean"
									}
									ebsOptimized: {
										description: """
		Indicates whether the instance is optimized for Amazon EBS I/O. This optimization provides dedicated throughput to Amazon EBS and an optimized configuration stack to provide optimal Amazon EBS I/O performance. This optimization isn't available with all instance types. Additional usage charges apply when using an EBS-optimized instance. 
		 Default: false
		"""

										type: "boolean"
									}
									elasticInferenceAccelerators: {
										description: """
		An elastic inference accelerator to associate with the instance. Elastic inference accelerators are a resource you can attach to your Amazon EC2 instances to accelerate your Deep Learning (DL) inference workloads. 
		 You cannot specify accelerators from different generations in the same request.
		"""

										items: {
											description: "ElasticInferenceAccelerator describes an elastic inference accelerator."

											properties: {
												count: {
													description: """
		The number of elastic inference accelerators to attach to the instance. 
		 Default: 1
		"""

													format: "int32"
													type:   "integer"
												}
												type: {
													description: """
		The type of elastic inference accelerator. The possible values are eia1.medium, eia1.large, and eia1.xlarge. 
		 Type is a required field
		"""

													type: "string"
												}
											}
											required: [
												"type",
											]
											type: "object"
										}
										type: "array"
									}
									hibernationOptions: {
										description: "Indicates whether an instance is enabled for hibernation. For more information, see Hibernate Your Instance (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html) in the Amazon Elastic Compute Cloud User Guide."

										properties: configured: {
											description: """
		If you set this parameter to true, your instance is enabled for hibernation. 
		 Default: false
		"""

											type: "boolean"
										}
										type: "object"
									}
									iamInstanceProfile: {
										description: "The IAM instance profile."
										properties: {
											arn: {
												description: "The Amazon Resource Name (ARN) of the instance profile."

												type: "string"
											}
											name: {
												description: "The name of the instance profile."
												type:        "string"
											}
										}
										type: "object"
									}
									imageId: {
										description: "The ID of the AMI. An AMI ID is required to launch an instance and must be specified here or in a launch template."

										type: "string"
									}
									instanceInitiatedShutdownBehavior: {
										description: """
		Indicates whether an instance stops or terminates when you initiate shutdown from the instance (using the operating system command for system shutdown). 
		 Default: stop
		"""

										type: "string"
									}
									instanceMarketOptions: {
										description: """
		The market (purchasing) option for the instances. 
		 For RunInstances, persistent Spot Instance requests are only supported when InstanceInterruptionBehavior is set to either hibernate or stop.
		"""

										properties: {
											marketType: {
												description: "The market type."
												type:        "string"
											}
											spotOptions: {
												description: "The options for Spot Instances."
												properties: {
													blockDurationMinutes: {
														description: "The required duration for the Spot Instances (also known as Spot blocks), in minutes. This value must be a multiple of 60 (60, 120, 180, 240, 300, or 360)."

														format: "int32"
														type:   "integer"
													}
													instanceInterruptionBehavior: {
														description: "The behavior when a Spot Instance is interrupted. The default is terminate."

														enum: [
															"hibernate",
															"stop",
															"terminate",
														]
														type: "string"
													}
													maxPrice: {
														description: "The maximum hourly price you're willing to pay for the Spot Instances. The default is the On-Demand price."

														type: "string"
													}
													spotInstanceType: {
														description: "The Spot Instance request type. For RunInstances (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances), persistent Spot Instance requests are only supported when InstanceInterruptionBehavior is set to either hibernate or stop."

														enum: [
															"one-time",
															"persistent",
														]
														type: "string"
													}
													validUntil: {
														description: "The end date of the request. For a one-time request, the request remains active until all instances launch, the request is canceled, or this date is reached. If the request is persistent, it remains active until it is canceled or this date and time is reached. The default end date is 7 days from the current date. Must be in UTC format (YYYY-MM-DDTHH:MM:SSZ)"

														format: "date-time"
														type:   "string"
													}
												}
												required: [
													"instanceInterruptionBehavior",
													"spotInstanceType",
												]
												type: "object"
											}
										}
										required: [
											"marketType",
											"spotOptions",
										]
										type: "object"
									}
									instanceType: {
										description: """
		The instance type. For more information, see Instance Types (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in the Amazon Elastic Compute Cloud User Guide. 
		 Default: m1.small
		"""

										type: "string"
									}
									ipv6AddressCount: {
										description: """
		[EC2-VPC] The number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet. You cannot specify this option and the option to assign specific IPv6 addresses in the same request. You can specify this option if you've specified a minimum number of instances to launch. 
		 You cannot specify this option and the network interfaces option in the same request.
		"""

										format: "int32"
										type:   "integer"
									}
									ipv6Addresses: {
										description: """
		[EC2-VPC] The IPv6 addresses from the range of the subnet to associate with the primary network interface. You cannot specify this option and the option to assign a number of IPv6 addresses in the same request. You cannot specify this option if you've specified a minimum number of instances to launch. 
		 You cannot specify this option and the network interfaces option in the same request.
		"""

										items: {
											description: "InstanceIPv6Address describes an IPv6 address."
											properties: ipv6Address: {
												description: "The IPv6 address."
												type:        "string"
											}
											required: [
												"ipv6Address",
											]
											type: "object"
										}
										type: "array"
									}
									kernelId: {
										description: """
		The ID of the kernel. 
		 AWS recommends that you use PV-GRUB instead of kernels and RAM disks. For more information, see PV-GRUB (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedkernels.html) in the Amazon Elastic Compute Cloud User Guide.
		"""

										type: "string"
									}
									keyName: {
										description: """
		The name of the key pair. You can create a key pair using CreateKeyPair (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateKeyPair.html) or ImportKeyPair (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportKeyPair.html). 
		 If you do not specify a key pair, you can't connect to the instance unless you choose an AMI that is configured to allow users another way to log in.
		"""

										type: "string"
									}
									launchTemplate: {
										description: "The launch template to use to launch the instances. Any parameters that you specify in RunInstances override the same parameters in the launch template. You can specify either the name or ID of a launch template, but not both."

										properties: {
											launchTemplateId: {
												description: "The ID of the launch template."
												type:        "string"
											}
											launchTemplateName: {
												description: "The name of the launch template."
												type:        "string"
											}
											version: {
												description: """
		The version number of the launch template. 
		 Default: The default version for the launch template.
		"""

												type: "string"
											}
										}
										required: [
											"launchTemplateId",
											"launchTemplateName",
										]
										type: "object"
									}
									licenseSpecifications: {
										description: "The Amazon Resource Name (ARN) of the license configuration"
										items: {
											description: "LicenseConfigurationRequest describes a license configuration"

											properties: licenseConfigurationArn: {
												description: "Amazon Resource Name (ARN) of the license configuration"
												type:        "string"
											}
											required: [
												"licenseConfigurationArn",
											]
											type: "object"
										}
										type: "array"
									}
									metadataOptions: {
										description: "The metadata options for the instance. For more information, see Instance Metadata and User Data (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html)."

										properties: {
											httpEndpoint: {
												description: """
		This parameter enables or disables the HTTP metadata endpoint on your instances. If the parameter is not specified, the default state is enabled. 
		 If you specify a value of disabled, you will not be able to access your instance metadata.
		"""

												enum: [
													"enabled",
													"disabled",
												]
												type: "string"
											}
											httpPutResponseHopLimit: {
												description: """
		The desired HTTP PUT response hop limit for instance metadata requests. The larger the number, the further instance metadata requests can travel. 
		 Default: 1 
		 Possible values: Integers from 1 to 64
		"""

												format: "int32"
												type:   "integer"
											}
											httpTokens: {
												description: """
		The state of token usage for your instance metadata requests. If the parameter is not specified in the request, the default state is optional. 
		 If the state is optional, you can choose to retrieve instance metadata with or without a signed token header on your request. If you retrieve the IAM role credentials without a token, the version 1.0 role credentials are returned. If you retrieve the IAM role credentials using a valid signed token, the version 2.0 role credentials are returned. 
		 If the state is required, you must send a signed token header with any instance metadata retrieval requests. In this state, retrieving the IAM role credentials always returns the version 2.0 credentials; the version 1.0 credentials are not available.
		"""

												enum: [
													"optional",
													"required",
												]
												type: "string"
											}
										}
										required: [
											"httpTokens",
										]
										type: "object"
									}
									monitoring: {
										description: "Specifies whether detailed monitoring is enabled for the instance."

										properties: enabled: {
											description: """
		Indicates whether detailed monitoring is enabled. Otherwise, basic monitoring is enabled. 
		 Enabled is a required field
		"""

											type: "boolean"
										}
										required: [
											"enabled",
										]
										type: "object"
									}
									networkInterfaces: {
										description: "The network interfaces to associate with the instance. If you specify a network interface, you must specify any security groups and subnets as part of the network interface."

										items: {
											description: "InstanceNetworkInterfaceSpecification describes a network interface."

											properties: {
												associatePublicIpAddress: {
													description: "Indicates whether to assign a public IPv4 address to an instance you launch in a VPC. The public IP address can only be assigned to a network interface for eth0, and can only be assigned to a new network interface, not an existing one. You cannot specify more than one network interface in the request. If launching into a default subnet, the default value is true."

													type: "boolean"
												}
												deleteOnTermination: {
													description: "If set to true, the interface is deleted when the instance is terminated. You can specify true only if creating a new network interface when launching an instance."

													type: "boolean"
												}
												description: {
													description: "The description of the network interface. Applies only if creating a network interface when launching an instance."

													type: "string"
												}
												deviceIndex: {
													description: """
		The position of the network interface in the attachment order. A primary network interface has a device index of 0. 
		 If you specify a network interface when launching an instance, you must specify the device index.
		"""

													format: "int32"
													type:   "integer"
												}
												groups: {
													description: "The IDs of the security groups for the network interface. Applies only if creating a network interface when launching an instance."

													items: type: "string"
													type: "array"
												}
												interfaceType: {
													description: """
		The type of network interface. To create an Elastic Fabric Adapter (EFA), specify efa. For more information, see Elastic Fabric Adapter (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/efa.html) in the Amazon Elastic Compute Cloud User Guide. 
		 If you are not creating an EFA, specify interface or omit this parameter. 
		 Valid values: interface | efa
		"""

													enum: [
														"interface",
														"efa",
													]
													type: "string"
												}
												ipv6AddressCount: {
													description: "A number of IPv6 addresses to assign to the network interface. Amazon EC2 chooses the IPv6 addresses from the range of the subnet. You cannot specify this option and the option to assign specific IPv6 addresses in the same request. You can specify this option if you've specified a minimum number of instances to launch."

													format: "int32"
													type:   "integer"
												}
												ipv6Addresses: {
													description: "One or more IPv6 addresses to assign to the network interface. You cannot specify this option and the option to assign a number of IPv6 addresses in the same request. You cannot specify this option if you've specified a minimum number of instances to launch."

													items: {
														description: "InstanceIPv6Address describes an IPv6 address."
														properties: ipv6Address: {
															description: "The IPv6 address."
															type:        "string"
														}
														required: [
															"ipv6Address",
														]
														type: "object"
													}
													type: "array"
												}
												networkInterfaceId: {
													description: """
		The ID of the network interface. 
		 If you are creating a Spot Fleet, omit this parameter because you can’t specify a network interface ID in a launch specification.
		"""

													type: "string"
												}
												privateIpAddress: {
													description: "The private IPv4 address of the network interface. Applies only if creating a network interface when launching an instance. You cannot specify this option if you're launching more than one instance in a RunInstances (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html) request."

													type: "string"
												}
												privateIpAddresses: {
													description: "One or more private IPv4 addresses to assign to the network interface. Only one private IPv4 address can be designated as primary. You cannot specify this option if you're launching more than one instance in a RunInstances (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html) request."

													items: {
														description: "PrivateIPAddressSpecification describes a secondary private IPv4 address for a network interface."

														properties: {
															primary: {
																description: "Indicates whether the private IPv4 address is the primary private IPv4 address. Only one IPv4 address can be designated as primary."

																type: "boolean"
															}
															privateIPAddress: {
																description: "The private IPv4 addresses."
																type:        "string"
															}
														}
														required: ["privateIPAddress"]
														type: "object"
													}
													type: "array"
												}
												secondaryPrivateIpAddressCount: {
													description: "The number of secondary private IPv4 addresses. You can't specify this option and specify more than one private IP address using the private IP addresses option. You cannot specify this option if you're launching more than one instance in a RunInstances (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html) request."

													format: "int32"
													type:   "integer"
												}
												subnetId: {
													description: "The ID of the subnet associated with the network interface. Applies only if creating a network interface when launching an instance."

													type: "string"
												}
											}
											required: [
												"deviceIndex",
												"groups",
												"interfaceType",
											]
											type: "object"
										}
										type: "array"
									}
									placement: {
										description: "The placement for the instance."
										properties: {
											affinity: {
												description: """
		The affinity setting for the instance on the Dedicated Host. This parameter is not supported for the ImportInstance (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html) command. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
											availabilityZone: {
												description: """
		The Availability Zone of the instance. 
		 If not specified, an Availability Zone will be automatically chosen for you based on the load balancing criteria for the Region. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
											groupName: {
												description: "The name of the placement group the instance is in."

												type: "string"
											}
											hostId: {
												description: """
		The ID of the Dedicated Host on which the instance resides. This parameter is not supported for the ImportInstance (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html) command. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
											hostResourceGroupArn: {
												description: """
		The ARN of the host resource group in which to launch the instances. If you specify a host resource group ARN, omit the Tenancy parameter or set it to host. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
											partitionNumber: {
												description: """
		The number of the partition the instance is in. Valid only if the placement group strategy is set to partition. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												format: "int32"
												type:   "integer"
											}
											spreadDomain: {
												description: """
		Reserved for future use. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
											tenancy: {
												description: """
		The tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of dedicated runs on single-tenant hardware. The host tenancy is not supported for the ImportInstance (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html) command. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
										}
										required: ["groupName"]
										type: "object"
									}
									privateIpAddress: {
										description: """
		[EC2-VPC] The primary IPv4 address. You must specify a value from the IPv4 address range of the subnet. 
		 Only one private IP address can be designated as primary. You can't specify this option if you've specified the option to designate a private IP address as the primary IP address in a network interface specification. You cannot specify this option if you're launching more than one instance in the request. 
		 You cannot specify this option and the network interfaces option in the same request.
		"""

										type: "string"
									}
									ramDiskId: {
										description: """
		The ID of the RAM disk to select. Some kernels require additional drivers at launch. Check the kernel requirements for information about whether you need to specify a RAM disk. To find kernel requirements, go to the AWS Resource Center and search for the kernel ID. 
		 AWS recommends that you use PV-GRUB instead of kernels and RAM disks. For more information, see PV-GRUB (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedkernels.html) in the Amazon Elastic Compute Cloud User Guide.
		"""

										type: "string"
									}
									region: {
										description: "Region is the region you'd like your Instance to be created in."

										type: "string"
									}
									securityGroupIds: {
										description: """
		The IDs of the security groups. You can create a security group using CreateSecurityGroup (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateSecurityGroup.html). 
		 If you specify a network interface, you must specify any security groups as part of the network interface.
		"""

										items: type: "string"
										type: "array"
									}
									securityGroupRefs: {
										description: "SecurityGroupsRefs is a list of references to SecurityGroups used to set the SecurityGroupIDs."

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
									securityGroupSelector: {
										description: "SecurityGroupsSelector selects references to SecurityGroups used to set the SecurityGroupIDs."

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
									subnetId: {
										description: """
		[EC2-VPC] The ID of the subnet to launch the instance into. 
		 If you specify a network interface, you must specify any subnets as part of the network interface.
		"""

										type: "string"
									}
									subnetIdRef: {
										description: "SubnetIDRef is a reference to a Subnet used to set the SubnetID."

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
									subnetIdSelector: {
										description: "SubnetIDSelector selects a reference to a Subnet used to set the SubnetID."

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
									tagSpecifications: {
										description: "The tags to apply to the resources during launch. You can only tag instances and volumes on launch. The specified tags are applied to all instances or volumes that are created during launch. To tag a resource after it has been created, see CreateTags (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html)."

										items: {
											description: "TagSpecification defines the tags to apply to a resource when the resource is being created."

											properties: {
												resourceType: {
													description: """
		The type of resource to tag. Currently, the resource types that support tagging on creation are: capacity-reservation | client-vpn-endpoint | dedicated-host | fleet | fpga-image | instance | ipv4pool-ec2 | ipv6pool-ec2 | key-pair | launch-template | natgateway | spot-fleet-request | placement-group | snapshot | traffic-mirror-filter | traffic-mirror-session | traffic-mirror-target | transit-gateway | transit-gateway-attachment | transit-gateway-route-table | vpc-endpoint (for interface VPC endpoints)| vpc-endpoint-service (for gateway VPC endpoints) | volume | vpc-flow-log. 
		 To tag a resource after it has been created, see CreateTags (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html).
		"""

													enum: [
														"capacity-reservation",
														"client-vpn-endpoint",
														"dedicated-host",
														"fleet",
														"fpga-image",
														"instance",
														"ipv4pool-ec2",
														"ipv6pool-ec2",
														"key-pair",
														"launch-template",
														"natgateway",
														"spot-fleet-request",
														"placement-group",
														"snapshot",
														"traffic-mirror-filter",
														"traffic-mirror-session",
														"traffic-mirror-target",
														"transit-gateway",
														"transit-gateway-attachment",
														"transit-gateway-route-table",
														"vpc-endpoint",
														"vpc-endpoint-service",
														"volume",
														"vpc-flow-log",
													]
													type: "string"
												}
												tags: {
													description: "The tags to apply to the resource"
													items: {
														description: "Tag defines a tag"
														properties: {
															key: {
																description: "Key is the name of the tag."
																type:        "string"
															}
															value: {
																description: "Value is the value of the tag."
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
											}
											required: [
												"resourceType",
												"tags",
											]
											type: "object"
										}
										type: "array"
									}
									tags: {
										description: "Tags are used as identification helpers between AWS resources."

										items: {
											description: "Tag defines a tag"
											properties: {
												key: {
													description: "Key is the name of the tag."
													type:        "string"
												}
												value: {
													description: "Value is the value of the tag."
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
									userData: {
										description: "The user data to make available to the instance. For more information, see Running Commands on Your Linux Instance at Launch (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html) (Linux) and Adding User Data (https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-instance-metadata.html#instancedata-add-user-data) (Windows). If you are using a command line tool, base64-encoding is performed for you, and you can load the text from a file. Otherwise, you must provide base64-encoded text. User data is limited to 16 KB."

										pattern: "^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$"
										type:    "string"
									}
								}
								required: [
									"imageId",
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
						description: "An InstanceStatus represents the observed state of Instances."
						properties: {
							atProvider: {
								description: "InstanceObservation keeps the state for the external resource. The below fields follow the Instance response object as closely as possible."

								properties: {
									amiLaunchIndex: {
										format: "int32"
										type:   "integer"
									}
									architecture: type: "string"
									blockDeviceMapping: {
										items: {
											description: "InstanceBlockDeviceMapping describes a block device mapping."

											properties: {
												deviceName: {
													description: "The device name (for example, /dev/sdh or xvdh)."
													type:        "string"
												}
												ebs: {
													description: "Parameters used to automatically set up EBS volumes when the instance is launched."

													properties: {
														attachTime: {
															description: "The time stamp when the attachment initiated."
															format:      "date-time"
															type:        "string"
														}
														deleteOnTermination: {
															description: "Indicates whether the volume is deleted on instance termination."

															type: "boolean"
														}
														status: {
															description: "The attachment state."
															type:        "string"
														}
														volumeId: {
															description: "The ID of the EBS volume."
															type:        "string"
														}
													}
													required: [
														"attachTime",
														"deleteOnTermination",
														"status",
														"volumeId",
													]
													type: "object"
												}
											}
											required: [
												"deviceName",
												"ebs",
											]
											type: "object"
										}
										type: "array"
									}
									capacityReservationId: type: "string"
									capacityReservationSpecification: {
										description: "CapacityReservationSpecificationResponse describes the instance's Capacity Reservation targeting preferences. The action returns the capacityReservationPreference response element if the instance is configured to run in On-Demand capacity, or if it is configured in run in any open Capacity Reservation that has matching attributes (instance type, platform, Availability Zone). The action returns the capacityReservationTarget response element if the instance explicily targets a specific Capacity Reservation."

										properties: {
											capacityReservationPreference: {
												description: """
		Describes the instance's Capacity Reservation preferences. Possible preferences include: 
		 * open - The instance can run in any open Capacity Reservation that has matching attributes (instance type, platform, Availability Zone). 
		 * none - The instance avoids running in a Capacity Reservation even if one is available. The instance runs in On-Demand capacity.
		"""

												type: "string"
											}
											capacityReservationTarget: {
												description: "Information about the targeted Capacity Reservation."
												properties: capacityReservationId: {
													description: "The ID of the Capacity Reservation."
													type:        "string"
												}
												type: "object"
											}
										}
										required: ["capacityReservationPreference"]
										type: "object"
									}
									clientToken: type: "string"
									cpuOptions: {
										description: "CPUOptionsRequest defines the options for the instance. Both the core count and threads per core must be specified in the request."

										properties: {
											coreCount: {
												description: "The number of CPU cores for the instance."
												format:      "int32"
												type:        "integer"
											}
											threadsPerCore: {
												description: "The number of threads per CPU core. To disable multithreading for the instance, specify a value of 1. Otherwise, specify the default value of 2."

												format: "int32"
												type:   "integer"
											}
										}
										required: [
											"coreCount",
											"threadsPerCore",
										]
										type: "object"
									}
									ebs: type: "string"
									ebsOptimized: type: "boolean"
									elasticGpuAssociation: {
										items: {
											description: "ElasticGPUAssociation describes the association between an instance and an Elastic Graphics accelerator."

											properties: {
												elasticGpuAssociationId: {
													description: "The ID of the association."
													type:        "string"
												}
												elasticGpuAssociationState: {
													description: "The state of the association between the instance and the Elastic Graphics accelerator."

													type: "string"
												}
												elasticGpuAssociationTime: {
													description: "The time the Elastic Graphics accelerator was associated with the instance."

													type: "string"
												}
												elasticGpuId: {
													description: "The ID of the Elastic Graphics accelerator."
													type:        "string"
												}
											}
											required: [
												"elasticGpuAssociationId",
												"elasticGpuAssociationState",
												"elasticGpuAssociationTime",
												"elasticGpuId",
											]
											type: "object"
										}
										type: "array"
									}
									elasticInferenceAcceleratorAssociations: {
										items: {
											description: "ElasticInferenceAcceleratorAssociation describes the association between an instance and an elastic inference accelerator."

											properties: {
												elasticInferenceAcceleratorArn: {
													description: "The Amazon Resource Name (ARN) of the elastic inference accelerator."

													type: "string"
												}
												elasticInferenceAcceleratorAssociationId: {
													description: "The ID of the association."
													type:        "string"
												}
												elasticInferenceAcceleratorAssociationState: {
													description: "The state of the elastic inference accelerator."
													type:        "string"
												}
												elasticInferenceAcceleratorAssociationTime: {
													description: "The time at which the elastic inference accelerator is associated with an instance."

													format: "date-time"
													type:   "string"
												}
											}
											required: [
												"elasticInferenceAcceleratorArn",
												"elasticInferenceAcceleratorAssociationId",
												"elasticInferenceAcceleratorAssociationState",
												"elasticInferenceAcceleratorAssociationTime",
											]
											type: "object"
										}
										type: "array"
									}
									enaSupport: type: "boolean"
									hibernationOptions: {
										description: "HibernationOptionsRequest indicates whether your instance is configured for hibernation. This parameter is valid only if the instance meets the hibernation prerequisites (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html#hibernating-prerequisites). For more information, see Hibernate Your Instance (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html) in the Amazon Elastic Compute Cloud User Guide."

										properties: configured: {
											description: """
		If you set this parameter to true, your instance is enabled for hibernation. 
		 Default: false
		"""

											type: "boolean"
										}
										type: "object"
									}
									hypervisor: type: "string"
									iamInstanceProfile: {
										description: "IAMInstanceProfile Describes an IAM instance profile."
										properties: {
											arn: {
												description: "The Amazon Resource Name (ARN) of the instance profile."

												type: "string"
											}
											id: {
												description: "The ID of the instance profile."
												type:        "string"
											}
										}
										required: [
											"arn",
											"id",
										]
										type: "object"
									}
									imageId: type: "string"
									instanceId: type: "string"
									instanceLifecyle: type: "string"
									instanceType: {
										description: "Supported instance family when set instanceInterruptionBehavior to hibernate C3, C4, C5, M4, M5, R3, R4"

										type: "string"
									}
									kernelId: type: "string"
									launchTime: {
										format: "date-time"
										type:   "string"
									}
									licenseSet: {
										items: {
											description: "LicenseConfigurationRequest describes a license configuration"

											properties: licenseConfigurationArn: {
												description: "Amazon Resource Name (ARN) of the license configuration"
												type:        "string"
											}
											required: ["licenseConfigurationArn"]
											type: "object"
										}
										type: "array"
									}
									metadataOptions: {
										description: "InstanceMetadataOptionsRequest defines the metadata options for the instance."

										properties: {
											httpEndpoint: {
												description: """
		This parameter enables or disables the HTTP metadata endpoint on your instances. If the parameter is not specified, the default state is enabled. 
		 If you specify a value of disabled, you will not be able to access your instance metadata.
		"""

												enum: [
													"enabled",
													"disabled",
												]
												type: "string"
											}
											httpPutResponseHopLimit: {
												description: """
		The desired HTTP PUT response hop limit for instance metadata requests. The larger the number, the further instance metadata requests can travel. 
		 Default: 1 
		 Possible values: Integers from 1 to 64
		"""

												format: "int32"
												type:   "integer"
											}
											httpTokens: {
												description: """
		The state of token usage for your instance metadata requests. If the parameter is not specified in the request, the default state is optional. 
		 If the state is optional, you can choose to retrieve instance metadata with or without a signed token header on your request. If you retrieve the IAM role credentials without a token, the version 1.0 role credentials are returned. If you retrieve the IAM role credentials using a valid signed token, the version 2.0 role credentials are returned. 
		 If the state is required, you must send a signed token header with any instance metadata retrieval requests. In this state, retrieving the IAM role credentials always returns the version 2.0 credentials; the version 1.0 credentials are not available.
		"""

												enum: [
													"optional",
													"required",
												]
												type: "string"
											}
										}
										required: ["httpTokens"]
										type: "object"
									}
									monitoring: {
										description: "Monitoring describes the monitoring of an instance."
										properties: state: {
											description: "Indicates whether detailed monitoring is enabled. Otherwise, basic monitoring is enabled."

											type: "string"
										}
										required: ["state"]
										type: "object"
									}
									networkInterfaces: {
										items: {
											description: "InstanceNetworkInterface describes a network interface."
											properties: {
												association: {
													description: "The association information for an Elastic IPv4 associated with the network interface."

													properties: {
														ipOwnerId: {
															description: "The ID of the owner of the Elastic IP address."
															type:        "string"
														}
														publicDnsName: {
															description: "The public DNS name."
															type:        "string"
														}
														publicIp: {
															description: "The public IP address or Elastic IP address bound to the network interface."

															type: "string"
														}
													}
													type: "object"
												}
												attachment: {
													description: "The network interface attachment."
													properties: {
														attachTime: {
															description: "The time stamp when the attachment initiated."
															format:      "date-time"
															type:        "string"
														}
														attachmentId: {
															description: "The ID of the network interface attachment."
															type:        "string"
														}
														deleteOnTermination: {
															description: "Indicates whether the network interface is deleted when the instance is terminated."

															type: "boolean"
														}
														deviceIndex: {
															description: "The index of the device on the instance for the network interface attachment."

															format: "int32"
															type:   "integer"
														}
														status: {
															description: "The attachment state."
															type:        "string"
														}
													}
													type: "object"
												}
												description: {
													description: "The description."
													type:        "string"
												}
												groups: {
													description: "One or more security groups."
													items: {
														description: "GroupIdentifier describes a security group"
														properties: {
															groupId: {
																description: "GroupID is the security group identifier"
																type:        "string"
															}
															groupName: {
																description: "GroupName is the name of the security group"

																type: "string"
															}
														}
														required: [
															"groupId",
															"groupName",
														]
														type: "object"
													}
													type: "array"
												}
												interfaceType: {
													description: """
		Describes the type of network interface. 
		 Valid values: interface | efa
		"""

													type: "string"
												}
												ipv6Addresses: {
													description: "One or more IPv6 addresses associated with the network interface."

													items: {
														description: "InstanceIPv6Address describes an IPv6 address."
														properties: ipv6Address: {
															description: "The IPv6 address."
															type:        "string"
														}
														required: ["ipv6Address"]
														type: "object"
													}
													type: "array"
												}
												macAddress: {
													description: "The MAC address."
													type:        "string"
												}
												networkInterfaceId: {
													description: "The ID of the network interface."
													type:        "string"
												}
												ownerId: {
													description: "The ID of the AWS account that created the network interface."

													type: "string"
												}
												privateDnsName: {
													description: "The private DNS name."
													type:        "string"
												}
												privateIpAddress: {
													description: "The IPv4 address of the network interface within the subnet."

													type: "string"
												}
												privateIpAddresses: {
													description: "One or more private IPv4 addresses associated with the network interface."

													items: {
														description: "InstancePrivateIPAddress describes a private IPv4 address."

														properties: {
															association: {
																description: "The association information for an Elastic IP address for the network interface."

																properties: {
																	ipOwnerId: {
																		description: "The ID of the owner of the Elastic IP address."

																		type: "string"
																	}
																	publicDnsName: {
																		description: "The public DNS name."
																		type:        "string"
																	}
																	publicIp: {
																		description: "The public IP address or Elastic IP address bound to the network interface."

																		type: "string"
																	}
																}
																type: "object"
															}
															primary: {
																description: "Indicates whether this IPv4 address is the primary private IP address of the network interface."

																type: "boolean"
															}
															privateDnsName: {
																description: "The private IPv4 DNS name."
																type:        "string"
															}
															privateIpAddress: {
																description: "The private IPv4 address of the network interface."

																type: "string"
															}
														}
														required: [
															"association",
															"primary",
															"privateDnsName",
															"privateIpAddress",
														]
														type: "object"
													}
													type: "array"
												}
												sourceDestCheck: {
													description: "Indicates whether to validate network traffic to or from this network interface."

													type: "boolean"
												}
												status: {
													description: "The status of the network interface."
													type:        "string"
												}
												subnetId: {
													description: "The ID of the subnet."
													type:        "string"
												}
												vpcId: {
													description: "The ID of the VPC."
													type:        "string"
												}
											}
											required: ["status"]
											type: "object"
										}
										type: "array"
									}
									outpostArn: type: "string"
									placement: {
										description: "Placement describes the placement of an instance."
										properties: {
											affinity: {
												description: """
		The affinity setting for the instance on the Dedicated Host. This parameter is not supported for the ImportInstance (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html) command. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
											availabilityZone: {
												description: """
		The Availability Zone of the instance. 
		 If not specified, an Availability Zone will be automatically chosen for you based on the load balancing criteria for the Region. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
											groupName: {
												description: "The name of the placement group the instance is in."

												type: "string"
											}
											hostId: {
												description: """
		The ID of the Dedicated Host on which the instance resides. This parameter is not supported for the ImportInstance (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html) command. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
											hostResourceGroupArn: {
												description: """
		The ARN of the host resource group in which to launch the instances. If you specify a host resource group ARN, omit the Tenancy parameter or set it to host. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
											partitionNumber: {
												description: """
		The number of the partition the instance is in. Valid only if the placement group strategy is set to partition. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												format: "int32"
												type:   "integer"
											}
											spreadDomain: {
												description: """
		Reserved for future use. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
											tenancy: {
												description: """
		The tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of dedicated runs on single-tenant hardware. The host tenancy is not supported for the ImportInstance (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportInstance.html) command. 
		 This parameter is not supported by CreateFleet (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet).
		"""

												type: "string"
											}
										}
										required: ["groupName"]
										type: "object"
									}
									platform: type: "string"
									privateDnsName: type: "string"
									privateIpAddress: type: "string"
									productCodes: {
										items: {
											description: "ProductCode describes a product code."
											properties: {
												productCodeId: {
													description: "The product code."
													type:        "string"
												}
												productCodeType: {
													description: "The type of product code."
													type:        "string"
												}
											}
											required: [
												"productCodeId",
												"productCodeType",
											]
											type: "object"
										}
										type: "array"
									}
									publicDnsName: type: "string"
									publicIpAddress: type: "string"
									ramDiskId: type: "string"
									rootDeviceType: type: "string"
									securityGroups: {
										items: {
											description: "GroupIdentifier describes a security group"
											properties: {
												groupId: {
													description: "GroupID is the security group identifier"
													type:        "string"
												}
												groupName: {
													description: "GroupName is the name of the security group"
													type:        "string"
												}
											}
											required: [
												"groupId",
												"groupName",
											]
											type: "object"
										}
										type: "array"
									}
									sourceDestCheck: type: "boolean"
									spotInstanceId: type: "string"
									sriovNetSupport: type: "string"
									state: type: "string"
									stateReason: {
										description: "StateReason describes a state change."
										properties: {
											code: {
												description: "The reason code for the state change."
												type:        "string"
											}
											message: {
												description: """
		The message for the state change. 
		 * Server.InsufficientInstanceCapacity: There was insufficient capacity available to satisfy the launch request. 
		 * Server.InternalError: An internal error caused the instance to terminate during launch. 
		 * Server.ScheduledStop: The instance was stopped due to a scheduled retirement. 
		 * Server.SpotInstanceShutdown: The instance was stopped because the number of Spot requests with a maximum price equal to or higher than the Spot price exceeded available capacity or because of an increase in the Spot price. 
		 * Server.SpotInstanceTermination: The instance was terminated because the number of Spot requests with a maximum price equal to or higher than the Spot price exceeded available capacity or because of an increase in the Spot price. 
		 * Client.InstanceInitiatedShutdown: The instance was shut down using the shutdown -h command from the instance. 
		 * Client.InstanceTerminated: The instance was terminated or rebooted during AMI creation. 
		 * Client.InternalError: A client error caused the instance to terminate during launch. 
		 * Client.InvalidSnapshot.NotFound: The specified snapshot was not found. 
		 * Client.UserInitiatedHibernate: Hibernation was initiated on the instance. 
		 * Client.UserInitiatedShutdown: The instance was shut down using the Amazon EC2 API. 
		 * Client.VolumeLimitExceeded: The limit on the number of EBS volumes or total storage was exceeded. Decrease usage or request an increase in your account limits.
		"""

												type: "string"
											}
										}
										required: [
											"code",
											"message",
										]
										type: "object"
									}
									stateTransitionReason: type: "string"
									subnetId: type: "string"
									tags: {
										items: {
											description: "Tag defines a tag"
											properties: {
												key: {
													description: "Key is the name of the tag."
													type:        "string"
												}
												value: {
													description: "Value is the value of the tag."
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
									virualizationType: type: "string"
									vpcId: type: "string"
								}
								required: [
									"architecture",
									"instanceType",
									"platform",
									"rootDeviceType",
									"state",
									"virualizationType",
								]
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
	}, status: {

		acceptedNames: {
			kind:   ""
			plural: ""
		}
		conditions: []
		storedVersions: []
	}
}
