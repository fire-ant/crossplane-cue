package rds_aws_crossplane_io_dbinstances

customresourcedefinition: "dbinstances.rds.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "dbinstances.rds.aws.crossplane.io"
	}
	spec: {
		group: "rds.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "DBInstance"
			listKind: "DBInstanceList"
			plural:   "dbinstances"
			singular: "dbinstance"
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
				description: "DBInstance is the Schema for the DBInstances API"
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
						description: "DBInstanceSpec defines the desired state of DBInstance"
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
								description: "DBInstanceParameters defines the desired state of DBInstance"
								properties: {
									allocatedStorage: {
										description: """
		The amount of storage in gibibytes (GiB) to allocate for the DB instance. 
		 Type: Integer 
		 Amazon Aurora 
		 Not applicable. Aurora cluster volumes automatically grow as the amount of data in your database increases, though you are only charged for the space that you use in an Aurora cluster volume. 
		 Amazon RDS Custom 
		 Constraints to the amount of storage for each storage type are the following: 
		 * General Purpose (SSD) storage (gp2): Must be an integer from 40 to 65536 for RDS Custom for Oracle, 16384 for RDS Custom for SQL Server. 
		 * Provisioned IOPS storage (io1): Must be an integer from 40 to 65536 for RDS Custom for Oracle, 16384 for RDS Custom for SQL Server. 
		 MySQL 
		 Constraints to the amount of storage for each storage type are the following: 
		 * General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536. 
		 * Provisioned IOPS storage (io1): Must be an integer from 100 to 65536. 
		 * Magnetic storage (standard): Must be an integer from 5 to 3072. 
		 MariaDB 
		 Constraints to the amount of storage for each storage type are the following: 
		 * General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536. 
		 * Provisioned IOPS storage (io1): Must be an integer from 100 to 65536. 
		 * Magnetic storage (standard): Must be an integer from 5 to 3072. 
		 PostgreSQL 
		 Constraints to the amount of storage for each storage type are the following: 
		 * General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536. 
		 * Provisioned IOPS storage (io1): Must be an integer from 100 to 65536. 
		 * Magnetic storage (standard): Must be an integer from 5 to 3072. 
		 Oracle 
		 Constraints to the amount of storage for each storage type are the following: 
		 * General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536. 
		 * Provisioned IOPS storage (io1): Must be an integer from 100 to 65536. 
		 * Magnetic storage (standard): Must be an integer from 10 to 3072. 
		 SQL Server 
		 Constraints to the amount of storage for each storage type are the following: 
		 * General Purpose (SSD) storage (gp2): Enterprise and Standard editions: Must be an integer from 20 to 16384. Web and Express editions: Must be an integer from 20 to 16384. 
		 * Provisioned IOPS storage (io1): Enterprise and Standard editions: Must be an integer from 100 to 16384. Web and Express editions: Must be an integer from 100 to 16384. 
		 * Magnetic storage (standard): Enterprise and Standard editions: Must be an integer from 20 to 1024. Web and Express editions: Must be an integer from 20 to 1024.
		"""

										format: "int64"
										type:   "integer"
									}
									applyImmediately: {
										description: """
		A value that indicates whether the modifications in this request and any pending modifications are asynchronously applied as soon as possible, regardless of the PreferredMaintenanceWindow setting for the DB instance. By default, this parameter is disabled. 
		 If this parameter is disabled, changes to the DB instance are applied during the next maintenance window. Some parameter changes can cause an outage and are applied on the next call to RebootDBInstance, or the next failure reboot. Review the table of parameters in Modifying a DB Instance (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.DBInstance.Modifying.html) in the Amazon RDS User Guide. to see the impact of enabling or disabling ApplyImmediately for each modified parameter and to determine when the changes are applied.
		"""

										type: "boolean"
									}
									autoMinorVersionUpgrade: {
										description: """
		A value that indicates whether minor engine upgrades are applied automatically to the DB instance during the maintenance window. By default, minor engine upgrades are applied automatically. 
		 If you create an RDS Custom DB instance, you must set AutoMinorVersionUpgrade to false.
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
									availabilityZone: {
										description: """
		The Availability Zone (AZ) where the database will be created. For information on Amazon Web Services Regions and Availability Zones, see Regions and Availability Zones (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html). 
		 Amazon Aurora 
		 Each Aurora DB cluster hosts copies of its storage in three separate Availability Zones. Specify one of these Availability Zones. Aurora automatically chooses an appropriate Availability Zone if you don't specify one. 
		 Default: A random, system-chosen Availability Zone in the endpoint's Amazon Web Services Region. 
		 Example: us-east-1d 
		 Constraint: The AvailabilityZone parameter can't be specified if the DB instance is a Multi-AZ deployment. The specified Availability Zone must be in the same Amazon Web Services Region as the current endpoint. 
		 If you're creating a DB instance in an RDS on VMware environment, specify the identifier of the custom Availability Zone to create the DB instance in. 
		 For more information about RDS on VMware, see the RDS on VMware User Guide. (https://docs.aws.amazon.com/AmazonRDS/latest/RDSonVMwareUserGuide/rds-on-vmware.html)
		"""

										type: "string"
									}
									backupRetentionPeriod: {
										description: """
		The number of days for which automated backups are retained. Setting this parameter to a positive number enables backups. Setting this parameter to 0 disables automated backups. 
		 Amazon Aurora 
		 Not applicable. The retention period for automated backups is managed by the DB cluster. 
		 Default: 1 
		 Constraints: 
		 * Must be a value from 0 to 35 
		 * Can't be set to 0 if the DB instance is a source to read replicas 
		 * Can't be set to 0 or 35 for an RDS Custom for Oracle DB instance
		"""

										format: "int64"
										type:   "integer"
									}
									backupTarget: {
										description: """
		Specifies where automated backups and manual snapshots are stored. 
		 Possible values are outposts (Amazon Web Services Outposts) and region (Amazon Web Services Region). The default is region. 
		 For more information, see Working with Amazon RDS on Amazon Web Services Outposts (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-on-outposts.html) in the Amazon RDS User Guide.
		"""

										type: "string"
									}
									characterSetName: {
										description: """
		For supported engines, this value indicates that the DB instance should be associated with the specified CharacterSet. 
		 This setting doesn't apply to RDS Custom. However, if you need to change the character set, you can change it on the database itself. 
		 Amazon Aurora 
		 Not applicable. The character set is managed by the DB cluster. For more information, see CreateDBCluster.
		"""

										type: "string"
									}
									copyTagsToSnapshot: {
										description: """
		A value that indicates whether to copy tags from the DB instance to snapshots of the DB instance. By default, tags are not copied. 
		 Amazon Aurora 
		 Not applicable. Copying tags to snapshots is managed by the DB cluster. Setting this value for an Aurora DB instance has no effect on the DB cluster setting.
		"""

										type: "boolean"
									}
									customIAMInstanceProfile: {
										description: """
		The instance profile associated with the underlying Amazon EC2 instance of an RDS Custom DB instance. The instance profile must meet the following requirements: 
		 * The profile must exist in your account. 
		 * The profile must have an IAM role that Amazon EC2 has permissions to assume. 
		 * The instance profile name and the associated IAM role name must start with the prefix AWSRDSCustom. 
		 For the list of permissions required for the IAM role, see Configure IAM and your VPC (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-setup-orcl.html#custom-setup-orcl.iam-vpc) in the Amazon RDS User Guide. 
		 This setting is required for RDS Custom.
		"""

										type: "string"
									}
									dbClusterIdentifier: {
										description: """
		The identifier of the DB cluster that the instance will belong to. 
		 This setting doesn't apply to RDS Custom.
		"""

										type: "string"
									}
									dbClusterIdentifierRef: {
										description: "DBClusterIdentifierRef is a reference to a DBCluster used to set DBClusterIdentifier."

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
									dbClusterIdentifierSelector: {
										description: "DBClusterIdentifierSelector selects a reference to a DBCluster used to set DBClusterIdentifier."

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
									dbInstanceClass: {
										description: "The compute and memory capacity of the DB instance, for example db.m4.large. Not all DB instance classes are available in all Amazon Web Services Regions, or for all database engines. For the full list of DB instance classes, and availability for your engine, see DB Instance Class (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html) in the Amazon RDS User Guide."

										type: "string"
									}
									dbName: {
										description: """
		The meaning of this parameter differs according to the database engine you use. 
		 MySQL 
		 The name of the database to create when the DB instance is created. If this parameter isn't specified, no database is created in the DB instance. 
		 Constraints: 
		 * Must contain 1 to 64 letters or numbers. 
		 * Must begin with a letter. Subsequent characters can be letters, underscores, or digits (0-9). 
		 * Can't be a word reserved by the specified database engine 
		 MariaDB 
		 The name of the database to create when the DB instance is created. If this parameter isn't specified, no database is created in the DB instance. 
		 Constraints: 
		 * Must contain 1 to 64 letters or numbers. 
		 * Must begin with a letter. Subsequent characters can be letters, underscores, or digits (0-9). 
		 * Can't be a word reserved by the specified database engine 
		 PostgreSQL 
		 The name of the database to create when the DB instance is created. If this parameter isn't specified, a database named postgres is created in the DB instance. 
		 Constraints: 
		 * Must contain 1 to 63 letters, numbers, or underscores. 
		 * Must begin with a letter. Subsequent characters can be letters, underscores, or digits (0-9). 
		 * Can't be a word reserved by the specified database engine 
		 Oracle 
		 The Oracle System ID (SID) of the created DB instance. If you specify null, the default value ORCL is used. You can't specify the string NULL, or any other reserved word, for DBName. 
		 Default: ORCL 
		 Constraints: 
		 * Can't be longer than 8 characters 
		 Amazon RDS Custom for Oracle 
		 The Oracle System ID (SID) of the created RDS Custom DB instance. If you don't specify a value, the default value is ORCL. 
		 Default: ORCL 
		 Constraints: 
		 * It must contain 1 to 8 alphanumeric characters. 
		 * It must contain a letter. 
		 * It can't be a word reserved by the database engine. 
		 Amazon RDS Custom for SQL Server 
		 Not applicable. Must be null. 
		 SQL Server 
		 Not applicable. Must be null. 
		 Amazon Aurora MySQL 
		 The name of the database to create when the primary DB instance of the Aurora MySQL DB cluster is created. If this parameter isn't specified for an Aurora MySQL DB cluster, no database is created in the DB cluster. 
		 Constraints: 
		 * It must contain 1 to 64 alphanumeric characters. 
		 * It can't be a word reserved by the database engine. 
		 Amazon Aurora PostgreSQL 
		 The name of the database to create when the primary DB instance of the Aurora PostgreSQL DB cluster is created. If this parameter isn't specified for an Aurora PostgreSQL DB cluster, a database named postgres is created in the DB cluster. 
		 Constraints: 
		 * It must contain 1 to 63 alphanumeric characters. 
		 * It must begin with a letter or an underscore. Subsequent characters can be letters, underscores, or digits (0 to 9). 
		 * It can't be a word reserved by the database engine.
		"""

										type: "string"
									}
									dbParameterGroupName: {
										description: """
		The name of the DB parameter group to associate with this DB instance. If you do not specify a value, then the default DB parameter group for the specified DB engine and version is used. 
		 This setting doesn't apply to RDS Custom. 
		 Constraints: 
		 * Must be 1 to 255 letters, numbers, or hyphens. 
		 * First character must be a letter 
		 * Can't end with a hyphen or contain two consecutive hyphens
		"""

										type: "string"
									}
									dbParameterGroupNameRef: {
										description: "DBParameterGroupNameRef is a reference to a DBParameterGroup used to set DBParameterGroupName."

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
									dbParameterGroupNameSelector: {
										description: "DBParameterGroupNameSelector selects a reference to a DBParameterGroup used to set DBParameterGroupName."

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
									dbSecurityGroups: {
										description: "A list of database security groups to associate with this DB instance"

										items: type: "string"
										type: "array"
									}
									dbSubnetGroupName: {
										description: """
		A DB subnet group to associate with this DB instance. 
		 Constraints: Must match the name of an existing DBSubnetGroup. Must not be default. 
		 Example: mydbsubnetgroup
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
		A value that indicates whether the DB instance has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection isn't enabled. For more information, see Deleting a DB Instance (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html). 
		 Amazon Aurora 
		 Not applicable. You can enable or disable deletion protection for the DB cluster. For more information, see CreateDBCluster. DB instances in a DB cluster can be deleted even when deletion protection is enabled for the DB cluster.
		"""

										type: "boolean"
									}
									domain: {
										description: """
		The Active Directory directory ID to create the DB instance in. Currently, only MySQL, Microsoft SQL Server, Oracle, and PostgreSQL DB instances can be created in an Active Directory Domain. 
		 For more information, see Kerberos Authentication (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/kerberos-authentication.html) in the Amazon RDS User Guide. 
		 This setting doesn't apply to RDS Custom.
		"""

										type: "string"
									}
									domainIAMRoleName: {
										description: """
		Specify the name of the IAM role to be used when making API calls to the Directory Service. 
		 This setting doesn't apply to RDS Custom.
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
		The list of log types that need to be enabled for exporting to CloudWatch Logs. The values in the list depend on the DB engine. For more information, see Publishing Database Logs to Amazon CloudWatch Logs (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch) in the Amazon RDS User Guide. 
		 Amazon Aurora 
		 Not applicable. CloudWatch Logs exports are managed by the DB cluster. 
		 RDS Custom 
		 Not applicable. 
		 MariaDB 
		 Possible values are audit, error, general, and slowquery. 
		 Microsoft SQL Server 
		 Possible values are agent and error. 
		 MySQL 
		 Possible values are audit, error, general, and slowquery. 
		 Oracle 
		 Possible values are alert, audit, listener, trace, and oemagent. 
		 PostgreSQL 
		 Possible values are postgresql and upgrade.
		"""

										items: type: "string"
										type: "array"
									}
									enableCustomerOwnedIP: {
										description: """
		A value that indicates whether to enable a customer-owned IP address (CoIP) for an RDS on Outposts DB instance. 
		 A CoIP provides local or external connectivity to resources in your Outpost subnets through your on-premises network. For some use cases, a CoIP can provide lower latency for connections to the DB instance from outside of its virtual private cloud (VPC) on your local network. 
		 For more information about RDS on Outposts, see Working with Amazon RDS on Amazon Web Services Outposts (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-on-outposts.html) in the Amazon RDS User Guide. 
		 For more information about CoIPs, see Customer-owned IP addresses (https://docs.aws.amazon.com/outposts/latest/userguide/outposts-networking-components.html#ip-addressing) in the Amazon Web Services Outposts User Guide.
		"""

										type: "boolean"
									}
									enableIAMDatabaseAuthentication: {
										description: """
		A value that indicates whether to enable mapping of Amazon Web Services Identity and Access Management (IAM) accounts to database accounts. By default, mapping isn't enabled. 
		 This setting doesn't apply to RDS Custom or Amazon Aurora. In Aurora, mapping Amazon Web Services IAM accounts to database accounts is managed by the DB cluster. 
		 For more information, see IAM Database Authentication for MySQL and PostgreSQL (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html) in the Amazon RDS User Guide.
		"""

										type: "boolean"
									}
									enablePerformanceInsights: {
										description: """
		A value that indicates whether to enable Performance Insights for the DB instance. For more information, see Using Amazon Performance Insights (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html) in the Amazon RDS User Guide. 
		 This setting doesn't apply to RDS Custom.
		"""

										type: "boolean"
									}
									engine: {
										description: """
		The name of the database engine to be used for this instance. 
		 Not every database engine is available for every Amazon Web Services Region. 
		 Valid Values: 
		 * aurora (for MySQL 5.6-compatible Aurora) 
		 * aurora-mysql (for MySQL 5.7-compatible and MySQL 8.0-compatible Aurora) 
		 * aurora-postgresql 
		 * custom-oracle-ee (for RDS Custom for Oracle instances) 
		 * custom-sqlserver-ee (for RDS Custom for SQL Server instances) 
		 * custom-sqlserver-se (for RDS Custom for SQL Server instances) 
		 * custom-sqlserver-web (for RDS Custom for SQL Server instances) 
		 * mariadb 
		 * mysql 
		 * oracle-ee 
		 * oracle-ee-cdb 
		 * oracle-se2 
		 * oracle-se2-cdb 
		 * postgres 
		 * sqlserver-ee 
		 * sqlserver-se 
		 * sqlserver-ex 
		 * sqlserver-web
		"""

										type: "string"
									}
									engineVersion: {
										description: """
		The version number of the database engine to use. 
		 For a list of valid engine versions, use the DescribeDBEngineVersions action. 
		 The following are the database engines and links to information about the major and minor versions that are available with Amazon RDS. Not every database engine is available for every Amazon Web Services Region. 
		 Amazon Aurora 
		 Not applicable. The version number of the database engine to be used by the DB instance is managed by the DB cluster. 
		 Amazon RDS Custom for Oracle 
		 A custom engine version (CEV) that you have previously created. This setting is required for RDS Custom for Oracle. The CEV name has the following format: 19.customized_string . An example identifier is 19.my_cev1. For more information, see Creating an RDS Custom for Oracle DB instance (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-creating.html#custom-creating.create) in the Amazon RDS User Guide. 
		 Amazon RDS Custom for SQL Server 
		 See RDS Custom for SQL Server general requirements (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-reqs-limits.html#custom-reqs-limits.reqsMS) in the Amazon RDS User Guide. 
		 MariaDB 
		 For information, see MariaDB on Amazon RDS Versions (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MariaDB.html#MariaDB.Concepts.VersionMgmt) in the Amazon RDS User Guide. 
		 Microsoft SQL Server 
		 For information, see Microsoft SQL Server Versions on Amazon RDS (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.VersionSupport) in the Amazon RDS User Guide. 
		 MySQL 
		 For information, see MySQL on Amazon RDS Versions (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt) in the Amazon RDS User Guide. 
		 Oracle 
		 For information, see Oracle Database Engine Release Notes (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.Oracle.PatchComposition.html) in the Amazon RDS User Guide. 
		 PostgreSQL 
		 For information, see Amazon RDS for PostgreSQL versions and extensions (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts) in the Amazon RDS User Guide.
		"""

										type: "string"
									}
									finalDBSnapshotIdentifier: {
										description: """
		The DB instance snapshot identifier of the new DB instance snapshot created when SkipFinalSnapshot is disabled. 
		 Specifying this parameter and also skipping the creation of a final DB instance snapshot with the SkipFinalShapshot parameter results in an error. 
		 Constraints: 
		 * Must be 1 to 255 letters, numbers, or hyphens. 
		 * First character must be a letter 
		 * Can't end with a hyphen or contain two consecutive hyphens
		"""

										type: "string"
									}
									iops: {
										description: """
		The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for the DB instance. For information about valid Iops values, see Amazon RDS Provisioned IOPS storage to improve performance (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS) in the Amazon RDS User Guide. 
		 Constraints: For MariaDB, MySQL, Oracle, and PostgreSQL DB instances, must be a multiple between .5 and 50 of the storage amount for the DB instance. For SQL Server DB instances, must be a multiple between 1 and 50 of the storage amount for the DB instance.
		"""

										format: "int64"
										type:   "integer"
									}
									kmsKeyID: {
										description: """
		The Amazon Web Services KMS key identifier for an encrypted DB instance. 
		 The Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key. To use a KMS key in a different Amazon Web Services account, specify the key ARN or alias ARN. 
		 Amazon Aurora 
		 Not applicable. The Amazon Web Services KMS key identifier is managed by the DB cluster. For more information, see CreateDBCluster. 
		 If StorageEncrypted is enabled, and you do not specify a value for the KmsKeyId parameter, then Amazon RDS uses your default KMS key. There is a default KMS key for your Amazon Web Services account. Your Amazon Web Services account has a different default KMS key for each Amazon Web Services Region. 
		 Amazon RDS Custom 
		 A KMS key is required for RDS Custom instances. For most RDS engines, if you leave this parameter empty while enabling StorageEncrypted, the engine uses the default KMS key. However, RDS Custom doesn't use the default key when this parameter is empty. You must explicitly specify a key.
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
									licenseModel: {
										description: """
		License model information for this DB instance. 
		 Valid values: license-included | bring-your-own-license | general-public-license 
		 This setting doesn't apply to RDS Custom.
		"""

										type: "string"
									}
									masterUserPasswordSecretRef: {
										description: """
		The password for the master database user. This password can contain any printable ASCII character except \"/\", \"\"\", or \"@\". 
		 Constraints: Must contain from 8 to 41 characters.
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
		The name for the master user. 
		 Amazon Aurora 
		 Not applicable. The name for the master user is managed by the DB cluster. 
		 Amazon RDS 
		 Constraints: 
		 * Required. 
		 * Must be 1 to 16 letters, numbers, or underscores. 
		 * First character must be a letter. 
		 * Can't be a reserved word for the chosen database engine.
		"""

										type: "string"
									}
									maxAllocatedStorage: {
										description: """
		The upper limit in gibibytes (GiB) to which Amazon RDS can automatically scale the storage of the DB instance. 
		 For more information about this setting, including limitations that apply to it, see Managing capacity automatically with Amazon RDS storage autoscaling (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PIOPS.StorageTypes.html#USER_PIOPS.Autoscaling) in the Amazon RDS User Guide. 
		 This setting doesn't apply to RDS Custom.
		"""

										format: "int64"
										type:   "integer"
									}
									monitoringInterval: {
										description: """
		The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collection of Enhanced Monitoring metrics, specify 0. The default is 0. 
		 If MonitoringRoleArn is specified, then you must set MonitoringInterval to a value other than 0. 
		 This setting doesn't apply to RDS Custom. 
		 Valid Values: 0, 1, 5, 10, 15, 30, 60
		"""

										format: "int64"
										type:   "integer"
									}
									monitoringRoleARN: {
										description: """
		The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to Amazon CloudWatch Logs. For example, arn:aws:iam:123456789012:role/emaccess. For information on creating a monitoring role, see Setting Up and Enabling Enhanced Monitoring (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html#USER_Monitoring.OS.Enabling) in the Amazon RDS User Guide. 
		 If MonitoringInterval is set to a value other than 0, then you must supply a MonitoringRoleArn value. 
		 This setting doesn't apply to RDS Custom.
		"""

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
										description: """
		A value that indicates whether the DB instance is a Multi-AZ deployment. You can't set the AvailabilityZone parameter if the DB instance is a Multi-AZ deployment. 
		 This setting doesn't apply to RDS Custom.
		"""

										type: "boolean"
									}
									ncharCharacterSetName: {
										description: """
		The name of the NCHAR character set for the Oracle DB instance. 
		 This parameter doesn't apply to RDS Custom.
		"""

										type: "string"
									}
									optionGroupName: {
										description: """
		A value that indicates that the DB instance should be associated with the specified option group. 
		 Permanent options, such as the TDE option for Oracle Advanced Security TDE, can't be removed from an option group. Also, that option group can't be removed from a DB instance after it is associated with a DB instance. 
		 This setting doesn't apply to RDS Custom.
		"""

										type: "string"
									}
									performanceInsightsKMSKeyID: {
										description: """
		The Amazon Web Services KMS key identifier for encryption of Performance Insights data. 
		 The Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key. 
		 If you do not specify a value for PerformanceInsightsKMSKeyId, then Amazon RDS uses your default KMS key. There is a default KMS key for your Amazon Web Services account. Your Amazon Web Services account has a different default KMS key for each Amazon Web Services Region. 
		 This setting doesn't apply to RDS Custom.
		"""

										type: "string"
									}
									performanceInsightsRetentionPeriod: {
										description: """
		The amount of time, in days, to retain Performance Insights data. Valid values are 7 or 731 (2 years). 
		 This setting doesn't apply to RDS Custom.
		"""

										format: "int64"
										type:   "integer"
									}
									port: {
										description: """
		The port number on which the database accepts connections. 
		 MySQL 
		 Default: 3306 
		 Valid values: 1150-65535 
		 Type: Integer 
		 MariaDB 
		 Default: 3306 
		 Valid values: 1150-65535 
		 Type: Integer 
		 PostgreSQL 
		 Default: 5432 
		 Valid values: 1150-65535 
		 Type: Integer 
		 Oracle 
		 Default: 1521 
		 Valid values: 1150-65535 
		 SQL Server 
		 Default: 1433 
		 Valid values: 1150-65535 except 1234, 1434, 3260, 3343, 3389, 47001, and 49152-49156. 
		 Amazon Aurora 
		 Default: 3306 
		 Valid values: 1150-65535 
		 Type: Integer
		"""

										format: "int64"
										type:   "integer"
									}
									preferredBackupWindow: {
										description: """
		The daily time range during which automated backups are created if automated backups are enabled, using the BackupRetentionPeriod parameter. The default is a 30-minute window selected at random from an 8-hour block of time for each Amazon Web Services Region. For more information, see Backup window (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html#USER_WorkingWithAutomatedBackups.BackupWindow) in the Amazon RDS User Guide. 
		 Amazon Aurora 
		 Not applicable. The daily time range for creating automated backups is managed by the DB cluster. 
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
		The time range each week during which system maintenance can occur, in Universal Coordinated Time (UTC). For more information, see Amazon RDS Maintenance Window (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html#Concepts.DBMaintenance). 
		 Format: ddd:hh24:mi-ddd:hh24:mi 
		 The default is a 30-minute window selected at random from an 8-hour block of time for each Amazon Web Services Region, occurring on a random day of the week. 
		 Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun. 
		 Constraints: Minimum 30-minute window.
		"""

										type: "string"
									}
									processorFeatures: {
										description: """
		The number of CPU cores and the number of threads per core for the DB instance class of the DB instance. 
		 This setting doesn't apply to RDS Custom.
		"""

										items: {
											properties: {
												name: type: "string"
												value: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									promotionTier: {
										description: """
		A value that specifies the order in which an Aurora Replica is promoted to the primary instance after a failure of the existing primary instance. For more information, see Fault Tolerance for an Aurora DB Cluster (https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.FaultTolerance) in the Amazon Aurora User Guide. 
		 This setting doesn't apply to RDS Custom. 
		 Default: 1 
		 Valid Values: 0 - 15
		"""

										format: "int64"
										type:   "integer"
									}
									publiclyAccessible: {
										description: """
		A value that indicates whether the DB instance is publicly accessible. 
		 When the DB instance is publicly accessible, its Domain Name System (DNS) endpoint resolves to the private IP address from within the DB instance's virtual private cloud (VPC). It resolves to the public IP address from outside of the DB instance's VPC. Access to the DB instance is ultimately controlled by the security group it uses. That public access is not permitted if the security group assigned to the DB instance doesn't permit it. 
		 When the DB instance isn't publicly accessible, it is an internal DB instance with a DNS name that resolves to a private IP address. 
		 Default: The default behavior varies depending on whether DBSubnetGroupName is specified. 
		 If DBSubnetGroupName isn't specified, and PubliclyAccessible isn't specified, the following applies: 
		 * If the default VPC in the target Region doesn’t have an internet gateway attached to it, the DB instance is private. 
		 * If the default VPC in the target Region has an internet gateway attached to it, the DB instance is public. 
		 If DBSubnetGroupName is specified, and PubliclyAccessible isn't specified, the following applies: 
		 * If the subnets are part of a VPC that doesn’t have an internet gateway attached to it, the DB instance is private. 
		 * If the subnets are part of a VPC that has an internet gateway attached to it, the DB instance is public.
		"""

										type: "boolean"
									}
									region: {
										description: "Region is which region the DBInstance will be created."
										type:        "string"
									}
									skipFinalSnapshot: {
										description: """
		A value that indicates whether to skip the creation of a final DB instance snapshot before the DB instance is deleted. If skip is specified, no DB instance snapshot is created. If skip isn't specified, a DB instance snapshot is created before the DB instance is deleted. By default, skip isn't specified, and the DB instance snapshot is created. By default, this parameter is disabled. 
		 You must specify a FinalDBSnapshotIdentifier parameter if SkipFinalSnapshot is disabled.
		"""

										type: "boolean"
									}
									storageEncrypted: {
										description: """
		A value that indicates whether the DB instance is encrypted. By default, it isn't encrypted. 
		 For RDS Custom instances, either set this parameter to true or leave it unset. If you set this parameter to false, RDS reports an error. 
		 Amazon Aurora 
		 Not applicable. The encryption for DB instances is managed by the DB cluster.
		"""

										type: "boolean"
									}
									storageType: {
										description: """
		Specifies the storage type to be associated with the DB instance. 
		 Valid values: standard | gp2 | io1 
		 If you specify io1, you must also include a value for the Iops parameter. 
		 Default: io1 if the Iops parameter is specified, otherwise gp2
		"""

										type: "string"
									}
									tags: {
										description: "Tags to assign to the DB instance."
										items: {
											properties: {
												key: type: "string"
												value: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									tdeCredentialARN: {
										description: """
		The ARN from the key store with which to associate the instance for TDE encryption. 
		 This setting doesn't apply to RDS Custom.
		"""

										type: "string"
									}
									tdeCredentialPassword: {
										description: """
		The password for the given ARN from the key store in order to access the device. 
		 This setting doesn't apply to RDS Custom.
		"""

										type: "string"
									}
									timezone: {
										description: "The time zone of the DB instance. The time zone parameter is currently supported only by Microsoft SQL Server (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.TimeZone)."

										type: "string"
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
										description: "A list of EC2 VPC security groups to associate with this DB instance."

										items: type: "string"
										type: "array"
									}
								}
								required: [
									"dbInstanceClass",
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
						description: "DBInstanceStatus defines the observed state of DBInstance."
						properties: {
							atProvider: {
								description: "DBInstanceObservation defines the observed state of DBInstance"
								properties: {
									activityStreamEngineNativeAuditFieldsIncluded: {
										description: "Indicates whether engine-native audit fields are included in the database activity stream."

										type: "boolean"
									}
									activityStreamKMSKeyID: {
										description: "The Amazon Web Services KMS key identifier used for encrypting messages in the database activity stream. The Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key."

										type: "string"
									}
									activityStreamKinesisStreamName: {
										description: "The name of the Amazon Kinesis data stream used for the database activity stream."

										type: "string"
									}
									activityStreamMode: {
										description: "The mode of the database activity stream. Database events such as a change or access generate an activity stream event. RDS for Oracle always handles these events asynchronously."

										type: "string"
									}
									activityStreamStatus: {
										description: "The status of the database activity stream."
										type:        "string"
									}
									associatedRoles: {
										description: "The Amazon Web Services Identity and Access Management (IAM) roles associated with the DB instance."

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
										description: "The time when a stopped DB instance is restarted automatically."

										format: "date-time"
										type:   "string"
									}
									automationMode: {
										description: "The automation mode of the RDS Custom DB instance: full or all paused. If full, the DB instance automates monitoring and instance recovery. If all paused, the instance pauses automation for the duration set by --resume-full-automation-mode-minutes."

										type: "string"
									}
									awsBackupRecoveryPointARN: {
										description: "The Amazon Resource Name (ARN) of the recovery point in Amazon Web Services Backup."

										type: "string"
									}
									caCertificateIdentifier: {
										description: "The identifier of the CA certificate for this DB instance."

										type: "string"
									}
									customerOwnedIPEnabled: {
										description: """
		Specifies whether a customer-owned IP address (CoIP) is enabled for an RDS on Outposts DB instance. 
		 A CoIP provides local or external connectivity to resources in your Outpost subnets through your on-premises network. For some use cases, a CoIP can provide lower latency for connections to the DB instance from outside of its virtual private cloud (VPC) on your local network. 
		 For more information about RDS on Outposts, see Working with Amazon RDS on Amazon Web Services Outposts (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-on-outposts.html) in the Amazon RDS User Guide. 
		 For more information about CoIPs, see Customer-owned IP addresses (https://docs.aws.amazon.com/outposts/latest/userguide/outposts-networking-components.html#ip-addressing) in the Amazon Web Services Outposts User Guide.
		"""

										type: "boolean"
									}
									dbInstanceARN: {
										description: "The Amazon Resource Name (ARN) for the DB instance."
										type:        "string"
									}
									dbInstanceAutomatedBackupsReplications: {
										description: "The list of replicated automated backups associated with the DB instance."

										items: {
											properties: dbInstanceAutomatedBackupsARN: type: "string"
											type: "object"
										}
										type: "array"
									}
									dbInstanceIdentifier: {
										description: "Contains a user-supplied database identifier. This identifier is the unique key that identifies a DB instance."

										type: "string"
									}
									dbInstancePort: {
										description: "Specifies the port that the DB instance listens on. If the DB instance is part of a DB cluster, this can be a different port than the DB cluster port."

										format: "int64"
										type:   "integer"
									}
									dbInstanceStatus: {
										description: """
		Specifies the current state of this database. 
		 For information about DB instance statuses, see Viewing DB instance status (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/accessing-monitoring.html#Overview.DBInstance.Status) in the Amazon RDS User Guide.
		"""

										type: "string"
									}
									dbParameterGroups: {
										description: "Provides the list of DB parameter groups applied to this DB instance."

										items: {
											properties: {
												dbParameterGroupName: type: "string"
												parameterApplyStatus: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									dbSecurityGroups: {
										description: "A list of DB security group elements containing DBSecurityGroup.Name and DBSecurityGroup.Status subelements."

										items: {
											properties: {
												dbSecurityGroupName: type: "string"
												status: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									dbSubnetGroup: {
										description: "Specifies information on the subnet group associated with the DB instance, including the name, description, and subnets in the subnet group."

										properties: {
											dbSubnetGroupARN: type: "string"
											dbSubnetGroupDescription: type: "string"
											dbSubnetGroupName: type: "string"
											subnetGroupStatus: type: "string"
											subnets: {
												items: {
													properties: {
														subnetAvailabilityZone: {
															description: """
		Contains Availability Zone information. 
		 This data type is used as an element in the OrderableDBInstanceOption data type.
		"""

															properties: name: type: "string"
															type: "object"
														}
														subnetIdentifier: type: "string"
														subnetOutpost: {
															description: """
		A data type that represents an Outpost. 
		 For more information about RDS on Outposts, see Amazon RDS on Amazon Web Services Outposts (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-on-outposts.html) in the Amazon RDS User Guide.
		"""

															properties: arn: type: "string"
															type: "object"
														}
														subnetStatus: type: "string"
													}
													type: "object"
												}
												type: "array"
											}
											vpcID: type: "string"
										}
										type: "object"
									}
									dbiResourceID: {
										description: "The Amazon Web Services Region-unique, immutable identifier for the DB instance. This identifier is found in Amazon Web Services CloudTrail log entries whenever the Amazon Web Services KMS key for the DB instance is accessed."

										type: "string"
									}
									domainMemberships: {
										description: "The Active Directory Domain membership records associated with the DB instance."

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
									enabledCloudwatchLogsExports: {
										description: """
		A list of log types that this DB instance is configured to export to CloudWatch Logs. 
		 Log types vary by DB engine. For information about the log types for each DB engine, see Amazon RDS Database Log Files (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html) in the Amazon RDS User Guide.
		"""

										items: type: "string"
										type: "array"
									}
									endpoint: {
										description: """
		Specifies the connection endpoint. 
		 The endpoint might not be shown for instances whose status is creating.
		"""

										properties: {
											address: type: "string"
											hostedZoneID: type: "string"
											port: {
												format: "int64"
												type:   "integer"
											}
										}
										type: "object"
									}
									enhancedMonitoringResourceARN: {
										description: "The Amazon Resource Name (ARN) of the Amazon CloudWatch Logs log stream that receives the Enhanced Monitoring metrics data for the DB instance."

										type: "string"
									}
									iamDatabaseAuthenticationEnabled: {
										description: """
		True if mapping of Amazon Web Services Identity and Access Management (IAM) accounts to database accounts is enabled, and otherwise false. 
		 IAM database authentication can be enabled for the following database engines 
		 * For MySQL 5.6, minor version 5.6.34 or higher 
		 * For MySQL 5.7, minor version 5.7.16 or higher 
		 * Aurora 5.6 or higher. To enable IAM database authentication for Aurora, see DBCluster Type.
		"""

										type: "boolean"
									}
									instanceCreateTime: {
										description: "Provides the date and time the DB instance was created."
										format:      "date-time"
										type:        "string"
									}
									latestRestorableTime: {
										description: "Specifies the latest time to which a database can be restored with point-in-time restore."

										format: "date-time"
										type:   "string"
									}
									listenerEndpoint: {
										description: "Specifies the listener connection endpoint for SQL Server Always On."

										properties: {
											address: type: "string"
											hostedZoneID: type: "string"
											port: {
												format: "int64"
												type:   "integer"
											}
										}
										type: "object"
									}
									optionGroupMemberships: {
										description: "Provides the list of option group memberships for this DB instance."

										items: {
											properties: {
												optionGroupName: type: "string"
												status: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									pendingModifiedValues: {
										description: "A value that specifies that changes to the DB instance are pending. This element is only included when changes are pending. Specific changes are identified by subelements."

										properties: {
											allocatedStorage: {
												format: "int64"
												type:   "integer"
											}
											automationMode: type: "string"
											backupRetentionPeriod: {
												format: "int64"
												type:   "integer"
											}
											caCertificateIdentifier: type: "string"
											dbInstanceClass: type: "string"
											dbInstanceIdentifier: type: "string"
											dbSubnetGroupName: type: "string"
											engineVersion: type: "string"
											iamDatabaseAuthenticationEnabled: type: "boolean"
											iops: {
												format: "int64"
												type:   "integer"
											}
											licenseModel: type: "string"
											masterUserPassword: type: "string"
											multiAZ: type: "boolean"
											pendingCloudwatchLogsExports: {
												description: "A list of the log types whose configuration is still pending. In other words, these log types are in the process of being activated or deactivated."

												properties: {
													logTypesToDisable: {
														items: type: "string"
														type: "array"
													}
													logTypesToEnable: {
														items: type: "string"
														type: "array"
													}
												}
												type: "object"
											}
											port: {
												format: "int64"
												type:   "integer"
											}
											processorFeatures: {
												items: {
													properties: {
														name: type: "string"
														value: type: "string"
													}
													type: "object"
												}
												type: "array"
											}
											resumeFullAutomationModeTime: {
												format: "date-time"
												type:   "string"
											}
											storageType: type: "string"
										}
										type: "object"
									}
									performanceInsightsEnabled: {
										description: "True if Performance Insights is enabled for the DB instance, and otherwise false."

										type: "boolean"
									}
									readReplicaDBClusterIdentifiers: {
										description: """
		Contains one or more identifiers of Aurora DB clusters to which the RDS DB instance is replicated as a read replica. For example, when you create an Aurora read replica of an RDS for MySQL DB instance, the Aurora MySQL DB cluster for the Aurora read replica is shown. This output doesn't contain information about cross-Region Aurora read replicas. 
		 Currently, each RDS DB instance can have only one Aurora read replica.
		"""

										items: type: "string"
										type: "array"
									}
									readReplicaDBInstanceIdentifiers: {
										description: "Contains one or more identifiers of the read replicas associated with this DB instance."

										items: type: "string"
										type: "array"
									}
									readReplicaSourceDBInstanceIdentifier: {
										description: "Contains the identifier of the source DB instance if this DB instance is a read replica."

										type: "string"
									}
									replicaMode: {
										description: """
		The open mode of an Oracle read replica. The default is open-read-only. For more information, see Working with Oracle Read Replicas for Amazon RDS (https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/oracle-read-replicas.html) in the Amazon RDS User Guide. 
		 This attribute is only supported in RDS for Oracle.
		"""

										type: "string"
									}
									resumeFullAutomationModeTime: {
										description: "The number of minutes to pause the automation. When the time period ends, RDS Custom resumes full automation. The minimum value is 60 (default). The maximum value is 1,440."

										format: "date-time"
										type:   "string"
									}
									secondaryAvailabilityZone: {
										description: "If present, specifies the name of the secondary Availability Zone for a DB instance with multi-AZ support."

										type: "string"
									}
									statusInfos: {
										description: "The status of a read replica. If the instance isn't a read replica, this is blank."

										items: {
											properties: {
												message: type: "string"
												normal: type: "boolean"
												status: type: "string"
												statusType: type: "string"
											}
											type: "object"
										}
										type: "array"
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
										description: "Provides a list of VPC security group elements that the DB instance belongs to."

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
