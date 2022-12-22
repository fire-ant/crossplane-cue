package lambda_aws_crossplane_io_functions

customresourcedefinition: "functions.lambda.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "functions.lambda.aws.crossplane.io"
	}
	spec: {
		group: "lambda.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Function"
			listKind: "FunctionList"
			plural:   "functions"
			singular: "function"
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
			deprecated:         true
			deprecationWarning: "Please use v1beta1 version of this resource."
			name:               "v1alpha1"
			schema: openAPIV3Schema: {
				description: "Function is the Schema for the Functions API"
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
						description: "FunctionSpec defines the desired state of Function"
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
								description: "FunctionParameters defines the desired state of Function"
								properties: {
									code: {
										description: "The code for the function."
										properties: {
											imageURI: type: "string"
											s3Bucket: type: "string"
											s3BucketRef: {
												description: "S3BucketRef is a reference to an S3 Bucket."
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
											s3BucketSelector: {
												description: "S3BucketSelector selects references to an S3 Bucket."

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
											s3Key: type: "string"
											s3ObjectVersion: type: "string"
										}
										type: "object"
									}
									codeSigningConfigARN: {
										description: "To enable code signing for this function, specify the ARN of a code-signing configuration. A code-signing configuration includes a set of signing profiles, which define the trusted publishers for this function."

										type: "string"
									}
									deadLetterConfig: {
										description: "A dead letter queue configuration that specifies the queue or topic where Lambda sends asynchronous events when they fail processing. For more information, see Dead Letter Queues (https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#dlq)."

										properties: targetARN: type: "string"
										type: "object"
									}
									description: {
										description: "A description of the function."
										type:        "string"
									}
									environment: {
										description: "Environment variables that are accessible from function code during execution."

										properties: variables: {
											additionalProperties: type: "string"
											type: "object"
										}
										type: "object"
									}
									fileSystemConfigs: {
										description: "Connection settings for an Amazon EFS file system."
										items: {
											properties: {
												arn: type: "string"
												localMountPath: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									handler: {
										description: "The name of the method within your code that Lambda calls to execute your function. The format includes the file name. It can also include namespaces and other qualifiers, depending on the runtime. For more information, see Programming Model (https://docs.aws.amazon.com/lambda/latest/dg/programming-model-v2.html)."

										type: "string"
									}
									imageConfig: {
										description: "Container image configuration values (https://docs.aws.amazon.com/lambda/latest/dg/images-parms.html) that override the values in the container image Dockerfile."

										properties: {
											command: {
												items: type: "string"
												type: "array"
											}
											entryPoint: {
												items: type: "string"
												type: "array"
											}
											workingDirectory: type: "string"
										}
										type: "object"
									}
									kmsKeyARN: {
										description: "The ARN of the AWS Key Management Service (AWS KMS) key that's used to encrypt your function's environment variables. If it's not provided, AWS Lambda uses a default service key."

										type: "string"
									}
									kmsKeyARNRef: {
										description: "KMSKeyARNRef is a reference to a kms key used to set the KMSKeyARN."

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
										description: "KMSKeyARNSelector selects references to kms key arn used to set the KMSKeyARN."

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
									layers: {
										description: "A list of function layers (https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html) to add to the function's execution environment. Specify each layer by its ARN, including the version."

										items: type: "string"
										type: "array"
									}
									memorySize: {
										description: "The amount of memory available to the function at runtime. Increasing the function's memory also increases its CPU allocation. The default value is 128 MB. The value can be any multiple of 1 MB."

										format: "int64"
										type:   "integer"
									}
									packageType: {
										description: "The type of deployment package. Set to Image for container image and set Zip for ZIP archive."

										type: "string"
									}
									publish: {
										description: "Set to true to publish the first version of the function during creation."

										type: "boolean"
									}
									region: {
										description: "Region is which region the Function will be created."
										type:        "string"
									}
									role: {
										description: "The Amazon Resource Name (ARN) of the function's execution role. One of role, roleRef or roleSelector is required."

										type: "string"
									}
									roleRef: {
										description: "RoleRef is a reference to an iam role"
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
									roleSelector: {
										description: "RoleSelector selects references to iam role arn used to set the lambda Role."

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
									runtime: {
										description: "The identifier of the function's runtime (https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html)."
										type:        "string"
									}
									tags: {
										additionalProperties: type: "string"
										description: "A list of tags (https://docs.aws.amazon.com/lambda/latest/dg/tagging.html) to apply to the function."

										type: "object"
									}
									timeout: {
										description: "The amount of time that Lambda allows a function to run before stopping it. The default is 3 seconds. The maximum allowed value is 900 seconds."

										format: "int64"
										type:   "integer"
									}
									tracingConfig: {
										description: "Set Mode to Active to sample and trace a subset of incoming requests with AWS X-Ray."

										properties: mode: type: "string"
										type: "object"
									}
									vpcConfig: {
										description: "For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC. When you connect a function to a VPC, it can only access resources and the internet through that VPC. For more information, see VPC Settings (https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html)."

										properties: {
											securityGroupIDRefs: {
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
											securityGroupIDSelector: {
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
											securityGroupIDs: {
												items: type: "string"
												type: "array"
											}
											subnetIDRefs: {
												description: "SubnetIDRefs is a list of references to Subnets used to set the SubnetIDs."

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
											subnetIDSelector: {
												description: "SubnetIDsSelector selects references to Subnets used to set the SubnetIDs."

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
											subnetIDs: {
												items: type: "string"
												type: "array"
											}
										}
										type: "object"
									}
								}
								required: [
									"code",
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
						description: "FunctionStatus defines the observed state of Function."
						properties: {
							atProvider: {
								description: "FunctionObservation defines the observed state of Function"
								properties: {
									codeSHA256: {
										description: "The SHA256 hash of the function's deployment package."
										type:        "string"
									}
									codeSize: {
										description: "The size of the function's deployment package, in bytes."

										format: "int64"
										type:   "integer"
									}
									functionARN: {
										description: "The function's Amazon Resource Name (ARN)."
										type:        "string"
									}
									functionName: {
										description: "The name of the function."
										type:        "string"
									}
									imageConfigResponse: {
										description: "The function's image configuration values."
										properties: {
											error: {
												description: "Error response to GetFunctionConfiguration."
												properties: {
													errorCode: type: "string"
													message: type: "string"
												}
												type: "object"
											}
											imageConfig: {
												description: "Configuration values that override the container image Dockerfile settings. See Container settings (https://docs.aws.amazon.com/lambda/latest/dg/images-create.html#images-parms)."

												properties: {
													command: {
														items: type: "string"
														type: "array"
													}
													entryPoint: {
														items: type: "string"
														type: "array"
													}
													workingDirectory: type: "string"
												}
												type: "object"
											}
										}
										type: "object"
									}
									lastModified: {
										description: "The date and time that the function was last updated, in ISO-8601 format (https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD)."

										type: "string"
									}
									lastUpdateStatus: {
										description: "The status of the last update that was performed on the function. This is first set to Successful after function creation completes."

										type: "string"
									}
									lastUpdateStatusReason: {
										description: "The reason for the last update that was performed on the function."

										type: "string"
									}
									lastUpdateStatusReasonCode: {
										description: "The reason code for the last update that was performed on the function."

										type: "string"
									}
									masterARN: {
										description: "For Lambda@Edge functions, the ARN of the master function."

										type: "string"
									}
									revisionID: {
										description: "The latest updated revision of the function or alias."
										type:        "string"
									}
									role: {
										description: "The function's execution role."
										type:        "string"
									}
									signingJobARN: {
										description: "The ARN of the signing job."
										type:        "string"
									}
									signingProfileVersionARN: {
										description: "The ARN of the signing profile version."
										type:        "string"
									}
									state: {
										description: "The current state of the function. When the state is Inactive, you can reactivate the function by invoking it."

										type: "string"
									}
									stateReason: {
										description: "The reason for the function's current state."
										type:        "string"
									}
									stateReasonCode: {
										description: "The reason code for the function's current state. When the code is Creating, you can't invoke or modify the function."

										type: "string"
									}
									version: {
										description: "The version of the Lambda function."
										type:        "string"
									}
									vpcConfig: {
										description: "The function's networking configuration."
										properties: {
											securityGroupIDs: {
												items: type: "string"
												type: "array"
											}
											subnetIDs: {
												items: type: "string"
												type: "array"
											}
											vpcID: type: "string"
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
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
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
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "Function is the Schema for the Functions API"
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
						description: "FunctionSpec defines the desired state of Function"
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
								description: "FunctionParameters defines the desired state of Function"
								properties: {
									architectures: {
										description: "The instruction set architecture that the function supports. Enter a string array with one of the valid values (arm64 or x86_64). The default value is x86_64."

										items: type: "string"
										type: "array"
									}
									code: {
										description: "The code for the function."
										properties: {
											imageURI: type: "string"
											s3Bucket: type: "string"
											s3BucketRef: {
												description: "S3BucketRef is a reference to an S3 Bucket."
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
											s3BucketSelector: {
												description: "S3BucketSelector selects references to an S3 Bucket."

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
											s3Key: type: "string"
											s3ObjectVersion: type: "string"
										}
										type: "object"
									}
									codeSigningConfigARN: {
										description: "To enable code signing for this function, specify the ARN of a code-signing configuration. A code-signing configuration includes a set of signing profiles, which define the trusted publishers for this function."

										type: "string"
									}
									deadLetterConfig: {
										description: "A dead letter queue configuration that specifies the queue or topic where Lambda sends asynchronous events when they fail processing. For more information, see Dead Letter Queues (https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#dlq)."

										properties: targetARN: type: "string"
										type: "object"
									}
									description: {
										description: "A description of the function."
										type:        "string"
									}
									environment: {
										description: "Environment variables that are accessible from function code during execution."

										properties: variables: {
											additionalProperties: type: "string"
											type: "object"
										}
										type: "object"
									}
									ephemeralStorage: {
										description: "The size of the function’s /tmp directory in MB. The default value is 512, but can be any whole number between 512 and 10240 MB."

										properties: size: {
											format: "int64"
											type:   "integer"
										}
										type: "object"
									}
									fileSystemConfigs: {
										description: "Connection settings for an Amazon EFS file system."
										items: {
											properties: {
												arn: type: "string"
												localMountPath: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									handler: {
										description: "The name of the method within your code that Lambda calls to execute your function. Handler is required if the deployment package is a .zip file archive. The format includes the file name. It can also include namespaces and other qualifiers, depending on the runtime. For more information, see Programming Model (https://docs.aws.amazon.com/lambda/latest/dg/programming-model-v2.html)."

										type: "string"
									}
									imageConfig: {
										description: "Container image configuration values (https://docs.aws.amazon.com/lambda/latest/dg/configuration-images.html#configuration-images-settings) that override the values in the container image Dockerfile."

										properties: {
											command: {
												items: type: "string"
												type: "array"
											}
											entryPoint: {
												items: type: "string"
												type: "array"
											}
											workingDirectory: type: "string"
										}
										type: "object"
									}
									kmsKeyARN: {
										description: "The ARN of the Amazon Web Services Key Management Service (KMS) key that's used to encrypt your function's environment variables. If it's not provided, Lambda uses a default service key."

										type: "string"
									}
									kmsKeyARNRef: {
										description: "KMSKeyARNRef is a reference to a kms key used to set the KMSKeyARN."

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
									kmsKeyARNSelector: {
										description: "KMSKeyARNSelector selects references to kms key arn used to set the KMSKeyARN."

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
									layers: {
										description: "A list of function layers (https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html) to add to the function's execution environment. Specify each layer by its ARN, including the version."

										items: type: "string"
										type: "array"
									}
									memorySize: {
										description: "The amount of memory available to the function (https://docs.aws.amazon.com/lambda/latest/dg/configuration-memory.html) at runtime. Increasing the function memory also increases its CPU allocation. The default value is 128 MB. The value can be any multiple of 1 MB."

										format: "int64"
										type:   "integer"
									}
									packageType: {
										description: "The type of deployment package. Set to Image for container image and set Zip for ZIP archive."

										type: "string"
									}
									publish: {
										description: "Set to true to publish the first version of the function during creation."

										type: "boolean"
									}
									region: {
										description: "Region is which region the Function will be created."
										type:        "string"
									}
									role: {
										description: "The Amazon Resource Name (ARN) of the function's execution role. One of role, roleRef or roleSelector is required."

										type: "string"
									}
									roleRef: {
										description: "RoleRef is a reference to an iam role"
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
									roleSelector: {
										description: "RoleSelector selects references to iam role arn used to set the lambda Role."

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
									runtime: {
										description: "The identifier of the function's runtime (https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html). Runtime is required if the deployment package is a .zip file archive."

										type: "string"
									}
									tags: {
										additionalProperties: type: "string"
										description: "A list of tags (https://docs.aws.amazon.com/lambda/latest/dg/tagging.html) to apply to the function."

										type: "object"
									}
									timeout: {
										description: "The amount of time (in seconds) that Lambda allows a function to run before stopping it. The default is 3 seconds. The maximum allowed value is 900 seconds. For additional information, see Lambda execution environment (https://docs.aws.amazon.com/lambda/latest/dg/runtimes-context.html)."

										format: "int64"
										type:   "integer"
									}
									tracingConfig: {
										description: "Set Mode to Active to sample and trace a subset of incoming requests with X-Ray (https://docs.aws.amazon.com/lambda/latest/dg/services-xray.html)."

										properties: mode: type: "string"
										type: "object"
									}
									vpcConfig: {
										description: "For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC. When you connect a function to a VPC, it can only access resources and the internet through that VPC. For more information, see VPC Settings (https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html)."

										properties: {
											securityGroupIDRefs: {
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
													required: ["name"]
													type: "object"
												}
												type: "array"
											}
											securityGroupIDSelector: {
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
											securityGroupIDs: {
												items: type: "string"
												type: "array"
											}
											subnetIDRefs: {
												description: "SubnetIDRefs is a list of references to Subnets used to set the SubnetIDs."

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
											subnetIDSelector: {
												description: "SubnetIDsSelector selects references to Subnets used to set the SubnetIDs."

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
											subnetIDs: {
												items: type: "string"
												type: "array"
											}
										}
										type: "object"
									}
								}
								required: [
									"code",
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
						description: "FunctionStatus defines the observed state of Function."
						properties: {
							atProvider: {
								description: "FunctionObservation defines the observed state of Function"
								properties: {
									codeSHA256: {
										description: "The SHA256 hash of the function's deployment package."
										type:        "string"
									}
									codeSize: {
										description: "The size of the function's deployment package, in bytes."

										format: "int64"
										type:   "integer"
									}
									functionARN: {
										description: "The function's Amazon Resource Name (ARN)."
										type:        "string"
									}
									functionName: {
										description: "The name of the function."
										type:        "string"
									}
									imageConfigResponse: {
										description: "The function's image configuration values."
										properties: {
											error: {
												description: "Error response to GetFunctionConfiguration."
												properties: {
													errorCode: type: "string"
													message: type: "string"
												}
												type: "object"
											}
											imageConfig: {
												description: "Configuration values that override the container image Dockerfile settings. See Container settings (https://docs.aws.amazon.com/lambda/latest/dg/images-create.html#images-parms)."

												properties: {
													command: {
														items: type: "string"
														type: "array"
													}
													entryPoint: {
														items: type: "string"
														type: "array"
													}
													workingDirectory: type: "string"
												}
												type: "object"
											}
										}
										type: "object"
									}
									lastModified: {
										description: "The date and time that the function was last updated, in ISO-8601 format (https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD)."

										type: "string"
									}
									lastUpdateStatus: {
										description: "The status of the last update that was performed on the function. This is first set to Successful after function creation completes."

										type: "string"
									}
									lastUpdateStatusReason: {
										description: "The reason for the last update that was performed on the function."

										type: "string"
									}
									lastUpdateStatusReasonCode: {
										description: "The reason code for the last update that was performed on the function."

										type: "string"
									}
									masterARN: {
										description: "For Lambda@Edge functions, the ARN of the main function."
										type:        "string"
									}
									revisionID: {
										description: "The latest updated revision of the function or alias."
										type:        "string"
									}
									role: {
										description: "The function's execution role."
										type:        "string"
									}
									signingJobARN: {
										description: "The ARN of the signing job."
										type:        "string"
									}
									signingProfileVersionARN: {
										description: "The ARN of the signing profile version."
										type:        "string"
									}
									state: {
										description: "The current state of the function. When the state is Inactive, you can reactivate the function by invoking it."

										type: "string"
									}
									stateReason: {
										description: "The reason for the function's current state."
										type:        "string"
									}
									stateReasonCode: {
										description: "The reason code for the function's current state. When the code is Creating, you can't invoke or modify the function."

										type: "string"
									}
									version: {
										description: "The version of the Lambda function."
										type:        "string"
									}
									vpcConfig: {
										description: "The function's networking configuration."
										properties: {
											securityGroupIDs: {
												items: type: "string"
												type: "array"
											}
											subnetIDs: {
												items: type: "string"
												type: "array"
											}
											vpcID: type: "string"
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
