package glue_aws_crossplane_io_crawlers

customresourcedefinition: "crawlers.glue.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "crawlers.glue.aws.crossplane.io"
	}
	spec: {
		group: "glue.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Crawler"
			listKind: "CrawlerList"
			plural:   "crawlers"
			singular: "crawler"
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
				description: "Crawler is the Schema for the Crawlers API"
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
						description: "CrawlerSpec defines the desired state of Crawler"
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
								description: "CrawlerParameters defines the desired state of Crawler"
								properties: {
									classifierRefs: {
										description: "ClassifierRefs is a list of references to Classifiers used to set the Classifiers."

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
									classifierSelector: {
										description: "ClassifiersSelector selects references to Classifiers used to set the Classifiers."

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
									classifiers: {
										description: "A list of custom classifiers that the user has registered. By default, all built-in classifiers are included in a crawl, but these custom classifiers always override the default classifiers for a given classification."

										items: type: "string"
										type: "array"
									}
									configuration: {
										description: "Crawler configuration information. This versioned JSON string allows users to specify aspects of a crawler's behavior. For more information, see Configuring a Crawler (https://docs.aws.amazon.com/glue/latest/dg/crawler-configuration.html)."

										type: "string"
									}
									crawlerSecurityConfiguration: {
										description: "The name of the SecurityConfiguration structure to be used by this crawler."

										type: "string"
									}
									crawlerSecurityConfigurationRef: {
										description: "CrawlerSecurityConfigurationRef is a reference to an SecurityConfiguration used to set the CrawlerSecurityConfiguration."

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
									crawlerSecurityConfigurationSelector: {
										description: "CrawlerSecurityConfigurationSelector selects references to SecurityConfiguration used to set the CrawlerSecurityConfiguration."

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
									databaseName: {
										description: "The Glue database where results are written, such as: arn:aws:daylight:us-east-1::database/sometable/*."

										type: "string"
									}
									databaseNameRef: {
										description: "DatabaseNameRef is a reference to an Database used to set the DatabaseName."

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
									databaseNameSelector: {
										description: "DatabaseNamesSelector selects references to Database used to set the DatabaseName."

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
									description: {
										description: "A description of the new crawler."
										type:        "string"
									}
									lakeFormationConfiguration: {
										properties: {
											accountID: type: "string"
											useLakeFormationCredentials: type: "boolean"
										}
										type: "object"
									}
									lineageConfiguration: {
										description: "Specifies data lineage configuration settings for the crawler."

										properties: crawlerLineageSettings: type: "string"
										type: "object"
									}
									recrawlPolicy: {
										description: "A policy that specifies whether to crawl the entire dataset again, or to crawl only folders that were added since the last crawler run."

										properties: recrawlBehavior: type: "string"
										type: "object"
									}
									region: {
										description: "Region is which region the Crawler will be created."
										type:        "string"
									}
									role: {
										description: "The IAM role or Amazon Resource Name (ARN) of an IAM role used by the new crawler to access customer resources. AWS API seems to give just name of the role back (not ARN)"

										type: "string"
									}
									roleRef: {
										description: "RoleRef is a reference to an IAMRole used to set the Role."

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
									roleSelector: {
										description: "RoleSelector selects references to IAMRole used to set the Role."

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
									schedule: {
										description: "A cron expression used to specify the schedule (see Time-Based Schedules for Jobs and Crawlers (https://docs.aws.amazon.com/glue/latest/dg/monitor-data-warehouse-schedule.html). For example, to run something every day at 12:15 UTC, you would specify: cron(15 12 * * ? *)."

										type: "string"
									}
									schemaChangePolicy: {
										description: "The policy for the crawler's update and deletion behavior."

										properties: {
											deleteBehavior: type: "string"
											updateBehavior: type: "string"
										}
										type: "object"
									}
									tablePrefix: {
										description: "The table prefix used for catalog tables that are created."

										type: "string"
									}
									tags: {
										additionalProperties: type: "string"
										description: "The tags to use with this crawler request. You may use tags to limit access to the crawler. For more information about tags in Glue, see Amazon Web Services Tags in Glue (https://docs.aws.amazon.com/glue/latest/dg/monitor-tags.html) in the developer guide."

										type: "object"
									}
									targets: {
										description: """
		A list of collection of targets to crawl. 
		 Targets is a required field
		"""

										properties: {
											catalogTargets: {
												description: "Specifies Glue Data Catalog targets."
												items: {
													description: "CustomCatalogTarget contains the additional fields for CatalogTarget"

													properties: {
														databaseName: {
															description: """
		The name of the database to be synchronized. 
		 DatabaseName is a required field
		"""

															type: "string"
														}
														databaseNameRef: {
															description: "DatabaseNameRef is a reference to an Database used to set the DatabaseName."

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
														databaseNameSelector: {
															description: "DatabaseNamesSelector selects references to Database used to set the DatabaseName."

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
														tables: {
															description: """
		A list of the tables to be synchronized. 
		 Tables is a required field
		"""

															items: type: "string"
															type: "array"
														}
													}
													required: [
														"tables",
													]
													type: "object"
												}
												type: "array"
											}
											dynamoDBTargets: {
												description: "Specifies Amazon DynamoDB targets."
												items: {
													properties: {
														path: type: "string"
														scanAll: type: "boolean"
														scanRate: type: "number"
													}
													type: "object"
												}
												type: "array"
											}
											jdbcTargets: {
												description: "Specifies JDBC targets."
												items: {
													description: "CustomJDBCTarget contains the additional fields for JdbcTarget"

													properties: {
														connectionName: {
															description: "The name of the connection to use to connect to the JDBC target."

															type: "string"
														}
														connectionNameRef: {
															description: "ConnectionNameRef is a reference to an Connection used to set the ConnectionName."

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
														connectionNameSelector: {
															description: "ConnectionNamesSelector selects references to Connection used to set the ConnectionName."

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
														exclusions: {
															description: "A list of glob patterns used to exclude from the crawl. For more information, see Catalog Tables with a Crawler (https://docs.aws.amazon.com/glue/latest/dg/add-crawler.html)."

															items: type: "string"
															type: "array"
														}
														path: {
															description: "The path of the JDBC target."
															type:        "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
											mongoDBTargets: {
												description: "Specifies Amazon DocumentDB or MongoDB targets."
												items: {
													description: "CustomMongoDBTarget contains the additional fields for MongoDBTarget"

													properties: {
														connectionName: {
															description: "The name of the connection to use to connect to the Amazon DocumentDB or MongoDB target."

															type: "string"
														}
														connectionNameRef: {
															description: "ConnectionNameRef is a reference to an Connection used to set the ConnectionName."

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
														connectionNameSelector: {
															description: "ConnectionNamesSelector selects references to Connection used to set the ConnectionName."

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
														path: {
															description: "The path of the Amazon DocumentDB or MongoDB target (database/collection)."

															type: "string"
														}
														scanAll: {
															description: """
		Indicates whether to scan all the records, or to sample rows from the table. Scanning all the records can take a long time when the table is not a high throughput table. 
		 A value of true means to scan all records, while a value of false means to sample the records. If no value is specified, the value defaults to true.
		"""

															type: "boolean"
														}
													}
													type: "object"
												}
												type: "array"
											}
											s3Targets: {
												description: "Specifies Amazon Simple Storage Service (Amazon S3) targets."

												items: {
													description: "CustomS3Target contains the additional fields for S3Target"

													properties: {
														connectionName: {
															description: "The name of a connection which allows a job or crawler to access data in Amazon S3 within an Amazon Virtual Private Cloud environment (Amazon VPC)."

															type: "string"
														}
														connectionNameRef: {
															description: "ConnectionNameRef is a reference to an Connection used to set the ConnectionName."

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
														connectionNameSelector: {
															description: "ConnectionNamesSelector selects references to Connection used to set the ConnectionName."

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
														dlqEventQueueArn: {
															description: "A valid Amazon dead-letter SQS ARN. For example, arn:aws:sqs:region:account:deadLetterQueue."

															type: "string"
														}
														dlqEventQueueArnRef: {
															description: "DlqEventQueueARNRef is a reference to an SQSEventQueue used to set the DlqEventQueueARN."

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
														dlqEventQueueArnSelector: {
															description: "DlqEventQueueARNSelector selects references to SQSEventQueue used to set the DlqEventQueueARN."

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
														eventQueueArn: {
															description: "A valid Amazon SQS ARN. For example, arn:aws:sqs:region:account:sqs."
															type:        "string"
														}
														eventQueueArnRef: {
															description: "EventQueueARNRef is a reference to an SQSEventQueue used to set the EventQueueARN."

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
														eventQueueArnSelector: {
															description: "EventQueueARNSelector selects references to SQSEventQueue used to set the EventQueueARN."

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
														exclusions: {
															description: "A list of glob patterns used to exclude from the crawl. For more information, see Catalog Tables with a Crawler (https://docs.aws.amazon.com/glue/latest/dg/add-crawler.html)."

															items: type: "string"
															type: "array"
														}
														path: {
															description: "The path to the Amazon S3 target."
															type:        "string"
														}
														sampleSize: {
															description: "Sets the number of files in each leaf folder to be crawled when crawling sample files in a dataset. If not set, all the files are crawled. A valid value is an integer between 1 and 249."

															format: "int64"
															type:   "integer"
														}
													}
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
								}
								required: [
									"region",
									"targets",
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
						description: "CrawlerStatus defines the observed state of Crawler."
						properties: {
							atProvider: {
								description: "CrawlerObservation defines the observed state of Crawler"
								properties: {
									crawlElapsedTime: {
										description: "If the crawler is running, contains the total time elapsed since the last crawl began."

										format: "int64"
										type:   "integer"
									}
									creationTime: {
										description: "The time that the crawler was created."
										format:      "date-time"
										type:        "string"
									}
									lastCrawl: {
										description: "The status of the last crawl, and potentially error information if an error occurred."

										properties: {
											errorMessage: type: "string"
											logGroup: type: "string"
											logStream: type: "string"
											messagePrefix: type: "string"
											startTime: {
												format: "date-time"
												type:   "string"
											}
											status: type: "string"
										}
										type: "object"
									}
									lastUpdated: {
										description: "The time that the crawler was last updated."
										format:      "date-time"
										type:        "string"
									}
									scheduleState: {
										description: "The state of the schedule."
										type:        "string"
									}
									state: {
										description: "Indicates whether the crawler is running, or whether a run is pending."

										type: "string"
									}
									version: {
										description: "The version of the crawler."
										format:      "int64"
										type:        "integer"
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
