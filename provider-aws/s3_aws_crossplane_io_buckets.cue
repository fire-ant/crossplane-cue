package s3_aws_crossplane_io_buckets

customresourcedefinition: "buckets.s3.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "buckets.s3.aws.crossplane.io"
	}
	spec: {
		group: "s3.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Bucket"
			listKind: "BucketList"
			plural:   "buckets"
			singular: "bucket"
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
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "An Bucket is a managed resource that represents an AWS S3 Bucket."
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
						description: "BucketSpec represents the desired state of the Bucket."
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
								description: "BucketParameters are parameters for configuring the calls made to AWS Bucket API."

								properties: {
									accelerateConfiguration: {
										description: "AccelerateConfiguration configures the transfer acceleration state for an Amazon S3 bucket. For more information, see Amazon S3 Transfer Acceleration (https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html) in the Amazon Simple Storage Service Developer Guide."

										properties: status: {
											description: "Status specifies the transfer acceleration status of the bucket."

											enum: [
												"Enabled",
												"Suspended",
											]
											type: "string"
										}
										required: [
											"status",
										]
										type: "object"
									}
									acl: {
										description: "The canned ACL to apply to the bucket."
										enum: [
											"private",
											"public-read",
											"public-read-write",
											"authenticated-read",
											"aws-exec-read",
											"bucket-owner-read",
											"bucket-owner-full-control",
											"log-delivery-write",
										]
										type: "string"
									}
									corsConfiguration: {
										description: "Describes the cross-origin access configuration for objects in an Amazon S3 bucket. For more information, see Enabling Cross-Origin Resource Sharing (https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html) in the Amazon Simple Storage Service Developer Guide."

										properties: corsRules: {
											description: "A set of origins and methods (cross-origin access that you want to allow). You can add up to 100 rules to the configuration."

											items: {
												description: "CORSRule specifies a cross-origin access rule for an Amazon S3 bucket."

												properties: {
													allowedHeaders: {
														description: "Headers that are specified in the Access-Control-Request-Headers header. These headers are allowed in a preflight OPTIONS request. In response to any preflight OPTIONS request, Amazon S3 returns any requested headers that are allowed."

														items: type: "string"
														type: "array"
													}
													allowedMethods: {
														description: "An HTTP method that you allow the origin to execute. Valid values are GET, PUT, HEAD, POST, and DELETE."

														items: type: "string"
														type: "array"
													}
													allowedOrigins: {
														description: "One or more origins you want customers to be able to access the bucket from."

														items: type: "string"
														type: "array"
													}
													exposeHeaders: {
														description: "One or more headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript XMLHttpRequest object)."

														items: type: "string"
														type: "array"
													}
													maxAgeSeconds: {
														description: "The time in seconds that your browser is to cache the preflight response for the specified resource."

														format: "int32"
														type:   "integer"
													}
												}
												required: [
													"allowedMethods",
													"allowedOrigins",
												]
												type: "object"
											}
											type: "array"
										}
										required: [
											"corsRules",
										]
										type: "object"
									}
									grantFullControl: {
										description: "Allows grantee the read, write, read ACP, and write ACP permissions on the bucket."

										type: "string"
									}
									grantRead: {
										description: "Allows grantee to list the objects in the bucket."
										type:        "string"
									}
									grantReadAcp: {
										description: "Allows grantee to read the bucket ACL."
										type:        "string"
									}
									grantWrite: {
										description: "Allows grantee to create, overwrite, and delete any object in the bucket."

										type: "string"
									}
									grantWriteAcp: {
										description: "Allows grantee to write the ACL for the applicable bucket."

										type: "string"
									}
									lifecycleConfiguration: {
										description: "Creates a new lifecycle configuration for the bucket or replaces an existing lifecycle configuration. For information about lifecycle configuration, see Managing Access Permissions to Your Amazon S3 Resources (https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html)."

										properties: rules: {
											description: """
		A lifecycle rule for individual objects in an Amazon S3 bucket. 
		 Rules is a required field
		"""

											items: {
												description: "LifecycleRule for individual objects in an Amazon S3 bucket."

												properties: {
													abortIncompleteMultipartUpload: {
														description: "Specifies the days since the initiation of an incomplete multipart upload that Amazon S3 will wait before permanently removing all parts of the upload. For more information, see Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy (https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config) in the Amazon Simple Storage Service Developer Guide."

														properties: daysAfterInitiation: {
															description: "Specifies the number of days after which Amazon S3 aborts an incomplete multipart upload."

															format: "int32"
															type:   "integer"
														}
														required: [
															"daysAfterInitiation",
														]
														type: "object"
													}
													expiration: {
														description: "Specifies the expiration for the lifecycle of the object in the form of date, days and, whether the object has a delete marker."

														properties: {
															date: {
																description: "Indicates at what date the object is to be moved or deleted."

																format: "date-time"
																type:   "string"
															}
															days: {
																description: "Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer."

																format:  "int32"
																minimum: 1
																type:    "integer"
															}
															expiredObjectDeleteMarker: {
																description: "Indicates whether Amazon S3 will remove a delete marker with no noncurrent versions. If set to true, the delete marker will be expired; if set to false the policy takes no action. This cannot be specified with Days or Date in a Lifecycle Expiration Policy."

																type: "boolean"
															}
														}
														type: "object"
													}
													filter: {
														description: "The Filter is used to identify objects that a Lifecycle Rule applies to. A Filter must have exactly one of Prefix, Tag, or And specified."

														properties: {
															and: {
																description: "This is used in a Lifecycle Rule Filter to apply a logical AND to two or more predicates. The Lifecycle Rule will apply to any object matching all of the predicates configured inside the And operator."

																properties: {
																	prefix: {
																		description: "Prefix identifying one or more objects to which the rule applies."

																		type: "string"
																	}
																	tags: {
																		description: "All of these tags must exist in the object's tag set in order for the rule to apply."

																		items: {
																			description: "Tag is a container for a key value name pair."

																			properties: {
																				key: {
																					description: "Name of the tag. Key is a required field"

																					type: "string"
																				}
																				value: {
																					description: "Value of the tag. Value is a required field"

																					type: "string"
																				}
																			}
																			required: [
																				"key",
																				"value",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																}
																required: [
																	"tags",
																]
																type: "object"
															}
															prefix: {
																description: "Prefix identifying one or more objects to which the rule applies."

																type: "string"
															}
															tag: {
																description: "This tag must exist in the object's tag set in order for the rule to apply."

																properties: {
																	key: {
																		description: "Name of the tag. Key is a required field"

																		type: "string"
																	}
																	value: {
																		description: "Value of the tag. Value is a required field"

																		type: "string"
																	}
																}
																required: [
																	"key",
																	"value",
																]
																type: "object"
															}
														}
														type: "object"
													}
													id: {
														description: "Unique identifier for the rule. The value cannot be longer than 255 characters."

														type: "string"
													}
													noncurrentVersionExpiration: {
														description: "Specifies when noncurrent object versions expire. Upon expiration, Amazon S3 permanently deletes the noncurrent object versions. You set this lifecycle configuration action on a bucket that has versioning enabled (or suspended) to request that Amazon S3 delete noncurrent object versions at a specific period in the object's lifetime."

														properties: noncurrentDays: {
															description: "Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see How Amazon S3 Calculates When an Object Became Noncurrent (https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations) in the Amazon Simple Storage Service Developer Guide."

															format: "int32"
															type:   "integer"
														}
														type: "object"
													}
													noncurrentVersionTransitions: {
														description: "Specifies the transition rule for the lifecycle rule that describes when noncurrent objects transition to a specific storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to a specific storage class at a set period in the object's lifetime."

														items: {
															description: "NoncurrentVersionTransition contains the transition rule that describes when noncurrent objects transition to the STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, GLACIER, or DEEP_ARCHIVE storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to the STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, GLACIER, or DEEP_ARCHIVE storage class at a specific period in the object's lifetime."

															properties: {
																noncurrentDays: {
																	description: "Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see How Amazon S3 Calculates How Long an Object Has Been Noncurrent (https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#non-current-days-calculations) in the Amazon Simple Storage Service Developer Guide."

																	format: "int32"
																	type:   "integer"
																}
																storageClass: {
																	description: "The class of storage used to store the object. Valid values are: GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE"

																	enum: [
																		"GLACIER",
																		"STANDARD_IA",
																		"ONEZONE_IA",
																		"INTELLIGENT_TIERING",
																		"DEEP_ARCHIVE",
																	]
																	type: "string"
																}
															}
															required: [
																"storageClass",
															]
															type: "object"
														}
														type: "array"
													}
													status: {
														description: """
		If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied. 
		 Status is a required field, valid values are Enabled or Disabled
		"""

														enum: [
															"Enabled",
															"Disabled",
														]
														type: "string"
													}
													transitions: {
														description: "Specifies when an Amazon S3 object transitions to a specified storage class."

														items: {
															description: "Transition specifies when an object transitions to a specified storage class. For more information about Amazon S3 lifecycle configuration rules, see Transitioning Objects Using Amazon S3 Lifecycle (https://docs.aws.amazon.com/AmazonS3/latest/dev/lifecycle-transition-general-considerations.html) in the Amazon Simple Storage Service Developer Guide."

															properties: {
																date: {
																	description: "Indicates when objects are transitioned to the specified storage class. The date value must be in ISO 8601 format. The time is always midnight UTC."

																	format: "date-time"
																	type:   "string"
																}
																days: {
																	description: "Indicates the number of days after creation when objects are transitioned to the specified storage class. The value must be a positive integer."

																	format:  "int32"
																	minimum: 1
																	type:    "integer"
																}
																storageClass: {
																	description: "The storage class to which you want the object to transition. Valid values are: GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE"

																	enum: [
																		"GLACIER",
																		"STANDARD_IA",
																		"ONEZONE_IA",
																		"INTELLIGENT_TIERING",
																		"DEEP_ARCHIVE",
																	]
																	type: "string"
																}
															}
															required: [
																"storageClass",
															]
															type: "object"
														}
														type: "array"
													}
												}
												required: [
													"status",
												]
												type: "object"
											}
											type: "array"
										}
										required: [
											"rules",
										]
										type: "object"
									}
									locationConstraint: {
										description: "LocationConstraint specifies the Region where the bucket will be created. It is a required field. Due to AWS API limitations lacking on a proper response, when this field is set to a wrong value, or to non-existent region on bucket creation, it's impossible forwarding a meaningful status message to the user about the problem, producing connection errors instead."

										type: "string"
									}
									loggingConfiguration: {
										description: "Specifies logging parameters for an Amazon S3 bucket. Set the logging parameters for a bucket and to specify permissions for who can view and modify the logging parameters. See the AWS API reference guide for Amazon Simple Storage Service's API operation PutBucketLogging for usage and error information. See also, https://docs.aws.amazon.com/goto/WebAPI/s3-2006-03-01/PutBucketLogging"

										properties: {
											targetBucket: {
												description: "TargetBucket where logs will be stored, it can be the same bucket. At least one of targetBucket, targetBucketRef or targetBucketSelector is required."

												type: "string"
											}
											targetBucketRef: {
												description: "TargetBucketRef references an S3Bucket to retrieve its name"

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
											targetBucketSelector: {
												description: "TargetBucketSelector selects a reference to an S3Bucket to retrieve its name"

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
											targetGrants: {
												description: "Container for granting information."
												items: {
													description: "TargetGrant is the container for granting information."
													properties: {
														bucketLogsPermission: {
															description: "Logging permissions assigned to the Grantee for the bucket. Valid values are \"FULL_CONTROL\", \"READ\", \"WRITE\""

															enum: [
																"FULL_CONTROL",
																"READ",
																"WRITE",
															]
															type: "string"
														}
														targetGrantee: {
															description: "Container for the person being granted permissions."

															properties: {
																ID: {
																	description: "The canonical user ID of the grantee."
																	type:        "string"
																}
																URI: {
																	description: "URI of the grantee group."
																	type:        "string"
																}
																displayName: {
																	description: "Screen name of the grantee."
																	type:        "string"
																}
																emailAddress: {
																	description: "Email address of the grantee. For a list of all the Amazon S3 supported Regions and endpoints, see Regions and Endpoints (https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) in the AWS General Reference."

																	type: "string"
																}
																type: {
																	description: "Type of grantee Type is a required field"

																	enum: [
																		"CanonicalUser",
																		"AmazonCustomerByEmail",
																		"Group",
																	]
																	type: "string"
																}
															}
															required: [
																"type",
															]
															type: "object"
														}
													}
													required: [
														"bucketLogsPermission",
														"targetGrantee",
													]
													type: "object"
												}
												type: "array"
											}
											targetPrefix: {
												description: "A prefix for all log object keys."
												type:        "string"
											}
										}
										required: [
											"targetPrefix",
										]
										type: "object"
									}
									notificationConfiguration: {
										description: "Enables notifications of specified events for a bucket. For more information about event notifications, see Configuring Event Notifications (https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html)."

										properties: {
											lambdaFunctionConfigurations: {
												description: "Describes the AWS Lambda functions to invoke and the events for which to invoke them."

												items: {
													description: "LambdaFunctionConfiguration contains the configuration for AWS Lambda notifications."

													properties: {
														ID: {
															description: "An optional unique identifier for configurations in a notification configuration. If you don't provide one, Amazon S3 will assign an ID."

															type: "string"
														}
														events: {
															description: """
		The Amazon S3 bucket event for which to invoke the AWS Lambda function. For more information, see Supported Event Types (https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the Amazon Simple Storage Service Developer Guide. 
		 Events is a required field A full list of valid events can be found in the Amazon S3 Developer guide https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html#notification-how-to-event-types-and-destinations
		"""

															items: type: "string"
															type: "array"
														}
														filter: {
															description: "Specifies object key name filtering rules. For information about key name filtering, see Configuring Event Notifications (https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the Amazon Simple Storage Service Developer Guide."

															properties: key: {
																description: "A container for object key name prefix and suffix filtering rules."

																properties: filterRules: {
																	description: "A list of containers for the key-value pair that defines the criteria for the filter rule."

																	items: {
																		description: "FilterRule specifies the Amazon S3 object key name to filter on and whether to filter on the suffix or prefix of the key name."

																		properties: {
																			name: {
																				description: "The object key name prefix or suffix identifying one or more objects to which the filtering rule applies. The maximum length is 1,024 characters. Overlapping prefixes and suffixes are not supported. For more information, see Configuring Event Notifications (https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the Amazon Simple Storage Service Developer Guide. Valid values are \"prefix\" or \"suffix\""

																				enum: [
																					"prefix",
																					"suffix",
																				]
																				type: "string"
																			}
																			value: {
																				description: "The value that the filter searches for in object key names."

																				type: "string"
																			}
																		}
																		required: [
																			"name",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																required: [
																	"filterRules",
																]
																type: "object"
															}
															type: "object"
														}
														lambdaFunctionArn: {
															description: """
		The Amazon Resource Name (ARN) of the AWS Lambda function that Amazon S3 invokes when the specified event type occurs. 
		 LambdaFunctionArn is a required field
		"""

															type: "string"
														}
													}
													required: [
														"events",
														"lambdaFunctionArn",
													]
													type: "object"
												}
												type: "array"
											}
											queueConfigurations: {
												description: "The Amazon Simple Queue Service queues to publish messages to and the events for which to publish messages."

												items: {
													description: "QueueConfiguration specifies the configuration for publishing messages to an Amazon Simple Queue Service (Amazon SQS) queue when Amazon S3 detects specified events."

													properties: {
														ID: {
															description: "An optional unique identifier for configurations in a notification configuration. If you don't provide one, Amazon S3 will assign an ID."

															type: "string"
														}
														events: {
															description: """
		A collection of bucket events for which to send notifications 
		 Events is a required field A full list of valid events can be found in the Amazon S3 Developer guide https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html#notification-how-to-event-types-and-destinations
		"""

															items: type: "string"
															type: "array"
														}
														filter: {
															description: "Specifies object key name filtering rules. For information about key name filtering, see Configuring Event Notifications (https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the Amazon Simple Storage Service Developer Guide."

															properties: key: {
																description: "A container for object key name prefix and suffix filtering rules."

																properties: filterRules: {
																	description: "A list of containers for the key-value pair that defines the criteria for the filter rule."

																	items: {
																		description: "FilterRule specifies the Amazon S3 object key name to filter on and whether to filter on the suffix or prefix of the key name."

																		properties: {
																			name: {
																				description: "The object key name prefix or suffix identifying one or more objects to which the filtering rule applies. The maximum length is 1,024 characters. Overlapping prefixes and suffixes are not supported. For more information, see Configuring Event Notifications (https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the Amazon Simple Storage Service Developer Guide. Valid values are \"prefix\" or \"suffix\""

																				enum: [
																					"prefix",
																					"suffix",
																				]
																				type: "string"
																			}
																			value: {
																				description: "The value that the filter searches for in object key names."

																				type: "string"
																			}
																		}
																		required: [
																			"name",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																required: [
																	"filterRules",
																]
																type: "object"
															}
															type: "object"
														}
														queueArn: {
															description: """
		The Amazon Resource Name (ARN) of the Amazon SQS queue to which Amazon S3 publishes a message when it detects events of the specified type. 
		 QueueArn is a required field
		"""

															type: "string"
														}
														queueArnRef: {
															description: "QueueArnRef references an Queue to retrieve its ARN"

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
														queueArnSelector: {
															description: "QueueArnSelector selects a reference to an Queue to retrieve its ARN"

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
														"events",
													]
													type: "object"
												}
												type: "array"
											}
											topicConfigurations: {
												description: "The topic to which notifications are sent and the events for which notifications are generated."

												items: {
													description: "TopicConfiguration specifies the configuration for publication of messages to an Amazon Simple Notification Service (Amazon SNS) topic when Amazon S3 detects specified events."

													properties: {
														ID: {
															description: "An optional unique identifier for configurations in a notification configuration. If you don't provide one, Amazon S3 will assign an ID."

															type: "string"
														}
														events: {
															description: """
		The Amazon S3 bucket event about which to send notifications. For more information, see Supported Event Types (https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the Amazon Simple Storage Service Developer Guide. 
		 Events is a required field A full list of valid events can be found in the Amazon S3 Developer guide https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html#notification-how-to-event-types-and-destinations
		"""

															items: type: "string"
															type: "array"
														}
														filter: {
															description: "Specifies object key name filtering rules. For information about key name filtering, see Configuring Event Notifications (https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the Amazon Simple Storage Service Developer Guide."

															properties: key: {
																description: "A container for object key name prefix and suffix filtering rules."

																properties: filterRules: {
																	description: "A list of containers for the key-value pair that defines the criteria for the filter rule."

																	items: {
																		description: "FilterRule specifies the Amazon S3 object key name to filter on and whether to filter on the suffix or prefix of the key name."

																		properties: {
																			name: {
																				description: "The object key name prefix or suffix identifying one or more objects to which the filtering rule applies. The maximum length is 1,024 characters. Overlapping prefixes and suffixes are not supported. For more information, see Configuring Event Notifications (https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the Amazon Simple Storage Service Developer Guide. Valid values are \"prefix\" or \"suffix\""

																				enum: [
																					"prefix",
																					"suffix",
																				]
																				type: "string"
																			}
																			value: {
																				description: "The value that the filter searches for in object key names."

																				type: "string"
																			}
																		}
																		required: [
																			"name",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																required: [
																	"filterRules",
																]
																type: "object"
															}
															type: "object"
														}
														topicArn: {
															description: "The Amazon Resource Name (ARN) of the Amazon SNS topic to which Amazon S3 publishes a message when it detects events of the specified type. At least one of topicArn, topicArnRef or topicSelector is required."

															type: "string"
														}
														topicRef: {
															description: "TopicArnRef references an SNS Topic to retrieve its Arn"

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
														topicSelector: {
															description: "TopicArnSelector selects a reference to an SNS Topic to retrieve its Arn"

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
														"events",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									objectLockEnabledForBucket: {
										description: "Specifies whether you want S3 Object Lock to be enabled for the new bucket."

										type: "boolean"
									}
									objectOwnership: {
										description: "The container element for object ownership for a bucket's ownership controls. BucketOwnerPreferred - Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. ObjectWriter - The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL. BucketOwnerEnforced - Access control lists (ACLs) are disabled and no longer affect permissions. The bucket owner automatically owns and has full control over every object in the bucket. The bucket only accepts PUT requests that don't specify an ACL or bucket owner full control ACLs, such as the bucket-owner-full-control canned ACL or an equivalent form of this ACL expressed in the XML format."

										enum: [
											"BucketOwnerPreferred",
											"ObjectWriter",
											"BucketOwnerEnforced",
										]
										type: "string"
									}
									paymentConfiguration: {
										description: "Specifies payer parameters for an Amazon S3 bucket. For more information, see Request Pays buckets (https://docs.aws.amazon.com/AmazonS3/latest/dev/RequesterPaysBuckets.html) in the Amazon Simple Storage Service Developer Guide."

										properties: payer: {
											description: "Payer is a required field, detailing who pays Valid values are \"Requester\" and \"BucketOwner\""

											enum: [
												"Requester",
												"BucketOwner",
											]
											type: "string"
										}
										required: [
											"payer",
										]
										type: "object"
									}
									publicAccessBlockConfiguration: {
										description: "PublicAccessBlockConfiguration that you want to apply to this Amazon S3 bucket."

										properties: {
											blockPublicAcls: {
												description: """
		Specifies whether Amazon S3 should block public access control lists (ACLs) for this bucket and objects in this bucket. Setting this element to TRUE causes the following behavior: 
		 * PUT Bucket acl and PUT Object acl calls fail if the specified ACL is public. 
		 * PUT Object calls fail if the request includes a public ACL. 
		 * PUT Bucket calls fail if the request includes a public ACL. 
		 Enabling this setting doesn't affect existing policies or ACLs.
		"""

												type: "boolean"
											}
											blockPublicPolicy: {
												description: """
		Specifies whether Amazon S3 should block public bucket policies for this bucket. Setting this element to TRUE causes Amazon S3 to reject calls to PUT Bucket policy if the specified bucket policy allows public access. 
		 Enabling this setting doesn't affect existing bucket policies.
		"""

												type: "boolean"
											}
											ignorePublicAcls: {
												description: """
		Specifies whether Amazon S3 should ignore public ACLs for this bucket and objects in this bucket. Setting this element to TRUE causes Amazon S3 to ignore all public ACLs on this bucket and objects in this bucket. 
		 Enabling this setting doesn't affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set.
		"""

												type: "boolean"
											}
											restrictPublicBuckets: {
												description: """
		Specifies whether Amazon S3 should restrict public bucket policies for this bucket. Setting this element to TRUE restricts access to this bucket to only AWS services and authorized users within this account if the bucket has a public policy. 
		 Enabling this setting doesn't affect previously stored bucket policies, except that public and cross-account access within any public bucket policy, including non-public delegation to specific accounts, is blocked.
		"""

												type: "boolean"
											}
										}
										type: "object"
									}
									replicationConfiguration: {
										description: "Creates a replication configuration or replaces an existing one. For more information, see Replication (https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html) in the Amazon S3 Developer Guide."

										properties: {
											role: {
												description: """
		The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that Amazon S3 assumes when replicating objects. For more information, see How to Set Up Replication (https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-how-setup.html) in the Amazon Simple Storage Service Developer Guide. 
		 At least one of role, roleRef or roleSelector fields is required.
		"""

												type: "string"
											}
											roleRef: {
												description: "RoleRef references an IAMRole to retrieve its Name"

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
												description: "RoleSelector selects a reference to an IAMRole to retrieve its Name"

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
											rules: {
												description: """
		A container for one or more replication rules. A replication configuration must have at least one rule and can contain a maximum of 1,000 rules. 
		 Rules is a required field
		"""

												items: {
													description: "ReplicationRule specifies which Amazon S3 objects to replicate and where to store the replicas."

													properties: {
														deleteMarkerReplication: {
															description: """
		Specifies whether Amazon S3 replicates the delete markers. If you specify a Filter, you must specify this element. However, in the latest version of replication configuration (when Filter is specified), Amazon S3 doesn't replicate delete markers. Therefore, the DeleteMarkerReplication element can contain only <Status>Disabled</Status>. For an example configuration, see Basic Rule Configuration (https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-config-min-rule-config). 
		 If you don't specify the Filter element, Amazon S3 assumes that the replication configuration is the earlier version, V1. In the earlier version, Amazon S3 handled replication of delete markers differently. For more information, see Backward Compatibility (https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-backward-compat-considerations).
		"""

															properties: status: {
																description: "Indicates whether to replicate delete markers. Valid values are \"Enabled\" or \"Disabled\""

																enum: [
																	"Enabled",
																	"Disabled",
																]
																type: "string"
															}
															required: [
																"status",
															]
															type: "object"
														}
														destination: {
															description: """
		A container for information about the replication destination and its configurations including enabling the S3 Replication Time Control (S3 RTC). 
		 Destination is a required field
		"""

															properties: {
																accessControlTranslation: {
																	description: "Specify this only in a cross-account scenario (where source and destination bucket owners are not the same), and you want to change replica ownership to the AWS account that owns the destination bucket. If this is not specified in the replication configuration, the replicas are owned by same AWS account that owns the source object."

																	properties: ownerOverride: {
																		description: "Specifies the replica ownership. For default and valid values, see PUT bucket replication (https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html) in the Amazon Simple Storage Service API Reference. Owner is a required field"

																		type: "string"
																	}
																	required: [
																		"ownerOverride",
																	]
																	type: "object"
																}
																account: {
																	description: "Destination bucket owner account ID. In a cross-account scenario, if you direct Amazon S3 to change replica ownership to the AWS account that owns the destination bucket by specifying the AccessControlTranslation property, this is the account ID of the destination bucket owner. For more information, see Replication Additional Configuration: Changing the Replica Owner (https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-change-owner.html) in the Amazon Simple Storage Service Developer Guide."

																	type: "string"
																}
																bucket: {
																	description: "The Amazon Resource Name (ARN) of the bucket where you want Amazon S3 to store the results. At least one of bucket, bucketRef or bucketSelector is required."

																	type: "string"
																}
																bucketRef: {
																	description: "BucketRef references a Bucket to retrieve its Name"

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
																bucketSelector: {
																	description: "BucketSelector selects a reference to a Bucket to retrieve its Name"

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
																encryptionConfiguration: {
																	description: "A container that provides information about encryption. If SourceSelectionCriteria is specified, you must specify this element."

																	properties: {
																		replicaKmsKeyId: {
																			description: "Specifies the ID (Key ARN or Alias ARN) of the customer managed customer master key (CMK) stored in AWS Key Management Service (KMS) for the destination bucket. Amazon S3 uses this key to encrypt replica objects. Amazon S3 only supports symmetric customer managed CMKs. For more information, see Using Symmetric and Asymmetric Keys (https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html) in the AWS Key Management Service Developer Guide."

																			type: "string"
																		}
																		replicaKmsKeyIdRef: {
																			description: "ReplicaKmsKeyIDRef references an KMSKey to retrieve its ID"

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
																		replicaKmsKeyIdSelector: {
																			description: "ReplicaKmsKeyIDSelector selects a reference to an KMSKey to retrieve its ID"

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
																		"replicaKmsKeyId",
																	]
																	type: "object"
																}
																metrics: {
																	description: "A container specifying replication metrics-related settings enabling metrics and Amazon S3 events for S3 Replication Time Control (S3 RTC). Must be specified together with a ReplicationTime block."

																	properties: {
																		eventThreshold: {
																			description: "A container specifying the time threshold for emitting the s3:Replication:OperationMissedThreshold event."

																			properties: minutes: {
																				description: """
		Contains an integer specifying time in minutes. 
		 Valid values: 15 minutes.
		"""

																				format: "int32"
																				type:   "integer"
																			}
																			required: [
																				"minutes",
																			]
																			type: "object"
																		}
																		status: {
																			description: """
		Specifies whether the replication metrics are enabled. 
		 Status is a required field, valid values are \"Enabled\" and \"Disabled\"
		"""

																			enum: [
																				"Enabled",
																				"Disabled",
																			]
																			type: "string"
																		}
																	}
																	required: [
																		"status",
																	]
																	type: "object"
																}
																replicationTime: {
																	description: "A container specifying S3 Replication Time Control (S3 RTC), including whether S3 RTC is enabled and the time when all objects and operations on objects must be replicated. Must be specified together with a Metrics block."

																	properties: {
																		status: {
																			description: "Specifies whether the replication time is enabled Status is a required field Valid values are \"Enabled\" and \"Disabled\""

																			enum: [
																				"Enabled",
																				"Disabled",
																			]
																			type: "string"
																		}
																		time: {
																			description: "A container specifying the time by which replication should be complete for all objects and operations on objects. Time is a required field"

																			properties: minutes: {
																				description: """
		Contains an integer specifying time in minutes. 
		 Valid values: 15 minutes.
		"""

																				format: "int32"
																				type:   "integer"
																			}
																			required: [
																				"minutes",
																			]
																			type: "object"
																		}
																	}
																	required: [
																		"status",
																		"time",
																	]
																	type: "object"
																}
																storageClass: {
																	description: "The storage class to use when replicating objects, such as S3 Standard or reduced redundancy. By default, Amazon S3 uses the storage class of the source object to create the object replica. For valid values, see the StorageClass element of the PUT Bucket replication (https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html) action in the Amazon Simple Storage Service API Reference."

																	enum: [
																		"STANDARD",
																		"GLACIER",
																		"STANDARD_IA",
																		"ONEZONE_IA",
																		"INTELLIGENT_TIERING",
																		"DEEP_ARCHIVE",
																	]
																	type: "string"
																}
															}
															type: "object"
														}
														existingObjectReplication: {
															description: "Optional configuration to replicate existing source bucket objects. For more information, see Replicating Existing Objects (https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-what-is-isnot-replicated.html#existing-object-replication) in the Amazon S3 Developer Guide."

															properties: status: {
																description: "Status is a required field Valid values are \"Enabled\" and \"Disabled\""

																enum: [
																	"Enabled",
																	"Disabled",
																]
																type: "string"
															}
															required: [
																"status",
															]
															type: "object"
														}
														filter: {
															description: "A filter that identifies the subset of objects to which the replication rule applies. A Filter must specify exactly one Prefix, Tag, or an And child element."

															properties: {
																and: {
																	description: """
		A container for specifying rule filters. The filters determine the subset of objects to which the rule applies. This element is required only if you specify more than one filter. For example: 
		 * If you specify both a Prefix and a Tag filter, wrap these filters in an And tag. 
		 * If you specify a filter based on multiple tags, wrap the Tag elements in an And tag.
		"""

																	properties: {
																		prefix: {
																			description: "An object key name prefix that identifies the subset of objects to which the rule applies."

																			type: "string"
																		}
																		tag: {
																			description: "An array of tags containing key and value pairs."

																			items: {
																				description: "Tag is a container for a key value name pair."

																				properties: {
																					key: {
																						description: "Name of the tag. Key is a required field"

																						type: "string"
																					}
																					value: {
																						description: "Value of the tag. Value is a required field"

																						type: "string"
																					}
																				}
																				required: [
																					"key",
																					"value",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																	}
																	type: "object"
																}
																prefix: {
																	description: "An object key name prefix that identifies the subset of objects to which the rule applies."

																	type: "string"
																}
																tag: {
																	description: "A container for specifying a tag key and value. The rule applies only to objects that have the tag in their tag set."

																	properties: {
																		key: {
																			description: "Name of the tag. Key is a required field"

																			type: "string"
																		}
																		value: {
																			description: "Value of the tag. Value is a required field"

																			type: "string"
																		}
																	}
																	required: [
																		"key",
																		"value",
																	]
																	type: "object"
																}
															}
															type: "object"
														}
														id: {
															description: "A unique identifier for the rule. The maximum value is 255 characters."

															type: "string"
														}
														priority: {
															description: """
		The priority associated with the rule. If you specify multiple rules in a replication configuration, Amazon S3 prioritizes the rules to prevent conflicts when filtering. If two or more rules identify the same object based on a specified filter, the rule with higher priority takes precedence. For example: 
		 * Same object quality prefix-based filter criteria if prefixes you specified in multiple rules overlap 
		 * Same object qualify tag-based filter criteria specified in multiple rules 
		 For more information, see Replication (https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html) in the Amazon Simple Storage Service Developer Guide.
		"""

															format: "int32"
															type:   "integer"
														}
														sourceSelectionCriteria: {
															description: "A container that describes additional filters for identifying the source objects that you want to replicate. You can choose to enable or disable the replication of these objects. Currently, Amazon S3 supports only the filter that you can specify for objects created with server-side encryption using a customer master key (CMK) stored in AWS Key Management Service (SSE-KMS)."

															properties: sseKmsEncryptedObjects: {
																description: "A container for filter information for the selection of Amazon S3 objects encrypted with AWS KMS. If you include SourceSelectionCriteria in the replication configuration, this element is required."

																properties: status: {
																	description: """
		Specifies whether Amazon S3 replicates objects created with server-side encryption using a customer master key (CMK) stored in AWS Key Management Service. 
		 Status is a required field Valid values are \"Enabled\" or \"Disabled\"
		"""

																	enum: [
																		"Enabled",
																		"Disabled",
																	]
																	type: "string"
																}
																required: [
																	"status",
																]
																type: "object"
															}
															required: [
																"sseKmsEncryptedObjects",
															]
															type: "object"
														}
														status: {
															description: """
		Specifies whether the rule is enabled. 
		 Status is a required field Valid values are \"Enabled\" or \"Disabled\"
		"""

															enum: [
																"Enabled",
																"Disabled",
															]
															type: "string"
														}
													}
													required: [
														"destination",
														"status",
													]
													type: "object"
												}
												type: "array"
											}
										}
										required: [
											"rules",
										]
										type: "object"
									}
									serverSideEncryptionConfiguration: {
										description: "Specifies default encryption for a bucket using server-side encryption with Amazon S3-managed keys (SSE-S3) or customer master keys stored in AWS KMS (SSE-KMS). For information about the Amazon S3 default encryption feature, see Amazon S3 Default Bucket Encryption (https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html) in the Amazon Simple Storage Service Developer Guide."

										properties: rules: {
											description: "Container for information about a particular server-side encryption configuration rule."

											items: {
												description: "ServerSideEncryptionRule Specifies the default server-side encryption configuration."

												properties: {
													applyServerSideEncryptionByDefault: {
														description: "Specifies the default server-side encryption to apply to new objects in the bucket. If a PUT Object request doesn't specify any server-side encryption, this default encryption will be applied."

														properties: {
															kmsMasterKeyId: {
																description: """
		AWS Key Management Service (KMS) customer master key ID to use for the default encryption. This parameter is allowed if and only if SSEAlgorithm is set to aws:kms. 
		 You can specify the key ID or the Amazon Resource Name (ARN) of the CMK. However, if you are using encryption with cross-account operations, you must use a fully qualified CMK ARN. For more information, see Using encryption for cross-account operations (https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html#bucket-encryption-update-bucket-policy). 
		 For example: 
		 * Key ID: 1234abcd-12ab-34cd-56ef-1234567890ab 
		 * Key ARN: arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab 
		 Amazon S3 only supports symmetric CMKs and not asymmetric CMKs. For more information, see Using Symmetric and Asymmetric Keys (https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html) in the AWS Key Management Service Developer Guide.
		"""

																type: "string"
															}
															kmsMasterKeyIdRef: {
																description: "KMSMasterKeyIDRef references an KMSKey to retrieve its ID"

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
															kmsMasterKeyIdSelector: {
																description: "KMSMasterKeyIDSelector selects a reference to an KMSKey to retrieve its ID"

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
															sseAlgorithm: {
																description: "Server-side encryption algorithm to use for the default encryption. Options are AES256 or aws:kms"

																type: "string"
															}
														}
														required: [
															"sseAlgorithm",
														]
														type: "object"
													}
													bucketKeyEnabled: {
														description: "Specifies whether Amazon S3 should use an S3 Bucket Key with server-side encryption using KMS (SSE-KMS) for new objects in the bucket. Existing objects are not affected. Setting the BucketKeyEnabled element to true causes Amazon S3 to use an S3 Bucket Key. By default, S3 Bucket Key is not enabled. For more information, see Amazon S3 Bucket Keys (https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-key.html) in the Amazon S3 User Guide."

														type: "boolean"
													}
												}
												required: [
													"applyServerSideEncryptionByDefault",
												]
												type: "object"
											}
											type: "array"
										}
										required: [
											"rules",
										]
										type: "object"
									}
									tagging: {
										description: "Sets the tags for a bucket. Use tags to organize your AWS bill to reflect your own cost structure. For more information, see Billing and usage reporting for S3 buckets. (https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketBilling.html) in the Amazon Simple Storage Service Developer Guide."

										properties: tagSet: {
											description: "A collection for a set of tags TagSet is a required field"

											items: {
												description: "Tag is a container for a key value name pair."
												properties: {
													key: {
														description: "Name of the tag. Key is a required field"
														type:        "string"
													}
													value: {
														description: "Value of the tag. Value is a required field"
														type:        "string"
													}
												}
												required: [
													"key",
													"value",
												]
												type: "object"
											}
											type: "array"
										}
										required: [
											"tagSet",
										]
										type: "object"
									}
									versioningConfiguration: {
										description: "VersioningConfiguration describes the versioning state of an Amazon S3 bucket. See the AWS API reference guide for Amazon Simple Storage Service's API operation PutBucketVersioning for usage and error information. See also, https://docs.aws.amazon.com/goto/WebAPI/s3-2006-03-01/PutBucketVersioning"

										properties: {
											mfaDelete: {
												description: "MFADelete specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned."

												enum: [
													"Enabled",
													"Disabled",
												]
												type: "string"
											}
											status: {
												description: "Status is the desired versioning state of the bucket."

												enum: [
													"Enabled",
													"Suspended",
												]
												type: "string"
											}
										}
										type: "object"
									}
									websiteConfiguration: {
										description: "Specifies website configuration parameters for an Amazon S3 bucket. See the AWS API reference guide for Amazon Simple Storage Service's API operation PutBucketWebsite for usage and error information. See also, https://docs.aws.amazon.com/goto/WebAPI/s3-2006-03-01/PutBucketWebsite"

										properties: {
											errorDocument: {
												description: "The name of the error document for the website."
												properties: key: {
													description: "The object key name to use when a 4XX class error occurs."

													type: "string"
												}
												required: [
													"key",
												]
												type: "object"
											}
											indexDocument: {
												description: "The name of the index document for the website."
												properties: suffix: {
													description: "A suffix that is appended to a request that is for a directory on the website endpoint (for example,if the suffix is index.html and you make a request to samplebucket/images/ the data that is returned will be for the object with the key name images/index.html) The suffix must not be empty and must not include a slash character."

													type: "string"
												}
												required: [
													"suffix",
												]
												type: "object"
											}
											redirectAllRequestsTo: {
												description: "The redirect behavior for every request to this bucket's website endpoint. If you specify this property, you can't specify any other property."

												properties: {
													hostName: {
														description: "Name of the host where requests are redirected."
														type:        "string"
													}
													protocol: {
														description: "Protocol to use when redirecting requests. The default is the protocol that is used in the original request."

														enum: [
															"http",
															"https",
														]
														type: "string"
													}
												}
												required: [
													"hostName",
												]
												type: "object"
											}
											routingRules: {
												description: "Rules that define when a redirect is applied and the redirect behavior."

												items: {
													description: "RoutingRule specifies the redirect behavior and when a redirect is applied."

													properties: {
														condition: {
															description: "A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the /docs folder, redirect to the /documents folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error."

															properties: {
																httpErrorCodeReturnedEquals: {
																	description: "The HTTP error code when the redirect is applied. In the event of an error, if the error code equals this value, then the specified redirect is applied. Required when parent element Condition is specified and sibling KeyPrefixEquals is not specified. If both are specified, then both must be true for the redirect to be applied."

																	type: "string"
																}
																keyPrefixEquals: {
																	description: "The object key name prefix when the redirect is applied. For example, to redirect requests for ExamplePage.html, the key prefix will be ExamplePage.html. To redirect request for all pages with the prefix docs/, the key prefix will be /docs, which identifies all objects in the docs/ folder. Required when the parent element Condition is specified and sibling HttpErrorCodeReturnedEquals is not specified. If both conditions are specified, both must be true for the redirect to be applied."

																	type: "string"
																}
															}
															type: "object"
														}
														redirect: {
															description: "Container for redirect information. You can redirect requests to another host, to another page, or with another protocol. In the event of an error, you can specify a different error code to return."

															properties: {
																httpRedirectCode: {
																	description: "The HTTP redirect code to use on the response. Not required if one of the siblings is present."

																	type: "string"
																}
																keyPrefixEquals: {
																	description: "The host name to use in the redirect request."

																	type: "string"
																}
																protocol: {
																	description: "Protocol to use when redirecting requests. The default is the protocol that is used in the original request."

																	type: "string"
																}
																replaceKeyPrefixWith: {
																	description: "The object key prefix to use in the redirect request. For example, to redirect requests for all pages with prefix docs/ (objects in the docs/ folder) to documents/, you can set a condition block with KeyPrefixEquals set to docs/ and in the Redirect set ReplaceKeyPrefixWith to /documents. Not required if one of the siblings is present. Can be present only if ReplaceKeyWith is not provided."

																	type: "string"
																}
																replaceKeyWith: {
																	description: "The specific object key to use in the redirect request. For example, redirect request to error.html. Not required if one of the siblings is present. Can be present only if ReplaceKeyPrefixWith is not provided."

																	type: "string"
																}
															}
															type: "object"
														}
													}
													required: [
														"redirect",
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
									"locationConstraint",
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
						description: "BucketStatus represents the observed state of the Bucket."
						properties: {
							atProvider: {
								description: "BucketExternalStatus keeps the state for the external resource"

								properties: arn: {
									description: "ARN is the Amazon Resource Name (ARN) specifying the S3 Bucket. For more information about ARNs and how to use them, see S3 Resources (https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html) in the Amazon Simple Storage Service guide."

									type: "string"
								}
								required: [
									"arn",
								]
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
