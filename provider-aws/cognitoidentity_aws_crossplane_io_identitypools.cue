package cognitoidentity_aws_crossplane_io_identitypools

customresourcedefinition: "identitypools.cognitoidentity.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "identitypools.cognitoidentity.aws.crossplane.io"
	}
	spec: {
		group: "cognitoidentity.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "IdentityPool"
			listKind: "IdentityPoolList"
			plural:   "identitypools"
			singular: "identitypool"
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
				description: "IdentityPool is the Schema for the IdentityPools API"
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
						description: "IdentityPoolSpec defines the desired state of IdentityPool"
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
								description: "IdentityPoolParameters defines the desired state of IdentityPool"
								properties: {
									allowClassicFlow: {
										description: "Enables or disables the Basic (Classic) authentication flow. For more information, see Identity Pools (Federated Identities) Authentication Flow (https://docs.aws.amazon.com/cognito/latest/developerguide/authentication-flow.html) in the Amazon Cognito Developer Guide."

										type: "boolean"
									}
									allowUnauthenticatedIdentities: {
										description: "TRUE if the identity pool supports unauthenticated logins."

										type: "boolean"
									}
									cognitoIdentityProviders: {
										description: "An array of Amazon Cognito user pools and their client IDs."

										items: {
											description: "Provider contains information to Cognito UserPools and UserPoolClients"

											properties: {
												clientId: {
													description: "The client ID for the Amazon Cognito user pool client."

													type: "string"
												}
												clientIdRef: {
													description: "ClientIDRef is a reference to an ClientID."
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
												clientIdSelector: {
													description: "ClientIDSelector selects references to ClientID."
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
												providerName: {
													description: "The provider name for an Amazon Cognito user pool."

													type: "string"
												}
												providerNameRef: {
													description: "ProviderNameRef is a reference to an ProviderName."
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
												providerNameSelector: {
													description: "ProviderNameSelector selects references to ProviderName."

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
												serverSideTokenCheck: {
													description: "Whether the server-side token validation is enabled for the identity provider’s token."

													type: "boolean"
												}
											}
											type: "object"
										}
										type: "array"
									}
									developerProviderName: {
										description: """
		The \"domain\" by which Cognito will refer to your users. This name acts as a placeholder that allows your backend and the Cognito service to communicate about the developer provider. For the DeveloperProviderName, you can use letters as well as period (.), underscore (_), and dash (-). 
		 Once you have set a developer provider name, you cannot change it. Please take care in setting this parameter.
		"""

										type: "string"
									}
									identityPoolName: {
										description: "A string that you provide."
										type:        "string"
									}
									identityPoolTags: {
										additionalProperties: type: "string"
										description: "Tags to assign to the identity pool. A tag is a label that you can apply to identity pools to categorize and manage them in different ways, such as by purpose, owner, environment, or other criteria."

										type: "object"
									}
									openIdConnectProviderARNRefs: {
										description: "OpenIDConnectProviderARNRefs is a list of references to OpenIDConnectProviderARNs."

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
									openIdConnectProviderARNSelector: {
										description: "OpenIDConnectProviderARNSelector selects references to OpenIDConnectProviderARNs."

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
									openIdConnectProviderARNs: {
										description: "The Amazon Resource Names (ARN) of the OpenID Connect providers."

										items: type: "string"
										type: "array"
									}
									region: {
										description: "Region is which region the IdentityPool will be created."
										type:        "string"
									}
									samlProviderARNs: {
										description: "An array of Amazon Resource Names (ARNs) of the SAML provider for your identity pool."

										items: type: "string"
										type: "array"
									}
									supportedLoginProviders: {
										additionalProperties: type: "string"
										description: "Optional key:value pairs mapping provider names to provider app IDs."

										type: "object"
									}
								}
								required: [
									"allowUnauthenticatedIdentities",
									"identityPoolName",
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
						description: "IdentityPoolStatus defines the observed state of IdentityPool."
						properties: {
							atProvider: {
								description: "IdentityPoolObservation defines the observed state of IdentityPool"

								properties: {
									allowUnauthenticatedIDentities: {
										description: "TRUE if the identity pool supports unauthenticated logins."

										type: "boolean"
									}
									cognitoIdentityProviders: {
										description: "A list representing an Amazon Cognito user pool and its client ID."

										items: {
											description: "Provider contains information to Cognito UserPools and UserPoolClients"

											properties: {
												clientId: {
													description: "The client ID for the Amazon Cognito user pool client."

													type: "string"
												}
												clientIdRef: {
													description: "ClientIDRef is a reference to an ClientID."
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
												clientIdSelector: {
													description: "ClientIDSelector selects references to ClientID."
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
												providerName: {
													description: "The provider name for an Amazon Cognito user pool."

													type: "string"
												}
												providerNameRef: {
													description: "ProviderNameRef is a reference to an ProviderName."
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
												providerNameSelector: {
													description: "ProviderNameSelector selects references to ProviderName."

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
												serverSideTokenCheck: {
													description: "Whether the server-side token validation is enabled for the identity provider’s token."

													type: "boolean"
												}
											}
											type: "object"
										}
										type: "array"
									}
									identityPoolID: {
										description: "An identity pool ID in the format REGION:GUID."
										type:        "string"
									}
									openIDConnectProviderARNs: {
										description: "The ARNs of the OpenID Connect providers."
										items: type: "string"
										type: "array"
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
		}, conditions: [], storedVersions: []
	}
}
