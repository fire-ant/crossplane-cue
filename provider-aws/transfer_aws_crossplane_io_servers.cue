package transfer_aws_crossplane_io_servers

customresourcedefinition: "servers.transfer.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "servers.transfer.aws.crossplane.io"
	}
	spec: {
		group: "transfer.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Server"
			listKind: "ServerList"
			plural:   "servers"
			singular: "server"
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
				description: "Server is the Schema for the Servers API"
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
						description: "ServerSpec defines the desired state of Server"
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
								description: "ServerParameters defines the desired state of Server"
								properties: {
									certificate: {
										description: """
		The Amazon Resource Name (ARN) of the AWS Certificate Manager (ACM) certificate. Required when Protocols is set to FTPS. 
		 To request a new public certificate, see Request a public certificate (https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-public.html) in the AWS Certificate Manager User Guide. 
		 To import an existing certificate into ACM, see Importing certificates into ACM (https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html) in the AWS Certificate Manager User Guide. 
		 To request a private certificate to use FTPS through private IP addresses, see Request a private certificate (https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-private.html) in the AWS Certificate Manager User Guide. 
		 Certificates with the following cryptographic algorithms and key sizes are supported: 
		 * 2048-bit RSA (RSA_2048) 
		 * 4096-bit RSA (RSA_4096) 
		 * Elliptic Prime Curve 256 bit (EC_prime256v1) 
		 * Elliptic Prime Curve 384 bit (EC_secp384r1) 
		 * Elliptic Prime Curve 521 bit (EC_secp521r1) 
		 The certificate must be a valid SSL/TLS X.509 version 3 certificate with FQDN or IP address specified and information about the issuer.
		"""

										type: "string"
									}
									certificateRef: {
										description: "CertificateRef is a reference to a Certificate."
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
									certificateSelector: {
										description: "CertificateSelector selects references to a Certificate."
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
									domain: {
										description: """
		The domain of the storage system that is used for file transfers. There are two domains available: Amazon Simple Storage Service (Amazon S3) and Amazon Elastic File System (Amazon EFS). The default value is S3. 
		 After the server is created, the domain cannot be changed.
		"""

										type: "string"
									}
									endpointDetails: {
										description: "The virtual private cloud (VPC) endpoint settings that are configured for your server. When you host your endpoint within your VPC, you can make it accessible only to resources within your VPC, or you can attach Elastic IPs and make it accessible to clients over the internet. Your VPC's default security groups are automatically assigned to your endpoint."

										properties: {
											addressAllocationIDRefs: {
												description: "AddressAllocationIDRefs is a list of references to AddressAllocationID used to set the AddressAllocationIDs."

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
													required: [
														"name",
													]
													type: "object"
												}
												type: "array"
											}
											addressAllocationIDSelector: {
												description: "AddressAllocationIDSelector selects references to AddressAllocationID used to set the AddressAllocationIDs."

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
											addressAllocationIDs: {
												description: """
		A list of address allocation IDs that are required to attach an Elastic IP address to your server's endpoint. 
		 This property can only be set when EndpointType is set to VPC and it is only valid in the UpdateServer API.
		"""

												items: type: "string"
												type: "array"
											}
											securityGroupIDRefs: {
												description: "SecurityGroupIDRefs is a list of references to SecurityGroups used to set the SecurityGroupIDs."

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
													required: [
														"name",
													]
													type: "object"
												}
												type: "array"
											}
											securityGroupIDSelector: {
												description: "SecurityGroupIDsSelector selects references to SecurityGroupID used to set the SecurityGroupIDs."

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
											securityGroupIDs: {
												description: """
		A list of security groups IDs that are available to attach to your server's endpoint. 
		 This property can only be set when EndpointType is set to VPC. 
		 You can edit the SecurityGroupIds property in the UpdateServer (https://docs.aws.amazon.com/transfer/latest/userguide/API_UpdateServer.html) API only if you are changing the EndpointType from PUBLIC or VPC_ENDPOINT to VPC. To change security groups associated with your server's VPC endpoint after creation, use the Amazon EC2 ModifyVpcEndpoint (https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyVpcEndpoint.html) API.
		"""

												items: type: "string"
												type: "array"
											}
											subnetIDRefs: {
												description: "SubnetIDRefs is a list of references to Subnets used to set the SubnetIDs."

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
													required: [
														"name",
													]
													type: "object"
												}
												type: "array"
											}
											subnetIDSelector: {
												description: "SubnetIDSelector selects references to Subnets used to set the SubnetIds."

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
											subnetIDs: {
												description: """
		A list of subnet IDs that are required to host your server endpoint in your VPC. 
		 This property can only be set when EndpointType is set to VPC.
		"""

												items: type: "string"
												type: "array"
											}
											vpcEndpointID: {
												description: """
		The ID of the VPC endpoint. 
		 This property can only be set when EndpointType is set to VPC_ENDPOINT. 
		 For more information, see https://docs.aws.amazon.com/transfer/latest/userguide/create-server-in-vpc.html#deprecate-vpc-endpoint.
		"""

												type: "string"
											}
											vpcEndpointIDRef: {
												description: "VPCEndpointIDRef is a reference to a VPCEndpointID."
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
											vpcEndpointIDSelector: {
												description: "VPCEndpointIDSelector selects references to a VPCEndpointID."

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
											vpcID: {
												description: """
		The VPC ID of the VPC in which a server's endpoint will be hosted. 
		 This property can only be set when EndpointType is set to VPC.
		"""

												type: "string"
											}
											vpcIDRef: {
												description: "VPCIDRef is a reference to a VPCID."
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
											vpcIDSelector: {
												description: "VPCIDSelector selects references to a VPCID."
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
									endpointType: {
										description: """
		The type of endpoint that you want your server to use. You can choose to make your server's endpoint publicly accessible (PUBLIC) or host it inside your VPC. With an endpoint that is hosted in a VPC, you can restrict access to your server and resources only within your VPC or choose to make it internet facing by attaching Elastic IP addresses directly to it. 
		 After May 19, 2021, you won't be able to create a server using EndpointType=VPC_ENDPOINT in your Amazon Web Services account if your account hasn't already done so before May 19, 2021. If you have already created servers with EndpointType=VPC_ENDPOINT in your Amazon Web Services account on or before May 19, 2021, you will not be affected. After this date, use EndpointType=VPC. 
		 For more information, see https://docs.aws.amazon.com/transfer/latest/userguide/create-server-in-vpc.html#deprecate-vpc-endpoint. 
		 It is recommended that you use VPC as the EndpointType. With this endpoint type, you have the option to directly associate up to three Elastic IPv4 addresses (BYO IP included) with your server's endpoint and use VPC security groups to restrict traffic by the client's public IP address. This is not possible with EndpointType set to VPC_ENDPOINT.
		"""

										type: "string"
									}
									hostKey: {
										description: """
		The RSA private key as generated by the ssh-keygen -N \"\" -m PEM -f my-new-server-key command. 
		 If you aren't planning to migrate existing users from an existing SFTP-enabled server to a new server, don't update the host key. Accidentally changing a server's host key can be disruptive. 
		 For more information, see Change the host key for your SFTP-enabled server (https://docs.aws.amazon.com/transfer/latest/userguide/edit-server-config.html#configuring-servers-change-host-key) in the Amazon Web Services Transfer Family User Guide.
		"""

										type: "string"
									}
									identityProviderDetails: {
										description: "Required when IdentityProviderType is set to AWS_DIRECTORY_SERVICE or API_GATEWAY. Accepts an array containing all of the information required to use a directory in AWS_DIRECTORY_SERVICE or invoke a customer-supplied authentication API, including the API Gateway URL. Not required when IdentityProviderType is set to SERVICE_MANAGED."

										properties: {
											directoryID: type: "string"
											function: type: "string"
											invocationRole: type: "string"
											url: type: "string"
										}
										type: "object"
									}
									identityProviderType: {
										description: """
		Specifies the mode of authentication for a server. The default value is SERVICE_MANAGED, which allows you to store and access user credentials within the Amazon Web Services Transfer Family service. 
		 Use AWS_DIRECTORY_SERVICE to provide access to Active Directory groups in Amazon Web Services Managed Active Directory or Microsoft Active Directory in your on-premises environment or in Amazon Web Services using AD Connectors. This option also requires you to provide a Directory ID using the IdentityProviderDetails parameter. 
		 Use the API_GATEWAY value to integrate with an identity provider of your choosing. The API_GATEWAY setting requires you to provide an API Gateway endpoint URL to call for authentication using the IdentityProviderDetails parameter. 
		 Use the AWS_LAMBDA value to directly use a Lambda function as your identity provider. If you choose this value, you must specify the ARN for the lambda function in the Function parameter for the IdentityProviderDetails data type.
		"""

										type: "string"
									}
									loggingRole: {
										description: "Allows the service to write your users' activity to your Amazon CloudWatch logs for monitoring and auditing purposes."

										type: "string"
									}
									loggingRoleRef: {
										description: "LoggingRoleRef is a reference to a IAM role."
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
									loggingRoleSelector: {
										description: "LoggingRoleSelector selects references to a IAM role."
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
									postAuthenticationLoginBanner: {
										description: """
		Specify a string to display when users connect to a server. This string is displayed after the user authenticates. 
		 The SFTP protocol does not support post-authentication display banners.
		"""

										type: "string"
									}
									preAuthenticationLoginBanner: {
										description: """
		Specify a string to display when users connect to a server. This string is displayed before the user authenticates. For example, the following banner displays details about using the system. 
		 This system is for the use of authorized users only. Individuals using this computer system without authority, or in excess of their authority, are subject to having all of their activities on this system monitored and recorded by system personnel.
		"""

										type: "string"
									}
									protocolDetails: {
										description: """
		The protocol settings that are configured for your server. 
		 Use the PassiveIp parameter to indicate passive mode (for FTP and FTPS protocols). Enter a single dotted-quad IPv4 address, such as the external IP address of a firewall, router, or load balancer. 
		 Use the TlsSessionResumptionMode parameter to determine whether or not your Transfer server resumes recent, negotiated sessions through a unique session ID.
		"""

										properties: {
											passiveIP: type: "string"
											tlsSessionResumptionMode: type: "string"
										}
										type: "object"
									}
									protocols: {
										description: """
		Specifies the file transfer protocol or protocols over which your file transfer protocol client can connect to your server's endpoint. The available protocols are: 
		 * SFTP (Secure Shell (SSH) File Transfer Protocol): File transfer over SSH 
		 * FTPS (File Transfer Protocol Secure): File transfer with TLS encryption 
		 * FTP (File Transfer Protocol): Unencrypted file transfer 
		 If you select FTPS, you must choose a certificate stored in Amazon Web Services Certificate Manager (ACM) which is used to identify your server when clients connect to it over FTPS. 
		 If Protocol includes either FTP or FTPS, then the EndpointType must be VPC and the IdentityProviderType must be AWS_DIRECTORY_SERVICE or API_GATEWAY. 
		 If Protocol includes FTP, then AddressAllocationIds cannot be associated. 
		 If Protocol is set only to SFTP, the EndpointType can be set to PUBLIC and the IdentityProviderType can be set to SERVICE_MANAGED.
		"""

										items: type: "string"
										type: "array"
									}
									region: {
										description: "Region is which region the Server will be created."
										type:        "string"
									}
									securityPolicyName: {
										description: "Specifies the name of the security policy that is attached to the server."

										type: "string"
									}
									tags: {
										description: "Key-value pairs that can be used to group and search for servers."

										items: {
											properties: {
												key: type: "string"
												value: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									workflowDetails: {
										description: "Specifies the workflow ID for the workflow to assign and the execution role used for executing the workflow."

										properties: onUpload: {
											items: {
												properties: {
													executionRole: type: "string"
													workflowID: type: "string"
												}
												type: "object"
											}
											type: "array"
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
						description: "ServerStatus defines the observed state of Server."
						properties: {
							atProvider: {
								description: "ServerObservation defines the observed state of Server"
								properties: serverID: {
									description: "The service-assigned ID of the server that is created."
									type:        "string"
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
