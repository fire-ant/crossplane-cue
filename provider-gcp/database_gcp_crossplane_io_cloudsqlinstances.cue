package database_gcp_crossplane_io_cloudsqlinstances

customresourcedefinition: "cloudsqlinstances.database.gcp.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.2"
		creationTimestamp: null
		name:              "cloudsqlinstances.database.gcp.crossplane.io"
	}
	spec: {
		group: "database.gcp.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"gcp",
			]
			kind:     "CloudSQLInstance"
			listKind: "CloudSQLInstanceList"
			plural:   "cloudsqlinstances"
			singular: "cloudsqlinstance"
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
				jsonPath: ".status.atProvider.state"
				name:     "STATE"
				type:     "string"
			}, {
				jsonPath: ".spec.forProvider.databaseVersion"
				name:     "VERSION"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "A CloudSQLInstance is a managed resource that represents a Google CloudSQL instance."

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
						description: "A CloudSQLInstanceSpec defines the desired state of a CloudSQLInstance."
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
								description: "CloudSQLInstanceParameters define the desired state of a Google CloudSQL instance. Most of its fields are direct mirror of GCP DatabaseInstance object. See https://cloud.google.com/sql/docs/mysql/admin-api/rest/v1beta4/instances#DatabaseInstance"

								properties: {
									databaseVersion: {
										description: "DatabaseVersion: The database engine type and version. The databaseVersion field can not be changed after instance creation. MySQL Second Generation instances: MYSQL_5_7 (default) or MYSQL_5_6. PostgreSQL instances: POSTGRES_9_6, POSTGRES_10, POSTGRES_11, POSTGRES_12, POSTGRES_13 MySQL First Generation instances: MYSQL_5_6 (default) or MYSQL_5_5"

										type: "string"
									}
									diskEncryptionConfiguration: {
										description: "DiskEncryptionConfiguration: Disk encryption configuration specific to an instance. Applies only to Second Generation instances."

										properties: kmsKeyName: {
											description: "KmsKeyName: KMS key resource name"
											type:        "string"
										}
										required: [
											"kmsKeyName",
										]
										type: "object"
									}
									failoverReplica: {
										description: "FailoverReplica: The name and status of the failover replica. This property is applicable only to Second Generation instances."

										properties: name: {
											description: "Name: The name of the failover replica. If specified at instance creation, a failover replica is created for the instance. The name doesn't include the project ID. This property is applicable only to Second Generation instances."

											type: "string"
										}
										required: [
											"name",
										]
										type: "object"
									}
									gceZone: {
										description: "GceZone: The Compute Engine zone that the instance is currently serving from. This value could be different from the zone that was specified when the instance was created if the instance has failed over to its secondary zone."

										type: "string"
									}
									instanceType: {
										description: "InstanceType: The instance type. This can be one of the following. CLOUD_SQL_INSTANCE: A Cloud SQL instance that is not replicating from a master. ON_PREMISES_INSTANCE: An instance running on the customer's premises. READ_REPLICA_INSTANCE: A Cloud SQL instance configured as a read-replica."

										type: "string"
									}
									masterInstanceName: {
										description: "MasterInstanceName: The name of the instance which will act as master in the replication setup."

										type: "string"
									}
									maxDiskSize: {
										description: "MaxDiskSize: The maximum disk size of the instance in bytes."

										format: "int64"
										type:   "integer"
									}
									onPremisesConfiguration: {
										description: "OnPremisesConfiguration: Configuration specific to on-premises instances."

										properties: hostPort: {
											description: "HostPort: The host and port of the on-premises instance in host:port format"

											type: "string"
										}
										required: [
											"hostPort",
										]
										type: "object"
									}
									region: {
										description: "Region: The geographical region. Can be us-central (FIRST_GEN instances only), us-central1 (SECOND_GEN instances only), asia-east1 or europe-west1. Defaults to us-central or us-central1 depending on the instance type (First Generation or Second Generation). The region can not be changed after instance creation."

										type: "string"
									}
									replicaNames: {
										description: "ReplicaNames: The replicas of the instance."
										items: type: "string"
										type: "array"
									}
									settings: {
										description: "Settings: The user settings."
										properties: {
											activationPolicy: {
												description: "ActivationPolicy: The activation policy specifies when the instance is activated; it is applicable only when the instance state is RUNNABLE. Valid values: ALWAYS: The instance is on, and remains so even in the absence of connection requests. NEVER: The instance is off; it is not activated, even if a connection request arrives. ON_DEMAND: First Generation instances only. The instance responds to incoming requests, and turns itself off when not in use. Instances with PER_USE pricing turn off after 15 minutes of inactivity. Instances with PER_PACKAGE pricing turn off after 12 hours of inactivity."

												type: "string"
											}
											authorizedGaeApplications: {
												description: "AuthorizedGaeApplications: The App Engine app IDs that can access this instance. First Generation instances only."

												items: type: "string"
												type: "array"
											}
											availabilityType: {
												description: "AvailabilityType: Availability type (PostgreSQL instances only). Potential values: ZONAL: The instance serves data from only one zone. Outages in that zone affect data accessibility. REGIONAL: The instance can serve data from more than one zone in a region (it is highly available). For more information, see Overview of the High Availability Configuration."

												type: "string"
											}
											backupConfiguration: {
												description: "BackupConfiguration is the daily backup configuration for the instance."

												properties: {
													backupRetentionSettings: {
														description: "BackupRetentionSettings: Backup retention settings."

														properties: {
															retainedBackups: {
																description: "RetainedBackups: Depending on the value of retention_unit, this is used to determine if a backup needs to be deleted. If retention_unit is 'COUNT', we will retain this many backups."

																format: "int64"
																type:   "integer"
															}
															retentionUnit: {
																description: """
		RetentionUnit: The unit that 'retained_backups' represents. 
		 Possible values: \"RETENTION_UNIT_UNSPECIFIED\" - Backup retention unit is unspecified, will be treated as COUNT. \"COUNT\" - Retention will be by count, eg. \"retain the most recent 7 backups\".
		"""

																enum: [
																	"RETENTION_UNIT_UNSPECIFIED",
																	"COUNT",
																]
																type: "string"
															}
														}
														type: "object"
													}
													binaryLogEnabled: {
														description: "BinaryLogEnabled: Whether binary log is enabled. If backup configuration is disabled, binary log must be disabled as well."

														type: "boolean"
													}
													enabled: {
														description: "Enabled: Whether this configuration is enabled."
														type:        "boolean"
													}
													location: {
														description: "Location: The location of the backup."
														type:        "string"
													}
													pointInTimeRecoveryEnabled: {
														description: "PointInTimeRecoveryEnabled: True if Point-in-time recovery is enabled. Will restart database if enabled after instance creation."

														type: "boolean"
													}
													replicationLogArchivingEnabled: {
														description: "ReplicationLogArchivingEnabled: Reserved for future use."

														type: "boolean"
													}
													startTime: {
														description: "StartTime: Start time for the daily backup configuration in UTC timezone in the 24 hour format - HH:MM."

														type: "string"
													}
												}
												type: "object"
											}
											crashSafeReplicationEnabled: {
												description: "CrashSafeReplicationEnabled: Configuration specific to read replica instances. Indicates whether database flags for crash-safe replication are enabled. This property is only applicable to First Generation instances."

												type: "boolean"
											}
											dataDiskSizeGb: {
												description: "DataDiskSizeGb: The size of data disk, in GB. The data disk size minimum is 10GB. Not used for First Generation instances. Please note, if storage auto resize enabled, it won't be possible to decrease the size of the database using this field as it is not an allowed operation on GCP side. But you would still be able to increase it."

												format: "int64"
												type:   "integer"
											}
											dataDiskType: {
												description: "DataDiskType: The type of data disk: PD_SSD (default) or PD_HDD. Not used for First Generation instances."

												type: "string"
											}
											databaseFlags: {
												description: "DatabaseFlags is the array of database flags passed to the instance at startup."

												items: {
													description: "DatabaseFlags are database flags for Cloud SQL instances."

													properties: {
														name: {
															description: "Name: The name of the flag. These flags are passed at instance startup, so include both server options and system variables for MySQL. Flags should be specified with underscores, not hyphens. For more information, see Configuring Database Flags in the Cloud SQL documentation."

															type: "string"
														}
														value: {
															description: "Value: The value of the flag. Booleans should be set to on for true and off for false. This field must be omitted if the flag doesn't take a value."

															type: "string"
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
											databaseReplicationEnabled: {
												description: "DatabaseReplicationEnabled: Configuration specific to read replica instances. Indicates whether replication is enabled or not."

												type: "boolean"
											}
											ipConfiguration: {
												description: "IPConfiguration: The settings for IP Management. This allows to enable or disable the instance IP and manage which external networks can connect to the instance. The IPv4 address cannot be disabled for Second Generation instances."

												properties: {
													authorizedNetworks: {
														description: "AuthorizedNetworks: The list of external networks that are allowed to connect to the instance using the IP. In CIDR notation, also known as 'slash' notation (e.g. 192.168.100.0/24)."

														items: {
															description: "ACLEntry is an entry for an Access Control list."

															properties: {
																expirationTime: {
																	description: "ExpirationTime: The time when this access control entry expires in RFC 3339 format, for example 2012-11-15T16:19:00.094Z."

																	type: "string"
																}
																name: {
																	description: "Name: An optional label to identify this entry."

																	type: "string"
																}
																value: {
																	description: "Value: The whitelisted value for the access control list."

																	type: "string"
																}
															}
															type: "object"
														}
														type: "array"
													}
													ipv4Enabled: {
														description: "Ipv4Enabled: Whether the instance should be assigned an IP address or not."

														type: "boolean"
													}
													privateNetwork: {
														description: "PrivateNetwork: The resource link for the VPC network from which the Cloud SQL instance is accessible for private IP. For example, projects/myProject/global/networks/default. This setting can be updated, but it cannot be removed after it is set. The Network must have an active Service Networking connection peering before resolution will proceed. https://cloud.google.com/vpc/docs/configure-private-services-access"

														pattern: "^projects\\/.+"
														type:    "string"
													}
													privateNetworkRef: {
														description: "PrivateNetworkRef sets the PrivateNetwork field by resolving the resource link of the referenced Crossplane Network managed resource."

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
													privateNetworkSelector: {
														description: "PrivateNetworkSelector selects a PrivateNetworkRef."
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
													requireSsl: {
														description: "RequireSsl: Whether SSL connections over IP should be enforced or not."

														type: "boolean"
													}
												}
												type: "object"
											}
											locationPreference: {
												description: "LocationPreference is the location preference settings. This allows the instance to be located as near as possible to either an App Engine app or Compute Engine zone for better performance. App Engine co-location is only applicable to First Generation instances."

												properties: {
													followGaeApplication: {
														description: "FollowGaeApplication: The AppEngine application to follow, it must be in the same region as the Cloud SQL instance."

														type: "string"
													}
													zone: {
														description: "Zone: The preferred Compute Engine zone (e.g. us-central1-a, us-central1-b, etc.)."

														type: "string"
													}
												}
												type: "object"
											}
											maintenanceWindow: {
												description: "MaintenanceWindow: The maintenance window for this instance. This specifies when the instance can be restarted for maintenance purposes. Not used for First Generation instances."

												properties: {
													day: {
														description: "Day: day of week (1-7), starting on Monday."
														format:      "int64"
														type:        "integer"
													}
													hour: {
														description: "Hour: hour of day - 0 to 23."
														format:      "int64"
														type:        "integer"
													}
													updateTrack: {
														description: "UpdateTrack: Maintenance timing setting: canary (Earlier) or stable (Later)."

														type: "string"
													}
												}
												type: "object"
											}
											pricingPlan: {
												description: "PricingPlan: The pricing plan for this instance. This can be either PER_USE or PACKAGE. Only PER_USE is supported for Second Generation instances."

												type: "string"
											}
											replicationType: {
												description: "ReplicationType: The type of replication this instance uses. This can be either ASYNCHRONOUS or SYNCHRONOUS. This property is only applicable to First Generation instances."

												type: "string"
											}
											storageAutoResize: {
												description: "StorageAutoResize: Configuration to increase storage size automatically. The default value is true. Not used for First Generation instances. Please note, if storage auto resize enabled, it won't be possible to decrease the size of the database using the DataDiskSizeGb field as it is not an allowed operation on GCP side. But you would still be able to increase it."

												type: "boolean"
											}
											storageAutoResizeLimit: {
												description: "StorageAutoResizeLimit: The maximum size to which storage capacity can be automatically increased. The default value is 0, which specifies that there is no limit. Not used for First Generation instances."

												format: "int64"
												type:   "integer"
											}
											tier: {
												description: "Tier: The tier (or machine type) for this instance, for example db-n1-standard-1 (MySQL instances) or db-custom-1-3840 (PostgreSQL instances). For MySQL instances, this property determines whether the instance is First or Second Generation. For more information, see Instance Settings."

												type: "string"
											}
											userLabels: {
												additionalProperties: type: "string"
												description: "UserLabels: User-provided labels, represented as a dictionary where each label is a single key value pair."

												type: "object"
											}
										}
										required: [
											"tier",
										]
										type: "object"
									}
									suspensionReason: {
										description: "SuspensionReason: If the instance state is SUSPENDED, the reason for the suspension."

										items: type: "string"
										type: "array"
									}
								}
								required: [
									"region",
									"settings",
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
						description: "A CloudSQLInstanceStatus represents the observed state of a CloudSQLInstance."

						properties: {
							atProvider: {
								description: "CloudSQLInstanceObservation is used to show the observed state of the Cloud SQL resource on GCP."

								properties: {
									backendType: {
										description: "BackendType: FIRST_GEN: First Generation instance. MySQL only. SECOND_GEN: Second Generation instance or PostgreSQL instance. EXTERNAL: A database server that is not managed by Google. This property is read-only; use the tier property in the settings object to determine the database type and Second or First Generation."

										type: "string"
									}
									connectionName: {
										description: "ConnectionName: Connection name of the Cloud SQL instance used in connection strings."

										type: "string"
									}
									currentDiskSize: {
										description: "CurrentDiskSize: The current disk usage of the instance in bytes. This property has been deprecated. Users should use the \"cloudsql.googleapis.com/database/disk/bytes_used\" metric in Cloud Monitoring API instead. Please see this announcement for details."

										format: "int64"
										type:   "integer"
									}
									diskEncryptionStatus: {
										description: "DiskEncryptionStatus: Disk encryption status specific to an instance. Applies only to Second Generation instances."

										properties: kmsKeyVersionName: {
											description: "KmsKeyVersionName: KMS key version used to encrypt the Cloud SQL instance disk"

											type: "string"
										}
										required: [
											"kmsKeyVersionName",
										]
										type: "object"
									}
									failoverReplica: {
										description: "FailoverReplica: The name and status of the failover replica. This property is applicable only to Second Generation instances."

										properties: available: {
											description: "Available: The availability status of the failover replica. A false status indicates that the failover replica is out of sync. The master can only failover to the failover replica when the status is true."

											type: "boolean"
										}
										required: [
											"available",
										]
										type: "object"
									}
									gceZone: {
										description: "GceZone: The Compute Engine zone that the instance is currently serving from. This value could be different from the zone that was specified when the instance was created if the instance has failed over to its secondary zone."

										type: "string"
									}
									ipAddresses: {
										description: "IPAddresses: The assigned IP addresses for the instance."
										items: {
											description: "IPMapping is database instance IP Mapping."
											properties: {
												ipAddress: {
													description: "IPAddress: The IP address assigned."
													type:        "string"
												}
												timeToRetire: {
													description: "TimeToRetire: The due time for this IP to be retired in RFC 3339 format, for example 2012-11-15T16:19:00.094Z. This field is only available when the IP is scheduled to be retired."

													type: "string"
												}
												type: {
													description: "Type: The type of this IP address. A PRIMARY address is a public address that can accept incoming connections. A PRIVATE address is a private address that can accept incoming connections. An OUTGOING address is the source address of connections originating from the instance, if supported."

													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									ipv6Address: {
										description: "IPv6Address: The IPv6 address assigned to the instance. This property is applicable only to First Generation instances."

										type: "string"
									}
									project: {
										description: "Project: The project ID of the project containing the Cloud SQL instance. The Google apps domain is prefixed if applicable."

										type: "string"
									}
									selfLink: {
										description: "SelfLink: The URI of this resource."
										type:        "string"
									}
									serviceAccountEmailAddress: {
										description: "ServiceAccountEmailAddress: The service account email address assigned to the instance. This property is applicable only to Second Generation instances."

										type: "string"
									}
									settingsVersion: {
										description: "SettingsVersion: The version of instance settings. This is a required field for update method to make sure concurrent updates are handled properly. During update, use the most recent settingsVersion value for this instance and do not try to update this value."

										format: "int64"
										type:   "integer"
									}
									state: {
										description: "State: The current serving state of the Cloud SQL instance. This can be one of the following. RUNNABLE: The instance is running, or is ready to run when accessed. SUSPENDED: The instance is not available, for example due to problems with billing. PENDING_CREATE: The instance is being created. MAINTENANCE: The instance is down for maintenance. FAILED: The instance creation failed. UNKNOWN_STATE: The state of the instance is unknown."

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
}
