package secretsmanager_aws_crossplane_io_secrets

customresourcedefinition: "secrets.secretsmanager.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "secrets.secretsmanager.aws.crossplane.io"
	}
	spec: {
		group: "secretsmanager.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Secret"
			listKind: "SecretList"
			plural:   "secrets"
			singular: "secret"
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
				description: "Secret is the Schema for the Secrets API"
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
						description: "SecretSpec defines the desired state of Secret"
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
								description: "SecretParameters defines the desired state of Secret"
								properties: {
									binarySecretRef: {
										description: "BinarySecretRef points to the Kubernetes Secret whose data will be encoded as binary data to AWS. If key parameter is given, only the value of that key will be used. Otherwise, all data in the Secret will be marshalled into JSON and sent to AWS. Either StringSecretRef or BinarySecretRef must be set, but not both."

										properties: {
											key: {
												description: "Key whose value will be used. If not given, the whole map in the Secret data will be used."

												type: "string"
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
											"name",
											"namespace",
										]
										type: "object"
									}
									description: {
										description: "(Optional) Specifies a user-provided description of the secret."

										type: "string"
									}
									forceDeleteWithoutRecovery: {
										description: """
		(Optional) Specifies that the secret is to be deleted without any recovery window. You can't use both this parameter and the RecoveryWindowInDays parameter in the same API call. 
		 An asynchronous background process performs the actual deletion, so there can be a short delay before the operation completes. If you write code to delete and then immediately recreate a secret with the same name, ensure that your code includes appropriate back off and retry logic. 
		 Use this parameter with caution. This parameter causes the operation to skip the normal waiting period before the permanent deletion that AWS would normally impose with the RecoveryWindowInDays parameter. If you delete a secret with the ForceDeleteWithouRecovery parameter, then you have no opportunity to recover the secret. It is permanently lost.
		"""

										type: "boolean"
									}
									kmsKeyID: {
										description: """
		(Optional) Specifies the ARN, Key ID, or alias of the AWS KMS customer master key (CMK) to be used to encrypt the SecretString or SecretBinary values in the versions stored in this secret. 
		 You can specify any of the supported ways to identify a AWS KMS key ID. If you need to reference a CMK in a different account, you can use only the key ARN or the alias ARN. 
		 If you don't specify this value, then Secrets Manager defaults to using the AWS account's default CMK (the one named aws/secretsmanager). If a AWS KMS CMK with that name doesn't yet exist, then Secrets Manager creates it for you automatically the first time it needs to encrypt a version's SecretString or SecretBinary fields. 
		 You can use the account default CMK to encrypt and decrypt only if you call this operation using credentials from the same account that owns the secret. If the secret resides in a different account, then you must create a custom CMK and specify the ARN in this field.
		"""

										type: "string"
									}
									kmsKeyIDRef: {
										description: "KMSKeyIDRef is a reference to an kms/v1alpha1.Key used to set the KMSKeyID field."

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
									kmsKeyIDSelector: {
										description: "KMSKeyIDSelector selects references to kms/v1alpha1.Key used to set the KMSKeyID."

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
									recoveryWindowInDays: {
										description: """
		(Optional) Specifies the number of days that Secrets Manager waits before it can delete the secret. You can't use both this parameter and the ForceDeleteWithoutRecovery parameter in the same API call. 
		 This value can range from 7 to 30 days. The default value is 30.
		"""

										format: "int64"
										type:   "integer"
									}
									region: {
										description: "Region is which region the Secret will be created."
										type:        "string"
									}
									resourcePolicy: {
										description: """
		A JSON-formatted string constructed according to the grammar and syntax for an Amazon Web Services resource-based policy. The policy in the string identifies who can access or manage this secret and its versions. For information on how to format a JSON parameter for the various command line tool environments, see Using JSON for Parameters (http://docs.aws.amazon.com/cli/latest/userguide/cli-using-param.html#cli-using-param-json) in the CLI User Guide. 
		 ResourcePolicy is a required field
		"""

										type: "string"
									}
									stringSecretRef: {
										description: "StringSecretRef points to the Kubernetes Secret whose data will be sent as string to AWS. If key parameter is given, only the value of that key will be used. Otherwise, all data in the Secret will be marshalled into JSON and sent to AWS. Either StringSecretRef or BinarySecretRef must be set, but not both."

										properties: {
											key: {
												description: "Key whose value will be used. If not given, the whole map in the Secret data will be used."

												type: "string"
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
											"name",
											"namespace",
										]
										type: "object"
									}
									tags: {
										description: """
		(Optional) Specifies a list of user-defined tags that are attached to the secret. Each tag is a \"Key\" and \"Value\" pair of strings. This operation only appends tags to the existing list of tags. To remove tags, you must use UntagResource. 
		 * Secrets Manager tag key names are case sensitive. A tag with the key \"ABC\" is a different tag from one with key \"abc\". 
		 * If you check tags in IAM policy Condition elements as part of your security strategy, then adding or removing a tag can change permissions. If the successful completion of this operation would result in you losing your permissions for this secret, then this operation is blocked and returns an Access Denied error. 
		 This parameter requires a JSON text string argument. For information on how to format a JSON parameter for the various command line tool environments, see Using JSON for Parameters (https://docs.aws.amazon.com/cli/latest/userguide/cli-using-param.html#cli-using-param-json) in the AWS CLI User Guide. For example: 
		 [{\"Key\":\"CostCenter\",\"Value\":\"12345\"},{\"Key\":\"environment\",\"Value\":\"production\"}] 
		 If your command-line tool or SDK requires quotation marks around the parameter, you should use single quotes to avoid confusion with the double quotes required in the JSON text. 
		 The following basic restrictions apply to tags: 
		 * Maximum number of tags per secret—50 
		 * Maximum key length—127 Unicode characters in UTF-8 
		 * Maximum value length—255 Unicode characters in UTF-8 
		 * Tag keys and values are case sensitive. 
		 * Do not use the aws: prefix in your tag names or values because AWS reserves it for AWS use. You can't edit or delete tag names or values with this prefix. Tags with this prefix do not count against your tags per secret limit. 
		 * If you use your tagging schema across multiple services and resources, remember other services might have restrictions on allowed characters. Generally allowed characters: letters, spaces, and numbers representable in UTF-8, plus the following special characters: + - = . _ : / @.
		"""

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
								required: ["region"]
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
						description: "SecretStatus defines the observed state of Secret."
						properties: {
							atProvider: {
								description: "SecretObservation defines the observed state of Secret"
								properties: arn: {
									description: """
		The Amazon Resource Name (ARN) of the secret that you just created. 
		 Secrets Manager automatically adds several random characters to the name at the end of the ARN when you initially create a secret. This affects only the ARN and not the actual friendly name. This ensures that if you create a new secret with the same name as an old secret that you previously deleted, then users with access to the old secret don't automatically get access to the new secret because the ARNs are different.
		"""

									type: "string"
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
			}, served:
				true, storage:
				false, subresources: status: {}
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
			}], name:
				"v1beta1", schema: openAPIV3Schema: {
				description: "Secret is the Schema for the Secrets API"
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
						description: "SecretSpec defines the desired state of Secret"
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
								description: "SecretParameters defines the desired state of Secret"
								properties: {
									addReplicaRegions: {
										description: "A list of Regions and KMS keys to replicate secrets."
										items: {
											properties: {
												kmsKeyID: type: "string"
												region: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									binarySecretRef: {
										description: "BinarySecretRef points to the Kubernetes Secret whose data will be encoded as binary data to AWS. If key parameter is given, only the value of that key will be used. Otherwise, all data in the Secret will be marshalled into JSON and sent to AWS."

										properties: {
											key: {
												description: "Key whose value will be used. If not given, the whole map in the Secret data will be used."

												type: "string"
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
											"name",
											"namespace",
										]
										type: "object"
									}
									description: {
										description: "The description of the secret."
										type:        "string"
									}
									forceDeleteWithoutRecovery: {
										description: """
		(Optional) Specifies that the secret is to be deleted without any recovery window. You can't use both this parameter and the RecoveryWindowInDays parameter in the same API call. 
		 An asynchronous background process performs the actual deletion, so there can be a short delay before the operation completes. If you write code to delete and then immediately recreate a secret with the same name, ensure that your code includes appropriate back off and retry logic. 
		 Use this parameter with caution. This parameter causes the operation to skip the normal waiting period before the permanent deletion that AWS would normally impose with the RecoveryWindowInDays parameter. If you delete a secret with the ForceDeleteWithouRecovery parameter, then you have no opportunity to recover the secret. It is permanently lost.
		"""

										type: "boolean"
									}
									forceOverwriteReplicaSecret: {
										description: "Specifies whether to overwrite a secret with the same name in the destination Region."

										type: "boolean"
									}
									kmsKeyID: {
										description: """
		The ARN, key ID, or alias of the KMS key that Secrets Manager uses to encrypt the secret value in the secret. 
		 To use a KMS key in a different account, use the key ARN or the alias ARN. 
		 If you don't specify this value, then Secrets Manager uses the key aws/secretsmanager. If that key doesn't yet exist, then Secrets Manager creates it for you automatically the first time it encrypts the secret value. 
		 If the secret is in a different Amazon Web Services account from the credentials calling the API, then you can't use aws/secretsmanager to encrypt the secret, and you must create and use a customer managed KMS key.
		"""

										type: "string"
									}
									kmsKeyIDRef: {
										description: "KMSKeyIDRef is a reference to an kms/v1alpha1.Key used to set the KMSKeyID field."

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
									kmsKeyIDSelector: {
										description: "KMSKeyIDSelector selects references to kms/v1alpha1.Key used to set the KMSKeyID."

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
									recoveryWindowInDays: {
										description: """
		(Optional) Specifies the number of days that Secrets Manager waits before it can delete the secret. You can't use both this parameter and the ForceDeleteWithoutRecovery parameter in the same API call. 
		 This value can range from 7 to 30 days. The default value is 30.
		"""

										format: "int64"
										type:   "integer"
									}
									region: {
										description: "Region is which region the Secret will be created."
										type:        "string"
									}
									resourcePolicy: {
										description: """
		A JSON-formatted string constructed according to the grammar and syntax for an Amazon Web Services resource-based policy. The policy in the string identifies who can access or manage this secret and its versions. For information on how to format a JSON parameter for the various command line tool environments, see Using JSON for Parameters (http://docs.aws.amazon.com/cli/latest/userguide/cli-using-param.html#cli-using-param-json) in the CLI User Guide. 
		 ResourcePolicy is a required field
		"""

										type: "string"
									}
									stringSecretRef: {
										description: "StringSecretRef points to the Kubernetes Secret whose data will be sent as string to AWS. If key parameter is given, only the value of that key will be used. Otherwise, all data in the Secret will be marshalled into JSON and sent to AWS."

										properties: {
											key: {
												description: "Key whose value will be used. If not given, the whole map in the Secret data will be used."

												type: "string"
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
											"name",
											"namespace",
										]
										type: "object"
									}
									tags: {
										description: """
		A list of tags to attach to the secret. Each tag is a key and value pair of strings in a JSON text string, for example: 
		 [{\"Key\":\"CostCenter\",\"Value\":\"12345\"},{\"Key\":\"environment\",\"Value\":\"production\"}] 
		 Secrets Manager tag key names are case sensitive. A tag with the key \"ABC\" is a different tag from one with key \"abc\". 
		 If you check tags in permissions policies as part of your security strategy, then adding or removing a tag can change permissions. If the completion of this operation would result in you losing your permissions for this secret, then Secrets Manager blocks the operation and returns an Access Denied error. For more information, see Control access to secrets using tags (https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_examples.html#tag-secrets-abac) and Limit access to identities with tags that match secrets' tags (https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_examples.html#auth-and-access_tags2). 
		 For information about how to format a JSON parameter for the various command line tool environments, see Using JSON for Parameters (https://docs.aws.amazon.com/cli/latest/userguide/cli-using-param.html#cli-using-param-json). If your command-line tool or SDK requires quotation marks around the parameter, you should use single quotes to avoid confusion with the double quotes required in the JSON text. 
		 The following restrictions apply to tags: 
		 * Maximum number of tags per secret: 50 
		 * Maximum key length: 127 Unicode characters in UTF-8 
		 * Maximum value length: 255 Unicode characters in UTF-8 
		 * Tag keys and values are case sensitive. 
		 * Do not use the aws: prefix in your tag names or values because Amazon Web Services reserves it for Amazon Web Services use. You can't edit or delete tag names or values with this prefix. Tags with this prefix do not count against your tags per secret limit. 
		 * If you use your tagging schema across multiple services and resources, other services might have restrictions on allowed characters. Generally allowed characters: letters, spaces, and numbers representable in UTF-8, plus the following special characters: + - = . _ : / @.
		"""

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
								required: ["region"]
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
						description: "SecretStatus defines the observed state of Secret."
						properties: {
							atProvider: {
								description: "SecretObservation defines the observed state of Secret"
								properties: {
									arn: {
										description: "The ARN of the new secret. The ARN includes the name of the secret followed by six random characters. This ensures that if you create a new secret with the same name as a deleted secret, then users with access to the old secret don't get access to the new secret because the ARNs are different."

										type: "string"
									}
									replicationStatus: {
										description: """
		A list of the replicas of this secret and their status: 
		 * Failed, which indicates that the replica was not created. 
		 * InProgress, which indicates that Secrets Manager is in the process of creating the replica. 
		 * InSync, which indicates that the replica was created.
		"""

										items: {
											properties: {
												kmsKeyID: type: "string"
												lastAccessedDate: {
													format: "date-time"
													type:   "string"
												}
												region: type: "string"
												status: type: "string"
												statusMessage: type: "string"
											}
											type: "object"
										}
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
			}, served:
				true, storage:
				true, subresources: status: {}
		}]
	}, status: {
		acceptedNames: {
			kind:
				"", plural:
				""
		}, conditions: [], storedVersions: []
	}
}
