package cloudfront_aws_crossplane_io_cachepolicies

customresourcedefinition: "cachepolicies.cloudfront.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "cachepolicies.cloudfront.aws.crossplane.io"
	}
	spec: {
		group: "cloudfront.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "CachePolicy"
			listKind: "CachePolicyList"
			plural:   "cachepolicies"
			singular: "cachepolicy"
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
				description: "CachePolicy is the Schema for the CachePolicies API"
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
						description: "CachePolicySpec defines the desired state of CachePolicy"
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
								description: "CachePolicyParameters defines the desired state of CachePolicy"
								properties: {
									cachePolicyConfig: {
										description: "A cache policy configuration."
										properties: {
											comment: type: "string"
											defaultTTL: {
												format: "int64"
												type:   "integer"
											}
											maxTTL: {
												format: "int64"
												type:   "integer"
											}
											minTTL: {
												format: "int64"
												type:   "integer"
											}
											name: type: "string"
											parametersInCacheKeyAndForwardedToOrigin: {
												description: """
		This object determines the values that CloudFront includes in the cache key. These values can include HTTP headers, cookies, and URL query strings. CloudFront uses the cache key to find an object in its cache that it can return to the viewer. 
		 The headers, cookies, and query strings that are included in the cache key are automatically included in requests that CloudFront sends to the origin. CloudFront sends a request when it can’t find an object in its cache that matches the request’s cache key. If you want to send values to the origin but not include them in the cache key, use OriginRequestPolicy.
		"""

												properties: {
													cookiesConfig: {
														description: "An object that determines whether any cookies in viewer requests (and if so, which cookies) are included in the cache key and automatically included in requests that CloudFront sends to the origin."

														properties: {
															cookieBehavior: type: "string"
															cookies: {
																description: "Contains a list of cookie names."
																properties: {
																	items: {
																		items: type: "string"
																		type: "array"
																	}
																	quantity: {
																		format: "int64"
																		type:   "integer"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													enableAcceptEncodingBrotli: type: "boolean"
													enableAcceptEncodingGzip: type: "boolean"
													headersConfig: {
														description: "An object that determines whether any HTTP headers (and if so, which headers) are included in the cache key and automatically included in requests that CloudFront sends to the origin."

														properties: {
															headerBehavior: type: "string"
															headers: {
																description: "Contains a list of HTTP header names."
																properties: items: {
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
														}
														type: "object"
													}
													queryStringsConfig: {
														description: "An object that determines whether any URL query strings in viewer requests (and if so, which query strings) are included in the cache key and automatically included in requests that CloudFront sends to the origin."

														properties: {
															queryStringBehavior: type: "string"
															queryStrings: {
																description: "Contains a list of query string names."
																properties: {
																	items: {
																		items: type: "string"
																		type: "array"
																	}
																	quantity: {
																		format: "int64"
																		type:   "integer"
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
										}
										type: "object"
									}
									region: {
										description: "Region is which region the CachePolicy will be created."
										type:        "string"
									}
								}
								required: [
									"cachePolicyConfig",
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
						description: "CachePolicyStatus defines the observed state of CachePolicy."
						properties: {
							atProvider: {
								description: "CachePolicyObservation defines the observed state of CachePolicy"

								properties: {
									cachePolicy: {
										description: "A cache policy."
										properties: {
											cachePolicyConfig: {
												description: """
		A cache policy configuration. 
		 This configuration determines the following: 
		 * The values that CloudFront includes in the cache key. These values can include HTTP headers, cookies, and URL query strings. CloudFront uses the cache key to find an object in its cache that it can return to the viewer. 
		 * The default, minimum, and maximum time to live (TTL) values that you want objects to stay in the CloudFront cache. 
		 The headers, cookies, and query strings that are included in the cache key are automatically included in requests that CloudFront sends to the origin. CloudFront sends a request when it can’t find a valid object in its cache that matches the request’s cache key. If you want to send values to the origin but not include them in the cache key, use OriginRequestPolicy.
		"""

												properties: {
													comment: type: "string"
													defaultTTL: {
														format: "int64"
														type:   "integer"
													}
													maxTTL: {
														format: "int64"
														type:   "integer"
													}
													minTTL: {
														format: "int64"
														type:   "integer"
													}
													name: type: "string"
													parametersInCacheKeyAndForwardedToOrigin: {
														description: """
		This object determines the values that CloudFront includes in the cache key. These values can include HTTP headers, cookies, and URL query strings. CloudFront uses the cache key to find an object in its cache that it can return to the viewer. 
		 The headers, cookies, and query strings that are included in the cache key are automatically included in requests that CloudFront sends to the origin. CloudFront sends a request when it can’t find an object in its cache that matches the request’s cache key. If you want to send values to the origin but not include them in the cache key, use OriginRequestPolicy.
		"""

														properties: {
															cookiesConfig: {
																description: "An object that determines whether any cookies in viewer requests (and if so, which cookies) are included in the cache key and automatically included in requests that CloudFront sends to the origin."

																properties: {
																	cookieBehavior: type: "string"
																	cookies: {
																		description: "Contains a list of cookie names."
																		properties: {
																			items: {
																				items: type: "string"
																				type: "array"
																			}
																			quantity: {
																				format: "int64"
																				type:   "integer"
																			}
																		}
																		type: "object"
																	}
																}
																type: "object"
															}
															enableAcceptEncodingBrotli: type: "boolean"
															enableAcceptEncodingGzip: type: "boolean"
															headersConfig: {
																description: "An object that determines whether any HTTP headers (and if so, which headers) are included in the cache key and automatically included in requests that CloudFront sends to the origin."

																properties: {
																	headerBehavior: type: "string"
																	headers: {
																		description: "Contains a list of HTTP header names."
																		properties: items: {
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																}
																type: "object"
															}
															queryStringsConfig: {
																description: "An object that determines whether any URL query strings in viewer requests (and if so, which query strings) are included in the cache key and automatically included in requests that CloudFront sends to the origin."

																properties: {
																	queryStringBehavior: type: "string"
																	queryStrings: {
																		description: "Contains a list of query string names."
																		properties: {
																			items: {
																				items: type: "string"
																				type: "array"
																			}
																			quantity: {
																				format: "int64"
																				type:   "integer"
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
												}
												type: "object"
											}
											id: type: "string"
											lastModifiedTime: {
												format: "date-time"
												type:   "string"
											}
										}
										type: "object"
									}
									eTag: {
										description: "The current version of the cache policy."
										type:        "string"
									}
									location: {
										description: "The fully qualified URI of the cache policy just created."

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
				}, required: [
					"spec",
				]
				type:
					"object"
			}, served:
				true, storage:
				true, subresources: status: {}
		}]
	}
	status: {acceptedNames: {

		kind: ""
		plural:
			""
	}, conditions: [], storedVersions: []
	}
}
