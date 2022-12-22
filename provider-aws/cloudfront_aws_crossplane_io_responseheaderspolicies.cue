package cloudfront_aws_crossplane_io_responseheaderspolicies

customresourcedefinition: "responseheaderspolicies.cloudfront.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "responseheaderspolicies.cloudfront.aws.crossplane.io"
	}
	spec: {
		group: "cloudfront.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "ResponseHeadersPolicy"
			listKind: "ResponseHeadersPolicyList"
			plural:   "responseheaderspolicies"
			singular: "responseheaderspolicy"
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
				description: "ResponseHeadersPolicy is the Schema for the ResponseHeadersPolicies API"

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
						description: "ResponseHeadersPolicySpec defines the desired state of ResponseHeadersPolicy"
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
								description: "ResponseHeadersPolicyParameters defines the desired state of ResponseHeadersPolicy"

								properties: {
									region: {
										description: "Region is which region the ResponseHeadersPolicy will be created."

										type: "string"
									}
									responseHeadersPolicyConfig: {
										description: "Contains metadata about the response headers policy, and a set of configurations that specify the response headers."

										properties: {
											comment: type: "string"
											corsConfig: {
												description: """
		A configuration for a set of HTTP response headers that are used for cross-origin resource sharing (CORS). CloudFront adds these headers to HTTP responses that it sends for CORS requests that match a cache behavior associated with this response headers policy. 
		 For more information about CORS, see Cross-Origin Resource Sharing (CORS) (https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) in the MDN Web Docs.
		"""

												properties: {
													accessControlAllowCredentials: type: "boolean"
													accessControlAllowHeaders: {
														description: """
		A list of HTTP header names that CloudFront includes as values for the Access-Control-Allow-Headers HTTP response header. 
		 For more information about the Access-Control-Allow-Headers HTTP response header, see Access-Control-Allow-Headers (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Headers) in the MDN Web Docs.
		"""

														properties: items: {
															items: type: "string"
															type: "array"
														}
														type: "object"
													}
													accessControlAllowMethods: {
														description: """
		A list of HTTP methods that CloudFront includes as values for the Access-Control-Allow-Methods HTTP response header. 
		 For more information about the Access-Control-Allow-Methods HTTP response header, see Access-Control-Allow-Methods (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Methods) in the MDN Web Docs.
		"""

														properties: items: {
															items: type: "string"
															type: "array"
														}
														type: "object"
													}
													accessControlAllowOrigins: {
														description: """
		A list of origins (domain names) that CloudFront can use as the value for the Access-Control-Allow-Origin HTTP response header. 
		 For more information about the Access-Control-Allow-Origin HTTP response header, see Access-Control-Allow-Origin (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) in the MDN Web Docs.
		"""

														properties: items: {
															items: type: "string"
															type: "array"
														}
														type: "object"
													}
													accessControlExposeHeaders: {
														description: """
		A list of HTTP headers that CloudFront includes as values for the Access-Control-Expose-Headers HTTP response header. 
		 For more information about the Access-Control-Expose-Headers HTTP response header, see Access-Control-Expose-Headers (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Expose-Headers) in the MDN Web Docs.
		"""

														properties: items: {
															items: type: "string"
															type: "array"
														}
														type: "object"
													}
													accessControlMaxAgeSec: {
														format: "int64"
														type:   "integer"
													}
													originOverride: type: "boolean"
												}
												type: "object"
											}
											customHeadersConfig: {
												description: "A list of HTTP response header names and their values. CloudFront includes these headers in HTTP responses that it sends for requests that match a cache behavior that’s associated with this response headers policy."

												properties: items: {
													items: {
														properties: {
															header: type: "string"
															override: type: "boolean"
															value: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												type: "object"
											}
											name: type: "string"
											securityHeadersConfig: {
												description: "A configuration for a set of security-related HTTP response headers. CloudFront adds these headers to HTTP responses that it sends for requests that match a cache behavior associated with this response headers policy."

												properties: {
													contentSecurityPolicy: {
														description: """
		The policy directives and their values that CloudFront includes as values for the Content-Security-Policy HTTP response header. 
		 For more information about the Content-Security-Policy HTTP response header, see Content-Security-Policy (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy) in the MDN Web Docs.
		"""

														properties: {
															contentSecurityPolicy: type: "string"
															override: type: "boolean"
														}
														type: "object"
													}
													contentTypeOptions: {
														description: """
		Determines whether CloudFront includes the X-Content-Type-Options HTTP response header with its value set to nosniff. 
		 For more information about the X-Content-Type-Options HTTP response header, see X-Content-Type-Options (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options) in the MDN Web Docs.
		"""

														properties: override: type: "boolean"
														type: "object"
													}
													frameOptions: {
														description: """
		Determines whether CloudFront includes the X-Frame-Options HTTP response header and the header’s value. 
		 For more information about the X-Frame-Options HTTP response header, see X-Frame-Options (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options) in the MDN Web Docs.
		"""

														properties: {
															frameOption: type: "string"
															override: type: "boolean"
														}
														type: "object"
													}
													referrerPolicy: {
														description: """
		Determines whether CloudFront includes the Referrer-Policy HTTP response header and the header’s value. 
		 For more information about the Referrer-Policy HTTP response header, see Referrer-Policy (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy) in the MDN Web Docs.
		"""

														properties: {
															override: type: "boolean"
															referrerPolicy: type: "string"
														}
														type: "object"
													}
													strictTransportSecurity: {
														description: """
		Determines whether CloudFront includes the Strict-Transport-Security HTTP response header and the header’s value. 
		 For more information about the Strict-Transport-Security HTTP response header, see Strict-Transport-Security (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security) in the MDN Web Docs.
		"""

														properties: {
															accessControlMaxAgeSec: {
																format: "int64"
																type:   "integer"
															}
															includeSubdomains: type: "boolean"
															override: type: "boolean"
															preload: type: "boolean"
														}
														type: "object"
													}
													xSSProtection: {
														description: """
		Determines whether CloudFront includes the X-XSS-Protection HTTP response header and the header’s value. 
		 For more information about the X-XSS-Protection HTTP response header, see X-XSS-Protection (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection) in the MDN Web Docs.
		"""

														properties: {
															modeBlock: type: "boolean"
															override: type: "boolean"
															protection: type: "boolean"
															reportURI: type: "string"
														}
														type: "object"
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
									"responseHeadersPolicyConfig",
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
						description: "ResponseHeadersPolicyStatus defines the observed state of ResponseHeadersPolicy."

						properties: {
							atProvider: {
								description: "ResponseHeadersPolicyObservation defines the observed state of ResponseHeadersPolicy"

								properties: {
									eTag: {
										description: "The version identifier for the current version of the response headers policy."

										type: "string"
									}
									location: {
										description: "The URL of the response headers policy."
										type:        "string"
									}
									responseHeadersPolicy: {
										description: "Contains a response headers policy."
										properties: {
											id: type: "string"
											lastModifiedTime: {
												format: "date-time"
												type:   "string"
											}
											responseHeadersPolicyConfig: {
												description: """
		A response headers policy configuration. 
		 A response headers policy configuration contains metadata about the response headers policy, and configurations for sets of HTTP response headers and their values. CloudFront adds the headers in the policy to HTTP responses that it sends for requests that match a cache behavior associated with the policy.
		"""

												properties: {
													comment: type: "string"
													corsConfig: {
														description: """
		A configuration for a set of HTTP response headers that are used for cross-origin resource sharing (CORS). CloudFront adds these headers to HTTP responses that it sends for CORS requests that match a cache behavior associated with this response headers policy. 
		 For more information about CORS, see Cross-Origin Resource Sharing (CORS) (https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) in the MDN Web Docs.
		"""

														properties: {
															accessControlAllowCredentials: type: "boolean"
															accessControlAllowHeaders: {
																description: """
		A list of HTTP header names that CloudFront includes as values for the Access-Control-Allow-Headers HTTP response header. 
		 For more information about the Access-Control-Allow-Headers HTTP response header, see Access-Control-Allow-Headers (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Headers) in the MDN Web Docs.
		"""

																properties: items: {
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															accessControlAllowMethods: {
																description: """
		A list of HTTP methods that CloudFront includes as values for the Access-Control-Allow-Methods HTTP response header. 
		 For more information about the Access-Control-Allow-Methods HTTP response header, see Access-Control-Allow-Methods (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Methods) in the MDN Web Docs.
		"""

																properties: items: {
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															accessControlAllowOrigins: {
																description: """
		A list of origins (domain names) that CloudFront can use as the value for the Access-Control-Allow-Origin HTTP response header. 
		 For more information about the Access-Control-Allow-Origin HTTP response header, see Access-Control-Allow-Origin (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) in the MDN Web Docs.
		"""

																properties: items: {
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															accessControlExposeHeaders: {
																description: """
		A list of HTTP headers that CloudFront includes as values for the Access-Control-Expose-Headers HTTP response header. 
		 For more information about the Access-Control-Expose-Headers HTTP response header, see Access-Control-Expose-Headers (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Expose-Headers) in the MDN Web Docs.
		"""

																properties: items: {
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															accessControlMaxAgeSec: {
																format: "int64"
																type:   "integer"
															}
															originOverride: type: "boolean"
														}
														type: "object"
													}
													customHeadersConfig: {
														description: "A list of HTTP response header names and their values. CloudFront includes these headers in HTTP responses that it sends for requests that match a cache behavior that’s associated with this response headers policy."

														properties: items: {
															items: {
																properties: {
																	header: type: "string"
																	override: type: "boolean"
																	value: type: "string"
																}
																type: "object"
															}
															type: "array"
														}
														type: "object"
													}
													name: type: "string"
													securityHeadersConfig: {
														description: "A configuration for a set of security-related HTTP response headers. CloudFront adds these headers to HTTP responses that it sends for requests that match a cache behavior associated with this response headers policy."

														properties: {
															contentSecurityPolicy: {
																description: """
		The policy directives and their values that CloudFront includes as values for the Content-Security-Policy HTTP response header. 
		 For more information about the Content-Security-Policy HTTP response header, see Content-Security-Policy (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy) in the MDN Web Docs.
		"""

																properties: {
																	contentSecurityPolicy: type: "string"
																	override: type: "boolean"
																}
																type: "object"
															}
															contentTypeOptions: {
																description: """
		Determines whether CloudFront includes the X-Content-Type-Options HTTP response header with its value set to nosniff. 
		 For more information about the X-Content-Type-Options HTTP response header, see X-Content-Type-Options (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options) in the MDN Web Docs.
		"""

																properties: override: type: "boolean"
																type: "object"
															}
															frameOptions: {
																description: """
		Determines whether CloudFront includes the X-Frame-Options HTTP response header and the header’s value. 
		 For more information about the X-Frame-Options HTTP response header, see X-Frame-Options (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options) in the MDN Web Docs.
		"""

																properties: {
																	frameOption: type: "string"
																	override: type: "boolean"
																}
																type: "object"
															}
															referrerPolicy: {
																description: """
		Determines whether CloudFront includes the Referrer-Policy HTTP response header and the header’s value. 
		 For more information about the Referrer-Policy HTTP response header, see Referrer-Policy (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy) in the MDN Web Docs.
		"""

																properties: {
																	override: type: "boolean"
																	referrerPolicy: type: "string"
																}
																type: "object"
															}
															strictTransportSecurity: {
																description: """
		Determines whether CloudFront includes the Strict-Transport-Security HTTP response header and the header’s value. 
		 For more information about the Strict-Transport-Security HTTP response header, see Strict-Transport-Security (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security) in the MDN Web Docs.
		"""

																properties: {
																	accessControlMaxAgeSec: {
																		format: "int64"
																		type:   "integer"
																	}
																	includeSubdomains: type: "boolean"
																	override: type: "boolean"
																	preload: type: "boolean"
																}
																type: "object"
															}
															xSSProtection: {
																description: """
		Determines whether CloudFront includes the X-XSS-Protection HTTP response header and the header’s value. 
		 For more information about the X-XSS-Protection HTTP response header, see X-XSS-Protection (https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection) in the MDN Web Docs.
		"""

																properties: {
																	modeBlock: type: "boolean"
																	override: type: "boolean"
																	protection: type: "boolean"
																	reportURI: type: "string"
																}
																type: "object"
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
								}, type:
									"object"
							}, conditions: {
								description:
									"Conditions of the resource.", items: {
									description:
										"A Condition that may apply to a resource.", properties: {

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
									}, required: [
										"lastTransitionTime",
										"reason",
										"status",
										"type",
									], type:
										"object"
								}, type:
									"array"
							}
						}, type: "object"
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

			kind: "", plural:
				""
		}, conditions: []
		storedVersions: [
		]
	}
}
