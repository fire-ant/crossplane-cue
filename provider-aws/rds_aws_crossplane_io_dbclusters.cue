package rds_aws_crossplane_io_dbclusters

customresourcedefinition: "dbclusters.rds.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "dbclusters.rds.aws.crossplane.io"
	}
	spec: {
		group: "rds.aws.crossplane.io"
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
									allocatedStorage: {
										description: """
		The amount of storage in gibibytes (GiB) to allocate to each DB instance in the Multi-AZ DB cluster. 
		 This setting is required to create a Multi-AZ DB cluster. 
		 Valid for: Multi-AZ DB clusters only
		"""

										format: "int64"
										type:   "integer"
									}
									applyImmediately: {
										description: """
		A value that indicates whether the modifications in this request and any pending modifications are asynchronously applied as soon as possible, regardless of the PreferredMaintenanceWindow setting for the DB cluster. If this parameter is disabled, changes to the DB cluster are applied during the next maintenance window. 
		 The ApplyImmediately parameter only affects the EnableIAMDatabaseAuthentication, MasterUserPassword values. If the ApplyImmediately parameter is disabled, then changes to the EnableIAMDatabaseAuthentication, MasterUserPassword values are applied during the next maintenance window. All other changes are applied immediately, regardless of the value of the ApplyImmediately parameter. 
		 By default, this parameter is disabled.
		"""

										type: "boolean"
									}
									autoMinorVersionUpgrade: {
										description: """
		A value that indicates whether minor engine upgrades are applied automatically to the DB cluster during the maintenance window. By default, minor engine upgrades are applied automatically. 
		 Valid for: Multi-AZ DB clusters only
		"""

										type: "boolean"
									}
									autogeneratePassword: {
										description: """
		AutogeneratePassword indicates whether the controller should generate a random password for the master user if one is not provided via MasterUserPasswordSecretRef. 
		 If a password is generated, it will be stored as a secret at the location specified by MasterUserPasswordSecretRef.
		"""

										type: "boolean"
									}
									availabilityZones: {
										description: """
		A list of Availability Zones (AZs) where DB instances in the DB cluster can be created. 
		 For information on Amazon Web Services Regions and Availability Zones, see Choosing the Regions and Availability Zones (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.RegionsAndAvailabilityZones.html) in the Amazon Aurora User Guide. 
		 Valid for: Aurora DB clusters only
		"""

										items: type: "string"
										type: "array"
									}
									backtrackWindow: {
										description: """
		The target backtrack window, in seconds. To disable backtracking, set this value to 0. 
		 Default: 0 
		 Constraints: 
		 * If specified, this value must be set to a number from 0 to 259,200 (72 hours). 
		 Valid for: Aurora MySQL DB clusters only
		"""

										format: "int64"
										type:   "integer"
									}
									backupRetentionPeriod: {
										description: """
		The number of days for which automated backups are retained. 
		 Default: 1 
		 Constraints: 
		 * Must be a value from 1 to 35 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										format: "int64"
										type:   "integer"
									}
									characterSetName: {
										description: """
		A value that indicates that the DB cluster should be associated with the specified CharacterSet. 
		 Valid for: Aurora DB clusters only
		"""

										type: "string"
									}
									copyTagsToSnapshot: {
										description: """
		A value that indicates whether to copy all tags from the DB cluster to snapshots of the DB cluster. The default is not to copy them. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "boolean"
									}
									databaseName: {
										description: """
		The name for your database of up to 64 alphanumeric characters. If you do not provide a name, Amazon RDS doesn't create a database in the DB cluster you are creating. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "string"
									}
									dbClusterInstanceClass: {
										description: """
		The compute and memory capacity of each DB instance in the Multi-AZ DB cluster, for example db.m6g.xlarge. Not all DB instance classes are available in all Amazon Web Services Regions, or for all database engines. 
		 For the full list of DB instance classes and availability for your engine, see DB instance class (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) in the Amazon RDS User Guide. 
		 This setting is required to create a Multi-AZ DB cluster. 
		 Valid for: Multi-AZ DB clusters only
		"""

										type: "string"
									}
									dbClusterParameterGroupName: {
										description: """
		The name of the DB cluster parameter group to associate with this DB cluster. If you do not specify a value, then the default DB cluster parameter group for the specified DB engine and version is used. 
		 Constraints: 
		 * If supplied, must match the name of an existing DB cluster parameter group. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "string"
									}
									dbClusterParameterGroupNameRef: {
										description: "DBClusterParameterGroupNameRef is a reference to a DBClusterParameterGroup used to set DBClusterParameterGroupName."

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
										description: "DBClusterParameterGroupNameSelector selects a reference to a DBClusterParameterGroup used to set DBClusterParameterGroupName."

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
		A DB subnet group to associate with this DB cluster. 
		 This setting is required to create a Multi-AZ DB cluster. 
		 Constraints: Must match the name of an existing DBSubnetGroup. Must not be default. 
		 Example: mydbsubnetgroup 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "string"
									}
									dbSubnetGroupNameRef: {
										description: "DBSubnetGroupNameRef is a reference to a DBSubnetGroup used to set DBSubnetGroupName."

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
										description: "DBSubnetGroupNameSelector selects a reference to a DBSubnetGroup used to set DBSubnetGroupName."

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
										description: """
		A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection isn't enabled. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "boolean"
									}
									destinationRegion: {
										description: "DestinationRegion is used for presigning the request to a given region."

										type: "string"
									}
									domain: {
										description: """
		The Active Directory directory ID to create the DB cluster in. 
		 For Amazon Aurora DB clusters, Amazon RDS can use Kerberos authentication to authenticate users that connect to the DB cluster. 
		 For more information, see Kerberos authentication (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/kerberos-authentication.html) in the Amazon Aurora User Guide. 
		 Valid for: Aurora DB clusters only
		"""

										type: "string"
									}
									domainIAMRoleName: {
										description: """
		Specify the name of the IAM role to be used when making API calls to the Directory Service. 
		 Valid for: Aurora DB clusters only
		"""

										type: "string"
									}
									domainIAMRoleNameRef: {
										description: "DomainIAMRoleNameRef is a reference to an IAMRole used to set DomainIAMRoleName."

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
									domainIAMRoleNameSelector: {
										description: "DomainIAMRoleNameSelector selects a reference to an IAMRole used to set DomainIAMRoleName."

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
									enableCloudwatchLogsExports: {
										description: """
		The list of log types that need to be enabled for exporting to CloudWatch Logs. The values in the list depend on the DB engine being used. 
		 RDS for MySQL 
		 Possible values are error, general, and slowquery. 
		 RDS for PostgreSQL 
		 Possible values are postgresql and upgrade. 
		 Aurora MySQL 
		 Possible values are audit, error, general, and slowquery. 
		 Aurora PostgreSQL 
		 Possible value is postgresql. 
		 For more information about exporting CloudWatch Logs for Amazon RDS, see Publishing Database Logs to Amazon CloudWatch Logs (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the Amazon RDS User Guide. 
		 For more information about exporting CloudWatch Logs for Amazon Aurora, see Publishing Database Logs to Amazon CloudWatch Logs (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the Amazon Aurora User Guide. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										items: type: "string"
										type: "array"
									}
									enableGlobalWriteForwarding: {
										description: """
		A value that indicates whether to enable this DB cluster to forward write operations to the primary cluster of an Aurora global database (GlobalCluster). By default, write operations are not allowed on Aurora DB clusters that are secondary clusters in an Aurora global database. 
		 You can set this value only on Aurora DB clusters that are members of an Aurora global database. With this parameter enabled, a secondary cluster can forward writes to the current primary cluster and the resulting changes are replicated back to this cluster. For the primary DB cluster of an Aurora global database, this value is used immediately if the primary is demoted by the FailoverGlobalCluster API operation, but it does nothing until then. 
		 Valid for: Aurora DB clusters only
		"""

										type: "boolean"
									}
									enableHTTPEndpoint: {
										description: """
		A value that indicates whether to enable the HTTP endpoint for an Aurora Serverless v1 DB cluster. By default, the HTTP endpoint is disabled. 
		 When enabled, the HTTP endpoint provides a connectionless web service API for running SQL queries on the Aurora Serverless v1 DB cluster. You can also query your database from inside the RDS console with the query editor. 
		 For more information, see Using the Data API for Aurora Serverless v1 (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html) in the Amazon Aurora User Guide. 
		 Valid for: Aurora DB clusters only
		"""

										type: "boolean"
									}
									enableIAMDatabaseAuthentication: {
										description: """
		A value that indicates whether to enable mapping of Amazon Web Services Identity and Access Management (IAM) accounts to database accounts. By default, mapping isn't enabled. 
		 For more information, see IAM Database Authentication (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html) in the Amazon Aurora User Guide.. 
		 Valid for: Aurora DB clusters only
		"""

										type: "boolean"
									}
									enablePerformanceInsights: {
										description: """
		A value that indicates whether to turn on Performance Insights for the DB cluster. 
		 For more information, see Using Amazon Performance Insights (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html) in the Amazon RDS User Guide. 
		 Valid for: Multi-AZ DB clusters only
		"""

										type: "boolean"
									}
									engine: {
										description: """
		The name of the database engine to be used for this DB cluster. 
		 Valid Values: 
		 * aurora (for MySQL 5.6-compatible Aurora) 
		 * aurora-mysql (for MySQL 5.7-compatible and MySQL 8.0-compatible Aurora) 
		 * aurora-postgresql 
		 * mysql 
		 * postgres 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "string"
									}
									engineMode: {
										description: """
		The DB engine mode of the DB cluster, either provisioned, serverless, parallelquery, global, or multimaster. 
		 The parallelquery engine mode isn't required for Aurora MySQL version 1.23 and higher 1.x versions, and version 2.09 and higher 2.x versions. 
		 The global engine mode isn't required for Aurora MySQL version 1.22 and higher 1.x versions, and global engine mode isn't required for any 2.x versions. 
		 The multimaster engine mode only applies for DB clusters created with Aurora MySQL version 5.6.10a. 
		 For Aurora PostgreSQL, the global engine mode isn't required, and both the parallelquery and the multimaster engine modes currently aren't supported. 
		 Limitations and requirements apply to some DB engine modes. For more information, see the following sections in the Amazon Aurora User Guide: 
		 * Limitations of Aurora Serverless v1 (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.html#aurora-serverless.limitations) 
		 * Limitations of Parallel Query (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-mysql-parallel-query.html#aurora-mysql-parallel-query-limitations) 
		 * Limitations of Aurora Global Databases (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-global-database.html#aurora-global-database.limitations) 
		 * Limitations of Multi-Master Clusters (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-multi-master.html#aurora-multi-master-limitations) 
		 Valid for: Aurora DB clusters only
		"""

										type: "string"
									}
									engineVersion: {
										description: """
		The version number of the database engine to use. 
		 To list all of the available engine versions for MySQL 5.6-compatible Aurora, use the following command: 
		 aws rds describe-db-engine-versions --engine aurora --query \"DBEngineVersions[].EngineVersion\" 
		 To list all of the available engine versions for MySQL 5.7-compatible and MySQL 8.0-compatible Aurora, use the following command: 
		 aws rds describe-db-engine-versions --engine aurora-mysql --query \"DBEngineVersions[].EngineVersion\" 
		 To list all of the available engine versions for Aurora PostgreSQL, use the following command: 
		 aws rds describe-db-engine-versions --engine aurora-postgresql --query \"DBEngineVersions[].EngineVersion\" 
		 To list all of the available engine versions for RDS for MySQL, use the following command: 
		 aws rds describe-db-engine-versions --engine mysql --query \"DBEngineVersions[].EngineVersion\" 
		 To list all of the available engine versions for RDS for PostgreSQL, use the following command: 
		 aws rds describe-db-engine-versions --engine postgres --query \"DBEngineVersions[].EngineVersion\" 
		 Aurora MySQL 
		 For information, see MySQL on Amazon RDS Versions (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Updates.html) in the Amazon Aurora User Guide. 
		 Aurora PostgreSQL 
		 For information, see Amazon Aurora PostgreSQL releases and engine versions (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Updates.20180305.html) in the Amazon Aurora User Guide. 
		 MySQL 
		 For information, see MySQL on Amazon RDS Versions (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt) in the Amazon RDS User Guide. 
		 PostgreSQL 
		 For information, see Amazon RDS for PostgreSQL versions and extensions (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts) in the Amazon RDS User Guide. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "string"
									}
									finalDBSnapshotIdentifier: {
										description: """
		The DB cluster snapshot identifier of the new DB cluster snapshot created when SkipFinalSnapshot is disabled. 
		 Specifying this parameter and also skipping the creation of a final DB cluster snapshot with the SkipFinalShapshot parameter results in an error. 
		 Constraints: 
		 * Must be 1 to 255 letters, numbers, or hyphens. 
		 * First character must be a letter 
		 * Can't end with a hyphen or contain two consecutive hyphens
		"""

										type: "string"
									}
									globalClusterIdentifier: {
										description: """
		The global cluster ID of an Aurora cluster that becomes the primary cluster in the new global database cluster. 
		 Valid for: Aurora DB clusters only
		"""

										type: "string"
									}
									iops: {
										description: """
		The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for each DB instance in the Multi-AZ DB cluster. 
		 For information about valid Iops values, see Amazon RDS Provisioned IOPS storage to improve performance (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS) in the Amazon RDS User Guide. 
		 This setting is required to create a Multi-AZ DB cluster. 
		 Constraints: Must be a multiple between .5 and 50 of the storage amount for the DB cluster. 
		 Valid for: Multi-AZ DB clusters only
		"""

										format: "int64"
										type:   "integer"
									}
									kmsKeyID: {
										description: """
		The Amazon Web Services KMS key identifier for an encrypted DB cluster. 
		 The Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key. To use a KMS key in a different Amazon Web Services account, specify the key ARN or alias ARN. 
		 When a KMS key isn't specified in KmsKeyId: 
		 * If ReplicationSourceIdentifier identifies an encrypted source, then Amazon RDS will use the KMS key used to encrypt the source. Otherwise, Amazon RDS will use your default KMS key. 
		 * If the StorageEncrypted parameter is enabled and ReplicationSourceIdentifier isn't specified, then Amazon RDS will use your default KMS key. 
		 There is a default KMS key for your Amazon Web Services account. Your Amazon Web Services account has a different default KMS key for each Amazon Web Services Region. 
		 If you create a read replica of an encrypted DB cluster in another Amazon Web Services Region, you must set KmsKeyId to a KMS key identifier that is valid in the destination Amazon Web Services Region. This KMS key is used to encrypt the read replica in that Amazon Web Services Region. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "string"
									}
									kmsKeyIDRef: {
										description: "KMSKeyIDRef is a reference to a KMS Key used to set KMSKeyID."

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
										description: "KMSKeyIDSelector selects a reference to a KMS Key used to set KMSKeyID."

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
		The password for the master database user. This password can contain any printable ASCII character except \"/\", \"\"\", or \"@\". 
		 Constraints: Must contain from 8 to 41 characters. Required.
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
		The name of the master user for the DB cluster. 
		 Constraints: 
		 * Must be 1 to 16 letters or numbers. 
		 * First character must be a letter. 
		 * Can't be a reserved word for the chosen database engine. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "string"
									}
									monitoringInterval: {
										description: """
		The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB cluster. To turn off collecting Enhanced Monitoring metrics, specify 0. The default is 0. 
		 If MonitoringRoleArn is specified, also set MonitoringInterval to a value other than 0. 
		 Valid Values: 0, 1, 5, 10, 15, 30, 60 
		 Valid for: Multi-AZ DB clusters only
		"""

										format: "int64"
										type:   "integer"
									}
									monitoringRoleARN: {
										description: """
		The Amazon Resource Name (ARN) for the IAM role that permits RDS to send Enhanced Monitoring metrics to Amazon CloudWatch Logs. An example is arn:aws:iam:123456789012:role/emaccess. For information on creating a monitoring role, see Setting up and enabling Enhanced Monitoring (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html#USER_Monitoring.OS.Enabling) in the Amazon RDS User Guide. 
		 If MonitoringInterval is set to a value other than 0, supply a MonitoringRoleArn value. 
		 Valid for: Multi-AZ DB clusters only
		"""

										type: "string"
									}
									optionGroupName: {
										description: """
		A value that indicates that the DB cluster should be associated with the specified option group. 
		 DB clusters are associated with a default option group that can't be modified.
		"""

										type: "string"
									}
									performanceInsightsKMSKeyID: {
										description: """
		The Amazon Web Services KMS key identifier for encryption of Performance Insights data. 
		 The Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key. 
		 If you don't specify a value for PerformanceInsightsKMSKeyId, then Amazon RDS uses your default KMS key. There is a default KMS key for your Amazon Web Services account. Your Amazon Web Services account has a different default KMS key for each Amazon Web Services Region. 
		 Valid for: Multi-AZ DB clusters only
		"""

										type: "string"
									}
									performanceInsightsRetentionPeriod: {
										description: """
		The amount of time, in days, to retain Performance Insights data. Valid values are 7 or 731 (2 years). 
		 Valid for: Multi-AZ DB clusters only
		"""

										format: "int64"
										type:   "integer"
									}
									port: {
										description: """
		The port number on which the instances in the DB cluster accept connections. 
		 RDS for MySQL and Aurora MySQL 
		 Default: 3306 
		 Valid values: 1150-65535 
		 RDS for PostgreSQL and Aurora PostgreSQL 
		 Default: 5432 
		 Valid values: 1150-65535 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										format: "int64"
										type:   "integer"
									}
									preSignedURL: {
										description: """
		A URL that contains a Signature Version 4 signed request for the CreateDBCluster action to be called in the source Amazon Web Services Region where the DB cluster is replicated from. Specify PreSignedUrl only when you are performing cross-Region replication from an encrypted DB cluster. 
		 The pre-signed URL must be a valid request for the CreateDBCluster API action that can be executed in the source Amazon Web Services Region that contains the encrypted DB cluster to be copied. 
		 The pre-signed URL request must contain the following parameter values: 
		 * KmsKeyId - The Amazon Web Services KMS key identifier for the KMS key to use to encrypt the copy of the DB cluster in the destination Amazon Web Services Region. This should refer to the same KMS key for both the CreateDBCluster action that is called in the destination Amazon Web Services Region, and the action contained in the pre-signed URL. 
		 * DestinationRegion - The name of the Amazon Web Services Region that Aurora read replica will be created in. 
		 * ReplicationSourceIdentifier - The DB cluster identifier for the encrypted DB cluster to be copied. This identifier must be in the Amazon Resource Name (ARN) format for the source Amazon Web Services Region. For example, if you are copying an encrypted DB cluster from the us-west-2 Amazon Web Services Region, then your ReplicationSourceIdentifier would look like Example: arn:aws:rds:us-west-2:123456789012:cluster:aurora-cluster1. 
		 To learn how to generate a Signature Version 4 signed request, see Authenticating Requests: Using Query Parameters (Amazon Web Services Signature Version 4) (https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html) and Signature Version 4 Signing Process (https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html). 
		 If you are using an Amazon Web Services SDK tool or the CLI, you can specify SourceRegion (or --source-region for the CLI) instead of specifying PreSignedUrl manually. Specifying SourceRegion autogenerates a pre-signed URL that is a valid request for the operation that can be executed in the source Amazon Web Services Region. 
		 Valid for: Aurora DB clusters only
		"""

										type: "string"
									}
									preferredBackupWindow: {
										description: """
		The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter. 
		 The default is a 30-minute window selected at random from an 8-hour block of time for each Amazon Web Services Region. To view the time blocks available, see Backup window (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.Backups.BackupWindow) in the Amazon Aurora User Guide. 
		 Constraints: 
		 * Must be in the format hh24:mi-hh24:mi. 
		 * Must be in Universal Coordinated Time (UTC). 
		 * Must not conflict with the preferred maintenance window. 
		 * Must be at least 30 minutes. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "string"
									}
									preferredMaintenanceWindow: {
										description: """
		The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC). 
		 Format: ddd:hh24:mi-ddd:hh24:mi 
		 The default is a 30-minute window selected at random from an 8-hour block of time for each Amazon Web Services Region, occurring on a random day of the week. To see the time blocks available, see Adjusting the Preferred DB Cluster Maintenance Window (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow.Aurora) in the Amazon Aurora User Guide. 
		 Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun. 
		 Constraints: Minimum 30-minute window. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "string"
									}
									publiclyAccessible: {
										description: """
		A value that indicates whether the DB cluster is publicly accessible. 
		 When the DB cluster is publicly accessible, its Domain Name System (DNS) endpoint resolves to the private IP address from within the DB cluster's virtual private cloud (VPC). It resolves to the public IP address from outside of the DB cluster's VPC. Access to the DB cluster is ultimately controlled by the security group it uses. That public access isn't permitted if the security group assigned to the DB cluster doesn't permit it. 
		 When the DB cluster isn't publicly accessible, it is an internal DB cluster with a DNS name that resolves to a private IP address. 
		 Default: The default behavior varies depending on whether DBSubnetGroupName is specified. 
		 If DBSubnetGroupName isn't specified, and PubliclyAccessible isn't specified, the following applies: 
		 * If the default VPC in the target Region doesn’t have an internet gateway attached to it, the DB cluster is private. 
		 * If the default VPC in the target Region has an internet gateway attached to it, the DB cluster is public. 
		 If DBSubnetGroupName is specified, and PubliclyAccessible isn't specified, the following applies: 
		 * If the subnets are part of a VPC that doesn’t have an internet gateway attached to it, the DB cluster is private. 
		 * If the subnets are part of a VPC that has an internet gateway attached to it, the DB cluster is public. 
		 Valid for: Multi-AZ DB clusters only
		"""

										type: "boolean"
									}
									region: {
										description: "Region is which region the DBCluster will be created."
										type:        "string"
									}
									replicationSourceIdentifier: {
										description: """
		The Amazon Resource Name (ARN) of the source DB instance or DB cluster if this DB cluster is created as a read replica. 
		 Valid for: Aurora DB clusters only
		"""

										type: "string"
									}
									restoreFrom: {
										description: "RestoreFrom specifies the details of the backup to restore when creating a new DBCluster."

										properties: {
											s3: {
												description: "S3 specifies the details of the S3 backup to restore from."

												properties: {
													bucketName: {
														description: "BucketName is the name of the S3 bucket containing the backup to restore."

														type: "string"
													}
													ingestionRoleARN: {
														description: "IngestionRoleARN is the IAM role RDS can assume that will allow it to access the contents of the S3 bucket."

														type: "string"
													}
													prefix: {
														description: "Prefix is the path prefix of the S3 bucket within which the backup to restore is located."

														type: "string"
													}
													sourceEngine: {
														description: "SourceEngine is the engine used to create the backup. Must be \"mysql\"."

														type: "string"
													}
													sourceEngineVersion: {
														description: "SourceEngineVersion is the version of the engine used to create the backup. Example: \"5.7.30\""

														type: "string"
													}
												}
												required: [
													"bucketName",
													"ingestionRoleARN",
													"sourceEngine",
													"sourceEngineVersion",
												]
												type: "object"
											}
											snapshot: {
												description: "Snapshot specifies the details of the snapshot to restore from."

												properties: snapshotIdentifier: {
													description: "SnapshotIdentifier is the identifier of the snapshot to restore."

													type: "string"
												}
												required: ["snapshotIdentifier"]
												type: "object"
											}
											source: {
												description: "Source is the type of the backup to restore when creating a new DBCluster. Only S3 and Snapshot are supported at present."

												type: "string"
											}
										}
										required: ["source"]
										type: "object"
									}
									scalingConfiguration: {
										description: """
		For DB clusters in serverless DB engine mode, the scaling properties of the DB cluster. 
		 Valid for: Aurora DB clusters only
		"""

										properties: {
											autoPause: type: "boolean"
											maxCapacity: {
												format: "int64"
												type:   "integer"
											}
											minCapacity: {
												format: "int64"
												type:   "integer"
											}
											secondsBeforeTimeout: {
												format: "int64"
												type:   "integer"
											}
											secondsUntilAutoPause: {
												format: "int64"
												type:   "integer"
											}
											timeoutAction: type: "string"
										}
										type: "object"
									}
									serverlessV2ScalingConfiguration: {
										properties: {
											maxCapacity: type: "number"
											minCapacity: type: "number"
										}
										type: "object"
									}
									skipFinalSnapshot: {
										description: """
		A value that indicates whether to skip the creation of a final DB cluster snapshot before the DB cluster is deleted. If skip is specified, no DB cluster snapshot is created. If skip isn't specified, a DB cluster snapshot is created before the DB cluster is deleted. By default, skip isn't specified, and the DB cluster snapshot is created. By default, this parameter is disabled. 
		 You must specify a FinalDBSnapshotIdentifier parameter if SkipFinalSnapshot is disabled.
		"""

										type: "boolean"
									}
									sourceRegion: {
										description: "SourceRegion is the source region where the resource exists. This is not sent over the wire and is only used for presigning. This value should always have the same region as the source ARN."

										type: "string"
									}
									storageEncrypted: {
										description: """
		A value that indicates whether the DB cluster is encrypted. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
		"""

										type: "boolean"
									}
									storageType: {
										description: """
		Specifies the storage type to be associated with the DB cluster. 
		 This setting is required to create a Multi-AZ DB cluster. 
		 Valid values: io1 
		 When specified, a value for the Iops parameter is required. 
		 Default: io1 
		 Valid for: Multi-AZ DB clusters only
		"""

										type: "string"
									}
									tags: {
										description: """
		Tags to assign to the DB cluster. 
		 Valid for: Aurora DB clusters and Multi-AZ DB clusters
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
											required: ["name"]
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
									vpcSecurityGroupIDs: {
										description: "A list of EC2 VPC security groups to associate with this DB cluster."

										items: type: "string"
										type: "array"
									}
								}
								required: [
									"engine",
									"masterUserPasswordSecretRef",
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
						description: "DBClusterStatus defines the observed state of DBCluster."
						properties: {
							atProvider: {
								description: "DBClusterObservation defines the observed state of DBCluster"
								properties: {
									activityStreamKMSKeyID: {
										description: """
		The Amazon Web Services KMS key identifier used for encrypting messages in the database activity stream. 
		 The Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key.
		"""

										type: "string"
									}
									activityStreamKinesisStreamName: {
										description: "The name of the Amazon Kinesis data stream used for the database activity stream."

										type: "string"
									}
									activityStreamMode: {
										description: "The mode of the database activity stream. Database events such as a change or access generate an activity stream event. The database session can handle these events either synchronously or asynchronously."

										type: "string"
									}
									activityStreamStatus: {
										description: "The status of the database activity stream."
										type:        "string"
									}
									associatedRoles: {
										description: "Provides a list of the Amazon Web Services Identity and Access Management (IAM) roles that are associated with the DB cluster. IAM roles that are associated with a DB cluster grant permission for the DB cluster to access other Amazon Web Services on your behalf."

										items: {
											properties: {
												featureName: type: "string"
												roleARN: type: "string"
												status: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									automaticRestartTime: {
										description: "The time when a stopped DB cluster is restarted automatically."
										format:      "date-time"
										type:        "string"
									}
									backtrackConsumedChangeRecords: {
										description: "The number of change records stored for Backtrack."
										format:      "int64"
										type:        "integer"
									}
									capacity: {
										description: """
		The current capacity of an Aurora Serverless v1 DB cluster. The capacity is 0 (zero) when the cluster is paused. 
		 For more information about Aurora Serverless v1, see Using Amazon Aurora Serverless v1 (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.html) in the Amazon Aurora User Guide.
		"""

										format: "int64"
										type:   "integer"
									}
									cloneGroupID: {
										description: "Identifies the clone group to which the DB cluster is associated."

										type: "string"
									}
									clusterCreateTime: {
										description: "Specifies the time when the DB cluster was created, in Universal Coordinated Time (UTC)."

										format: "date-time"
										type:   "string"
									}
									crossAccountClone: {
										description: "Specifies whether the DB cluster is a clone of a DB cluster owned by a different Amazon Web Services account."

										type: "boolean"
									}
									customEndpoints: {
										description: "Identifies all custom endpoints associated with the cluster."

										items: type: "string"
										type: "array"
									}
									dbClusterARN: {
										description: "The Amazon Resource Name (ARN) for the DB cluster."
										type:        "string"
									}
									dbClusterIdentifier: {
										description: "Contains a user-supplied DB cluster identifier. This identifier is the unique key that identifies a DB cluster."

										type: "string"
									}
									dbClusterMembers: {
										description: "Provides the list of instances that make up the DB cluster."

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
									dbClusterOptionGroupMemberships: {
										description: "Provides the list of option group memberships for this DB cluster."

										items: {
											properties: {
												dbClusterOptionGroupName: type: "string"
												status: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									dbClusterParameterGroup: {
										description: "Specifies the name of the DB cluster parameter group for the DB cluster."

										type: "string"
									}
									dbClusterResourceID: {
										description: "The Amazon Web Services Region-unique, immutable identifier for the DB cluster. This identifier is found in Amazon Web Services CloudTrail log entries whenever the KMS key for the DB cluster is accessed."

										type: "string"
									}
									dbSubnetGroup: {
										description: "Specifies information on the subnet group associated with the DB cluster, including the name, description, and subnets in the subnet group."

										type: "string"
									}
									domainMemberships: {
										description: "The Active Directory Domain membership records associated with the DB cluster."

										items: {
											properties: {
												domain: type: "string"
												fQDN: type: "string"
												iamRoleName: type: "string"
												status: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									earliestBacktrackTime: {
										description: "The earliest time to which a DB cluster can be backtracked."
										format:      "date-time"
										type:        "string"
									}
									earliestRestorableTime: {
										description: "The earliest time to which a database can be restored with point-in-time restore."

										format: "date-time"
										type:   "string"
									}
									enabledCloudwatchLogsExports: {
										description: """
		A list of log types that this DB cluster is configured to export to CloudWatch Logs. 
		 Log types vary by DB engine. For information about the log types for each DB engine, see Amazon RDS Database Log Files (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html) in the Amazon Aurora User Guide.
		"""

										items: type: "string"
										type: "array"
									}
									endpoint: {
										description: "Specifies the connection endpoint for the primary instance of the DB cluster."

										type: "string"
									}
									globalWriteForwardingRequested: {
										description: "Specifies whether you have requested to enable write forwarding for a secondary cluster in an Aurora global database. Because write forwarding takes time to enable, check the value of GlobalWriteForwardingStatus to confirm that the request has completed before using the write forwarding feature for this cluster."

										type: "boolean"
									}
									globalWriteForwardingStatus: {
										description: "Specifies whether a secondary cluster in an Aurora global database has write forwarding enabled, not enabled, or is in the process of enabling it."

										type: "string"
									}
									hostedZoneID: {
										description: "Specifies the ID that Amazon Route 53 assigns when you create a hosted zone."

										type: "string"
									}
									httpEndpointEnabled: {
										description: """
		A value that indicates whether the HTTP endpoint for an Aurora Serverless v1 DB cluster is enabled. 
		 When enabled, the HTTP endpoint provides a connectionless web service API for running SQL queries on the Aurora Serverless v1 DB cluster. You can also query your database from inside the RDS console with the query editor. 
		 For more information, see Using the Data API for Aurora Serverless v1 (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html) in the Amazon Aurora User Guide.
		"""

										type: "boolean"
									}
									iamDatabaseAuthenticationEnabled: {
										description: "A value that indicates whether the mapping of Amazon Web Services Identity and Access Management (IAM) accounts to database accounts is enabled."

										type: "boolean"
									}
									latestRestorableTime: {
										description: "Specifies the latest time to which a database can be restored with point-in-time restore."

										format: "date-time"
										type:   "string"
									}
									multiAZ: {
										description: "Specifies whether the DB cluster has instances in multiple Availability Zones."

										type: "boolean"
									}
									percentProgress: {
										description: "Specifies the progress of the operation as a percentage."
										type:        "string"
									}
									performanceInsightsEnabled: {
										description: """
		True if Performance Insights is enabled for the DB cluster, and otherwise false. 
		 This setting is only for non-Aurora Multi-AZ DB clusters.
		"""

										type: "boolean"
									}
									readReplicaIdentifiers: {
										description: "Contains one or more identifiers of the read replicas associated with this DB cluster."

										items: type: "string"
										type: "array"
									}
									readerEndpoint: {
										description: """
		The reader endpoint for the DB cluster. The reader endpoint for a DB cluster load-balances connections across the Aurora Replicas that are available in a DB cluster. As clients request new connections to the reader endpoint, Aurora distributes the connection requests among the Aurora Replicas in the DB cluster. This functionality can help balance your read workload across multiple Aurora Replicas in your DB cluster. 
		 If a failover occurs, and the Aurora Replica that you are connected to is promoted to be the primary instance, your connection is dropped. To continue sending your read workload to other Aurora Replicas in the cluster, you can then reconnect to the reader endpoint.
		"""

										type: "string"
									}
									scalingConfigurationInfo: {
										properties: {
											autoPause: type: "boolean"
											maxCapacity: {
												format: "int64"
												type:   "integer"
											}
											minCapacity: {
												format: "int64"
												type:   "integer"
											}
											secondsBeforeTimeout: {
												format: "int64"
												type:   "integer"
											}
											secondsUntilAutoPause: {
												format: "int64"
												type:   "integer"
											}
											timeoutAction: type: "string"
										}
										type: "object"
									}
									status: {
										description: "Specifies the current state of this DB cluster."
										type:        "string"
									}
									tagList: {
										items: {
											properties: {
												key: type: "string"
												value: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									vpcSecurityGroups: {
										description: "Provides a list of VPC security groups that the DB cluster belongs to."

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
