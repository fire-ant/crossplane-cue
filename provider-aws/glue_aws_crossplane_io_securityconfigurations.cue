package glue_aws_crossplane_io_securityconfigurations

customresourcedefinition: "securityconfigurations.glue.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "securityconfigurations.glue.aws.crossplane.io"
	}
	spec: {
		group: "glue.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "SecurityConfiguration"
			listKind: "SecurityConfigurationList"
			plural:   "securityconfigurations"
			singular: "securityconfiguration"
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
				description: "SecurityConfiguration is the Schema for the SecurityConfigurations API"

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
						description: "SecurityConfigurationSpec defines the desired state of SecurityConfiguration"
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
								description: "SecurityConfigurationParameters defines the desired state of SecurityConfiguration"

								properties: {
									encryptionConfiguration: {
										description: "The encryption configuration for the new security configuration."

										properties: {
											cloudWatchEncryption: {
												description: "Specifies how Amazon CloudWatch data should be encrypted."

												properties: {
													cloudWatchEncryptionMode: {
														description: "The encryption mode to use for CloudWatch data."

														enum: [
															"DISABLED",
															"SSE-KMS",
														]
														type: "string"
													}
													kmsKeyArn: {
														description: "The Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data."

														type: "string"
													}
													kmsKeyArnRef: {
														description: "KMSKeyARNRef is a reference to an KMSKey used to set the KMSKeyARN."

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
													kmsKeyArnSelector: {
														description: "KMSKeyARNSelector selects references to an KMSKey used to set the KMSKeyARN."

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
											jobBookmarksEncryption: {
												description: "Specifies how job bookmark data should be encrypted."
												properties: {
													jobBookmarksEncryptionMode: {
														description: "The encryption mode to use for job bookmarks data."

														enum: [
															"DISABLED",
															"CSE-KMS",
														]
														type: "string"
													}
													kmsKeyArn: {
														description: "The Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data."

														type: "string"
													}
													kmsKeyArnRef: {
														description: "KMSKeyARNRef is a reference to an KMSKey used to set the KMSKeyARN."

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
													kmsKeyArnSelector: {
														description: "KMSKeyARNSelector selects references to an KMSKey used to set the KMSKeyARN."

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
											s3Encryption: {
												description: "Specifies how Amazon Simple Storage Service (Amazon S3) data should be encrypted."

												items: {
													description: "CustomS3Encryption contains the additional fields for S3Encryption"

													properties: {
														kmsKeyArn: {
															description: "The Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data."

															type: "string"
														}
														kmsKeyArnRef: {
															description: "KMSKeyARNRef is a reference to an KMSKey used to set the KMSKeyARN."

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
														kmsKeyArnSelector: {
															description: "KMSKeyARNSelector selects references to an KMSKey used to set the KMSKeyARN."

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
														s3EncryptionMode: {
															description: "The encryption mode to use for Amazon S3 data."

															enum: [
																"DISABLED",
																"SSE-KMS",
																"SSE-S3",
															]
															type: "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									region: {
										description: "Region is which region the SecurityConfiguration will be created."

										type: "string"
									}
								}
								required: [
									"encryptionConfiguration",
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
						description: "SecurityConfigurationStatus defines the observed state of SecurityConfiguration."

						properties: {
							atProvider: {
								description: "SecurityConfigurationObservation defines the observed state of SecurityConfiguration"

								properties: {
									createdTimestamp: {
										description: "The time at which the new security configuration was created."

										format: "date-time"
										type:   "string"
									}
									name: {
										description: "The name assigned to the new security configuration."
										type:        "string"
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
