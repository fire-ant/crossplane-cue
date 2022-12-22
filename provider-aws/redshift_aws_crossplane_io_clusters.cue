package redshift_aws_crossplane_io_clusters

customresourcedefinition: "clusters.redshift.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "clusters.redshift.aws.crossplane.io"
	}
	spec: {
		group: "redshift.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Cluster"
			listKind: "ClusterList"
			plural:   "clusters"
			singular: "cluster"
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
				jsonPath: ".status.atProvider.clusterStatus"
				name:     "STATE"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "A Cluster is a managed resource that represents an AWS Redshift cluster."

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
						description: "ClusterSpec defines the desired state of an AWS Redshift Cluster."

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
								description: "ClusterParameters define the parameters available for an AWS Redshift cluster"

								properties: {
									allowVersionUpgrade: {
										description: "AllowVersionUpgrade indicates that major engine upgrades are applied automatically to the cluster during the maintenance window. default=true"

										type: "boolean"
									}
									automatedSnapshotRetentionPeriod: {
										description: "AutomatedSnapshotRetentionPeriod is the number of days for which automated backups are retained. Setting this parameter to a positive number enables backups. Setting this parameter to  0 disables automated backups. default=1"

										format:  "int32"
										maximum: 35
										minimum: 0
										type:    "integer"
									}
									availabilityZone: {
										description: "AvailabilityZone is the EC2 Availability Zone in which you want Amazon Redshift to provision the cluster. Default: A random, system-chosen Availability Zone in the region that is specified by the endpoint. Example: us-east-2d Constraint: The specified Availability Zone must be in the same region as the current endpoint. The Availability Zone parameter can't be specified if the MultiAZ parameter is set to true. The specified Availability Zone must be in the same AWS Region as the current endpoint."

										type: "string"
									}
									clusterParameterGroupName: {
										description: "ClusterParameterGroupName is the name of the cluster parameter group to use for the cluster. Default: The default Amazon Redshift cluster parameter group. For information about the default parameter group, go to Working with Amazon Redshift Parameter Groups (https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html)"

										type: "string"
									}
									clusterSecurityGroupRefs: {
										description: "ClusterSecurityGroupRefs are references to ClusterSecurityGroups used to set the ClusterSecurityGroups."

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
									clusterSecurityGroupSelector: {
										description: "ClusterSecurityGroupSelector selects references to ClusterSecurityGroups used to set the ClusterSecurityGroups."

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
									clusterSecurityGroups: {
										description: "SecurityGroups is a list of security groups to associate with this cluster. Default: The default cluster security group for Amazon Redshift."

										items: type: "string"
										type: "array"
									}
									clusterSubnetGroupName: {
										description: "ClusterSubnetGroupName is the name of a cluster subnet group to be associated with this cluster. If this parameter is not provided the resulting cluster will be deployed outside virtual private cloud (VPC)."

										type: "string"
									}
									clusterType: {
										description: "ClusterType is the type of the cluster you want. When cluster type is specified as * single-node, the NumberOfNodes parameter is not required. * multi-node, the NumberOfNodes parameter is required. default=multi-node"

										enum: [
											"multi-node",
											"single-node",
										]
										type: "string"
									}
									clusterVersion: {
										description: "ClusterVersion is the version of the Amazon Redshift engine software that you want to deploy on the cluster. The version selected runs on all the nodes in the cluster. Constraints: Only version 1.0 is currently available."

										type: "string"
									}
									dbName: {
										description: "DBName is the name of the first database to be created when the cluster is created. To create additional databases after the cluster is created, connect to the cluster with a SQL client and use SQL commands to create a database. For more information, go to Create a Database (https://docs.aws.amazon.com/redshift/latest/dg/t_creating_database.html) in the Amazon Redshift Database Developer Guide. Constraints: * Must contain 1 to 64 alphanumeric characters. * Must contain only lowercase letters. * Cannot be a word that is reserved by the service. A list of reserved words can be found in Reserved Words (https://docs.aws.amazon.com/redshift/latest/dg/r_pg_keywords.html) in the Amazon Redshift Database Developer Guide. default=dev"

										type: "string"
									}
									elasticIP: {
										description: "The Elastic IP (EIP) address for the cluster. Constraints: The cluster must be provisioned in EC2-VPC and publicly-accessible through an Internet gateway. For more information about provisioning clusters in EC2-VPC, go to Supported Platforms to Launch Your Cluster (https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#cluster-platforms) in the Amazon Redshift Cluster Management Guide."

										type: "string"
									}
									encrypted: {
										description: "Encrypted defines whether your data in the cluster will be encrypted at rest or not. default=false"

										type: "boolean"
									}
									enhancedVPCRouting: {
										description: "EnhancedVPCRouting specifies whether to create the cluster with enhanced VPC routing enabled. To create a cluster that uses enhanced VPC routing, the cluster must be in a VPC. For more information, see Enhanced VPC Routing (https://docs.aws.amazon.com/redshift/latest/mgmt/enhanced-vpc-routing.html) in the Amazon Redshift Cluster Management Guide. If this option is true, enhanced VPC routing is enabled. default=false"

										type: "boolean"
									}
									finalClusterSnapshotIdentifier: {
										description: "FinalClusterSnapshotIdentifier is the identifier of the final snapshot that is to be created immediately before deleting the cluster. If this parameter is provided, SkipFinalClusterSnapshot must be false. Constraints: * Must be 1 to 255 alphanumeric characters. * First character must be a letter. * Cannot end with a hyphen or contain two consecutive hyphens."

										type: "string"
									}
									finalClusterSnapshotRetentionPeriod: {
										description: "FinalClusterSnapshotRetentionPeriod is the number of days that a manual snapshot is retained. If the value is -1, the manual snapshot is retained indefinitely. The value must be either -1 or an integer between 1 and 3,653. default -1"

										format: "int32"
										type:   "integer"
									}
									hsmClientCertificateIdentifier: {
										description: "HSMClientCertificateIdentifier specifies the name of the HSM client certificate the Amazon Redshift cluster uses to retrieve the data encryption keys stored in an HSM."

										type: "string"
									}
									hsmConfigurationIdentifier: {
										description: "HSMConfigurationIdentifier specifies the name of the HSM configuration that contains the information the Amazon Redshift cluster can use to retrieve and store keys in an HSM."

										type: "string"
									}
									iamRoleRefs: {
										description: "IAMRoleRefs are references to IAMRoles used to set the IAMRoles."

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
									iamRoleSelector: {
										description: "IAMRoleSelector selects references to IAMRoles used to set the IAMRoles."

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
									iamRoles: {
										description: "IAMRoles is a list of AWS Identity and Access Management (IAM) roles that can be used by the cluster to access other AWS services. You must supply the IAM roles in their Amazon Resource Name (ARN) format. You can supply up to 10 IAM roles in a single request. A cluster can have up to 10 IAM roles associated with it at any time. kubebuilder:validation:MaxItems=10"

										items: type: "string"
										type: "array"
									}
									kmsKeyID: {
										description: "KMSKeyID is the Amazon Resource Name (ARN) for the KMS encryption key. If you are creating a cluster with the same AWS account that owns the KMS encryption key used to encrypt the new cluster, then you can use the KMS key alias instead of the ARN for the KM encryption key."

										type: "string"
									}
									maintenanceTrackName: {
										description: "MaintenanceTrackName an optional parameter for the name of the maintenance track for the cluster."

										type: "string"
									}
									manualSnapshotRetentionPeriod: {
										description: "ManualSnapshotRetentionPeriod is the default number of days to retain a manual snapshot. If the value is -1, the snapshot is retained indefinitely. This setting doesn't change the retention period of existing snapshots. default=1"

										format:  "int32"
										maximum: 3653
										type:    "integer"
									}
									masterUsername: {
										description: "MasterUsername is the user name associated with the master user account for the cluster that is being created. Constraints: * Must be 1 - 128 alphanumeric characters. The user name can't be PUBLIC. * First character must be a letter. * Cannot be a reserved word. A list of reserved words can be found in Reserved Words (https://docs.aws.amazon.com/redshift/latest/dg/r_pg_keywords.html) in the Amazon Redshift Database Developer Guide."

										type: "string"
									}
									newClusterIdentifier: {
										description: "NewClusterIdentifier is the new identifier you want to use for the cluster."

										type: "string"
									}
									newMasterUserPassword: {
										description: "NewMasterUserPassword is the new password to be associated with the master user account for the cluster that has being created. Set this value if you want to change the existing password of the cluster. Constraints: * Must be between 8 and 64 characters in length. * Must contain at least one uppercase letter. * Must contain at least one lowercase letter. * Must contain one number. * Can be any printable ASCII character (ASCII code 33 to 126) except ' (single quote), \" (double quote), \\, /, @, or space."

										type: "string"
									}
									nodeType: {
										description: "NodeType is the node type defining its size and compute capacity to be provisioned for the cluster. For information about node types, go to Working with Clusters (https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#how-many-nodes) in the Amazon Redshift Cluster Management Guide."

										type: "string"
									}
									numberOfNodes: {
										description: "NumberOfNodes defines the number of compute nodes in the cluster. This parameter is required when the ClusterType parameter is specified as multi-node. For information about determining how many nodes you need, go to Working with Clusters (https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#how-many-nodes) in the Amazon Redshift Cluster Management Guide. If you don't specify this parameter, you get a single-node cluster. When requesting a multi-node cluster, you must specify the number of nodes that you want in the cluster. default=1"

										format:  "int32"
										maximum: 100
										minimum: 1
										type:    "integer"
									}
									port: {
										description: "Port specifies the port number on which the cluster accepts incoming connections. The cluster is accessible only via the JDBC and ODBC connection strings. Part of the connection string requires the port on which the cluster will listen for incoming connections. default=5439"

										format:  "int32"
										maximum: 65535
										minimum: 1150
										type:    "integer"
									}
									preferredMaintenanceWindow: {
										description: "PreferredMaintenanceWindow is the weekly time range (in UTC) during which automated cluster maintenance can occur. Default: A 30-minute window selected at random from an 8-hour block of time per region, occurring on a random day of the week. For more information about the time blocks for each region, see Maintenance Windows (https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html#rs-maintenance-windows) in Amazon Redshift Cluster Management Guide. Constraints: Minimum 30-minute window."

										type: "string"
									}
									publiclyAccessible: {
										description: "PubliclyAccessible is to specify if the cluster can be accessed from a public network."

										type: "boolean"
									}
									region: {
										description: "Region is the region you'd like the Cluster to be created in."

										type: "string"
									}
									skipFinalClusterSnapshot: {
										description: "SkipFinalClusterSnapshot determines whether a final snapshot of the cluster is created before Amazon Redshift deletes the cluster. If true, a final cluster snapshot is not created. If false, a final cluster snapshot is created before the cluster is deleted. The FinalClusterSnapshotIdentifier parameter must be specified if SkipFinalClusterSnapshot is false. Default: false"

										type: "boolean"
									}
									snapshotScheduleIdentifier: {
										description: "SnapshotScheduleIdentifier is a unique identifier for the snapshot schedule."

										type: "string"
									}
									tags: {
										description: "Tags indicates a list of tags for the clusters."
										items: {
											description: "Tag represetnt a key-pair metadata assigned to a Redshift Cluster"

											properties: {
												tag: {
													description: "The key of the tag."
													type:        "string"
												}
												value: {
													description: "The value of the tag."
													type:        "string"
												}
											}
											required: [
												"tag",
												"value",
											]
											type: "object"
										}
										type: "array"
									}
									vpcSecurityGroupIDRefs: {
										description: "VPCSecurityGroupIDRefs are references to VPCSecurityGroups used to set the VPCSecurityGroupIDs."

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
									vpcSecurityGroupIDSelector: {
										description: "VPCSecurityGroupIDSelector selects references to VPCSecurityGroups used to set the VPCSecurityGroupIDs."

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
									vpcSecurityGroupIds: {
										description: "VPCSecurityGroupIDs a list of Virtual Private Cloud (VPC) security groups to be associated with the cluster."

										items: type: "string"
										type: "array"
									}
								}
								required: [
									"masterUsername",
									"nodeType",
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
						description: "ClusterStatus represents the observed state of an AWS Redshift Cluster."

						properties: {
							atProvider: {
								description: "ClusterObservation is the representation of the current state that is observed."

								properties: {
									clusterAvailabilityStatus: {
										description: "ClusterAvailabilityStatus is the availability status of the cluster."

										type: "string"
									}
									clusterCreateTime: {
										description: "ClusterCreateTime is the date and time that the cluster was created."

										format: "date-time"
										type:   "string"
									}
									clusterNodes: {
										description: "The nodes in the cluster."
										items: {
											description: "ClusterNode is the identifier of a node in a cluster."
											properties: {
												nodeRole: {
													description: "Whether the node is a leader node or a compute node."

													type: "string"
												}
												privateIPAddress: {
													description: "The private IP address of a node within a cluster."
													type:        "string"
												}
												publicIPAddress: {
													description: "The public IP address of a node within a cluster."
													type:        "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									clusterParameterGroups: {
										description: "The list of cluster parameter groups that are associated with this cluster. Each parameter group in the list is returned with its status."

										items: {
											description: "ClusterParameterGroupStatus is the status of the Cluster parameter group."

											properties: {
												clusterParameterStatusList: {
													description: """
		The list of parameter statuses. 
		 For more information about parameters and parameter groups, go to Amazon Redshift Parameter Groups (https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-parameter-groups.html) in the Amazon Redshift Cluster Management Guide.
		"""

													items: {
														description: "ClusterParameterStatus describes the status of a Cluster parameter."

														properties: {
															parameterApplyErrorDescription: {
																description: "The error that prevented the parameter from being applied to the database."

																type: "string"
															}
															parameterApplyStatus: {
																description: """
		The status of the parameter that indicates whether the parameter is in sync with the database, waiting for a cluster reboot, or encountered an error when being applied. 
		 The following are possible statuses and descriptions. 
		 * in-sync: The parameter value is in sync with the database. 
		 * pending-reboot: The parameter value will be applied after the cluster reboots. 
		 * applying: The parameter value is being applied to the database. 
		 * invalid-parameter: Cannot apply the parameter value because it has an invalid value or syntax. 
		 * apply-deferred: The parameter contains static property changes. The changes are deferred until the cluster reboots. 
		 * apply-error: Cannot connect to the cluster. The parameter change will be applied after the cluster reboots. 
		 * unknown-error: Cannot apply the parameter change right now. The change will be applied after the cluster reboots.
		"""

																type: "string"
															}
															parameterName: {
																description: "The name of the parameter."
																type:        "string"
															}
														}
														type: "object"
													}
													type: "array"
												}
												parameterApplyStatus: {
													description: "The status of parameter updates."
													type:        "string"
												}
												parameterGroupName: {
													description: "The name of the cluster parameter group."
													type:        "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									clusterPublicKey: {
										description: "The public key for the cluster."
										type:        "string"
									}
									clusterRevisionNumber: {
										description: "The specific revision number of the database in the cluster."

										type: "string"
									}
									clusterSnapshotCopyStatus: {
										description: "A value that returns the destination region and retention period that are configured for cross-region snapshot copy."

										properties: {
											destinationRegion: {
												description: "The destination region that snapshots are automatically copied to when cross-region snapshot copy is enabled."

												type: "string"
											}
											manualSnapshotRetentionPeriod: {
												description: """
		The number of days that automated snapshots are retained in the destination region after they are copied from a source region. If the value is -1, the manual snapshot is retained indefinitely. 
		 The value must be either -1 or an integer between 1 and 3,653.
		"""

												format: "int32"
												type:   "integer"
											}
											retentionPeriod: {
												description: "The number of days that automated snapshots are retained in the destination region after they are copied from a source region."

												format: "int64"
												type:   "integer"
											}
											snapshotCopyGrantName: {
												description: "The name of the snapshot copy grant."
												type:        "string"
											}
										}
										type: "object"
									}
									clusterStatus: {
										description: "ClusterStatus is the current state of the cluster."
										type:        "string"
									}
									dataTransferProgress: {
										description: "Describes the status of a cluster while it is in the process of resizing with an incremental resize."

										properties: {
											currentRateInMegaBytesPerSecond: {
												description: "Describes the data transfer rate in MB's per second."

												type: "integer"
											}
											dataTransferredInMegaBytes: {
												description: "Describes the total amount of data that has been transferred in MB's."

												format: "int64"
												type:   "integer"
											}
											elapsedTimeInSeconds: {
												description: "Describes the number of seconds that have elapsed during the data transfer."

												format: "int64"
												type:   "integer"
											}
											estimatedTimeToCompletionInSeconds: {
												description: "Describes the estimated number of seconds remaining to complete the transfer."

												format: "int64"
												type:   "integer"
											}
											status: {
												description: "Describes the status of the cluster. While the transfer is in progress the status is transferringdata."

												type: "string"
											}
											totalDataInMegaBytes: {
												description: "Describes the total amount of data to be transferred in megabytes."

												format: "int64"
												type:   "integer"
											}
										}
										type: "object"
									}
									deferredMaintenanceWindows: {
										description: "Describes a group of DeferredMaintenanceWindow objects."
										items: {
											description: "DeferredMaintenanceWindow describes a deferred maintenance window"

											properties: {
												deferMaintenanceEndTime: {
													description: "A timestamp for the end of the time period when we defer maintenance."

													format: "date-time"
													type:   "string"
												}
												deferMaintenanceIdentifier: {
													description: "A unique identifier for the maintenance window."
													type:        "string"
												}
												deferMaintenanceStartTime: {
													description: "A timestamp for the beginning of the time period when we defer maintenance."

													format: "date-time"
													type:   "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									elasticIPStatus: {
										description: "The status of the elastic IP (EIP) address."
										properties: {
											elasticIP: {
												description: "The elastic IP (EIP) address for the cluster."
												type:        "string"
											}
											status: {
												description: "The status of the elastic IP (EIP) address."
												type:        "string"
											}
										}
										type: "object"
									}
									elasticResizeNumberOfNodeOptions: {
										description: "The number of nodes that you can resize the cluster to with the elastic resize method."

										type: "string"
									}
									endpoint: {
										description: "Endpoint specifies the connection endpoint."
										properties: {
											address: {
												description: "Address specifies the DNS address of the cluster."
												type:        "string"
											}
											port: {
												description: "Port specifies the port that the database engine is listening on."

												format: "int32"
												type:   "integer"
											}
										}
										type: "object"
									}
									expectedNextSnapshotScheduleTime: {
										description: "The date and time when the next snapshot is expected to be taken for clusters with a valid snapshot schedule and backups enabled."

										format: "date-time"
										type:   "string"
									}
									expectedNextSnapshotScheduleTimeStatus: {
										description: """
		The status of next expected snapshot for clusters having a valid snapshot schedule and backups enabled. Possible values are the following: 
		 * OnTrack - The next snapshot is expected to be taken on time. 
		 * Pending - The next snapshot is pending to be taken.
		"""

										type: "string"
									}
									hsmStatus: {
										description: """
		A value that reports whether the Amazon Redshift cluster has finished applying any hardware security module (HSM) settings changes specified in a modify cluster command. 
		 Values: active, applying
		"""

										properties: {
											hsmClientCertificateIdentifier: {
												description: "Specifies the name of the HSM client certificate the Amazon Redshift cluster uses to retrieve the data encryption keys stored in an HSM."

												type: "string"
											}
											hsmConfigurationIdentifier: {
												description: "Specifies the name of the HSM configuration that contains the information the Amazon Redshift cluster can use to retrieve and store keys in an HSM."

												type: "string"
											}
											status: {
												description: """
		Reports whether the Amazon Redshift cluster has finished applying any HSM settings changes specified in a modify cluster command. 
		 Values: active, applying
		"""

												type: "string"
											}
										}
										type: "object"
									}
									modifyStatus: {
										description: "The status of a modify operation, if any, initiated for the cluster."

										type: "string"
									}
									nextMaintenanceWindowStartTime: {
										description: "The date and time in UTC when system maintenance can begin."

										format: "date-time"
										type:   "string"
									}
									pendingActions: {
										description: "Cluster operations that are waiting to be started."
										items: type: "string"
										type: "array"
									}
									snapshotScheduleState: {
										description: "The current state of the cluster snapshot schedule."
										type:        "string"
									}
									vpcId: {
										description: "The identifier of the VPC the cluster is in, if the cluster is in a VPC."

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
