package cloudfront_aws_crossplane_io_distributions

customresourcedefinition: "distributions.cloudfront.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "distributions.cloudfront.aws.crossplane.io"
	}
	spec: {
		group: "cloudfront.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Distribution"
			listKind: "DistributionList"
			plural:   "distributions"
			singular: "distribution"
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
				description: "Distribution is the Schema for the Distributions API"
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
						description: "DistributionSpec defines the desired state of Distribution"
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
								description: "DistributionParameters defines the desired state of Distribution"
								properties: {
									distributionConfig: {
										description: "The distribution's configuration information."
										properties: {
											aliases: {
												description: "A complex type that contains information about CNAMEs (alternate domain names), if any, for this distribution."

												properties: items: {
													items: type: "string"
													type: "array"
												}
												type: "object"
											}
											cacheBehaviors: {
												description: "A complex type that contains zero or more CacheBehavior elements."

												properties: items: {
													items: {
														properties: {
															allowedMethods: {
																description: """
		A complex type that controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. There are three choices: 
		 * CloudFront forwards only GET and HEAD requests. 
		 * CloudFront forwards only GET, HEAD, and OPTIONS requests. 
		 * CloudFront forwards GET, HEAD, OPTIONS, PUT, PATCH, POST, and DELETE requests. 
		 If you pick the third choice, you may need to restrict access to your Amazon S3 bucket or to your custom origin so users can't perform operations that you don't want them to. For example, you might not want users to have permissions to delete objects from your origin.
		"""

																properties: {
																	cachedMethods: {
																		description: """
		A complex type that controls whether CloudFront caches the response to requests using the specified HTTP methods. There are two choices: 
		 * CloudFront caches responses to GET and HEAD requests. 
		 * CloudFront caches responses to GET, HEAD, and OPTIONS requests. 
		 If you pick the second choice for your Amazon S3 Origin, you may need to forward Access-Control-Request-Method, Access-Control-Request-Headers, and Origin headers for the responses to be cached correctly.
		"""

																		properties: items: {
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																	items: {
																		items: type: "string"
																		type: "array"
																	}
																}
																type: "object"
															}
															cachePolicyID: type: "string"
															compress: type: "boolean"
															defaultTTL: {
																format: "int64"
																type:   "integer"
															}
															fieldLevelEncryptionID: type: "string"
															forwardedValues: {
																description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include values in the cache key, use a cache policy. For more information, see Creating cache policies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the Amazon CloudFront Developer Guide. 
		 If you want to send values to the origin but not include them in the cache key, use an origin request policy. For more information, see Creating origin request policies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the Amazon CloudFront Developer Guide. 
		 A complex type that specifies how CloudFront handles query strings, cookies, and HTTP headers.
		"""

																properties: {
																	cookies: {
																		description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include cookies in the cache key, use CookiesConfig in a cache policy. See CachePolicy. 
		 If you want to send cookies to the origin but not include them in the cache key, use CookiesConfig in an origin request policy. See OriginRequestPolicy. 
		 A complex type that specifies whether you want CloudFront to forward cookies to the origin and, if so, which ones. For more information about forwarding cookies to the origin, see Caching Content Based on Cookies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Cookies.html) in the Amazon CloudFront Developer Guide.
		"""

																		properties: {
																			forward: type: "string"
																			whitelistedNames: {
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
																	headers: {
																		description: "Contains a list of HTTP header names."

																		properties: items: {
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																	queryString: type: "boolean"
																	queryStringCacheKeys: {
																		description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include query strings in the cache key, use QueryStringsConfig in a cache policy. See CachePolicy. 
		 If you want to send query strings to the origin but not include them in the cache key, use QueryStringsConfig in an origin request policy. See OriginRequestPolicy. 
		 A complex type that contains information about the query string parameters that you want CloudFront to use for caching for a cache behavior.
		"""

																		properties: items: {
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																}
																type: "object"
															}
															functionAssociations: {
																description: "A list of CloudFront functions that are associated with a cache behavior in a CloudFront distribution. CloudFront functions must be published to the LIVE stage to associate them with a cache behavior."

																properties: items: {
																	items: {
																		properties: {
																			eventType: type: "string"
																			functionARN: type: "string"
																		}
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															lambdaFunctionAssociations: {
																description: """
		A complex type that specifies a list of Lambda@Edge functions associations for a cache behavior. 
		 If you want to invoke one or more Lambda@Edge functions triggered by requests that match the PathPattern of the cache behavior, specify the applicable values for Quantity and Items. Note that there can be up to 4 LambdaFunctionAssociation items in this list (one for each possible value of EventType) and each EventType can be associated with only one function. 
		 If you don't want to invoke any Lambda@Edge functions for the requests that match PathPattern, specify 0 for Quantity and omit Items.
		"""

																properties: items: {
																	items: {
																		properties: {
																			eventType: type: "string"
																			includeBody: type: "boolean"
																			lambdaFunctionARN: type: "string"
																		}
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															maxTTL: {
																format: "int64"
																type:   "integer"
															}
															minTTL: {
																format: "int64"
																type:   "integer"
															}
															originRequestPolicyID: type: "string"
															pathPattern: type: "string"
															realtimeLogConfigARN: type: "string"
															responseHeadersPolicyID: type: "string"
															smoothStreaming: type: "boolean"
															targetOriginID: type: "string"
															trustedKeyGroups: {
																description: "A list of key groups whose public keys CloudFront can use to verify the signatures of signed URLs and signed cookies."

																properties: {
																	enabled: type: "boolean"
																	items: {
																		items: type: "string"
																		type: "array"
																	}
																}
																type: "object"
															}
															trustedSigners: {
																description: "A list of Amazon Web Services accounts whose public keys CloudFront can use to verify the signatures of signed URLs and signed cookies."

																properties: {
																	enabled: type: "boolean"
																	items: {
																		items: type: "string"
																		type: "array"
																	}
																}
																type: "object"
															}
															viewerProtocolPolicy: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												type: "object"
											}
											callerReference: type: "string"
											comment: type: "string"
											customErrorResponses: {
												description: """
		A complex type that controls: 
		 * Whether CloudFront replaces HTTP status codes in the 4xx and 5xx range with custom error messages before returning the response to the viewer. 
		 * How long CloudFront caches HTTP status codes in the 4xx and 5xx range. 
		 For more information about custom error pages, see Customizing Error Responses (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html) in the Amazon CloudFront Developer Guide.
		"""

												properties: items: {
													items: {
														properties: {
															errorCachingMinTTL: {
																format: "int64"
																type:   "integer"
															}
															errorCode: {
																format: "int64"
																type:   "integer"
															}
															responseCode: type: "string"
															responsePagePath: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												type: "object"
											}
											defaultCacheBehavior: {
												description: "A complex type that describes the default cache behavior if you don’t specify a CacheBehavior element or if request URLs don’t match any of the values of PathPattern in CacheBehavior elements. You must create exactly one default cache behavior."

												properties: {
													allowedMethods: {
														description: """
		A complex type that controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. There are three choices: 
		 * CloudFront forwards only GET and HEAD requests. 
		 * CloudFront forwards only GET, HEAD, and OPTIONS requests. 
		 * CloudFront forwards GET, HEAD, OPTIONS, PUT, PATCH, POST, and DELETE requests. 
		 If you pick the third choice, you may need to restrict access to your Amazon S3 bucket or to your custom origin so users can't perform operations that you don't want them to. For example, you might not want users to have permissions to delete objects from your origin.
		"""

														properties: {
															cachedMethods: {
																description: """
		A complex type that controls whether CloudFront caches the response to requests using the specified HTTP methods. There are two choices: 
		 * CloudFront caches responses to GET and HEAD requests. 
		 * CloudFront caches responses to GET, HEAD, and OPTIONS requests. 
		 If you pick the second choice for your Amazon S3 Origin, you may need to forward Access-Control-Request-Method, Access-Control-Request-Headers, and Origin headers for the responses to be cached correctly.
		"""

																properties: items: {
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															items: {
																items: type: "string"
																type: "array"
															}
														}
														type: "object"
													}
													cachePolicyID: type: "string"
													compress: type: "boolean"
													defaultTTL: {
														format: "int64"
														type:   "integer"
													}
													fieldLevelEncryptionID: type: "string"
													forwardedValues: {
														description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include values in the cache key, use a cache policy. For more information, see Creating cache policies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the Amazon CloudFront Developer Guide. 
		 If you want to send values to the origin but not include them in the cache key, use an origin request policy. For more information, see Creating origin request policies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the Amazon CloudFront Developer Guide. 
		 A complex type that specifies how CloudFront handles query strings, cookies, and HTTP headers.
		"""

														properties: {
															cookies: {
																description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include cookies in the cache key, use CookiesConfig in a cache policy. See CachePolicy. 
		 If you want to send cookies to the origin but not include them in the cache key, use CookiesConfig in an origin request policy. See OriginRequestPolicy. 
		 A complex type that specifies whether you want CloudFront to forward cookies to the origin and, if so, which ones. For more information about forwarding cookies to the origin, see Caching Content Based on Cookies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Cookies.html) in the Amazon CloudFront Developer Guide.
		"""

																properties: {
																	forward: type: "string"
																	whitelistedNames: {
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
															headers: {
																description: "Contains a list of HTTP header names."
																properties: items: {
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
															queryString: type: "boolean"
															queryStringCacheKeys: {
																description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include query strings in the cache key, use QueryStringsConfig in a cache policy. See CachePolicy. 
		 If you want to send query strings to the origin but not include them in the cache key, use QueryStringsConfig in an origin request policy. See OriginRequestPolicy. 
		 A complex type that contains information about the query string parameters that you want CloudFront to use for caching for a cache behavior.
		"""

																properties: items: {
																	items: type: "string"
																	type: "array"
																}
																type: "object"
															}
														}
														type: "object"
													}
													functionAssociations: {
														description: "A list of CloudFront functions that are associated with a cache behavior in a CloudFront distribution. CloudFront functions must be published to the LIVE stage to associate them with a cache behavior."

														properties: items: {
															items: {
																properties: {
																	eventType: type: "string"
																	functionARN: type: "string"
																}
																type: "object"
															}
															type: "array"
														}
														type: "object"
													}
													lambdaFunctionAssociations: {
														description: """
		A complex type that specifies a list of Lambda@Edge functions associations for a cache behavior. 
		 If you want to invoke one or more Lambda@Edge functions triggered by requests that match the PathPattern of the cache behavior, specify the applicable values for Quantity and Items. Note that there can be up to 4 LambdaFunctionAssociation items in this list (one for each possible value of EventType) and each EventType can be associated with only one function. 
		 If you don't want to invoke any Lambda@Edge functions for the requests that match PathPattern, specify 0 for Quantity and omit Items.
		"""

														properties: items: {
															items: {
																properties: {
																	eventType: type: "string"
																	includeBody: type: "boolean"
																	lambdaFunctionARN: type: "string"
																}
																type: "object"
															}
															type: "array"
														}
														type: "object"
													}
													maxTTL: {
														format: "int64"
														type:   "integer"
													}
													minTTL: {
														format: "int64"
														type:   "integer"
													}
													originRequestPolicyID: type: "string"
													realtimeLogConfigARN: type: "string"
													responseHeadersPolicyID: type: "string"
													smoothStreaming: type: "boolean"
													targetOriginID: type: "string"
													trustedKeyGroups: {
														description: "A list of key groups whose public keys CloudFront can use to verify the signatures of signed URLs and signed cookies."

														properties: {
															enabled: type: "boolean"
															items: {
																items: type: "string"
																type: "array"
															}
														}
														type: "object"
													}
													trustedSigners: {
														description: "A list of Amazon Web Services accounts whose public keys CloudFront can use to verify the signatures of signed URLs and signed cookies."

														properties: {
															enabled: type: "boolean"
															items: {
																items: type: "string"
																type: "array"
															}
														}
														type: "object"
													}
													viewerProtocolPolicy: type: "string"
												}
												type: "object"
											}
											defaultRootObject: type: "string"
											enabled: type: "boolean"
											httpVersion: type: "string"
											isIPV6Enabled: type: "boolean"
											logging: {
												description: "A complex type that controls whether access logs are written for the distribution."

												properties: {
													bucket: type: "string"
													enabled: type: "boolean"
													includeCookies: type: "boolean"
													prefix: type: "string"
												}
												type: "object"
											}
											originGroups: {
												description: "A complex data type for the origin groups specified for a distribution."

												properties: items: {
													description: "List of origin groups for a distribution."
													items: {
														properties: {
															failoverCriteria: {
																description: "A complex data type that includes information about the failover criteria for an origin group, including the status codes for which CloudFront will failover from the primary origin to the second origin."

																properties: statusCodes: {
																	description: "A complex data type for the status codes that you specify that, when returned by a primary origin, trigger CloudFront to failover to a second origin."

																	properties: items: {
																		description: "List of status codes for origin failover."

																		items: {
																			format: "int64"
																			type:   "integer"
																		}
																		type: "array"
																	}
																	type: "object"
																}
																type: "object"
															}
															id: type: "string"
															members: {
																description: "A complex data type for the origins included in an origin group."

																properties: {
																	items: {
																		description: "List of origins in an origin group."
																		items: {
																			properties: originID: type: "string"
																			type: "object"
																		}
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
													type: "array"
												}
												type: "object"
											}
											origins: {
												description: "Contains information about the origins for this distribution."

												properties: items: {
													items: {
														properties: {
															connectionAttempts: {
																format: "int64"
																type:   "integer"
															}
															connectionTimeout: {
																format: "int64"
																type:   "integer"
															}
															customHeaders: {
																description: "A complex type that contains the list of Custom Headers for each origin."

																properties: items: {
																	items: {
																		properties: {
																			headerName: type: "string"
																			headerValue: type: "string"
																		}
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															customOriginConfig: {
																description: "A custom origin. A custom origin is any origin that is not an Amazon S3 bucket, with one exception. An Amazon S3 bucket that is configured with static website hosting (https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) is a custom origin."

																properties: {
																	httpPort: {
																		format: "int64"
																		type:   "integer"
																	}
																	httpSPort: {
																		format: "int64"
																		type:   "integer"
																	}
																	originKeepaliveTimeout: {
																		format: "int64"
																		type:   "integer"
																	}
																	originProtocolPolicy: type: "string"
																	originReadTimeout: {
																		format: "int64"
																		type:   "integer"
																	}
																	originSSLProtocols: {
																		description: "A complex type that contains information about the SSL/TLS protocols that CloudFront can use when establishing an HTTPS connection with your origin."

																		properties: items: {
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																}
																type: "object"
															}
															domainName: type: "string"
															id: type: "string"
															originPath: type: "string"
															originShield: {
																description: """
		CloudFront Origin Shield. 
		 Using Origin Shield can help reduce the load on your origin. For more information, see Using Origin Shield (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/origin-shield.html) in the Amazon CloudFront Developer Guide.
		"""

																properties: {
																	enabled: type: "boolean"
																	originShieldRegion: type: "string"
																}
																type: "object"
															}
															s3OriginConfig: {
																description: "A complex type that contains information about the Amazon S3 origin. If the origin is a custom origin or an S3 bucket that is configured as a website endpoint, use the CustomOriginConfig element instead."

																properties: originAccessIdentity: type: "string"
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
												type: "object"
											}
											priceClass: type: "string"
											restrictions: {
												description: "A complex type that identifies ways in which you want to restrict distribution of your content."

												properties: geoRestriction: {
													description: "A complex type that controls the countries in which your content is distributed. CloudFront determines the location of your users using MaxMind GeoIP databases."

													properties: {
														items: {
															items: type: "string"
															type: "array"
														}
														restrictionType: type: "string"
													}
													type: "object"
												}
												type: "object"
											}
											viewerCertificate: {
												description: """
		A complex type that determines the distribution’s SSL/TLS configuration for communicating with viewers. 
		 If the distribution doesn’t use Aliases (also known as alternate domain names or CNAMEs)—that is, if the distribution uses the CloudFront domain name such as d111111abcdef8.cloudfront.net—set CloudFrontDefaultCertificate to true and leave all other fields empty. 
		 If the distribution uses Aliases (alternate domain names or CNAMEs), use the fields in this type to specify the following settings: 
		 * Which viewers the distribution accepts HTTPS connections from: only viewers that support server name indication (SNI) (https://en.wikipedia.org/wiki/Server_Name_Indication) (recommended), or all viewers including those that don’t support SNI. To accept HTTPS connections from only viewers that support SNI, set SSLSupportMethod to sni-only. This is recommended. Most browsers and clients support SNI. To accept HTTPS connections from all viewers, including those that don’t support SNI, set SSLSupportMethod to vip. This is not recommended, and results in additional monthly charges from CloudFront. 
		 * The minimum SSL/TLS protocol version that the distribution can use to communicate with viewers. To specify a minimum version, choose a value for MinimumProtocolVersion. For more information, see Security Policy (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValues-security-policy) in the Amazon CloudFront Developer Guide. 
		 * The location of the SSL/TLS certificate, Certificate Manager (ACM) (https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html) (recommended) or Identity and Access Management (IAM) (https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html). You specify the location by setting a value in one of the following fields (not both): ACMCertificateArn IAMCertificateId 
		 All distributions support HTTPS connections from viewers. To require viewers to use HTTPS only, or to redirect them from HTTP to HTTPS, use ViewerProtocolPolicy in the CacheBehavior or DefaultCacheBehavior. To specify how CloudFront should use SSL/TLS to communicate with your custom origin, use CustomOriginConfig. 
		 For more information, see Using HTTPS with CloudFront (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-https.html) and Using Alternate Domain Names and HTTPS (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-https-alternate-domain-names.html) in the Amazon CloudFront Developer Guide.
		"""

												properties: {
													aCMCertificateARN: type: "string"
													certificate: type: "string"
													certificateSource: type: "string"
													cloudFrontDefaultCertificate: type: "boolean"
													iamCertificateID: type: "string"
													minimumProtocolVersion: type: "string"
													sslSupportMethod: type: "string"
												}
												type: "object"
											}
											webACLID: type: "string"
										}
										type: "object"
									}
									region: {
										description: "Region is which region the Distribution will be created."
										type:        "string"
									}
								}
								required: [
									"distributionConfig",
									"region",
								]
								type: "object"
							}, providerConfigRef: {

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
							}, providerRef: {

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
							}, publishConnectionDetailsTo: {

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
							}, writeConnectionSecretToRef: {

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
						}, required: [
							"forProvider",
						]
						type:
							"object"
					}, status: {
						description:
							"DistributionStatus defines the observed state of Distribution.", properties: {
							atProvider: {

								description: "DistributionObservation defines the observed state of Distribution"

								properties: {
									distribution: {
										description: "The distribution's information."
										properties: {
											activeTrustedKeyGroups: {
												description: "A list of key groups, and the public keys in each key group, that CloudFront can use to verify the signatures of signed URLs and signed cookies."

												properties: {
													enabled: type: "boolean"
													items: {
														items: {
															properties: {
																keyGroupID: type: "string"
																keyPairIDs: {
																	description: "A list of CloudFront key pair identifiers."
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
														type: "array"
													}
													quantity: {
														format: "int64"
														type:   "integer"
													}
												}
												type: "object"
											}
											activeTrustedSigners: {
												description: "A list of Amazon Web Services accounts and the active CloudFront key pairs in each account that CloudFront can use to verify the signatures of signed URLs and signed cookies."

												properties: {
													enabled: type: "boolean"
													items: {
														items: {
															properties: {
																awsAccountNumber: type: "string"
																keyPairIDs: {
																	description: "A list of CloudFront key pair identifiers."
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
														type: "array"
													}
													quantity: {
														format: "int64"
														type:   "integer"
													}
												}
												type: "object"
											}
											aliasICPRecordals: {
												items: {
													properties: {
														cname: type: "string"
														iCPRecordalStatus: type: "string"
													}
													type: "object"
												}
												type: "array"
											}
											arn: type: "string"
											distributionConfig: {
												description: "A distribution configuration."
												properties: {
													aliases: {
														description: "A complex type that contains information about CNAMEs (alternate domain names), if any, for this distribution."

														properties: items: {
															items: type: "string"
															type: "array"
														}
														type: "object"
													}
													cacheBehaviors: {
														description: "A complex type that contains zero or more CacheBehavior elements."

														properties: items: {
															items: {
																properties: {
																	allowedMethods: {
																		description: """
		A complex type that controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. There are three choices: 
		 * CloudFront forwards only GET and HEAD requests. 
		 * CloudFront forwards only GET, HEAD, and OPTIONS requests. 
		 * CloudFront forwards GET, HEAD, OPTIONS, PUT, PATCH, POST, and DELETE requests. 
		 If you pick the third choice, you may need to restrict access to your Amazon S3 bucket or to your custom origin so users can't perform operations that you don't want them to. For example, you might not want users to have permissions to delete objects from your origin.
		"""

																		properties: {
																			cachedMethods: {
																				description: """
		A complex type that controls whether CloudFront caches the response to requests using the specified HTTP methods. There are two choices: 
		 * CloudFront caches responses to GET and HEAD requests. 
		 * CloudFront caches responses to GET, HEAD, and OPTIONS requests. 
		 If you pick the second choice for your Amazon S3 Origin, you may need to forward Access-Control-Request-Method, Access-Control-Request-Headers, and Origin headers for the responses to be cached correctly.
		"""

																				properties: items: {
																					items: type: "string"
																					type: "array"
																				}
																				type: "object"
																			}
																			items: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		type: "object"
																	}
																	cachePolicyID: type: "string"
																	compress: type: "boolean"
																	defaultTTL: {
																		format: "int64"
																		type:   "integer"
																	}
																	fieldLevelEncryptionID: type: "string"
																	forwardedValues: {
																		description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include values in the cache key, use a cache policy. For more information, see Creating cache policies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the Amazon CloudFront Developer Guide. 
		 If you want to send values to the origin but not include them in the cache key, use an origin request policy. For more information, see Creating origin request policies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the Amazon CloudFront Developer Guide. 
		 A complex type that specifies how CloudFront handles query strings, cookies, and HTTP headers.
		"""

																		properties: {
																			cookies: {
																				description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include cookies in the cache key, use CookiesConfig in a cache policy. See CachePolicy. 
		 If you want to send cookies to the origin but not include them in the cache key, use CookiesConfig in an origin request policy. See OriginRequestPolicy. 
		 A complex type that specifies whether you want CloudFront to forward cookies to the origin and, if so, which ones. For more information about forwarding cookies to the origin, see Caching Content Based on Cookies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Cookies.html) in the Amazon CloudFront Developer Guide.
		"""

																				properties: {
																					forward: type: "string"
																					whitelistedNames: {
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
																			headers: {
																				description: "Contains a list of HTTP header names."

																				properties: items: {
																					items: type: "string"
																					type: "array"
																				}
																				type: "object"
																			}
																			queryString: type: "boolean"
																			queryStringCacheKeys: {
																				description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include query strings in the cache key, use QueryStringsConfig in a cache policy. See CachePolicy. 
		 If you want to send query strings to the origin but not include them in the cache key, use QueryStringsConfig in an origin request policy. See OriginRequestPolicy. 
		 A complex type that contains information about the query string parameters that you want CloudFront to use for caching for a cache behavior.
		"""

																				properties: items: {
																					items: type: "string"
																					type: "array"
																				}
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	functionAssociations: {
																		description: "A list of CloudFront functions that are associated with a cache behavior in a CloudFront distribution. CloudFront functions must be published to the LIVE stage to associate them with a cache behavior."

																		properties: items: {
																			items: {
																				properties: {
																					eventType: type: "string"
																					functionARN: type: "string"
																				}
																				type: "object"
																			}
																			type: "array"
																		}
																		type: "object"
																	}
																	lambdaFunctionAssociations: {
																		description: """
		A complex type that specifies a list of Lambda@Edge functions associations for a cache behavior. 
		 If you want to invoke one or more Lambda@Edge functions triggered by requests that match the PathPattern of the cache behavior, specify the applicable values for Quantity and Items. Note that there can be up to 4 LambdaFunctionAssociation items in this list (one for each possible value of EventType) and each EventType can be associated with only one function. 
		 If you don't want to invoke any Lambda@Edge functions for the requests that match PathPattern, specify 0 for Quantity and omit Items.
		"""

																		properties: items: {
																			items: {
																				properties: {
																					eventType: type: "string"
																					includeBody: type: "boolean"
																					lambdaFunctionARN: type: "string"
																				}
																				type: "object"
																			}
																			type: "array"
																		}
																		type: "object"
																	}
																	maxTTL: {
																		format: "int64"
																		type:   "integer"
																	}
																	minTTL: {
																		format: "int64"
																		type:   "integer"
																	}
																	originRequestPolicyID: type: "string"
																	pathPattern: type: "string"
																	realtimeLogConfigARN: type: "string"
																	responseHeadersPolicyID: type: "string"
																	smoothStreaming: type: "boolean"
																	targetOriginID: type: "string"
																	trustedKeyGroups: {
																		description: "A list of key groups whose public keys CloudFront can use to verify the signatures of signed URLs and signed cookies."

																		properties: {
																			enabled: type: "boolean"
																			items: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		type: "object"
																	}
																	trustedSigners: {
																		description: "A list of Amazon Web Services accounts whose public keys CloudFront can use to verify the signatures of signed URLs and signed cookies."

																		properties: {
																			enabled: type: "boolean"
																			items: {
																				items: type: "string"
																				type: "array"
																			}
																		}
																		type: "object"
																	}
																	viewerProtocolPolicy: type: "string"
																}
																type: "object"
															}
															type: "array"
														}
														type: "object"
													}
													callerReference: type: "string"
													comment: type: "string"
													customErrorResponses: {
														description: """
		A complex type that controls: 
		 * Whether CloudFront replaces HTTP status codes in the 4xx and 5xx range with custom error messages before returning the response to the viewer. 
		 * How long CloudFront caches HTTP status codes in the 4xx and 5xx range. 
		 For more information about custom error pages, see Customizing Error Responses (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html) in the Amazon CloudFront Developer Guide.
		"""

														properties: items: {
															items: {
																properties: {
																	errorCachingMinTTL: {
																		format: "int64"
																		type:   "integer"
																	}
																	errorCode: {
																		format: "int64"
																		type:   "integer"
																	}
																	responseCode: type: "string"
																	responsePagePath: type: "string"
																}
																type: "object"
															}
															type: "array"
														}
														type: "object"
													}
													defaultCacheBehavior: {
														description: "A complex type that describes the default cache behavior if you don’t specify a CacheBehavior element or if request URLs don’t match any of the values of PathPattern in CacheBehavior elements. You must create exactly one default cache behavior."

														properties: {
															allowedMethods: {
																description: """
		A complex type that controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. There are three choices: 
		 * CloudFront forwards only GET and HEAD requests. 
		 * CloudFront forwards only GET, HEAD, and OPTIONS requests. 
		 * CloudFront forwards GET, HEAD, OPTIONS, PUT, PATCH, POST, and DELETE requests. 
		 If you pick the third choice, you may need to restrict access to your Amazon S3 bucket or to your custom origin so users can't perform operations that you don't want them to. For example, you might not want users to have permissions to delete objects from your origin.
		"""

																properties: {
																	cachedMethods: {
																		description: """
		A complex type that controls whether CloudFront caches the response to requests using the specified HTTP methods. There are two choices: 
		 * CloudFront caches responses to GET and HEAD requests. 
		 * CloudFront caches responses to GET, HEAD, and OPTIONS requests. 
		 If you pick the second choice for your Amazon S3 Origin, you may need to forward Access-Control-Request-Method, Access-Control-Request-Headers, and Origin headers for the responses to be cached correctly.
		"""

																		properties: items: {
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																	items: {
																		items: type: "string"
																		type: "array"
																	}
																}
																type: "object"
															}
															cachePolicyID: type: "string"
															compress: type: "boolean"
															defaultTTL: {
																format: "int64"
																type:   "integer"
															}
															fieldLevelEncryptionID: type: "string"
															forwardedValues: {
																description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include values in the cache key, use a cache policy. For more information, see Creating cache policies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html#cache-key-create-cache-policy) in the Amazon CloudFront Developer Guide. 
		 If you want to send values to the origin but not include them in the cache key, use an origin request policy. For more information, see Creating origin request policies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html#origin-request-create-origin-request-policy) in the Amazon CloudFront Developer Guide. 
		 A complex type that specifies how CloudFront handles query strings, cookies, and HTTP headers.
		"""

																properties: {
																	cookies: {
																		description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include cookies in the cache key, use CookiesConfig in a cache policy. See CachePolicy. 
		 If you want to send cookies to the origin but not include them in the cache key, use CookiesConfig in an origin request policy. See OriginRequestPolicy. 
		 A complex type that specifies whether you want CloudFront to forward cookies to the origin and, if so, which ones. For more information about forwarding cookies to the origin, see Caching Content Based on Cookies (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Cookies.html) in the Amazon CloudFront Developer Guide.
		"""

																		properties: {
																			forward: type: "string"
																			whitelistedNames: {
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
																	headers: {
																		description: "Contains a list of HTTP header names."
																		properties: items: {
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																	queryString: type: "boolean"
																	queryStringCacheKeys: {
																		description: """
		This field is deprecated. We recommend that you use a cache policy or an origin request policy instead of this field. 
		 If you want to include query strings in the cache key, use QueryStringsConfig in a cache policy. See CachePolicy. 
		 If you want to send query strings to the origin but not include them in the cache key, use QueryStringsConfig in an origin request policy. See OriginRequestPolicy. 
		 A complex type that contains information about the query string parameters that you want CloudFront to use for caching for a cache behavior.
		"""

																		properties: items: {
																			items: type: "string"
																			type: "array"
																		}
																		type: "object"
																	}
																}
																type: "object"
															}
															functionAssociations: {
																description: "A list of CloudFront functions that are associated with a cache behavior in a CloudFront distribution. CloudFront functions must be published to the LIVE stage to associate them with a cache behavior."

																properties: items: {
																	items: {
																		properties: {
																			eventType: type: "string"
																			functionARN: type: "string"
																		}
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															lambdaFunctionAssociations: {
																description: """
		A complex type that specifies a list of Lambda@Edge functions associations for a cache behavior. 
		 If you want to invoke one or more Lambda@Edge functions triggered by requests that match the PathPattern of the cache behavior, specify the applicable values for Quantity and Items. Note that there can be up to 4 LambdaFunctionAssociation items in this list (one for each possible value of EventType) and each EventType can be associated with only one function. 
		 If you don't want to invoke any Lambda@Edge functions for the requests that match PathPattern, specify 0 for Quantity and omit Items.
		"""

																properties: items: {
																	items: {
																		properties: {
																			eventType: type: "string"
																			includeBody: type: "boolean"
																			lambdaFunctionARN: type: "string"
																		}
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															maxTTL: {
																format: "int64"
																type:   "integer"
															}
															minTTL: {
																format: "int64"
																type:   "integer"
															}
															originRequestPolicyID: type: "string"
															realtimeLogConfigARN: type: "string"
															responseHeadersPolicyID: type: "string"
															smoothStreaming: type: "boolean"
															targetOriginID: type: "string"
															trustedKeyGroups: {
																description: "A list of key groups whose public keys CloudFront can use to verify the signatures of signed URLs and signed cookies."

																properties: {
																	enabled: type: "boolean"
																	items: {
																		items: type: "string"
																		type: "array"
																	}
																}
																type: "object"
															}
															trustedSigners: {
																description: "A list of Amazon Web Services accounts whose public keys CloudFront can use to verify the signatures of signed URLs and signed cookies."

																properties: {
																	enabled: type: "boolean"
																	items: {
																		items: type: "string"
																		type: "array"
																	}
																}
																type: "object"
															}
															viewerProtocolPolicy: type: "string"
														}
														type: "object"
													}
													defaultRootObject: type: "string"
													enabled: type: "boolean"
													httpVersion: type: "string"
													isIPV6Enabled: type: "boolean"
													logging: {
														description: "A complex type that controls whether access logs are written for the distribution."

														properties: {
															bucket: type: "string"
															enabled: type: "boolean"
															includeCookies: type: "boolean"
															prefix: type: "string"
														}
														type: "object"
													}
													originGroups: {
														description: "A complex data type for the origin groups specified for a distribution."

														properties: items: {
															description: "List of origin groups for a distribution."
															items: {
																properties: {
																	failoverCriteria: {
																		description: "A complex data type that includes information about the failover criteria for an origin group, including the status codes for which CloudFront will failover from the primary origin to the second origin."

																		properties: statusCodes: {
																			description: "A complex data type for the status codes that you specify that, when returned by a primary origin, trigger CloudFront to failover to a second origin."

																			properties: items: {
																				description: "List of status codes for origin failover."

																				items: {
																					format: "int64"
																					type:   "integer"
																				}
																				type: "array"
																			}
																			type: "object"
																		}
																		type: "object"
																	}
																	id: type: "string"
																	members: {
																		description: "A complex data type for the origins included in an origin group."

																		properties: {
																			items: {
																				description: "List of origins in an origin group."

																				items: {
																					properties: originID: type: "string"
																					type: "object"
																				}
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
															type: "array"
														}
														type: "object"
													}
													origins: {
														description: "Contains information about the origins for this distribution."

														properties: items: {
															items: {
																properties: {
																	connectionAttempts: {
																		format: "int64"
																		type:   "integer"
																	}
																	connectionTimeout: {
																		format: "int64"
																		type:   "integer"
																	}
																	customHeaders: {
																		description: "A complex type that contains the list of Custom Headers for each origin."

																		properties: items: {
																			items: {
																				properties: {
																					headerName: type: "string"
																					headerValue: type: "string"
																				}
																				type: "object"
																			}
																			type: "array"
																		}
																		type: "object"
																	}
																	customOriginConfig: {
																		description: "A custom origin. A custom origin is any origin that is not an Amazon S3 bucket, with one exception. An Amazon S3 bucket that is configured with static website hosting (https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) is a custom origin."

																		properties: {
																			httpPort: {
																				format: "int64"
																				type:   "integer"
																			}
																			httpSPort: {
																				format: "int64"
																				type:   "integer"
																			}
																			originKeepaliveTimeout: {
																				format: "int64"
																				type:   "integer"
																			}
																			originProtocolPolicy: type: "string"
																			originReadTimeout: {
																				format: "int64"
																				type:   "integer"
																			}
																			originSSLProtocols: {
																				description: "A complex type that contains information about the SSL/TLS protocols that CloudFront can use when establishing an HTTPS connection with your origin."

																				properties: items: {
																					items: type: "string"
																					type: "array"
																				}
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	domainName: type: "string"
																	id: type: "string"
																	originPath: type: "string"
																	originShield: {
																		description: """
		CloudFront Origin Shield. 
		 Using Origin Shield can help reduce the load on your origin. For more information, see Using Origin Shield (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/origin-shield.html) in the Amazon CloudFront Developer Guide.
		"""

																		properties: {
																			enabled: type: "boolean"
																			originShieldRegion: type: "string"
																		}
																		type: "object"
																	}
																	s3OriginConfig: {
																		description: "A complex type that contains information about the Amazon S3 origin. If the origin is a custom origin or an S3 bucket that is configured as a website endpoint, use the CustomOriginConfig element instead."

																		properties: originAccessIdentity: type: "string"
																		type: "object"
																	}
																}
																type: "object"
															}
															type: "array"
														}
														type: "object"
													}
													priceClass: type: "string"
													restrictions: {
														description: "A complex type that identifies ways in which you want to restrict distribution of your content."

														properties: geoRestriction: {
															description: "A complex type that controls the countries in which your content is distributed. CloudFront determines the location of your users using MaxMind GeoIP databases."

															properties: {
																items: {
																	items: type: "string"
																	type: "array"
																}
																restrictionType: type: "string"
															}
															type: "object"
														}
														type: "object"
													}
													viewerCertificate: {
														description: """
		A complex type that determines the distribution’s SSL/TLS configuration for communicating with viewers. 
		 If the distribution doesn’t use Aliases (also known as alternate domain names or CNAMEs)—that is, if the distribution uses the CloudFront domain name such as d111111abcdef8.cloudfront.net—set CloudFrontDefaultCertificate to true and leave all other fields empty. 
		 If the distribution uses Aliases (alternate domain names or CNAMEs), use the fields in this type to specify the following settings: 
		 * Which viewers the distribution accepts HTTPS connections from: only viewers that support server name indication (SNI) (https://en.wikipedia.org/wiki/Server_Name_Indication) (recommended), or all viewers including those that don’t support SNI. To accept HTTPS connections from only viewers that support SNI, set SSLSupportMethod to sni-only. This is recommended. Most browsers and clients support SNI. To accept HTTPS connections from all viewers, including those that don’t support SNI, set SSLSupportMethod to vip. This is not recommended, and results in additional monthly charges from CloudFront. 
		 * The minimum SSL/TLS protocol version that the distribution can use to communicate with viewers. To specify a minimum version, choose a value for MinimumProtocolVersion. For more information, see Security Policy (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValues-security-policy) in the Amazon CloudFront Developer Guide. 
		 * The location of the SSL/TLS certificate, Certificate Manager (ACM) (https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html) (recommended) or Identity and Access Management (IAM) (https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html). You specify the location by setting a value in one of the following fields (not both): ACMCertificateArn IAMCertificateId 
		 All distributions support HTTPS connections from viewers. To require viewers to use HTTPS only, or to redirect them from HTTP to HTTPS, use ViewerProtocolPolicy in the CacheBehavior or DefaultCacheBehavior. To specify how CloudFront should use SSL/TLS to communicate with your custom origin, use CustomOriginConfig. 
		 For more information, see Using HTTPS with CloudFront (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-https.html) and Using Alternate Domain Names and HTTPS (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-https-alternate-domain-names.html) in the Amazon CloudFront Developer Guide.
		"""

														properties: {
																aCMCertificateARN: type: "string", certificate: type: "string", certificateSource: type: "string", cloudFrontDefaultCertificate: type: "boolean", iamCertificateID: type: "string", minimumProtocolVersion: type: "string", sslSupportMethod: type: "string"
															}, type:
																"object"
														}, webACLID: type:
															"string"
												}, type: "object"
											}
											domainName: type: "string"
											id: type: "string"
											inProgressInvalidationBatches: {
												format:
													"int64", type: "integer"
											}
											lastModifiedTime: {
												format:
													"date-time", type: "string"
											}
											status: type: "string"
										}
										type: "object"
									}
									eTag: {
										description:
											"The current version of the distribution created.", type: "string"
									}
									location: {
										description:
											"The fully qualified URI of the new distribution resource just created."
										type: "string"
									}
								}
								type: "object"
							}
							conditions: {
								description: "Conditions of the resource."
								items: {
									description:
										"A Condition that may apply to a resource.", properties: {
										lastTransitionTime: {
											description:
												"LastTransitionTime is the last time this condition transitioned from one status to another."
											format: "date-time"
											type:   "string"
										}
										message: {
											description:
												"A Message containing details about this condition's last transition from one status to another, if any."
											type: "string"
										}
										reason: {
											description:
												"A Reason for this condition's last transition from one status to another."
											type: "string"
										}
										status: {
											description:
												"Status of this condition; is it currently True, False, or Unknown?"
											type: "string"
										}
										type: {
											description:
												"Type of this condition. At most one of each condition type may apply to a resource at any point in time."
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
			served:
				true, storage: true
			subresources: status: {}
		}]
	}
	status: {acceptedNames: {
		kind:
			""
		plural: ""
	}, conditions: []
		storedVersions: []
	}
}
