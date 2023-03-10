package cognitoidentityprovider_aws_crossplane_io_userpoolclients

customresourcedefinition: "userpoolclients.cognitoidentityprovider.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "userpoolclients.cognitoidentityprovider.aws.crossplane.io"
	}
	spec: {
		group: "cognitoidentityprovider.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "UserPoolClient"
			listKind: "UserPoolClientList"
			plural:   "userpoolclients"
			singular: "userpoolclient"
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
				description: "UserPoolClient is the Schema for the UserPoolClients API"
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
						description: "UserPoolClientSpec defines the desired state of UserPoolClient"
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
								description: "UserPoolClientParameters defines the desired state of UserPoolClient"

								properties: {
									accessTokenValidity: {
										description: "The time limit, between 5 minutes and 1 day, after which the access token is no longer valid and can't be used. If you supply a TokenValidityUnits value, you will override the default time unit."

										format: "int64"
										type:   "integer"
									}
									allowedOAuthFlows: {
										description: """
		The allowed OAuth flows. 
		 Set to code to initiate a code grant flow, which provides an authorization code as the response. This code can be exchanged for access tokens with the token endpoint. 
		 Set to implicit to specify that the client should get the access token (and, optionally, ID token, based on scopes) directly. 
		 Set to client_credentials to specify that the client should get the access token (and, optionally, ID token, based on scopes) from the token endpoint using a combination of client and client_secret.
		"""

										items: type: "string"
										type: "array"
									}
									allowedOAuthFlowsUserPoolClient: {
										description: "Set to true if the client is allowed to follow the OAuth protocol when interacting with Amazon Cognito user pools."

										type: "boolean"
									}
									allowedOAuthScopes: {
										description: "The allowed OAuth scopes. Possible values provided by OAuth are: phone, email, openid, and profile. Possible values provided by Amazon Web Services are: aws.cognito.signin.user.admin. Custom scopes created in Resource Servers are also supported."

										items: type: "string"
										type: "array"
									}
									analyticsConfiguration: {
										description: """
		The user pool analytics configuration for collecting metrics and sending them to your Amazon Pinpoint campaign. 
		 In Amazon Web Services Regions where Amazon Pinpoint isn't available, user pools only support sending events to Amazon Pinpoint projects in Amazon Web Services Region us-east-1. In Regions where Amazon Pinpoint is available, user pools support sending events to Amazon Pinpoint projects within that same Region.
		"""

										properties: {
											applicationARN: type: "string"
											applicationID: type: "string"
											externalID: type: "string"
											roleARN: type: "string"
											userDataShared: type: "boolean"
										}
										type: "object"
									}
									callbackURLs: {
										description: """
		A list of allowed redirect (callback) URLs for the identity providers. 
		 A redirect URI must: 
		 * Be an absolute URI. 
		 * Be registered with the authorization server. 
		 * Not include a fragment component. 
		 See OAuth 2.0 - Redirection Endpoint (https://tools.ietf.org/html/rfc6749#section-3.1.2). 
		 Amazon Cognito requires HTTPS over HTTP except for http://localhost for testing purposes only. 
		 App callback URLs such as myapp://example are also supported.
		"""

										items: type: "string"
										type: "array"
									}
									clientName: {
										description: "The client name for the user pool client you would like to create."

										type: "string"
									}
									defaultRedirectURI: {
										description: """
		The default redirect URI. Must be in the CallbackURLs list. 
		 A redirect URI must: 
		 * Be an absolute URI. 
		 * Be registered with the authorization server. 
		 * Not include a fragment component. 
		 See OAuth 2.0 - Redirection Endpoint (https://tools.ietf.org/html/rfc6749#section-3.1.2). 
		 Amazon Cognito requires HTTPS over HTTP except for http://localhost for testing purposes only. 
		 App callback URLs such as myapp://example are also supported.
		"""

										type: "string"
									}
									enableTokenRevocation: {
										description: """
		Activates or deactivates token revocation. For more information about revoking tokens, see RevokeToken (https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_RevokeToken.html). 
		 If you don't include this parameter, token revocation is automatically activated for the new user pool client.
		"""

										type: "boolean"
									}
									explicitAuthFlows: {
										description: """
		The authentication flows that are supported by the user pool clients. Flow names without the ALLOW_ prefix are no longer supported, in favor of new names with the ALLOW_ prefix. 
		 Values with ALLOW_ prefix must be used only along with the ALLOW_ prefix. 
		 Valid values include: 
		 * ALLOW_ADMIN_USER_PASSWORD_AUTH: Enable admin based user password authentication flow ADMIN_USER_PASSWORD_AUTH. This setting replaces the ADMIN_NO_SRP_AUTH setting. With this authentication flow, Amazon Cognito receives the password in the request instead of using the Secure Remote Password (SRP) protocol to verify passwords. 
		 * ALLOW_CUSTOM_AUTH: Enable Lambda trigger based authentication. 
		 * ALLOW_USER_PASSWORD_AUTH: Enable user password-based authentication. In this flow, Amazon Cognito receives the password in the request instead of using the SRP protocol to verify passwords. 
		 * ALLOW_USER_SRP_AUTH: Enable SRP-based authentication. 
		 * ALLOW_REFRESH_TOKEN_AUTH: Enable authflow to refresh tokens.
		"""

										items: type: "string"
										type: "array"
									}
									generateSecret: {
										description: "Boolean to specify whether you want to generate a secret for the user pool client being created."

										type: "boolean"
									}
									idTokenValidity: {
										description: "The time limit, between 5 minutes and 1 day, after which the access token is no longer valid and can't be used. If you supply a TokenValidityUnits value, you will override the default time unit."

										format: "int64"
										type:   "integer"
									}
									logoutURLs: {
										description: "A list of allowed logout URLs for the identity providers."
										items: type: "string"
										type: "array"
									}
									preventUserExistenceErrors: {
										description: """
		Errors and responses that you want Amazon Cognito APIs to return during authentication, account confirmation, and password recovery when the user doesn't exist in the user pool. When set to ENABLED and the user doesn't exist, authentication returns an error indicating either the username or password was incorrect. Account confirmation and password recovery return a response indicating a code was sent to a simulated destination. When set to LEGACY, those APIs return a UserNotFoundException exception if the user doesn't exist in the user pool. 
		 Valid values include: 
		 * ENABLED - This prevents user existence-related errors. 
		 * LEGACY - This represents the early behavior of Amazon Cognito where user existence related errors aren't prevented.
		"""

										type: "string"
									}
									readAttributes: {
										description: "The read attributes."
										items: type: "string"
										type: "array"
									}
									refreshTokenValidity: {
										description: "The time limit, in days, after which the refresh token is no longer valid and can't be used."

										format: "int64"
										type:   "integer"
									}
									region: {
										description: "Region is which region the UserPoolClient will be created."

										type: "string"
									}
									supportedIdentityProviders: {
										description: "A list of provider names for the identity providers that are supported on this client. The following are supported: COGNITO, Facebook, Google and LoginWithAmazon."

										items: type: "string"
										type: "array"
									}
									tokenValidityUnits: {
										description: "The units in which the validity times are represented. Default for RefreshToken is days, and default for ID and access tokens are hours."

										properties: {
											accessToken: type: "string"
											idToken: type: "string"
											refreshToken: type: "string"
										}
										type: "object"
									}
									userPoolId: {
										description: "The user pool ID."
										type:        "string"
									}
									userPoolIdRef: {
										description: "UserPoolIDRef is a reference to an server instance."
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
									userPoolIdSelector: {
										description: "UserPoolIDSelector selects references to an server instance."

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
									writeAttributes: {
										description: """
		The user pool attributes that the app client can write to. 
		 If your app client allows users to sign in through an identity provider, this array must include all attributes that you have mapped to identity provider attributes. Amazon Cognito updates mapped attributes when users sign in to your application through an identity provider. If your app client does not have write access to a mapped attribute, Amazon Cognito throws an error when it tries to update the attribute. For more information, see Specifying Identity Provider Attribute Mappings for Your user pool (https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-specifying-attribute-mapping.html).
		"""

										items: type: "string"
										type: "array"
									}
								}
								required: [
									"clientName",
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
						description: "UserPoolClientStatus defines the observed state of UserPoolClient."
						properties: {
							atProvider: {
								description: "UserPoolClientObservation defines the observed state of UserPoolClient"

								properties: {
									clientID: {
										description: "The ID of the client associated with the user pool."
										type:        "string"
									}
									clientSecret: {
										description: "The client secret from the user pool request of the client type."

										type: "string"
									}
									creationDate: {
										description: "The date the user pool client was created."
										format:      "date-time"
										type:        "string"
									}
									lastModifiedDate: {
										description: "The date the user pool client was last modified."
										format:      "date-time"
										type:        "string"
									}
									userPoolID: {
										description: "The user pool ID for the user pool client."
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
