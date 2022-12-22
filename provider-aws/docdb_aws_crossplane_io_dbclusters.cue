package docdb_aws_crossplane_io_dbclusters

customresourcedefinition: "dbclusters.docdb.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "dbclusters.docdb.aws.crossplane.io"
	}
	spec: {
		group: "docdb.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "DBCluster"
			listKind: "DBClusterList"
			plural:   "dbclusters"
			singular: "dbcluster"
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
				description: "DBCluster is the Schema for the DBClusters API"
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
						description: "DBClusterSpec defines the desired state of DBCluster"
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
								description: "DBClusterParameters defines the desired state of DBCluster"
								properties: {
									applyImmediately: {
										description: """
		A value that specifies whether the changes in this request and any pending changes are asynchronously applied as soon as possible, regardless of the PreferredMaintenanceWindow setting for the cluster. If this parameter is set to false, changes to the cluster are applied during the next maintenance window. 
		 The ApplyImmediately parameter affects only the NewDBClusterIdentifier and MasterUserPassword values. If you set this parameter value to false, the changes to the NewDBClusterIdentifier and MasterUserPassword values are applied during the next maintenance window. All other changes are applied immediately, regardless of the value of the ApplyImmediately parameter. 
		 Default: false
		"""

										type: "boolean"
									}
									availabilityZones: {
										description: "A list of Amazon EC2 Availability Zones that instances in the cluster can be created in."

										items: type: "string"
										type: "array"
									}
									backupRetentionPeriod: {
										description: """
		The number of days for which automated backups are retained. You must specify a minimum value of 1. 
		 Default: 1 
		 Constraints: 
		 * Must be a value from 1 to 35.
		"""

										format: "int64"
										type:   "integer"
									}
									dbClusterParameterGroupName: {
										description: "The name of the cluster parameter group to associate with this cluster."

										type: "string"
									}
									dbClusterParameterGroupNameRef: {
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
									dbClusterParameterGroupNameSelector: {
										description: "A Selector selects an object."
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
									dbSubnetGroupName: {
										description: """
		A subnet group to associate with this cluster. 
		 Constraints: Must match the name of an existing DBSubnetGroup. Must not be default. 
		 Example: mySubnetgroup
		"""

										type: "string"
									}
									dbSubnetGroupNameRef: {
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
									dbSubnetGroupNameSelector: {
										description: "A Selector selects an object."
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
									deletionProtection: {
										description: "Specifies whether this cluster can be deleted. If DeletionProtection is enabled, the cluster cannot be deleted unless it is modified and DeletionProtection is disabled. DeletionProtection protects clusters from being accidentally deleted."

										type: "boolean"
									}
									destinationRegion: {
										description: "DestinationRegion is used for presigning the request to a given region."

										type: "string"
									}
									enableCloudwatchLogsExports: {
										description: "A list of log types that need to be enabled for exporting to Amazon CloudWatch Logs. You can enable audit logs or profiler logs. For more information, see Auditing Amazon DocumentDB Events (https://docs.aws.amazon.com/documentdb/latest/developerguide/event-auditing.html) and Profiling Amazon DocumentDB Operations (https://docs.aws.amazon.com/documentdb/latest/developerguide/profiling.html)."

										items: type: "string"
										type: "array"
									}
									engine: {
										description: """
		The name of the database engine to be used for this cluster. 
		 Valid values: docdb
		"""

										type: "string"
									}
									engineVersion: {
										description: "The version number of the database engine to use. The --engine-version will default to the latest major engine version. For production workloads, we recommend explicitly declaring this parameter with the intended major engine version."

										type: "string"
									}
									finalDBSnapshotIdentifier: {
										description: """
		The cluster snapshot identifier of the new cluster snapshot created when SkipFinalSnapshot is set to false. 
		 Specifying this parameter and also setting the SkipFinalShapshot parameter to true results in an error. 
		 Constraints: 
		 * Must be from 1 to 255 letters, numbers, or hyphens. 
		 * The first character must be a letter. 
		 * Cannot end with a hyphen or contain two consecutive hyphens.
		"""

										type: "string"
									}
									globalClusterIdentifier: {
										description: "The cluster identifier of the new global cluster."
										type:        "string"
									}
									kmsKeyID: {
										description: """
		The KMS key identifier for an encrypted cluster. 
		 The KMS key identifier is the Amazon Resource Name (ARN) for the KMS encryption key. If you are creating a cluster using the same Amazon Web Services account that owns the KMS encryption key that is used to encrypt the new cluster, you can use the KMS key alias instead of the ARN for the KMS encryption key. 
		 If an encryption key is not specified in KmsKeyId: 
		 * If the StorageEncrypted parameter is true, Amazon DocumentDB uses your default encryption key. 
		 KMS creates the default encryption key for your Amazon Web Services account. Your Amazon Web Services account has a different default encryption key for each Amazon Web Services Regions.
		"""

										type: "string"
									}
									kmsKeyIDRef: {
										description: "TODO(haarchri): when resource is bumped to beta we will convert this field to kmsKeyIdRef"

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
										description: "TODO(haarchri): when resource is bumped to beta we will convert this field to kmsKeyIdSelector"

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
									masterUserPasswordSecretRef: {
										description: """
		MasterUserPasswordSecretRef references the secret that contains the password for the master database user. This password can contain any printable ASCII character except forward slash (/), double quote (\"), or the \"at\" symbol (@). 
		 Constraints: Must contain from 8 to 100 characters.
		"""

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
									masterUsername: {
										description: """
		The name of the master user for the cluster. 
		 Constraints: 
		 * Must be from 1 to 63 letters or numbers. 
		 * The first character must be a letter. 
		 * Cannot be a reserved word for the chosen database engine.
		"""

										type: "string"
									}
									port: {
										description: "The port number on which the instances in the cluster accept connections."

										format: "int64"
										type:   "integer"
									}
									preSignedURL: {
										description: "Not currently supported."
										type:        "string"
									}
									preferredBackupWindow: {
										description: """
		The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter. 
		 The default is a 30-minute window selected at random from an 8-hour block of time for each Amazon Web Services Region. 
		 Constraints: 
		 * Must be in the format hh24:mi-hh24:mi. 
		 * Must be in Universal Coordinated Time (UTC). 
		 * Must not conflict with the preferred maintenance window. 
		 * Must be at least 30 minutes.
		"""

										type: "string"
									}
									preferredMaintenanceWindow: {
										description: """
		The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC). 
		 Format: ddd:hh24:mi-ddd:hh24:mi 
		 The default is a 30-minute window selected at random from an 8-hour block of time for each Amazon Web Services Region, occurring on a random day of the week. 
		 Valid days: Mon, Tue, Wed, Thu, Fri, Sat, Sun 
		 Constraints: Minimum 30-minute window.
		"""

										type: "string"
									}
									region: {
										description: "Region is which region the DBCluster will be created."
										type:        "string"
									}
									skipFinalSnapshot: {
										description: """
		Determines whether a final cluster snapshot is created before the cluster is deleted. If true is specified, no cluster snapshot is created. If false is specified, a cluster snapshot is created before the DB cluster is deleted. 
		 If SkipFinalSnapshot is false, you must specify a FinalDBSnapshotIdentifier parameter. 
		 Default: false
		"""

										type: "boolean"
									}
									sourceRegion: {
										description: "SourceRegion is the source region where the resource exists. This is not sent over the wire and is only used for presigning. This value should always have the same region as the source ARN."

										type: "string"
									}
									storageEncrypted: {
										description: "Specifies whether the cluster is encrypted."
										type:        "boolean"
									}
									tags: {
										description: "The tags to be assigned to the cluster."
										items: {
											properties: {
												key: type: "string"
												value: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									vpcSecurityGroupIDs: {
										description: "A list of EC2 VPC security groups to associate with this cluster."

										items: type: "string"
										type: "array"
									}
									vpcSecurityGroupIDsRefs: {
										description: "TODO(haarchri): when resource is bumped to beta we will convert this field to vpcSecurityGroupIdRefs"

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
									vpcSecurityGroupIDsSelector: {
										description: "TODO(haarchri): when resource is bumped to beta we will convert this field to vpcSecurityGroupIdSelector"

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
									"engine",
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
						description: "DBClusterStatus defines the observed state of DBCluster."
						properties: {
							atProvider: {
								description: "DBClusterObservation defines the observed state of DBCluster"
								properties: {
									associatedRoles: {
										description: "Provides a list of the Identity and Access Management (IAM) roles that are associated with the cluster. (IAM) roles that are associated with a cluster grant permission for the cluster to access other Amazon Web Services services on your behalf."

										items: {
											properties: {
												roleARN: type: "string"
												status: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									clusterCreateTime: {
										description: "Specifies the time when the cluster was created, in Universal Coordinated Time (UTC)."

										format: "date-time"
										type:   "string"
									}
									dbClusterARN: {
										description: "The Amazon Resource Name (ARN) for the cluster."
										type:        "string"
									}
									dbClusterIdentifier: {
										description: "Contains a user-supplied cluster identifier. This identifier is the unique key that identifies a cluster."

										type: "string"
									}
									dbClusterMembers: {
										description: "Provides the list of instances that make up the cluster."
										items: {
											properties: {
												dbClusterParameterGroupStatus: type: "string"
												dbInstanceIdentifier: type: "string"
												isClusterWriter: type: "boolean"
												promotionTier: {
													format: "int64"
													type:   "integer"
												}
											}
											type: "object"
										}
										type: "array"
									}
									dbClusterParameterGroup: {
										description: "Specifies the name of the cluster parameter group for the cluster."

										type: "string"
									}
									dbClusterResourceID: {
										description: "The Amazon Web Services Region-unique, immutable identifier for the cluster. This identifier is found in CloudTrail log entries whenever the KMS key for the cluster is accessed."

										type: "string"
									}
									dbSubnetGroup: {
										description: "Specifies information on the subnet group that is associated with the cluster, including the name, description, and subnets in the subnet group."

										type: "string"
									}
									earliestRestorableTime: {
										description: "The earliest time to which a database can be restored with point-in-time restore."

										format: "date-time"
										type:   "string"
									}
									enabledCloudwatchLogsExports: {
										description: "A list of log types that this cluster is configured to export to Amazon CloudWatch Logs."

										items: type: "string"
										type: "array"
									}
									endpoint: {
										description: "Specifies the connection endpoint for the primary instance of the cluster."

										type: "string"
									}
									hostedZoneID: {
										description: "Specifies the ID that Amazon Route 53 assigns when you create a hosted zone."

										type: "string"
									}
									latestRestorableTime: {
										description: "Specifies the latest time to which a database can be restored with point-in-time restore."

										format: "date-time"
										type:   "string"
									}
									multiAZ: {
										description: "Specifies whether the cluster has instances in multiple Availability Zones."

										type: "boolean"
									}
									percentProgress: {
										description: "Specifies the progress of the operation as a percentage."
										type:        "string"
									}
									readReplicaIdentifiers: {
										description: "Contains one or more identifiers of the secondary clusters that are associated with this cluster."

										items: type: "string"
										type: "array"
									}
									readerEndpoint: {
										description: """
		The reader endpoint for the cluster. The reader endpoint for a cluster load balances connections across the Amazon DocumentDB replicas that are available in a cluster. As clients request new connections to the reader endpoint, Amazon DocumentDB distributes the connection requests among the Amazon DocumentDB replicas in the cluster. This functionality can help balance your read workload across multiple Amazon DocumentDB replicas in your cluster. 
		 If a failover occurs, and the Amazon DocumentDB replica that you are connected to is promoted to be the primary instance, your connection is dropped. To continue sending your read workload to other Amazon DocumentDB replicas in the cluster, you can then reconnect to the reader endpoint.
		"""

										type: "string"
									}
									replicationSourceIdentifier: {
										description: "Contains the identifier of the source cluster if this cluster is a secondary cluster."

										type: "string"
									}
									status: {
										description: "Specifies the current state of this cluster."
										type:        "string"
									}
									vpcSecurityGroups: {
										description: "Provides a list of virtual private cloud (VPC) security groups that the cluster belongs to."

										items: {
											properties: {
												status: type: "string"
												vpcSecurityGroupID: type: "string"
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
