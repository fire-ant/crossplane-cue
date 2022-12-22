package ecr_aws_crossplane_io_repositorypolicies

customresourcedefinition: "repositorypolicies.ecr.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "repositorypolicies.ecr.aws.crossplane.io"
	}
	spec: {
		group: "ecr.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "RepositoryPolicy"
			listKind: "RepositoryPolicyList"
			plural:   "repositorypolicies"
			singular: "repositorypolicy"
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
			}]
			deprecated:         true
			deprecationWarning: "Please use v1beta1 version of this resource that has identical schema."

			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "A RepositoryPolicy is a managed resource that represents an Elastic Container Repository Policy Deprecated: Please use v1beta1 version of this resource."

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
						description: "A RepositoryPolicySpec defines the desired state of a Elastic Container Repository."

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
								description: "RepositoryPolicyParameters define the desired state of an AWS Elastic Container Repository"

								properties: {
									force: {
										description: "If the policy you are attempting to set on a repository policy would prevent you from setting another policy in the future, you must force the SetRepositoryPolicy operation. This is intended to prevent accidental repository lock outs."

										type: "boolean"
									}
									policy: {
										description: "Policy is a well defined type which can be parsed into an JSON Repository Policy either policy or rawPolicy must be specified in the policy"

										properties: {
											id: {
												description: "ID is the policy's optional identifier"
												type:        "string"
											}
											statements: {
												description: "Statements is the list of statement this policy applies either jsonStatements or statements must be specified in the policy"

												items: {
													description: "RepositoryPolicyStatement defines an individual statement within the RepositoryPolicyBody"

													properties: {
														action: {
															description: "Each element of the PolicyAction array describes the specific action or actions that will be allowed or denied with this PolicyStatement."

															items: type: "string"
															type: "array"
														}
														condition: {
															description: "Condition specifies where conditions for policy are in effect. https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonelasticcontainerregistry.html#amazonelasticcontainerregistry-policy-keys"

															items: {
																description: "Condition represents a set of condition pairs for a Repository policy"

																properties: {
																	conditions: {
																		description: "Conditions represents each of the key/value pairs for the operator key"

																		items: {
																			description: "ConditionPair represents one condition inside of the set of conditions for a Repository policy"

																			properties: {
																				booleanValue: {
																					description: "ConditionBooleanValue is the expected boolean value of the key from the parent condition"

																					type: "boolean"
																				}
																				dateValue: {
																					description: "ConditionDateValue is the expected string value of the key from the parent condition. The date value must be in ISO 8601 format. The time is always midnight UTC."

																					format: "date-time"
																					type:   "string"
																				}
																				key: {
																					description: "ConditionKey is the key condition being applied to the parent condition"

																					type: "string"
																				}
																				listValue: {
																					description: "ConditionListValue is the list value of the key from the parent condition"

																					items: type: "string"
																					type: "array"
																				}
																				numericValue: {
																					description: "ConditionNumericValue is the expected string value of the key from the parent condition"

																					format: "int64"
																					type:   "integer"
																				}
																				stringValue: {
																					description: "ConditionStringValue is the expected string value of the key from the parent condition"

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
																	operatorKey: {
																		description: "OperatorKey matches the condition key and value in the policy against values in the request context"

																		type: "string"
																	}
																}
																required: [
																	"conditions",
																	"operatorKey",
																]
																type: "object"
															}
															type: "array"
														}
														effect: {
															description: "The effect is required and specifies whether the statement results in an allow or an explicit deny. Valid values for Effect are Allow and Deny."

															enum: [
																"Allow",
																"Deny",
															]
															type: "string"
														}
														notAction: {
															description: "Each element of the NotPolicyAction array will allow the property to match all but the listed actions."

															items: type: "string"
															type: "array"
														}
														notPrincipal: {
															description: "Used with the Repository policy to specify the users which are not included in this policy"

															properties: {
																allowAnon: {
																	description: "This flag indicates if the policy should be made available to all anonymous users. Principal: \"*\""

																	type: "boolean"
																}
																awsPrincipals: {
																	description: "This list contains the all of the AWS IAM users which are affected by the policy statement."

																	items: {
																		description: "AWSPrincipal wraps the potential values a policy principal can take. Only one of the values should be set."

																		properties: {
																			awsAccountId: {
																				description: "AWSAccountID identifies an AWS account as the principal"

																				type: "string"
																			}
																			iamRoleArn: {
																				description: "IAMRoleARN contains the ARN of an IAM role"

																				type: "string"
																			}
																			iamRoleArnRef: {
																				description: "IAMRoleARNRef contains the reference to an IAMRole"

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
																			iamRoleArnSelector: {
																				description: "IAMRoleARNSelector queries for an IAM role to retrieve its userName"

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
																			iamUserArn: {
																				description: "UserARN contains the ARN of an IAM user"

																				type: "string"
																			}
																			iamUserArnRef: {
																				description: "UserARNRef contains the reference to an User"

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
																			iamUserArnSelector: {
																				description: "UserARNSelector queries for an User to retrieve its userName"

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
																	type: "array"
																}
																raw: {
																	description: "Raw string input can be used for *"
																	type:        "string"
																}
																service: {
																	description: "Service define the services which can have access to this bucket"

																	items: type: "string"
																	type: "array"
																}
															}
															type: "object"
														}
														notResource: {
															description: "This will explicitly match all resource paths except the ones specified in this array"

															items: type: "string"
															type: "array"
														}
														principal: {
															description: "Used with the Repository policy to specify the principal that is allowed or denied access to a resource."

															properties: {
																allowAnon: {
																	description: "This flag indicates if the policy should be made available to all anonymous users. Principal: \"*\""

																	type: "boolean"
																}
																awsPrincipals: {
																	description: "This list contains the all of the AWS IAM users which are affected by the policy statement."

																	items: {
																		description: "AWSPrincipal wraps the potential values a policy principal can take. Only one of the values should be set."

																		properties: {
																			awsAccountId: {
																				description: "AWSAccountID identifies an AWS account as the principal"

																				type: "string"
																			}
																			iamRoleArn: {
																				description: "IAMRoleARN contains the ARN of an IAM role"

																				type: "string"
																			}
																			iamRoleArnRef: {
																				description: "IAMRoleARNRef contains the reference to an IAMRole"

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
																			iamRoleArnSelector: {
																				description: "IAMRoleARNSelector queries for an IAM role to retrieve its userName"

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
																			iamUserArn: {
																				description: "UserARN contains the ARN of an IAM user"

																				type: "string"
																			}
																			iamUserArnRef: {
																				description: "UserARNRef contains the reference to an User"

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
																			iamUserArnSelector: {
																				description: "UserARNSelector queries for an User to retrieve its userName"

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
																	type: "array"
																}
																raw: {
																	description: "Raw string input can be used for *"
																	type:        "string"
																}
																service: {
																	description: "Service define the services which can have access to this bucket"

																	items: type: "string"
																	type: "array"
																}
															}
															type: "object"
														}
														resource: {
															description: "The paths on which this resource will apply"
															items: type: "string"
															type: "array"
														}
														sid: {
															description: "Optional identifier for this statement, must be unique within the policy if provided."

															type: "string"
														}
													}
													required: [
														"effect",
													]
													type: "object"
												}
												type: "array"
											}
											version: {
												default:     "2012-10-17"
												description: "Version is the current IAM policy version"
												enum: [
													"2012-10-17",
													"2008-10-17",
												]
												type: "string"
											}
										}
										required: [
											"version",
										]
										type: "object"
									}
									rawPolicy: {
										description: "Policy stringified version of JSON repository policy either policy or rawPolicy must be specified in the policy"

										type: "string"
									}
									region: {
										description: "Region is the region you'd like your RepositoryPolicy to be created in."

										type: "string"
									}
									registryId: {
										description: "The AWS account ID associated with the registry that contains the repository. If you do not specify a registry, the default registry is assumed."

										type: "string"
									}
									repositoryName: {
										description: """
		The name of the repository to receive the policy. 
		 One of RepositoryName, RepositoryNameRef, or RepositoryNameSelector is required.
		"""

										type: "string"
									}
									repositoryNameRef: {
										description: "A referencer to retrieve the name of a repository One of RepositoryName, RepositoryNameRef, or RepositoryNameSelector is required."

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
									repositoryNameSelector: {
										description: "A selector to select a referencer to retrieve the name of a repository One of RepositoryName, RepositoryNameRef, or RepositoryNameSelector is required."

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
						description: "A RepositoryPolicyStatus represents the observed state of a repository policy"

						properties: {
							atProvider: {
								description: "RepositoryPolicyObservation keeps the state for the external resource"

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
				name:     "ID"
				type:     "string"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "A RepositoryPolicy is a managed resource that represents an Elastic Container Repository Policy"

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
						description: "A RepositoryPolicySpec defines the desired state of a Elastic Container Repository."

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
								description: "RepositoryPolicyParameters define the desired state of an AWS Elastic Container Repository"

								properties: {
									force: {
										description: "If the policy you are attempting to set on a repository policy would prevent you from setting another policy in the future, you must force the SetRepositoryPolicy operation. This is intended to prevent accidental repository lock outs."

										type: "boolean"
									}
									policy: {
										description: "Policy is a well defined type which can be parsed into an JSON Repository Policy either policy or rawPolicy must be specified in the policy"

										properties: {
											id: {
												description: "ID is the policy's optional identifier"
												type:        "string"
											}
											statements: {
												description: "Statements is the list of statement this policy applies either jsonStatements or statements must be specified in the policy"

												items: {
													description: "RepositoryPolicyStatement defines an individual statement within the RepositoryPolicyBody"

													properties: {
														action: {
															description: "Each element of the PolicyAction array describes the specific action or actions that will be allowed or denied with this PolicyStatement."

															items: type: "string"
															type: "array"
														}
														condition: {
															description: "Condition specifies where conditions for policy are in effect. https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonelasticcontainerregistry.html#amazonelasticcontainerregistry-policy-keys"

															items: {
																description: "Condition represents a set of condition pairs for a Repository policy"

																properties: {
																	conditions: {
																		description: "Conditions represents each of the key/value pairs for the operator key"

																		items: {
																			description: "ConditionPair represents one condition inside of the set of conditions for a Repository policy"

																			properties: {
																				booleanValue: {
																					description: "ConditionBooleanValue is the expected boolean value of the key from the parent condition"

																					type: "boolean"
																				}
																				dateValue: {
																					description: "ConditionDateValue is the expected string value of the key from the parent condition. The date value must be in ISO 8601 format. The time is always midnight UTC."

																					format: "date-time"
																					type:   "string"
																				}
																				key: {
																					description: "ConditionKey is the key condition being applied to the parent condition"

																					type: "string"
																				}
																				listValue: {
																					description: "ConditionListValue is the list value of the key from the parent condition"

																					items: type: "string"
																					type: "array"
																				}
																				numericValue: {
																					description: "ConditionNumericValue is the expected string value of the key from the parent condition"

																					format: "int64"
																					type:   "integer"
																				}
																				stringValue: {
																					description: "ConditionStringValue is the expected string value of the key from the parent condition"

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
																	operatorKey: {
																		description: "OperatorKey matches the condition key and value in the policy against values in the request context"

																		type: "string"
																	}
																}
																required: [
																	"conditions",
																	"operatorKey",
																]
																type: "object"
															}
															type: "array"
														}
														effect: {
															description: "The effect is required and specifies whether the statement results in an allow or an explicit deny. Valid values for Effect are Allow and Deny."

															enum: [
																"Allow",
																"Deny",
															]
															type: "string"
														}
														notAction: {
															description: "Each element of the NotPolicyAction array will allow the property to match all but the listed actions."

															items: type: "string"
															type: "array"
														}
														notPrincipal: {
															description: "Used with the Repository policy to specify the users which are not included in this policy"

															properties: {
																allowAnon: {
																	description: "This flag indicates if the policy should be made available to all anonymous users. Principal: \"*\""

																	type: "boolean"
																}
																awsPrincipals: {
																	description: "This list contains the all of the AWS IAM users which are affected by the policy statement."

																	items: {
																		description: "AWSPrincipal wraps the potential values a policy principal can take. Only one of the values should be set."

																		properties: {
																			awsAccountId: {
																				description: "AWSAccountID identifies an AWS account as the principal"

																				type: "string"
																			}
																			iamRoleArn: {
																				description: "IAMRoleARN contains the ARN of an IAM role"

																				type: "string"
																			}
																			iamRoleArnRef: {
																				description: "IAMRoleARNRef contains the reference to an IAMRole"

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
																			iamRoleArnSelector: {
																				description: "IAMRoleARNSelector queries for an IAM role to retrieve its userName"

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
																			iamUserArn: {
																				description: "UserARN contains the ARN of an IAM user"

																				type: "string"
																			}
																			iamUserArnRef: {
																				description: "UserARNRef contains the reference to an User"

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
																			iamUserArnSelector: {
																				description: "UserARNSelector queries for an User to retrieve its userName"

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
																	type: "array"
																}
																raw: {
																	description: "Raw string input can be used for *"
																	type:        "string"
																}
																service: {
																	description: "Service define the services which can have access to this bucket"

																	items: type: "string"
																	type: "array"
																}
															}
															type: "object"
														}
														notResource: {
															description: "This will explicitly match all resource paths except the ones specified in this array"

															items: type: "string"
															type: "array"
														}
														principal: {
															description: "Used with the Repository policy to specify the principal that is allowed or denied access to a resource."

															properties: {
																allowAnon: {
																	description: "This flag indicates if the policy should be made available to all anonymous users. Principal: \"*\""

																	type: "boolean"
																}
																awsPrincipals: {
																	description: "This list contains the all of the AWS IAM users which are affected by the policy statement."

																	items: {
																		description: "AWSPrincipal wraps the potential values a policy principal can take. Only one of the values should be set."

																		properties: {
																			awsAccountId: {
																				description: "AWSAccountID identifies an AWS account as the principal"

																				type: "string"
																			}
																			iamRoleArn: {
																				description: "IAMRoleARN contains the ARN of an IAM role"

																				type: "string"
																			}
																			iamRoleArnRef: {
																				description: "IAMRoleARNRef contains the reference to an IAMRole"

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
																			iamRoleArnSelector: {
																				description: "IAMRoleARNSelector queries for an IAM role to retrieve its userName"

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
																			iamUserArn: {
																				description: "UserARN contains the ARN of an IAM user"

																				type: "string"
																			}
																			iamUserArnRef: {
																				description: "UserARNRef contains the reference to an User"

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
																			iamUserArnSelector: {
																				description: "UserARNSelector queries for an User to retrieve its userName"

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
																	type: "array"
																}
																raw: {
																	description: "Raw string input can be used for *"
																	type:        "string"
																}
																service: {
																	description: "Service define the services which can have access to this bucket"

																	items: type: "string"
																	type: "array"
																}
															}
															type: "object"
														}
														resource: {
															description: "The paths on which this resource will apply"
															items: type: "string"
															type: "array"
														}
														sid: {
															description: "Optional identifier for this statement, must be unique within the policy if provided."

															type: "string"
														}
													}
													required: [
														"effect",
													]
													type: "object"
												}
												type: "array"
											}
											version: {
												default:     "2012-10-17"
												description: "Version is the current IAM policy version"
												enum: [
													"2012-10-17",
													"2008-10-17",
												]
												type: "string"
											}
										}
										required: [
											"version",
										]
										type: "object"
									}
									rawPolicy: {
										description: "Policy stringified version of JSON repository policy either policy or rawPolicy must be specified in the policy"

										type: "string"
									}
									region: {
										description: "Region is the region you'd like your RepositoryPolicy to be created in."

										type: "string"
									}
									registryId: {
										description: "The AWS account ID associated with the registry that contains the repository. If you do not specify a registry, the default registry is assumed."

										type: "string"
									}
									repositoryName: {
										description: """
		The name of the repository to receive the policy. 
		 One of RepositoryName, RepositoryNameRef, or RepositoryNameSelector is required.
		"""

										type: "string"
									}
									repositoryNameRef: {
										description: "A referencer to retrieve the name of a repository One of RepositoryName, RepositoryNameRef, or RepositoryNameSelector is required."

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
									repositoryNameSelector: {
										description: "A selector to select a referencer to retrieve the name of a repository One of RepositoryName, RepositoryNameRef, or RepositoryNameSelector is required."

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
						description: "A RepositoryPolicyStatus represents the observed state of a repository policy"

						properties: {
							atProvider: {
								description: "RepositoryPolicyObservation keeps the state for the external resource"

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
