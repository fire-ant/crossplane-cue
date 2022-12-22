package aws_crossplane_io_providerconfigs

customresourcedefinition: "providerconfigs.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "providerconfigs.aws.crossplane.io"
	}
	spec: {
		group: "aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"provider",
				"aws",
			]
			kind:     "ProviderConfig"
			listKind: "ProviderConfigList"
			plural:   "providerconfigs"
			singular: "providerconfig"
		}
		scope: "Cluster"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}, {
				jsonPath: ".spec.credentialsSecretRef.name"
				name:     "SECRET-NAME"
				priority: 1
				type:     "string"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "A ProviderConfig configures how AWS controllers will connect to AWS API."

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
						description: "A ProviderConfigSpec defines the desired state of a ProviderConfig."
						properties: {
							assumeRole: {
								description: "AssumeRole defines the options for assuming an IAM role"
								properties: {
									externalID: {
										description: "ExternalID is the external ID used when assuming role."

										type: "string"
									}
									roleARN: {
										description: "AssumeRoleARN to assume with provider credentials"
										type:        "string"
									}
									tags: {
										description: "Tags is list of session tags that you want to pass. Each session tag consists of a key name and an associated value. For more information about session tags, see Tagging STS Sessions (https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html)."

										items: {
											description: "Tag is session tag that can be used to assume an IAM Role"

											properties: {
												key: {
													description: "Name of the tag. Key is a required field"
													type:        "string"
												}
												value: {
													description: "Value of the tag. Value is a required field"
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
									transitiveTagKeys: {
										description: "TransitiveTagKeys is a list of keys for session tags that you want to set as transitive. If you set a tag key as transitive, the corresponding key and value passes to subsequent sessions in a role chain. For more information, see Chaining Roles with Session Tags (https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html#id_session-tags_role-chaining)."

										items: type: "string"
										type: "array"
									}
								}
								type: "object"
							}
							assumeRoleARN: {
								description: "AssumeRoleARN to assume with provider credentials This setting will be deprecated. Use the roleARN field under assumeRole instead."

								type: "string"
							}
							assumeRoleWithWebIdentity: {
								description: "AssumeRoleWithWebIdentity defines the options for assuming an IAM role with a Web Identity"

								properties: {
									roleARN: {
										description: "AssumeRoleARN to assume with provider credentials"
										type:        "string"
									}
									roleSessionName: {
										description: "RoleSessionName is the session name, if you wish to uniquely identify this session."

										type: "string"
									}
								}
								type: "object"
							}
							credentials: {
								description: "Credentials required to authenticate to this provider."
								properties: {
									env: {
										description: "Env is a reference to an environment variable that contains credentials that must be used to connect to the provider."

										properties: name: {
											description: "Name is the name of an environment variable."
											type:        "string"
										}
										required: [
											"name",
										]
										type: "object"
									}
									fs: {
										description: "Fs is a reference to a filesystem location that contains credentials that must be used to connect to the provider."

										properties: path: {
											description: "Path is a filesystem path."
											type:        "string"
										}
										required: [
											"path",
										]
										type: "object"
									}
									secretRef: {
										description: "A SecretRef is a reference to a secret key that contains the credentials that must be used to connect to the provider."

										properties: {
											key: {
												description: "The key to select."
												type:        "string"
											}
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
											"key",
											"name",
											"namespace",
										]
										type: "object"
									}
									source: {
										description: "Source of the provider credentials."
										enum: [
											"None",
											"Secret",
											"InjectedIdentity",
											"Environment",
											"Filesystem",
										]
										type: "string"
									}
								}
								required: [
									"source",
								]
								type: "object"
							}
							endpoint: {
								description: "Endpoint is where you can override the default endpoint configuration of AWS calls made by the provider."

								properties: {
									hostnameImmutable: {
										description: """
		Specifies if the endpoint's hostname can be modified by the SDK's API client. 
		 If the hostname is mutable the SDK API clients may modify any part of the hostname based on the requirements of the API, (e.g. adding, or removing content in the hostname). Such as, Amazon S3 API client prefixing \"bucketname\" to the hostname, or changing the hostname service name component from \"s3.\" to \"s3-accesspoint.dualstack.\" for the dualstack endpoint of an S3 Accesspoint resource. 
		 Care should be taken when providing a custom endpoint for an API. If the endpoint hostname is mutable, and the client cannot modify the endpoint correctly, the operation call will most likely fail, or have undefined behavior. 
		 If hostname is immutable, the SDK API clients will not modify the hostname of the URL. This may cause the API client not to function correctly if the API requires the operation specific hostname values to be used by the client. 
		 This flag does not modify the API client's behavior if this endpoint will be used instead of Endpoint Discovery, or if the endpoint will be used to perform Endpoint Discovery. That behavior is configured via the API Client's Options. Note that this is effective only for resources that use AWS SDK v2.
		"""

										type: "boolean"
									}
									partitionId: {
										description: "The AWS partition the endpoint belongs to."
										type:        "string"
									}
									signingMethod: {
										description: "The signing method that should be used for signing the requests to the endpoint."

										type: "string"
									}
									signingName: {
										description: "The service name that should be used for signing the requests to the endpoint."

										type: "string"
									}
									signingRegion: {
										description: "The region that should be used for signing the request to the endpoint. For IAM, which doesn't have any region, us-east-1 is used to sign the requests, which is the only signing region of IAM."

										type: "string"
									}
									source: {
										description: "The source of the Endpoint. By default, this will be ServiceMetadata. When providing a custom endpoint, you should set the source as Custom. If source is not provided when providing a custom endpoint, the SDK may not perform required host mutations correctly. Source should be used along with HostnameImmutable property as per the usage requirement. Note that this is effective only for resources that use AWS SDK v2."

										enum: [
											"ServiceMetadata",
											"Custom",
										]
										type: "string"
									}
									url: {
										description: "URL lets you configure the endpoint URL to be used in SDK calls."

										properties: {
											dynamic: {
												description: "Dynamic lets you configure the behavior of endpoint URL resolver."

												properties: {
													host: {
														description: "Host is the address of the main host that the resolver will use to prepend protocol, service and region configurations. For example, the final URL for EC2 in us-east-1 looks like https://ec2.us-east-1.amazonaws.com You would need to use \"amazonaws.com\" as Host and \"https\" as protocol to have the resolver construct it."

														type: "string"
													}
													protocol: {
														description: "Protocol is the HTTP protocol that will be used in the URL. Currently, only http and https are supported."

														enum: [
															"http",
															"https",
														]
														type: "string"
													}
												}
												required: [
													"host",
													"protocol",
												]
												type: "object"
											}
											static: {
												description: "Static is the full URL you'd like the AWS SDK to use. Recommended for using tools like localstack where a single host is exposed for all services and regions."

												type: "string"
											}
											type: {
												description: "You can provide a static URL that will be used regardless of the service and region by choosing Static type. Alternatively, you can provide configuration for dynamically resolving the URL with the config you provide once you set the type as Dynamic."

												enum: [
													"Static",
													"Dynamic",
												]
												type: "string"
											}
										}
										required: [
											"type",
										]
										type: "object"
									}
								}
								required: [
									"url",
								]
								type: "object"
							}
							externalID: {
								description: "ExternalID is the external ID used when assuming role. This setting will be deprecated. Use the externalID field under assumeRole instead."

								type: "string"
							}
						}
						required: [
							"credentials",
						]
						type: "object"
					}
					status: {
						description: "A ProviderConfigStatus represents the status of a ProviderConfig."
						properties: {
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
							users: {
								description: "Users of this provider configuration."
								format:      "int64"
								type:        "integer"
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
