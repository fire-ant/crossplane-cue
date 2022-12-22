package elbv2_aws_crossplane_io_listeners

customresourcedefinition: "listeners.elbv2.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "listeners.elbv2.aws.crossplane.io"
	}
	spec: {
		group: "elbv2.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Listener"
			listKind: "ListenerList"
			plural:   "listeners"
			singular: "listener"
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
				description: "Listener is the Schema for the Listeners API"
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
						description: "ListenerSpec defines the desired state of Listener"
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
								description: "ListenerParameters defines the desired state of Listener"
								properties: {
									alpnPolicy: {
										description: """
		[TLS listeners] The name of the Application-Layer Protocol Negotiation (ALPN) policy. You can specify one policy name. The following are the possible values: 
		 * HTTP1Only 
		 * HTTP2Only 
		 * HTTP2Optional 
		 * HTTP2Preferred 
		 * None 
		 For more information, see ALPN policies (https://docs.aws.amazon.com/elasticloadbalancing/latest/network/create-tls-listener.html#alpn-policies) in the Network Load Balancers Guide.
		"""

										items: type: "string"
										type: "array"
									}
									certificates: {
										description: "[HTTPS and TLS listeners] The default certificate for the listener. You must provide exactly one certificate. Set CertificateArn to the certificate ARN but do not set IsDefault."

										items: {
											description: "CustomCertificate includes custom fields about certificates."

											properties: {
												certificateARN: {
													description: "[HTTPS and TLS listeners] The default certificate for the listener."

													type: "string"
												}
												certificateARNRef: {
													description: "Reference to Certificates for Certificate ARN"
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
												certificateARNSelector: {
													description: "Selector for references to Certificate for CertificateArn"

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
												isDefault: type: "boolean"
											}
											type: "object"
										}
										type: "array"
									}
									defaultActions: {
										description: "The actions for the default rule."
										items: {
											description: """
		CustomAction includes custom fields for an action. 
		 Each rule must include exactly one of the following types of actions: forward, fixed-response, or redirect, and it must be the last action to be performed.
		"""

											properties: {
												actionType: {
													description: "The type of action."
													type:        "string"
												}
												authenticateCognitoConfig: {
													description: "Request parameters to use when integrating with Amazon Cognito to authenticate users."

													properties: {
														authenticationRequestExtraParams: {
															additionalProperties: type: "string"
															type: "object"
														}
														onUnauthenticatedRequest: type: "string"
														scope: type: "string"
														sessionCookieName: type: "string"
														sessionTimeout: {
															format: "int64"
															type:   "integer"
														}
														userPoolARN: type: "string"
														userPoolClientID: type: "string"
														userPoolDomain: type: "string"
													}
													type: "object"
												}
												authenticateOidcConfig: {
													description: "Request parameters when using an identity provider (IdP) that is compliant with OpenID Connect (OIDC) to authenticate users."

													properties: {
														authenticationRequestExtraParams: {
															additionalProperties: type: "string"
															type: "object"
														}
														authorizationEndpoint: type: "string"
														clientID: type: "string"
														clientSecret: type: "string"
														issuer: type: "string"
														onUnauthenticatedRequest: type: "string"
														scope: type: "string"
														sessionCookieName: type: "string"
														sessionTimeout: {
															format: "int64"
															type:   "integer"
														}
														tokenEndpoint: type: "string"
														useExistingClientSecret: type: "boolean"
														userInfoEndpoint: type: "string"
													}
													type: "object"
												}
												fixedResponseConfig: {
													description: "Information about an action that returns a custom HTTP response."

													properties: {
														contentType: type: "string"
														messageBody: type: "string"
														statusCode: type: "string"
													}
													type: "object"
												}
												forwardConfig: {
													description: "Information about a forward action."
													properties: {
														targetGroupStickinessConfig: {
															description: "Information about the target group stickiness for a rule."

															properties: {
																durationSeconds: {
																	format: "int64"
																	type:   "integer"
																}
																enabled: type: "boolean"
															}
															type: "object"
														}
														targetGroups: {
															description: "One or more target groups. For Network Load Balancers, you can specify a single target group."

															items: {
																description: "CustomTargetGroupTuple includes custom fields about target groups. Only used with ForwardActionConfig to route to multiple target groups."

																properties: {
																	targetGroupARN: type: "string"
																	targetGroupArnRef: {
																		description: "Reference to TargetGroupARN used to set TargetGroupARN"

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
																	targetGroupArnSelector: {
																		description: "Selector for references to TargetGroup for TargetGroupARN"

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
																	weight: {
																		format: "int64"
																		type:   "integer"
																	}
																}
																type: "object"
															}
															type: "array"
														}
													}
													type: "object"
												}
												order: {
													description: "The order for the action. This value is required for rules with multiple actions. The action with the lowest value for order is performed first."

													format: "int64"
													type:   "integer"
												}
												redirectConfig: {
													description: """
		Information about a redirect action. 
		 A URI consists of the following components: protocol://hostname:port/path?query. You must modify at least one of the following components to avoid a redirect loop: protocol, hostname, port, or path. Any components that you do not modify retain their original values. 
		 You can reuse URI components using the following reserved keywords: 
		 * #{protocol} 
		 * #{host} 
		 * #{port} 
		 * #{path} (the leading \"/\" is removed) 
		 * #{query} 
		 For example, you can change the path to \"/new/#{path}\", the hostname to \"example.#{host}\", or the query to \"#{query}&value=xyz\".
		"""

													properties: {
														host: type: "string"
														path: type: "string"
														port: type: "string"
														protocol: type: "string"
														query: type: "string"
														statusCode: type: "string"
													}
													type: "object"
												}
												targetGroupArn: {
													description: "The Amazon Resource Name (ARN) of the target group. Specify only when actionType is forward and you want to route to a single target group. To route to one or more target groups, use ForwardConfig instead."

													type: "string"
												}
												targetGroupArnRef: {
													description: "Reference to TargetGroupARN used to set TargetGroupARN"
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
												targetGroupArnSelector: {
													description: "Selector for references to TargetGroups for TargetGroupARNs"

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
												"actionType",
											]
											type: "object"
										}
										type: "array"
									}
									loadBalancerArn: {
										description: "The Amazon Resource Name (ARN) of the load balancer."
										type:        "string"
									}
									loadBalancerArnRef: {
										description: "Ref to loadbalancer ARN"
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
									loadBalancerArnSelector: {
										description: "Selector for references to LoadBalancer for LoadBalancerARN"
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
									port: {
										description: "The port on which the load balancer is listening. You cannot specify a port for a Gateway Load Balancer."

										format: "int64"
										type:   "integer"
									}
									protocol: {
										description: "The protocol for connections from clients to the load balancer. For Application Load Balancers, the supported protocols are HTTP and HTTPS. For Network Load Balancers, the supported protocols are TCP, TLS, UDP, and TCP_UDP. You can’t specify the UDP or TCP_UDP protocol if dual-stack mode is enabled. You cannot specify a protocol for a Gateway Load Balancer."

										type: "string"
									}
									region: {
										description: "Region is which region the Listener will be created."
										type:        "string"
									}
									sslPolicy: {
										description: """
		[HTTPS and TLS listeners] The security policy that defines which protocols and ciphers are supported. 
		 For more information, see Security policies (https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies) in the Application Load Balancers Guide and Security policies (https://docs.aws.amazon.com/elasticloadbalancing/latest/network/create-tls-listener.html#describe-ssl-policies) in the Network Load Balancers Guide.
		"""

										type: "string"
									}
									tags: {
										description: "The tags to assign to the listener."
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
									"defaultActions",
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
						description: "ListenerStatus defines the observed state of Listener."
						properties: {
							atProvider: {
								description: "ListenerObservation defines the observed state of Listener"
								properties: {
									certificates: {
										description: "[HTTPS or TLS listener] The default certificate for the listener."

										items: {
											properties: {
												certificateARN: type: "string"
												isDefault: type: "boolean"
											}
											type: "object"
										}
										type: "array"
									}
									defaultActions: {
										description: "The default actions for the listener."
										items: {
											properties: {
												authenticateCognitoConfig: {
													description: "Request parameters to use when integrating with Amazon Cognito to authenticate users."

													properties: {
														authenticationRequestExtraParams: {
															additionalProperties: type: "string"
															type: "object"
														}
														onUnauthenticatedRequest: type: "string"
														scope: type: "string"
														sessionCookieName: type: "string"
														sessionTimeout: {
															format: "int64"
															type:   "integer"
														}
														userPoolARN: type: "string"
														userPoolClientID: type: "string"
														userPoolDomain: type: "string"
													}
													type: "object"
												}
												authenticateOIDCConfig: {
													description: "Request parameters when using an identity provider (IdP) that is compliant with OpenID Connect (OIDC) to authenticate users."

													properties: {
														authenticationRequestExtraParams: {
															additionalProperties: type: "string"
															type: "object"
														}
														authorizationEndpoint: type: "string"
														clientID: type: "string"
														clientSecret: type: "string"
														issuer: type: "string"
														onUnauthenticatedRequest: type: "string"
														scope: type: "string"
														sessionCookieName: type: "string"
														sessionTimeout: {
															format: "int64"
															type:   "integer"
														}
														tokenEndpoint: type: "string"
														useExistingClientSecret: type: "boolean"
														userInfoEndpoint: type: "string"
													}
													type: "object"
												}
												fixedResponseConfig: {
													description: "Information about an action that returns a custom HTTP response."

													properties: {
														contentType: type: "string"
														messageBody: type: "string"
														statusCode: type: "string"
													}
													type: "object"
												}
												forwardConfig: {
													description: "Information about a forward action."
													properties: {
														targetGroupStickinessConfig: {
															description: "Information about the target group stickiness for a rule."

															properties: {
																durationSeconds: {
																	format: "int64"
																	type:   "integer"
																}
																enabled: type: "boolean"
															}
															type: "object"
														}
														targetGroups: {
															items: {
																properties: {
																	targetGroupARN: type: "string"
																	weight: {
																		format: "int64"
																		type:   "integer"
																	}
																}
																type: "object"
															}
															type: "array"
														}
													}
													type: "object"
												}
												order: {
													format: "int64"
													type:   "integer"
												}
												redirectConfig: {
													description: """
		Information about a redirect action. 
		 A URI consists of the following components: protocol://hostname:port/path?query. You must modify at least one of the following components to avoid a redirect loop: protocol, hostname, port, or path. Any components that you do not modify retain their original values. 
		 You can reuse URI components using the following reserved keywords: 
		 * #{protocol} 
		 * #{host} 
		 * #{port} 
		 * #{path} (the leading \"/\" is removed) 
		 * #{query} 
		 For example, you can change the path to \"/new/#{path}\", the hostname to \"example.#{host}\", or the query to \"#{query}&value=xyz\".
		"""

													properties: {
														host: type: "string"
														path: type: "string"
														port: type: "string"
														protocol: type: "string"
														query: type: "string"
														statusCode: type: "string"
													}
													type: "object"
												}
												targetGroupARN: type: "string"
												type_: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									listenerARN: {
										description: "The Amazon Resource Name (ARN) of the listener."
										type:        "string"
									}
									loadBalancerARN: {
										description: "The Amazon Resource Name (ARN) of the load balancer."
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
