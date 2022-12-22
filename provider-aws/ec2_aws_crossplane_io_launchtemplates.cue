package ec2_aws_crossplane_io_launchtemplates

customresourcedefinition: "launchtemplates.ec2.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "launchtemplates.ec2.aws.crossplane.io"
	}
	spec: {
		group: "ec2.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "LaunchTemplate"
			listKind: "LaunchTemplateList"
			plural:   "launchtemplates"
			singular: "launchtemplate"
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
				description: "LaunchTemplate is the Schema for the LaunchTemplates API"
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
						description: "LaunchTemplateSpec defines the desired state of LaunchTemplate"
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
								description: "LaunchTemplateParameters defines the desired state of LaunchTemplate"

								properties: {
									launchTemplateData: {
										description: "The information for the launch template."
										properties: {
											blockDeviceMappings: {
												items: {
													properties: {
														deviceName: type: "string"
														ebs: {
															description: "The parameters for a block device for an EBS volume."

															properties: {
																deleteOnTermination: type: "boolean"
																encrypted: type: "boolean"
																iops: {
																	format: "int64"
																	type:   "integer"
																}
																kmsKeyID: type: "string"
																snapshotID: type: "string"
																throughput: {
																	format: "int64"
																	type:   "integer"
																}
																volumeSize: {
																	format: "int64"
																	type:   "integer"
																}
																volumeType: type: "string"
															}
															type: "object"
														}
														noDevice: type: "string"
														virtualName: type: "string"
													}
													type: "object"
												}
												type: "array"
											}
											capacityReservationSpecification: {
												description: "Describes an instance's Capacity Reservation targeting option. You can specify only one option at a time. Use the CapacityReservationPreference parameter to configure the instance to run in On-Demand capacity or to run in any open Capacity Reservation that has matching attributes (instance type, platform, Availability Zone). Use the CapacityReservationTarget parameter to explicitly target a specific Capacity Reservation or a Capacity Reservation group."

												properties: {
													capacityReservationPreference: type: "string"
													capacityReservationTarget: {
														description: "Describes a target Capacity Reservation or Capacity Reservation group."

														properties: {
															capacityReservationID: type: "string"
															capacityReservationResourceGroupARN: type: "string"
														}
														type: "object"
													}
												}
												type: "object"
											}
											cpuOptions: {
												description: "The CPU options for the instance. Both the core count and threads per core must be specified in the request."

												properties: {
													coreCount: {
														format: "int64"
														type:   "integer"
													}
													threadsPerCore: {
														format: "int64"
														type:   "integer"
													}
												}
												type: "object"
											}
											creditSpecification: {
												description: "The credit option for CPU usage of a T2, T3, or T3a instance."

												properties: cpuCredits: type: "string"
												type: "object"
											}
											disableAPITermination: type: "boolean"
											ebsOptimized: type: "boolean"
											elasticGPUSpecifications: {
												items: {
													properties: type_: type: "string"
													type: "object"
												}
												type: "array"
											}
											elasticInferenceAccelerators: {
												items: {
													properties: {
														count: {
															format: "int64"
															type:   "integer"
														}
														type_: type: "string"
													}
													type: "object"
												}
												type: "array"
											}
											enclaveOptions: {
												description: "Indicates whether the instance is enabled for Amazon Web Services Nitro Enclaves. For more information, see What is Amazon Web Services Nitro Enclaves? (https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html) in the Amazon Web Services Nitro Enclaves User Guide."

												properties: enabled: type: "boolean"
												type: "object"
											}
											hibernationOptions: {
												description: "Indicates whether the instance is configured for hibernation. This parameter is valid only if the instance meets the hibernation prerequisites (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html#hibernating-prerequisites)."

												properties: configured: type: "boolean"
												type: "object"
											}
											iamInstanceProfile: {
												description: "An IAM instance profile."
												properties: {
													arn: type: "string"
													name: type: "string"
												}
												type: "object"
											}
											imageID: type: "string"
											instanceInitiatedShutdownBehavior: type: "string"
											instanceMarketOptions: {
												description: "The market (purchasing) option for the instances."
												properties: {
													marketType: type: "string"
													spotOptions: {
														description: "The options for Spot Instances."
														properties: {
															blockDurationMinutes: {
																format: "int64"
																type:   "integer"
															}
															instanceInterruptionBehavior: type: "string"
															maxPrice: type: "string"
															spotInstanceType: type: "string"
															validUntil: {
																format: "date-time"
																type:   "string"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											instanceRequirements: {
												description: """
		The attributes for the instance types. When you specify instance attributes, Amazon EC2 will identify instance types with these attributes. 
		 When you specify multiple parameters, you get instance types that satisfy all of the specified parameters. If you specify multiple values for a parameter, you get instance types that satisfy any of the specified values. 
		 You must specify VCpuCount and MemoryMiB. All other parameters are optional. Any unspecified optional parameter is set to its default. 
		 For more information, see Attribute-based instance type selection for EC2 Fleet (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-attribute-based-instance-type-selection.html), Attribute-based instance type selection for Spot Fleet (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-attribute-based-instance-type-selection.html), and Spot placement score (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-placement-score.html) in the Amazon EC2 User Guide.
		"""

												properties: {
													acceleratorCount: {
														description: "The minimum and maximum number of accelerators (GPUs, FPGAs, or Amazon Web Services Inferentia chips) on an instance. To exclude accelerator-enabled instance types, set Max to 0."

														properties: {
															max: {
																format: "int64"
																type:   "integer"
															}
															min: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
													acceleratorManufacturers: {
														items: type: "string"
														type: "array"
													}
													acceleratorNames: {
														items: type: "string"
														type: "array"
													}
													acceleratorTotalMemoryMiB: {
														description: "The minimum and maximum amount of total accelerator memory, in MiB."

														properties: {
															max: {
																format: "int64"
																type:   "integer"
															}
															min: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
													acceleratorTypes: {
														items: type: "string"
														type: "array"
													}
													bareMetal: type: "string"
													baselineEBSBandwidthMbps: {
														description: "The minimum and maximum baseline bandwidth to Amazon EBS, in Mbps. For more information, see Amazon EBS–optimized instances (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html) in the Amazon EC2 User Guide."

														properties: {
															max: {
																format: "int64"
																type:   "integer"
															}
															min: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
													burstablePerformance: type: "string"
													cpuManufacturers: {
														items: type: "string"
														type: "array"
													}
													excludedInstanceTypes: {
														items: type: "string"
														type: "array"
													}
													instanceGenerations: {
														items: type: "string"
														type: "array"
													}
													localStorage: type: "string"
													localStorageTypes: {
														items: type: "string"
														type: "array"
													}
													memoryGiBPerVCPU: {
														description: "The minimum and maximum amount of memory per vCPU, in GiB."

														properties: {
															max: type: "number"
															min: type: "number"
														}
														type: "object"
													}
													memoryMiB: {
														description: "The minimum and maximum amount of memory, in MiB."

														properties: {
															max: {
																format: "int64"
																type:   "integer"
															}
															min: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
													networkInterfaceCount: {
														description: "The minimum and maximum number of network interfaces."

														properties: {
															max: {
																format: "int64"
																type:   "integer"
															}
															min: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
													onDemandMaxPricePercentageOverLowestPrice: {
														format: "int64"
														type:   "integer"
													}
													requireHibernateSupport: type: "boolean"
													spotMaxPricePercentageOverLowestPrice: {
														format: "int64"
														type:   "integer"
													}
													totalLocalStorageGB: {
														description: "The minimum and maximum amount of total local storage, in GB."

														properties: {
															max: type: "number"
															min: type: "number"
														}
														type: "object"
													}
													vCPUCount: {
														description: "The minimum and maximum number of vCPUs."
														properties: {
															max: {
																format: "int64"
																type:   "integer"
															}
															min: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											instanceType: type: "string"
											kernelID: type: "string"
											keyName: type: "string"
											licenseSpecifications: {
												items: {
													properties: licenseConfigurationARN: type: "string"
													type: "object"
												}
												type: "array"
											}
											maintenanceOptions: {
												description: "The maintenance options of your instance."
												properties: autoRecovery: type: "string"
												type: "object"
											}
											metadataOptions: {
												description: "The metadata options for the instance. For more information, see Instance Metadata and User Data (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html) in the Amazon Elastic Compute Cloud User Guide."

												properties: {
													httpEndpoint: type: "string"
													httpProtocolIPv6: type: "string"
													httpPutResponseHopLimit: {
														format: "int64"
														type:   "integer"
													}
													httpTokens: type: "string"
													instanceMetadataTags: type: "string"
												}
												type: "object"
											}
											monitoring: {
												description: "Describes the monitoring for the instance."
												properties: enabled: type: "boolean"
												type: "object"
											}
											networkInterfaces: {
												items: {
													properties: {
														associateCarrierIPAddress: type: "boolean"
														associatePublicIPAddress: type: "boolean"
														deleteOnTermination: type: "boolean"
														description: type: "string"
														deviceIndex: {
															format: "int64"
															type:   "integer"
														}
														groups: {
															items: type: "string"
															type: "array"
														}
														interfaceType: type: "string"
														ipv4PrefixCount: {
															format: "int64"
															type:   "integer"
														}
														ipv4Prefixes: {
															items: {
																properties: ipv4Prefix: type: "string"
																type: "object"
															}
															type: "array"
														}
														ipv6AddressCount: {
															format: "int64"
															type:   "integer"
														}
														ipv6Addresses: {
															items: {
																properties: ipv6Address: type: "string"
																type: "object"
															}
															type: "array"
														}
														ipv6PrefixCount: {
															format: "int64"
															type:   "integer"
														}
														ipv6Prefixes: {
															items: {
																properties: ipv6Prefix: type: "string"
																type: "object"
															}
															type: "array"
														}
														networkCardIndex: {
															format: "int64"
															type:   "integer"
														}
														networkInterfaceID: type: "string"
														privateIPAddress: type: "string"
														privateIPAddresses: {
															items: {
																properties: {
																	primary: type: "boolean"
																	privateIPAddress: type: "string"
																}
																type: "object"
															}
															type: "array"
														}
														secondaryPrivateIPAddressCount: {
															format: "int64"
															type:   "integer"
														}
														subnetID: type: "string"
													}
													type: "object"
												}
												type: "array"
											}
											placement: {
												description: "Describes the placement of an instance."
												properties: {
													affinity: type: "string"
													availabilityZone: type: "string"
													groupName: type: "string"
													hostID: type: "string"
													hostResourceGroupARN: type: "string"
													partitionNumber: {
														format: "int64"
														type:   "integer"
													}
													spreadDomain: type: "string"
													tenancy: type: "string"
												}
												type: "object"
											}
											privateDNSNameOptions: {
												description: "Describes the options for instance hostnames."
												properties: {
													enableResourceNameDNSAAAARecord: type: "boolean"
													enableResourceNameDNSARecord: type: "boolean"
													hostnameType: type: "string"
												}
												type: "object"
											}
											ramDiskID: type: "string"
											securityGroupIDs: {
												items: type: "string"
												type: "array"
											}
											securityGroups: {
												items: type: "string"
												type: "array"
											}
											tagSpecifications: {
												items: {
													properties: {
														resourceType: type: "string"
														tags: {
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
													type: "object"
												}
												type: "array"
											}
											userData: type: "string"
										}
										type: "object"
									}
									launchTemplateName: {
										description: "A name for the launch template."
										type:        "string"
									}
									region: {
										description: "Region is which region the LaunchTemplate will be created."

										type: "string"
									}
									tagSpecifications: {
										description: "The tags to apply to the launch template during creation."
										items: {
											properties: {
												resourceType: type: "string"
												tags: {
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
											type: "object"
										}
										type: "array"
									}
									tags: {
										description: "Metadata tagging key value pairs"
										items: {
											properties: {
												key: type: "string"
												value: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									versionDescription: {
										description: "A description for the first version of the launch template."

										type: "string"
									}
								}
								required: [
									"launchTemplateData",
									"launchTemplateName",
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
						description: "LaunchTemplateStatus defines the observed state of LaunchTemplate."
						properties: {
							atProvider: {
								description: "LaunchTemplateObservation defines the observed state of LaunchTemplate"

								properties: {
									launchTemplate: {
										description: "Information about the launch template."
										properties: {
											createTime: {
												format: "date-time"
												type:   "string"
											}
											createdBy: type: "string"
											defaultVersionNumber: {
												format: "int64"
												type:   "integer"
											}
											latestVersionNumber: {
												format: "int64"
												type:   "integer"
											}
											launchTemplateID: type: "string"
											launchTemplateName: type: "string"
											tags: {
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
										type: "object"
									}
									warning: {
										description: "If the launch template contains parameters or parameter combinations that are not valid, an error code and an error message are returned for each issue that's found."

										properties: errors: {
											items: {
												properties: {
													code: type: "string"
													message: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										type: "object"
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
	}, status: {

		acceptedNames: {
			kind:   ""
			plural: ""
		}
		conditions: []
		storedVersions: []
	}
}
