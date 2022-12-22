package cognitoidentityprovider_aws_crossplane_io_userpools

customresourcedefinition: "userpools.cognitoidentityprovider.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "userpools.cognitoidentityprovider.aws.crossplane.io"
	}
	spec: {
		group: "cognitoidentityprovider.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "UserPool"
			listKind: "UserPoolList"
			plural:   "userpools"
			singular: "userpool"
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
				description: "UserPool is the Schema for the UserPools API"
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
						description: "UserPoolSpec defines the desired state of UserPool"
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
								description: "UserPoolParameters defines the desired state of UserPool"
								properties: {
									accountRecoverySetting: {
										description: "The available verified method a user can use to recover their password when they call ForgotPassword. You can use this setting to define a preferred method when a user has more than one method available. With this setting, SMS doesn't qualify for a valid password recovery mechanism if the user also has SMS multi-factor authentication (MFA) activated. In the absence of this setting, Amazon Cognito uses the legacy behavior to determine the recovery method where SMS is preferred through email."

										properties: recoveryMechanisms: {
											items: {
												properties: {
													name: type: "string"
													priority: {
														format: "int64"
														type:   "integer"
													}
												}
												type: "object"
											}
											type: "array"
										}
										type: "object"
									}
									adminCreateUserConfig: {
										description: "The configuration for AdminCreateUser requests."
										properties: {
											allowAdminCreateUserOnly: type: "boolean"
											inviteMessageTemplate: {
												description: "The message template structure."
												properties: {
													emailMessage: type: "string"
													emailSubject: type: "string"
													sMSMessage: type: "string"
												}
												type: "object"
											}
										}
										type: "object"
									}
									aliasAttributes: {
										description: "Attributes supported as an alias for this user pool. Possible values: phone_number, email, or preferred_username."

										items: type: "string"
										type: "array"
									}
									autoVerifiedAttributes: {
										description: "The attributes to be auto-verified. Possible values: email, phone_number."

										items: type: "string"
										type: "array"
									}
									deviceConfiguration: {
										description: "The device configuration."
										properties: {
											challengeRequiredOnNewDevice: type: "boolean"
											deviceOnlyRememberedOnUserPrompt: type: "boolean"
										}
										type: "object"
									}
									emailConfiguration: {
										description: "The email configuration of your user pool. The email configuration type sets your preferred sending method, Amazon Web Services Region, and sender for messages from your user pool."

										properties: {
											configurationSet: type: "string"
											emailSendingAccount: type: "string"
											from: type: "string"
											replyToEmailAddress: type: "string"
											sourceARN: type: "string"
										}
										type: "object"
									}
									emailVerificationMessage: {
										description: "A string representing the email verification message. EmailVerificationMessage is allowed only if EmailSendingAccount (https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is DEVELOPER."

										type: "string"
									}
									emailVerificationSubject: {
										description: "A string representing the email verification subject. EmailVerificationSubject is allowed only if EmailSendingAccount (https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount) is DEVELOPER."

										type: "string"
									}
									lambdaConfig: {
										description: """
		The Lambda trigger configuration information for the new user pool. 
		 In a push model, event sources (such as Amazon S3 and custom applications) need permission to invoke a function. So you must make an extra call to add permission for these event sources to invoke your Lambda function. 
		 For more information on using the Lambda API to add permission, see AddPermission (https://docs.aws.amazon.com/lambda/latest/dg/API_AddPermission.html). 
		 For adding permission using the CLI, see add-permission (https://docs.aws.amazon.com/cli/latest/reference/lambda/add-permission.html).
		"""

										properties: {
											createAuthChallenge: type: "string"
											customEmailSender: {
												description: "A custom email sender Lambda configuration type."
												properties: {
													lambdaARN: type: "string"
													lambdaVersion: type: "string"
												}
												type: "object"
											}
											customMessage: type: "string"
											customSMSSender: {
												description: "A custom SMS sender Lambda configuration type."
												properties: {
													lambdaARN: type: "string"
													lambdaVersion: type: "string"
												}
												type: "object"
											}
											defineAuthChallenge: type: "string"
											kmsKeyID: type: "string"
											postAuthentication: type: "string"
											postConfirmation: type: "string"
											preAuthentication: type: "string"
											preSignUp: type: "string"
											preTokenGeneration: type: "string"
											userMigration: type: "string"
											verifyAuthChallengeResponse: type: "string"
										}
										type: "object"
									}
									mfaConfiguration: {
										description: "Specifies MFA configuration details."
										type:        "string"
									}
									policies: {
										description: "The policies associated with the new user pool."
										properties: passwordPolicy: {
											description: "The password policy type."
											properties: {
												minimumLength: {
													format: "int64"
													type:   "integer"
												}
												requireLowercase: type: "boolean"
												requireNumbers: type: "boolean"
												requireSymbols: type: "boolean"
												requireUppercase: type: "boolean"
												temporaryPasswordValidityDays: {
													format: "int64"
													type:   "integer"
												}
											}
											type: "object"
										}
										type: "object"
									}
									poolName: {
										description: "A string used to name the user pool."
										type:        "string"
									}
									region: {
										description: "Region is which region the UserPool will be created."
										type:        "string"
									}
									schema: {
										description: "An array of schema attributes for the new user pool. These attributes can be standard or custom attributes."

										items: {
											properties: {
												attributeDataType: type: "string"
												developerOnlyAttribute: type: "boolean"
												mutable: type: "boolean"
												name: type: "string"
												numberAttributeConstraints: {
													description: "The minimum and maximum values of an attribute that is of the number data type."

													properties: {
														maxValue: type: "string"
														minValue: type: "string"
													}
													type: "object"
												}
												required: type: "boolean"
												stringAttributeConstraints: {
													description: "The constraints associated with a string attribute."
													properties: {
														maxLength: type: "string"
														minLength: type: "string"
													}
													type: "object"
												}
											}
											type: "object"
										}
										type: "array"
									}
									smsAuthenticationMessage: {
										description: "A string representing the SMS authentication message."
										type:        "string"
									}
									smsConfiguration: {
										description: "The SMS configuration with the settings that your Amazon Cognito user pool must use to send an SMS message from your Amazon Web Services account through Amazon Simple Notification Service. To send SMS messages with Amazon SNS in the Amazon Web Services Region that you want, the Amazon Cognito user pool uses an Identity and Access Management (IAM) role in your Amazon Web Services account."

										properties: {
											externalID: type: "string"
											snsCallerARN: type: "string"
											snsRegion: type: "string"
										}
										type: "object"
									}
									smsVerificationMessage: {
										description: "A string representing the SMS verification message."
										type:        "string"
									}
									softwareTokenMFAConfiguration: {
										description: "The software token MFA configuration."
										properties: enabled: type: "boolean"
										type: "object"
									}
									userPoolAddOns: {
										description: "Enables advanced security risk detection. Set the key AdvancedSecurityMode to the value \"AUDIT\"."

										properties: advancedSecurityMode: type: "string"
										type: "object"
									}
									userPoolTags: {
										additionalProperties: type: "string"
										description: "The tag keys and values to assign to the user pool. A tag is a label that you can use to categorize and manage user pools in different ways, such as by purpose, owner, environment, or other criteria."

										type: "object"
									}
									usernameAttributes: {
										description: "Specifies whether a user can use an email address or phone number as a username when they sign up."

										items: type: "string"
										type: "array"
									}
									usernameConfiguration: {
										description: "Case sensitivity on the username input for the selected sign-in option. For example, when case sensitivity is set to False, users can sign in using either \"username\" or \"Username\". This configuration is immutable once it has been set. For more information, see UsernameConfigurationType (https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_UsernameConfigurationType.html)."

										properties: caseSensitive: type: "boolean"
										type: "object"
									}
									verificationMessageTemplate: {
										description: "The template for the verification message that the user sees when the app requests permission to access the user's information."

										properties: {
											defaultEmailOption: type: "string"
											emailMessage: type: "string"
											emailMessageByLink: type: "string"
											emailSubject: type: "string"
											emailSubjectByLink: type: "string"
											smsMessage: type: "string"
										}
										type: "object"
									}
								}
								required: [
									"poolName",
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
						description: "UserPoolStatus defines the observed state of UserPool."
						properties: {
							atProvider: {
								description: "UserPoolObservation defines the observed state of UserPool"
								properties: {
									arn: {
										description: "The Amazon Resource Name (ARN) for the user pool."
										type:        "string"
									}
									creationDate: {
										description: "The date the user pool was created."
										format:      "date-time"
										type:        "string"
									}
									customDomain: {
										description: """
		A custom domain name that you provide to Amazon Cognito. This parameter applies only if you use a custom domain to host the sign-up and sign-in pages for your application. An example of a custom domain name might be auth.example.com. 
		 For more information about adding a custom domain to your user pool, see Using Your Own Domain for the Hosted UI (https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-add-custom-domain.html).
		"""

										type: "string"
									}
									domain: {
										description: "The domain prefix, if the user pool has a domain associated with it."

										type: "string"
									}
									emailConfigurationFailure: {
										description: "Deprecated. Review error codes from API requests with EventSource:cognito-idp.amazonaws.com in CloudTrail for information about problems with user pool email configuration."

										type: "string"
									}
									estimatedNumberOfUsers: {
										description: "A number estimating the size of the user pool."
										format:      "int64"
										type:        "integer"
									}
									id: {
										description: "The ID of the user pool."
										type:        "string"
									}
									lastModifiedDate: {
										description: "The date the user pool was last modified."
										format:      "date-time"
										type:        "string"
									}
									name: {
										description: "The name of the user pool."
										type:        "string"
									}
									schemaAttributes: {
										description: "A container with the schema attributes of a user pool."

										items: {
											properties: {
												attributeDataType: type: "string"
												developerOnlyAttribute: type: "boolean"
												mutable: type: "boolean"
												name: type: "string"
												numberAttributeConstraints: {
													description: "The minimum and maximum values of an attribute that is of the number data type."

													properties: {
														maxValue: type: "string"
														minValue: type: "string"
													}
													type: "object"
												}
												required: type: "boolean"
												stringAttributeConstraints: {
													description: "The constraints associated with a string attribute."
													properties: {
														maxLength: type: "string"
														minLength: type: "string"
													}
													type: "object"
												}
											}
											type: "object"
										}
										type: "array"
									}
									smsConfigurationFailure: {
										description: """
		The reason why the SMS configuration can't send the messages to your users. 
		 This message might include comma-separated values to describe why your SMS configuration can't send messages to user pool end users. 
		 InvalidSmsRoleAccessPolicyException 
		 The Identity and Access Management role that Amazon Cognito uses to send SMS messages isn't properly configured. For more information, see SmsConfigurationType (https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_SmsConfigurationType.html). 
		 SNSSandbox 
		 The Amazon Web Services account is in the SNS SMS Sandbox and messages will only reach verified end users. This parameter won’t get populated with SNSSandbox if the IAM user creating the user pool doesn’t have SNS permissions. To learn how to move your Amazon Web Services account out of the sandbox, see Moving out of the SMS sandbox (https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox-moving-to-production.html).
		"""

										type: "string"
									}
									status: {
										description: "The status of a user pool."
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
		}, conditions: [], storedVersions: []
	}
}
