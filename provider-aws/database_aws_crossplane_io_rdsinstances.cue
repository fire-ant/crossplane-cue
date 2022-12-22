package database_aws_crossplane_io_rdsinstances

customresourcedefinition: "rdsinstances.database.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "rdsinstances.database.aws.crossplane.io"
	}
	spec: {
		group: "database.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "RDSInstance"
			listKind: "RDSInstanceList"
			plural:   "rdsinstances"
			singular: "rdsinstance"
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
				jsonPath: ".status.atProvider.dbInstanceStatus"
				name:     "STATE"
				type:     "string"
			}, {
				jsonPath: ".spec.forProvider.engine"
				name:     "ENGINE"
				type:     "string"
			}, {
				jsonPath: ".spec.forProvider.engineVersion"
				name:     "VERSION"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "An RDSInstance is a managed resource that represents an AWS Relational Database Service instance."

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
						description: "An RDSInstanceSpec defines the desired state of an RDSInstance."
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
								description: "RDSInstanceParameters define the desired state of an AWS Relational Database Service instance."

								properties: {
									allocatedStorage: {
										description: "AllocatedStorage is the amount of storage (in gibibytes) to allocate for the DB instance. Type: Integer Amazon Aurora Not applicable. Aurora cluster volumes automatically grow as the amount of data in your database increases, though you are only charged for the space that you use in an Aurora cluster volume. MySQL Constraints to the amount of storage for each storage type are the following: * General Purpose (SSD) storage (gp2): Must be an integer from 20 to 16384. * Provisioned IOPS storage (io1): Must be an integer from 100 to 16384. * Magnetic storage (standard): Must be an integer from 5 to 3072. MariaDB Constraints to the amount of storage for each storage type are the following: * General Purpose (SSD) storage (gp2): Must be an integer from 20 to 16384. * Provisioned IOPS storage (io1): Must be an integer from 100 to 16384. * Magnetic storage (standard): Must be an integer from 5 to 3072. PostgreSQL Constraints to the amount of storage for each storage type are the following: * General Purpose (SSD) storage (gp2): Must be an integer from 20 to 16384. * Provisioned IOPS storage (io1): Must be an integer from 100 to 16384. * Magnetic storage (standard): Must be an integer from 5 to 3072. Oracle Constraints to the amount of storage for each storage type are the following: * General Purpose (SSD) storage (gp2): Must be an integer from 20 to 16384. * Provisioned IOPS storage (io1): Must be an integer from 100 to 16384. * Magnetic storage (standard): Must be an integer from 10 to 3072. SQL Server Constraints to the amount of storage for each storage type are the following: * General Purpose (SSD) storage (gp2): Enterprise and Standard editions: Must be an integer from 200 to 16384. Web and Express editions: Must be an integer from 20 to 16384. * Provisioned IOPS storage (io1): Enterprise and Standard editions: Must be an integer from 200 to 16384. Web and Express editions: Must be an integer from 100 to 16384. * Magnetic storage (standard): Enterprise and Standard editions: Must be an integer from 200 to 1024. Web and Express editions: Must be an integer from 20 to 1024."

										type: "integer"
									}
									allowMajorVersionUpgrade: {
										description: "AllowMajorVersionUpgrade indicates that major version upgrades are allowed. Changing this parameter doesn't result in an outage and the change is asynchronously applied as soon as possible. Constraints: This parameter must be set to true when specifying a value for the EngineVersion parameter that is a different major version than the DB instance's current version."

										type: "boolean"
									}
									applyModificationsImmediately: {
										description: "ApplyModificationsImmediately specifies whether the modifications in this request and any pending modifications are asynchronously applied as soon as possible, regardless of the PreferredMaintenanceWindow setting for the DB instance. If this parameter is set to false, changes to the DB instance are applied during the next maintenance window. Some parameter changes can cause an outage and are applied on the next call to RebootDBInstance, or the next failure reboot. Review the table of parameters in Modifying a DB Instance and Using the Apply Immediately Parameter (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.DBInstance.Modifying.html) in the Amazon RDS User Guide. to see the impact that setting ApplyImmediately to true or false has for each modified parameter and to determine when the changes are applied. Default: false"

										type: "boolean"
									}
									autoMinorVersionUpgrade: {
										description: "AutoMinorVersionUpgrade indicates that minor engine upgrades are applied automatically to the DB instance during the maintenance window. Default: true"

										type: "boolean"
									}
									availabilityZone: {
										description: "AvailabilityZone is the EC2 Availability Zone that the DB instance is created in. For information on AWS Regions and Availability Zones, see Regions and Availability Zones (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html). Default: A random, system-chosen Availability Zone in the endpoint's AWS Region. Example: us-east-1d Constraint: The AvailabilityZone parameter can't be specified if the MultiAZ parameter is set to true. The specified Availability Zone must be in the same AWS Region as the current endpoint."

										type: "string"
									}
									backupRetentionPeriod: {
										description: "BackupRetentionPeriod is the number of days for which automated backups are retained. Setting this parameter to a positive number enables backups. Setting this parameter to 0 disables automated backups. Amazon Aurora Not applicable. The retention period for automated backups is managed by the DB cluster. For more information, see CreateDBCluster. Default: 1 Constraints: * Must be a value from 0 to 35 * Cannot be set to 0 if the DB instance is a source to Read Replicas"

										type: "integer"
									}
									caCertificateIdentifier: {
										description: "CACertificateIdentifier indicates the certificate that needs to be associated with the instance."

										type: "string"
									}
									characterSetName: {
										description: "CharacterSetName indicates that the DB instance should be associated with the specified CharacterSet for supported engines, Amazon Aurora Not applicable. The character set is managed by the DB cluster. For more information, see CreateDBCluster."

										type: "string"
									}
									cloudwatchLogsExportConfiguration: {
										description: "CloudwatchLogsExportConfiguration is the configuration setting for the log types to be enabled for export to CloudWatch Logs for a specific DB instance."

										properties: {
											disableLogTypes: {
												description: "DisableLogTypes is the list of log types to disable."
												items: type: "string"
												type: "array"
											}
											enableLogTypes: {
												description: "EnableLogTypes is the list of log types to enable."
												items: type: "string"
												type: "array"
											}
										}
										type: "object"
									}
									copyTagsToSnapshot: {
										description: "CopyTagsToSnapshot should be true to copy all tags from the DB instance to snapshots of the DB instance, and otherwise false. The default is false."

										type: "boolean"
									}
									dbClusterIdentifier: {
										description: "DBClusterIdentifier is the identifier of the DB cluster that the instance will belong to. For information on creating a DB cluster, see CreateDBCluster. Type: String"

										type: "string"
									}
									dbInstanceClass: {
										description: "DBInstanceClass is the compute and memory capacity of the DB instance, for example, db.m4.large. Not all DB instance classes are available in all AWS Regions, or for all database engines. For the full list of DB instance classes, and availability for your engine, see DB Instance Class (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) in the Amazon RDS User Guide."

										type: "string"
									}
									dbName: {
										description: "DBName is the meaning of this parameter differs according to the database engine you use. Type: String MySQL The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Constraints: * Must contain 1 to 64 letters or numbers. * Cannot be a word reserved by the specified database engine MariaDB The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Constraints: * Must contain 1 to 64 letters or numbers. * Cannot be a word reserved by the specified database engine PostgreSQL The name of the database to create when the DB instance is created. If this parameter is not specified, the default \"postgres\" database is created in the DB instance. Constraints: * Must contain 1 to 63 letters, numbers, or underscores. * Must begin with a letter or an underscore. Subsequent characters can be letters, underscores, or digits (0-9). * Cannot be a word reserved by the specified database engine Oracle The Oracle System ID (SID) of the created DB instance. If you specify null, the default value ORCL is used. You can't specify the string NULL, or any other reserved word, for DBName. Default: ORCL Constraints: * Cannot be longer than 8 characters SQL Server Not applicable. Must be null. Amazon Aurora The name of the database to create when the primary instance of the DB cluster is created. If this parameter is not specified, no database is created in the DB instance. Constraints: * Must contain 1 to 64 letters or numbers. * Cannot be a word reserved by the specified database engine"

										type: "string"
									}
									dbParameterGroupName: {
										description: "DBParameterGroupName is the name of the DB parameter group to associate with this DB instance. If this argument is omitted, the default DBParameterGroup for the specified engine is used. Constraints: * Must be 1 to 255 letters, numbers, or hyphens. * First character must be a letter * Cannot end with a hyphen or contain two consecutive hyphens"

										type: "string"
									}
									dbSecurityGroups: {
										description: "DBSecurityGroups is a list of DB security groups to associate with this DB instance. Default: The default DB security group for the database engine."

										items: type: "string"
										type: "array"
									}
									dbSubnetGroupName: {
										description: "DBSubnetGroupName is a DB subnet group to associate with this DB instance. If there is no DB subnet group, then it is a non-VPC DB instance."

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
									deleteAutomatedBackups: {
										description: "DeleteAutomatedBackups indicates whether to remove automated backups immediately after the DB instance is deleted. The default is to remove automated backups immediately after the DB instance is deleted."

										type: "boolean"
									}
									deletionProtection: {
										description: "DeletionProtection indicates if the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false. For more information, see  Deleting a DB Instance (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html)."

										type: "boolean"
									}
									domain: {
										description: "Domain specifies the Active Directory Domain to create the instance in."

										type: "string"
									}
									domainIAMRoleName: {
										description: "DomainIAMRoleName specifies the name of the IAM role to be used when making API calls to the Directory Service."

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
										description: "EnableCloudwatchLogsExports is the list of log types that need to be enabled for exporting to CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see Publishing Database Logs to Amazon CloudWatch Logs  (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the Amazon Relational Database Service User Guide."

										items: type: "string"
										type: "array"
									}
									enableIAMDatabaseAuthentication: {
										description: "EnableIAMDatabaseAuthentication should be true to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts, and otherwise false. You can enable IAM database authentication for the following database engines: Amazon Aurora Not applicable. Mapping AWS IAM accounts to database accounts is managed by the DB cluster. For more information, see CreateDBCluster. MySQL * For MySQL 5.6, minor version 5.6.34 or higher * For MySQL 5.7, minor version 5.7.16 or higher Default: false"

										type: "boolean"
									}
									enablePerformanceInsights: {
										description: "EnablePerformanceInsights should be true to enable Performance Insights for the DB instance, and otherwise false. For more information, see Using Amazon Performance Insights (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html) in the Amazon Relational Database Service User Guide."

										type: "boolean"
									}
									engine: {
										description: "Engine is the name of the database engine to be used for this instance. Not every database engine is available for every AWS Region. Valid Values: * aurora (for MySQL 5.6-compatible Aurora) * aurora-mysql (for MySQL 5.7-compatible Aurora) * aurora-postgresql * mariadb * mysql * oracle-ee * oracle-se2 * oracle-se1 * oracle-se * postgres * sqlserver-ee * sqlserver-se * sqlserver-ex * sqlserver-web Engine is a required field"

										type: "string"
									}
									engineVersion: {
										description: "EngineVersion is the version number of the database engine to use. For a list of valid engine versions, call DescribeDBEngineVersions. The following are the database engines and links to information about the major and minor versions that are available with Amazon RDS. Not every database engine is available for every AWS Region. Amazon Aurora Not applicable. The version number of the database engine to be used by the DB instance is managed by the DB cluster. For more information, see CreateDBCluster. MariaDB See MariaDB on Amazon RDS Versions (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MariaDB.html#MariaDB.Concepts.VersionMgmt) in the Amazon RDS User Guide. Microsoft SQL Server See Version and Feature Support on Amazon RDS (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.FeatureSupport) in the Amazon RDS User Guide. MySQL See MySQL on Amazon RDS Versions (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt) in the Amazon RDS User Guide. Oracle See Oracle Database Engine Release Notes (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.Oracle.PatchComposition.html) in the Amazon RDS User Guide. PostgreSQL See Supported PostgreSQL Database Versions (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts.General.DBVersions) in the Amazon RDS User Guide."

										type: "string"
									}
									finalDBSnapshotIdentifier: {
										description: "The DBSnapshotIdentifier of the new DBSnapshot created when SkipFinalSnapshot is set to false. Specifying this parameter and also setting the SkipFinalShapshot parameter to true results in an error. Constraints: * Must be 1 to 255 letters or numbers. * First character must be a letter * Cannot end with a hyphen or contain two consecutive hyphens * Cannot be specified when deleting a Read Replica."

										type: "string"
									}
									iops: {
										description: "IOPS is the amount of Provisioned IOPS (input/output operations per second) to be initially allocated for the DB instance. For information about valid IOPS values, see see Amazon RDS Provisioned IOPS Storage to Improve Performance (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS) in the Amazon RDS User Guide. Constraints: Must be a multiple between 1 and 50 of the storage amount for the DB instance. Must also be an integer multiple of 1000. For example, if the size of your DB instance is 500 GiB, then your IOPS value can be 2000, 3000, 4000, or 5000."

										type: "integer"
									}
									kmsKeyId: {
										description: "KMSKeyID for an encrypted DB instance. The KMS key identifier is the Amazon Resource Name (ARN) for the KMS encryption key. If you are creating a DB instance with the same AWS account that owns the KMS encryption key used to encrypt the new DB instance, then you can use the KMS key alias instead of the ARN for the KM encryption key. Amazon Aurora Not applicable. The KMS key identifier is managed by the DB cluster. For more information, see CreateDBCluster. If the StorageEncrypted parameter is true, and you do not specify a value for the KMSKeyID parameter, then Amazon RDS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS Region."

										type: "string"
									}
									licenseModel: {
										description: "LicenseModel information for this DB instance. Valid values: license-included | bring-your-own-license | general-public-license"

										type: "string"
									}
									masterPasswordSecretRef: {
										description: "MasterPasswordSecretRef references the secret that contains the password used in the creation of this RDS instance. If no reference is given, a password will be auto-generated."

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
										description: "MasterUsername is the name for the master user. Amazon Aurora Not applicable. The name for the master user is managed by the DB cluster. For more information, see CreateDBCluster. MariaDB Constraints: * Required for MariaDB. * Must be 1 to 16 letters or numbers. * Cannot be a reserved word for the chosen database engine. Microsoft SQL Server Constraints: * Required for SQL Server. * Must be 1 to 128 letters or numbers. * The first character must be a letter. * Cannot be a reserved word for the chosen database engine. MySQL Constraints: * Required for MySQL. * Must be 1 to 16 letters or numbers. * First character must be a letter. * Cannot be a reserved word for the chosen database engine. Oracle Constraints: * Required for Oracle. * Must be 1 to 30 letters or numbers. * First character must be a letter. * Cannot be a reserved word for the chosen database engine. PostgreSQL Constraints: * Required for PostgreSQL. * Must be 1 to 63 letters or numbers. * First character must be a letter. * Cannot be a reserved word for the chosen database engine."

										type: "string"
									}
									maxAllocatedStorage: {
										description: """
		The upper limit to which Amazon RDS can automatically scale the storage of the DB instance. 
		 For more information about this setting, including limitations that apply to it, see Managing capacity automatically with Amazon RDS storage autoscaling (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PIOPS.StorageTypes.html#USER_PIOPS.Autoscaling) in the Amazon RDS User Guide.
		"""

										type: "integer"
									}
									monitoringInterval: {
										description: "MonitoringInterval is the interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. If MonitoringRoleARN is specified, then you must also set MonitoringInterval to a value other than 0. Valid Values: 0, 1, 5, 10, 15, 30, 60"

										type: "integer"
									}
									monitoringRoleArn: {
										description: "MonitoringRoleARN is the ARN for the IAM role that permits RDS to send enhanced monitoring metrics to Amazon CloudWatch Logs. For example, arn:aws:iam:123456789012:role/emaccess. For information on creating a monitoring role, go to Setting Up and Enabling Enhanced Monitoring (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html#USER_Monitoring.OS.Enabling) in the Amazon RDS User Guide. If MonitoringInterval is set to a value other than 0, then you must supply a MonitoringRoleARN value."

										type: "string"
									}
									monitoringRoleArnRef: {
										description: "MonitoringRoleARNRef is a reference to an IAMRole used to set MonitoringRoleARN."

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
									monitoringRoleArnSelector: {
										description: "MonitoringRoleARNSelector selects a reference to an IAMRole used to set MonitoringRoleARN."

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
									multiAZ: {
										description: "MultiAZ specifies if the DB instance is a Multi-AZ deployment. You can't set the AvailabilityZone parameter if the MultiAZ parameter is set to true."

										type: "boolean"
									}
									optionGroupName: {
										description: "OptionGroupName indicates that the DB instance should be associated with the specified option group. Permanent options, such as the TDE option for Oracle Advanced Security TDE, can't be removed from an option group, and that option group can't be removed from a DB instance once it is associated with a DB instance"

										type: "string"
									}
									performanceInsightsKMSKeyId: {
										description: "PerformanceInsightsKMSKeyID is the AWS KMS key identifier for encryption of Performance Insights data. The KMS key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS encryption key."

										type: "string"
									}
									performanceInsightsRetentionPeriod: {
										description: "PerformanceInsightsRetentionPeriod is the amount of time, in days, to retain Performance Insights data. Valid values are 7 or 731 (2 years)."

										type: "integer"
									}
									port: {
										description: "Port number on which the database accepts connections. MySQL Default: 3306 Valid Values: 1150-65535 Type: Integer MariaDB Default: 3306 Valid Values: 1150-65535 Type: Integer PostgreSQL Default: 5432 Valid Values: 1150-65535 Type: Integer Oracle Default: 1521 Valid Values: 1150-65535 SQL Server Default: 1433 Valid Values: 1150-65535 except for 1434, 3389, 47001, 49152, and 49152 through 49156. Amazon Aurora Default: 3306 Valid Values: 1150-65535 Type: Integer"

										type: "integer"
									}
									preferredBackupWindow: {
										description: "PreferredBackupWindow is the daily time range during which automated backups are created if automated backups are enabled, using the BackupRetentionPeriod parameter. For more information, see The Backup Window (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html#USER_WorkingWithAutomatedBackups.BackupWindow) in the Amazon RDS User Guide. Amazon Aurora Not applicable. The daily time range for creating automated backups is managed by the DB cluster. For more information, see CreateDBCluster. The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region. To see the time blocks available, see  Adjusting the Preferred DB Instance Maintenance Window (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow) in the Amazon RDS User Guide. Constraints: * Must be in the format hh24:mi-hh24:mi. * Must be in Universal Coordinated Time (UTC). * Must not conflict with the preferred maintenance window. * Must be at least 30 minutes."

										type: "string"
									}
									preferredMaintenanceWindow: {
										description: "PreferredMaintenanceWindow is the time range each week during which system maintenance can occur, in Universal Coordinated Time (UTC). For more information, see Amazon RDS Maintenance Window (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html#Concepts.DBMaintenance). Format: ddd:hh24:mi-ddd:hh24:mi The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region, occurring on a random day of the week. Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun. Constraints: Minimum 30-minute window."

										type: "string"
									}
									processorFeatures: {
										description: "ProcessorFeatures is the number of CPU cores and the number of threads per core for the DB instance class of the DB instance."

										items: {
											description: "ProcessorFeature is a processor feature entry. For more information, see Configuring the Processor of the DB Instance Class (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html#USER_ConfigureProcessor) in the Amazon RDS User Guide. Please also see https://docs.aws.amazon.com/goto/WebAPI/rds-2014-10-31/ProcessorFeature"

											properties: {
												name: {
													description: "Name of the processor feature. Valid names are coreCount and threadsPerCore."

													type: "string"
												}
												value: {
													description: "Value of a processor feature name."
													type:        "string"
												}
											}
											required: [
												"name",
												"value",
											]
											type: "object"
										}
										type: "array"
									}
									promotionTier: {
										description: "PromotionTier specifies the order in which an Aurora Replica is promoted to the primary instance after a failure of the existing primary instance. For more information, see  Fault Tolerance for an Aurora DB Cluster (http://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.FaultTolerance) in the Amazon Aurora User Guide. Default: 1 Valid Values: 0 - 15"

										type: "integer"
									}
									publiclyAccessible: {
										description: "PubliclyAccessible specifies the accessibility options for the DB instance. A value of true specifies an Internet-facing instance with a publicly resolvable DNS name, which resolves to a public IP address. A value of false specifies an internal instance with a DNS name that resolves to a private IP address. Default: The default behavior varies depending on whether DBSubnetGroupName is specified. If DBSubnetGroupName is not specified, and PubliclyAccessible is not specified, the following applies: * If the default VPC in the target region doesn’t have an Internet gateway attached to it, the DB instance is private. * If the default VPC in the target region has an Internet gateway attached to it, the DB instance is public. If DBSubnetGroupName is specified, and PubliclyAccessible is not specified, the following applies: * If the subnets are part of a VPC that doesn’t have an Internet gateway attached to it, the DB instance is private. * If the subnets are part of a VPC that has an Internet gateway attached to it, the DB instance is public."

										type: "boolean"
									}
									region: {
										description: "Region is the region you'd like your RDSInstance to be created in."

										type: "string"
									}
									restoreFrom: {
										description: "RestoreFrom specifies the details of the backup to restore when creating a new RDS instance. (If the RDS instance already exists, this property will be ignored.)"

										properties: {
											pointInTime: {
												description: "PointInTime specifies the details of the point in time restore."

												properties: {
													restoreTime: {
														description: "RestoreTime is the date and time (UTC) to restore from. Must be before the latest restorable time for the DB instance. Can't be specified if the useLatestRestorableTime parameter is enabled. Example: 2011-09-07T23:45:00Z"

														format: "date-time"
														type:   "string"
													}
													sourceDBInstanceAutomatedBackupsArn: {
														description: "SourceDBInstanceAutomatedBackupsArn specifies the Amazon Resource Name (ARN) of the replicated automated backups from which to restore. Example: arn:aws:rds:useast-1:123456789012:auto-backup:ab-L2IJCEXJP7XQ7HOJ4SIEXAMPLE"

														type: "string"
													}
													sourceDBInstanceIdentifier: {
														description: "SourceDBInstanceIdentifier specifies the identifier of the source DB instance from which to restore. Constraints: Must match the identifier of an existing DB instance."

														type: "string"
													}
													sourceDbiResourceId: {
														description: "SourceDbiResourceID specifies the resource ID of the source DB instance from which to restore."

														type: "string"
													}
													useLatestRestorableTime: {
														description: "UseLatestRestorableTime indicates that the DB instance is restored from the latest backup Can't be specified if the restoreTime parameter is provided."

														type: "boolean"
													}
												}
												type: "object"
											}
											s3: {
												description: "S3 specifies the details of the S3 backup to restore from."

												properties: {
													bucketName: {
														description: "BucketName is the name of the S3 bucket containing the backup to restore."

														type: "string"
													}
													bucketNameRef: {
														description: "BucketNameRef is a reference to a Bucket used to set BucketName."

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
													bucketNameSelector: {
														description: "BucketNameSelector selects a reference to a Bucket used to set BucketName."

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
													ingestionRoleARN: {
														description: "IngestionRoleARN is the IAM role RDS can assume that will allow it to access the contents of the S3 bucket."

														type: "string"
													}
													ingestionRoleARNRef: {
														description: "IngestionRoleARNRef is a reference to a IAM Role used to set IngestionRoleARN."

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
													ingestionRoleARNSelector: {
														description: "IngestionRoleARNSelector selects a reference to a IAM Role used to set IngestionRoleARN."

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
													"sourceEngine",
													"sourceEngineVersion",
												]
												type: "object"
											}
											snapshot: {
												description: "Snapshot specifies the details of the database snapshot to restore from."

												properties: snapshotIdentifier: {
													description: "SnapshotIdentifier is the identifier of the database snapshot to restore."

													type: "string"
												}
												required: ["snapshotIdentifier"]
												type: "object"
											}
											source: {
												description: "Source is the type of the backup to restore when creating a new RDS instance. S3, Snapshot and PointInTime are supported."

												enum: [
													"S3",
													"Snapshot",
													"PointInTime",
												]
												type: "string"
											}
										}
										required: ["source"]
										type: "object"
									}
									scalingConfiguration: {
										description: "ScalingConfiguration is the scaling properties of the DB cluster. You can only modify scaling properties for DB clusters in serverless DB engine mode."

										properties: {
											autoPause: {
												description: "AutoPause specifies whether to allow or disallow automatic pause for an Aurora DB cluster in serverless DB engine mode. A DB cluster can be paused only when it's idle (it has no connections). If a DB cluster is paused for more than seven days, the DB cluster might be backed up with a snapshot. In this case, the DB cluster is restored when there is a request to connect to it."

												type: "boolean"
											}
											maxCapacity: {
												description: "MaxCapacity is the maximum capacity for an Aurora DB cluster in serverless DB engine mode. Valid capacity values are 2, 4, 8, 16, 32, 64, 128, and 256. The maximum capacity must be greater than or equal to the minimum capacity."

												type: "integer"
											}
											minCapacity: {
												description: "MinCapacity is the minimum capacity for an Aurora DB cluster in serverless DB engine mode. Valid capacity values are 2, 4, 8, 16, 32, 64, 128, and 256. The minimum capacity must be less than or equal to the maximum capacity."

												type: "integer"
											}
											secondsUntilAutoPause: {
												description: "SecondsUntilAutoPause is the time, in seconds, before an Aurora DB cluster in serverless mode is paused."

												type: "integer"
											}
										}
										type: "object"
									}
									skipFinalSnapshotBeforeDeletion: {
										description: "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted. Note that when a DB instance is in a failure state and has a status of 'failed', 'incompatible-restore', or 'incompatible-network', it can only be deleted when the SkipFinalSnapshotBeforeDeletion parameter is set to \"true\". Specify true when deleting a Read Replica. The FinalDBSnapshotIdentifier parameter must be specified if SkipFinalSnapshotBeforeDeletion is false. Default: false"

										type: "boolean"
									}
									storageEncrypted: {
										description: "StorageEncrypted specifies whether the DB instance is encrypted. Amazon Aurora Not applicable. The encryption for DB instances is managed by the DB cluster. For more information, see CreateDBCluster. Default: false"

										type: "boolean"
									}
									storageType: {
										description: "StorageType specifies the storage type to be associated with the DB instance. Valid values: standard | gp2 | io1 If you specify io1, you must also include a value for the IOPS parameter. Default: io1 if the IOPS parameter is specified, otherwise standard"

										type: "string"
									}
									tags: {
										description: "Tags. For more information, see Tagging Amazon RDS Resources (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.html) in the Amazon RDS User Guide."

										items: {
											description: "Tag is a metadata assigned to an Amazon RDS resource consisting of a key-value pair. Please also see https://docs.aws.amazon.com/goto/WebAPI/rds-2014-10-31/Tag"

											properties: {
												key: {
													description: "A key is the required name of the tag. The string value can be from 1 to 128 Unicode characters in length and can't be prefixed with \"aws:\" or \"rds:\". The string can only contain only the set of Unicode letters, digits, white-space, '_', '.', '/', '=', '+', '-' (Java regex: \"^([\\\\p{L}\\\\p{Z}\\\\p{N}_.:/=+\\\\-]*)$\")."

													type: "string"
												}
												value: {
													description: "A value is the optional value of the tag. The string value can be from 1 to 256 Unicode characters in length and can't be prefixed with \"aws:\" or \"rds:\". The string can only contain only the set of Unicode letters, digits, white-space, '_', '.', '/', '=', '+', '-' (Java regex: \"^([\\\\p{L}\\\\p{Z}\\\\p{N}_.:/=+\\\\-]*)$\")."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									timezone: {
										description: "Timezone of the DB instance. The time zone parameter is currently supported only by Microsoft SQL Server (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.TimeZone)."

										type: "string"
									}
									useDefaultProcessorFeatures: {
										description: "A value that specifies that the DB instance class of the DB instance uses its default processor features."

										type: "boolean"
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
									vpcSecurityGroupIds: {
										description: "VPCSecurityGroupIDs is a list of EC2 VPC security groups to associate with this DB instance. Amazon Aurora Not applicable. The associated list of EC2 VPC security groups is managed by the DB cluster. For more information, see CreateDBCluster. Default: The default EC2 VPC security group for the DB subnet group's VPC."

										items: type: "string"
										type: "array"
									}
								}
								required: [
									"dbInstanceClass",
									"engine",
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
						description: "An RDSInstanceStatus represents the observed state of an RDSInstance."

						properties: {
							atProvider: {
								description: "RDSInstanceObservation is the representation of the current state that is observed."

								properties: {
									allocatedStorage: {
										description: "AllocatedStorage is the allocated storage size in gibibytes."

										type: "integer"
									}
									awsBackupRecoveryPointARN: {
										description: "AWSBackupRecoveryPointARN is the Amazon Resource Name (ARN) of the recovery point in Amazon Web Services Backup."

										type: "string"
									}
									backupRetentionPeriod: {
										description: "BackupRetentionPeriod is the number of days for which automated backups are retained."

										type: "integer"
									}
									dbInstanceArn: {
										description: "DBInstanceArn is the Amazon Resource Name (ARN) for the DB instance."

										type: "string"
									}
									dbInstancePort: {
										description: "DBInstancePort specifies the port that the DB instance listens on. If the DB instance is part of a DB cluster, this can be a different port than the DB cluster port."

										type: "integer"
									}
									dbInstanceStatus: {
										description: "DBInstanceStatus specifies the current state of this database."

										type: "string"
									}
									dbParameterGroups: {
										description: "DBParameterGroups provides the list of DB parameter groups applied to this DB instance."

										items: {
											description: """
		DBParameterGroupStatus is the status of the DB parameter group. This data type is used as a response element in the following actions: - CreateDBInstance - CreateDBInstanceReadReplica - DeleteDBInstance - ModifyDBInstance - RebootDBInstance - RestoreDBInstanceFromDBSnapshot 
		 Please also see https://docs.aws.amazon.com/goto/WebAPI/rds-2014-10-31/DBParameterGroupStatus
		"""

											properties: {
												dbParameterGroupName: {
													description: "DBParameterGroupName is the name of the DP parameter group."

													type: "string"
												}
												parameterApplyStatus: {
													description: "ParameterApplyStatus is the status of parameter updates."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									dbResourceId: {
										description: "DBResourceID is the AWS Region-unique, immutable identifier for the DB instance. This identifier is found in AWS CloudTrail log entries whenever the AWS KMS key for the DB instance is accessed."

										type: "string"
									}
									dbSecurityGroups: {
										description: "DBSecurityGroups provides List of DB security group elements containing only DBSecurityGroup.Name and DBSecurityGroup.Status subelements."

										items: {
											description: """
		DBSecurityGroupMembership is used as a response element in the following actions: - ModifyDBInstance - RebootDBInstance - RestoreDBInstanceFromDBSnapshot - RestoreDBInstanceToPointInTime 
		 Please also see https://docs.aws.amazon.com/goto/WebAPI/rds-2014-10-31/DBSecurityGroupMembership
		"""

											properties: {
												dbSecurityGroupName: {
													description: "DBSecurityGroupName is the name of the DB security group."

													type: "string"
												}
												status: {
													description: "Status is the status of the DB security group."
													type:        "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									dbSubnetGroup: {
										description: "DBSubnetGroup specifies information on the subnet group associated with the DB instance, including the name, description, and subnets in the subnet group."

										properties: {
											dbSubnetGroupArn: {
												description: "DBSubnetGroupARN is the Amazon Resource Name (ARN) for the DB subnet group."

												type: "string"
											}
											dbSubnetGroupDescription: {
												description: "DBSubnetGroupDescription provides the description of the DB subnet group."

												type: "string"
											}
											dbSubnetGroupName: {
												description: "DBSubnetGroupName is the name of the DB subnet group."

												type: "string"
											}
											subnetGroupStatus: {
												description: "SubnetGroupStatus provides the status of the DB subnet group."

												type: "string"
											}
											subnets: {
												description: "Subnets contains a list of Subnet elements."
												items: {
													description: "SubnetInRDS is used as a response element in the DescribeDBSubnetGroups action. Please also see https://docs.aws.amazon.com/goto/WebAPI/rds-2014-10-31/Subnet"

													properties: {
														subnetAvailabilityZone: {
															description: "SubnetAvailabilityZone contains Availability Zone information. This data type is used as an element in the following data type: * OrderableDBInstanceOption"

															properties: name: {
																description: "Name of the Availability Zone."
																type:        "string"
															}
															type: "object"
														}
														subnetIdentifier: {
															description: "SubnetIdentifier specifies the identifier of the subnet."

															type: "string"
														}
														subnetStatus: {
															description: "SubnetStatus specifies the status of the subnet."

															type: "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
											vpcId: {
												description: "VPCID provides the VPCID of the DB subnet group."
												type:        "string"
											}
										}
										type: "object"
									}
									domainMemberships: {
										description: "DomainMemberships is the Active Directory Domain membership records associated with the DB instance."

										items: {
											description: "DomainMembership is an Active Directory Domain membership record associated with the DB instance. Please also see https://docs.aws.amazon.com/goto/WebAPI/rds-2014-10-31/DomainMembership"

											properties: {
												domain: {
													description: "Domain is the identifier of the Active Directory Domain."

													type: "string"
												}
												fqdn: {
													description: "FQDN us the fully qualified domain name of the Active Directory Domain."

													type: "string"
												}
												iamRoleName: {
													description: "IAMRoleName is the name of the IAM role to be used when making API calls to the Directory Service."

													type: "string"
												}
												status: {
													description: "Status of the DB instance's Active Directory Domain membership, such as joined, pending-join, failed etc)."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									endpoint: {
										description: "Endpoint specifies the connection endpoint."
										properties: {
											address: {
												description: "Address specifies the DNS address of the DB instance."
												type:        "string"
											}
											hostedZoneId: {
												description: "HostedZoneID specifies the ID that Amazon Route 53 assigns when you create a hosted zone."

												type: "string"
											}
											port: {
												description: "Port specifies the port that the database engine is listening on."

												type: "integer"
											}
										}
										type: "object"
									}
									enhancedMonitoringResourceArn: {
										description: "EnhancedMonitoringResourceArn is the Amazon Resource Name (ARN) of the Amazon CloudWatch Logs log stream that receives the Enhanced Monitoring metrics data for the DB instance."

										type: "string"
									}
									instanceCreateTime: {
										description: "InstanceCreateTime provides the date and time the DB instance was created."

										format: "date-time"
										type:   "string"
									}
									latestRestorableTime: {
										description: "LatestRestorableTime specifies the latest time to which a database can be restored with point-in-time restore."

										format: "date-time"
										type:   "string"
									}
									optionGroupMemberships: {
										description: "OptionGroupMemberships provides the list of option group memberships for this DB instance."

										items: {
											description: "OptionGroupMembership provides information on the option groups the DB instance is a member of. Please also see https://docs.aws.amazon.com/goto/WebAPI/rds-2014-10-31/OptionGroupMembership"

											properties: {
												optionGroupName: {
													description: "OptionGroupName is the name of the option group that the instance belongs to."

													type: "string"
												}
												status: {
													description: "Status is the status of the DB instance's option group membership. Valid values are: in-sync, pending-apply, pending-removal, pending-maintenance-apply, pending-maintenance-removal, applying, removing, and failed."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									pendingModifiedValues: {
										description: "PendingModifiedValues specifies that changes to the DB instance are pending. This element is only included when changes are pending. Specific changes are identified by subelements."

										properties: {
											allocatedStorage: {
												description: "AllocatedStorage contains the new AllocatedStorage size for the DB instance that will be applied or is currently being applied."

												type: "integer"
											}
											backupRetentionPeriod: {
												description: "BackupRetentionPeriod specifies the pending number of days for which automated backups are retained."

												type: "integer"
											}
											caCertificateIdentifier: {
												description: "CACertificateIdentifier specifies the identifier of the CA certificate for the DB instance."

												type: "string"
											}
											dbInstanceClass: {
												description: "DBInstanceClass contains the new DBInstanceClass for the DB instance that will be applied or is currently being applied."

												type: "string"
											}
											dbSubnetGroupName: {
												description: "DBSubnetGroupName is the new DB subnet group for the DB instance."

												type: "string"
											}
											engineVersion: {
												description: "EngineVersion indicates the database engine version."
												type:        "string"
											}
											iops: {
												description: "IOPS specifies the new Provisioned IOPS value for the DB instance that will be applied or is currently being applied."

												type: "integer"
											}
											licenseModel: {
												description: "LicenseModel is the license model for the DB instance. Valid values: license-included | bring-your-own-license | general-public-license"

												type: "string"
											}
											multiAZ: {
												description: "MultiAZ indicates that the Single-AZ DB instance is to change to a Multi-AZ deployment."

												type: "boolean"
											}
											pendingCloudwatchLogsExports: {
												description: "PendingCloudwatchLogsExports is a list of the log types whose configuration is still pending. In other words, these log types are in the process of being activated or deactivated."

												properties: {
													logTypesToDisable: {
														description: "LogTypesToDisable is list of log types that are in the process of being enabled. After they are enabled, these log types are exported to CloudWatch Logs."

														items: type: "string"
														type: "array"
													}
													logTypesToEnable: {
														description: "LogTypesToEnable is the log types that are in the process of being deactivated. After they are deactivated, these log types aren't exported to CloudWatch Logs."

														items: type: "string"
														type: "array"
													}
												}
												type: "object"
											}
											port: {
												description: "Port specifies the pending port for the DB instance."
												type:        "integer"
											}
											processorFeatures: {
												description: "ProcessorFeatures is the number of CPU cores and the number of threads per core for the DB instance class of the DB instance."

												items: {
													description: "ProcessorFeature is a processor feature entry. For more information, see Configuring the Processor of the DB Instance Class (http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html#USER_ConfigureProcessor) in the Amazon RDS User Guide. Please also see https://docs.aws.amazon.com/goto/WebAPI/rds-2014-10-31/ProcessorFeature"

													properties: {
														name: {
															description: "Name of the processor feature. Valid names are coreCount and threadsPerCore."

															type: "string"
														}
														value: {
															description: "Value of a processor feature name."
															type:        "string"
														}
													}
													required: [
														"name",
														"value",
													]
													type: "object"
												}
												type: "array"
											}
											storageType: {
												description: "StorageType specifies the storage type to be associated with the DB instance."

												type: "string"
											}
										}
										type: "object"
									}
									performanceInsightsEnabled: {
										description: "PerformanceInsightsEnabled is true if Performance Insights is enabled for the DB instance, and otherwise false."

										type: "boolean"
									}
									readReplicaDBClusterIdentifiers: {
										description: "ReadReplicaDBClusterIdentifiers contains one or more identifiers of Aurora DB clusters to which the RDS DB instance is replicated as a Read Replica. For example, when you create an Aurora Read Replica of an RDS MySQL DB instance, the Aurora MySQL DB cluster for the Aurora Read Replica is shown. This output does not contain information about cross region Aurora Read Replicas."

										items: type: "string"
										type: "array"
									}
									readReplicaDBInstanceIdentifiers: {
										description: "ReadReplicaDBInstanceIdentifiers contains one or more identifiers of the Read Replicas associated with this DB instance."

										items: type: "string"
										type: "array"
									}
									readReplicaSourceDBInstanceIdentifier: {
										description: "ReadReplicaSourceDBInstanceIdentifier contains the identifier of the source DB instance if this DB instance is a Read Replica."

										type: "string"
									}
									secondaryAvailabilityZone: {
										description: "SecondaryAvailabilityZone specifies the name of the secondary Availability Zone for a DB instance with multi-AZ support when it is present."

										type: "string"
									}
									statusInfos: {
										description: "StatusInfos is the status of a Read Replica. If the instance is not a Read Replica, this is blank."

										items: {
											description: "DBInstanceStatusInfo provides a list of status information for a DB instance. Please also see https://docs.aws.amazon.com/goto/WebAPI/rds-2014-10-31/DBInstanceStatusInfo"

											properties: {
												message: {
													description: "Message is the details of the error if there is an error for the instance. If the instance is not in an error state, this value is blank."

													type: "string"
												}
												normal: {
													description: "Normal is true if the instance is operating normally, or false if the instance is in an error state."

													type: "boolean"
												}
												status: {
													description: "Status of the DB instance. For a StatusType of read replica, the values can be replicating, replication stop point set, replication stop point reached, error, stopped, or terminated."

													type: "string"
												}
												statusType: {
													description: "StatusType is currently \"read replication.\""
													type:        "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									vpcSecurityGroups: {
										description: "VPCSecurityGroups provides a list of VPC security group elements that the DB instance belongs to."

										items: {
											description: "VPCSecurityGroupMembership is used as a response element for queries on VPC security group membership. Please also see https://docs.aws.amazon.com/goto/WebAPI/rds-2014-10-31/VpcSecurityGroupMembership"

											properties: {
												status: {
													description: "Status is the status of the VPC security group."
													type:        "string"
												}
												vpcSecurityGroupId: {
													description: "VPCSecurityGroupID is the name of the VPC security group."

													type: "string"
												}
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
