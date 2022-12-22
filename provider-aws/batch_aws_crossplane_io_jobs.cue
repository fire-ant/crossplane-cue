package batch_aws_crossplane_io_jobs

customresourcedefinition: "jobs.batch.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "jobs.batch.aws.crossplane.io"
	}
	spec: {
		group: "batch.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Job"
			listKind: "JobList"
			plural:   "jobs"
			singular: "job"
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
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "A Job is a managed resource that represents an AWS Batch Job."
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
						description: "A JobSpec defines the desired state of a Job."
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
								description: "JobParameters define the desired state of a Batch Job"
								properties: {
									arrayProperties: {
										description: "The array properties for the submitted job, such as the size of the array. The array size can be between 2 and 10,000. If you specify array properties for a job, it becomes an array job. For more information, see Array Jobs (https://docs.aws.amazon.com/batch/latest/userguide/array_jobs.html) in the Batch User Guide."

										properties: size: {
											description: "The size of the array job."
											format:      "int64"
											type:        "integer"
										}
										type: "object"
									}
									containerOverrides: {
										description: "A list of container overrides in the JSON format that specify the name of a container in the specified job definition and the overrides it should receive. You can override the default command for a container, which is specified in the job definition or the Docker image, with a command override. You can also override existing environment variables on a container or add new environment variables to it with an environment override."

										properties: {
											command: {
												description: "The command to send to the container that overrides the default command from the Docker image or the job definition."

												items: type: "string"
												type: "array"
											}
											environment: {
												description: """
		The environment variables to send to the container. You can add new environment variables, which are added to the container at launch, or you can override the existing environment variables from the Docker image or the job definition. 
		 Environment variables must not start with AWS_BATCH; this naming convention is reserved for variables that are set by the Batch service.
		"""

												items: {
													description: "KeyValuePair defines a key-value pair object."
													properties: {
														name: {
															description: "The name of the key-value pair. For environment variables, this is the name of the environment variable."

															type: "string"
														}
														value: {
															description: "The value of the key-value pair. For environment variables, this is the value of the environment variable."

															type: "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
											instanceType: {
												description: """
		The instance type to use for a multi-node parallel job. 
		 This parameter isn't applicable to single-node container jobs or jobs that run on Fargate resources, and shouldn't be provided.
		"""

												type: "string"
											}
											resourceRequirements: {
												description: "The type and amount of resources to assign to a container. This overrides the settings in the job definition. The supported resources include GPU, MEMORY, and VCPU."

												items: {
													description: "ResourceRequirement defines the type and amount of a resource to assign to a container. The supported resources include GPU, MEMORY, and VCPU."

													properties: {
														resourceType: {
															description: """
		The type of resource to assign to a container. The supported resources include GPU, MEMORY, and VCPU. 
		 Type is a required field
		"""

															enum: [
																"GPU",
																"MEMORY",
																"VCPU",
															]
															type: "string"
														}
														value: {
															description: """
		The quantity of the specified resource to reserve for the container. The values vary based on the type specified. 
		 type=\"GPU\" 
		 The number of physical GPUs to reserve for the container. The number of GPUs reserved for all containers in a job shouldn't exceed the number of available GPUs on the compute resource that the job is launched on. 
		 GPUs are not available for jobs that are running on Fargate resources. 
		 type=\"MEMORY\" 
		 The memory hard limit (in MiB) present to the container. This parameter is supported for jobs that are running on EC2 resources. If your container attempts to exceed the memory specified, the container is terminated. This parameter maps to Memory in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --memory option to docker run (https://docs.docker.com/engine/reference/run/). You must specify at least 4 MiB of memory for a job. This is required but can be specified in several places for multi-node parallel (MNP) jobs. It must be specified for each node at least once. This parameter maps to Memory in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --memory option to docker run (https://docs.docker.com/engine/reference/run/). 
		 If you're trying to maximize your resource utilization by providing your jobs as much memory as possible for a particular instance type, see Memory Management (https://docs.aws.amazon.com/batch/latest/userguide/memory-management.html) in the Batch User Guide. 
		 For jobs that are running on Fargate resources, then value is the hard limit (in MiB), and must match one of the supported values and the VCPU values must be one of the values supported for that memory value. 
		 value = 512 
		 VCPU = 0.25 
		 value = 1024 
		 VCPU = 0.25 or 0.5 
		 value = 2048 
		 VCPU = 0.25, 0.5, or 1 
		 value = 3072 
		 VCPU = 0.5, or 1 
		 value = 4096 
		 VCPU = 0.5, 1, or 2 
		 value = 5120, 6144, or 7168 
		 VCPU = 1 or 2 
		 value = 8192 
		 VCPU = 1, 2, or 4 
		 value = 9216, 10240, 11264, 12288, 13312, 14336, 15360, or 16384 
		 VCPU = 2 or 4 
		 value = 17408, 18432, 19456, 20480, 21504, 22528, 23552, 24576, 25600, 26624, 27648, 28672, 29696, or 30720 
		 VCPU = 4 
		 type=\"VCPU\" 
		 The number of vCPUs reserved for the container. This parameter maps to CpuShares in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --cpu-shares option to docker run (https://docs.docker.com/engine/reference/run/). Each vCPU is equivalent to 1,024 CPU shares. For EC2 resources, you must specify at least one vCPU. This is required but can be specified in several places; it must be specified for each node at least once. 
		 For jobs that are running on Fargate resources, then value must match one of the supported values and the MEMORY values must be one of the values supported for that VCPU value. The supported values are 0.25, 0.5, 1, 2, and 4 
		 value = 0.25 
		 MEMORY = 512, 1024, or 2048 
		 value = 0.5 
		 MEMORY = 1024, 2048, 3072, or 4096 
		 value = 1 
		 MEMORY = 2048, 3072, 4096, 5120, 6144, 7168, or 8192 
		 value = 2 
		 MEMORY = 4096, 5120, 6144, 7168, 8192, 9216, 10240, 11264, 12288, 13312, 14336, 15360, or 16384 
		 value = 4 
		 MEMORY = 8192, 9216, 10240, 11264, 12288, 13312, 14336, 15360, 16384, 17408, 18432, 19456, 20480, 21504, 22528, 23552, 24576, 25600, 26624, 27648, 28672, 29696, or 30720 
		 Value is a required field
		"""

															type: "string"
														}
													}
													required: [
														"resourceType",
														"value",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									dependsOn: {
										description: "A list of dependencies for the job. A job can depend upon a maximum of 20 jobs. You can specify a SEQUENTIAL type dependency without specifying a job ID for array jobs so that each child array job completes sequentially, starting at index 0. You can also specify an N_TO_N type dependency with a job ID for array jobs. In that case, each index child of this job must wait for the corresponding index child of each dependency to complete before it can begin."

										items: {
											description: "JobDependency defines an Batch job dependency."
											properties: {
												jobId: {
													description: "The job ID of the Batch job associated with this dependency."

													type: "string"
												}
												jobIdRef: {
													description: "JobIDRef is a reference to an JobID."
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
												jobIdSelector: {
													description: "JobIDSelector selects references to an JobID."
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
												type: {
													description: "The type of the job dependency."
													enum: [
														"N_TO_N",
														"SEQUENTIAL",
													]
													type: "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									jobDefinition: {
										description: """
		The job definition used by this job. This value can be one of name, name:revision, or the Amazon Resource Name (ARN) for the job definition. If name is specified without a revision then the latest active revision is used. 
		 JobDefinition is a required field
		"""

										type: "string"
									}
									jobDefinitionRef: {
										description: "JobDefinitionRef is a reference to an JobDefinition."
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
									jobDefinitionSelector: {
										description: "JobDefinitionSelector selects references to an JobDefinition."
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
									jobQueue: {
										description: """
		The job queue where the job is submitted. You can specify either the name or the Amazon Resource Name (ARN) of the queue. 
		 JobQueue is a required field
		"""

										type: "string"
									}
									jobQueueRef: {
										description: "JobQueueRef is a reference to an JobQueue."
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
									jobQueueSelector: {
										description: "JobQueueSelector selects references to an JobQueue."
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
									nodeOverrides: {
										description: """
		A list of node overrides in JSON format that specify the node range to target and the container overrides for that node range. 
		 This parameter isn't applicable to jobs that are running on Fargate resources; use containerOverrides instead.
		"""

										properties: {
											nodePropertyOverrides: {
												description: "The node property overrides for the job."
												items: {
													description: "NodePropertyOverride defines any node overrides to a job definition that's used in a SubmitJob API operation."

													properties: {
														containerOverrides: {
															description: "The overrides that should be sent to a node range."

															properties: {
																command: {
																	description: "The command to send to the container that overrides the default command from the Docker image or the job definition."

																	items: type: "string"
																	type: "array"
																}
																environment: {
																	description: """
		The environment variables to send to the container. You can add new environment variables, which are added to the container at launch, or you can override the existing environment variables from the Docker image or the job definition. 
		 Environment variables must not start with AWS_BATCH; this naming convention is reserved for variables that are set by the Batch service.
		"""

																	items: {
																		description: "KeyValuePair defines a key-value pair object."

																		properties: {
																			name: {
																				description: "The name of the key-value pair. For environment variables, this is the name of the environment variable."

																				type: "string"
																			}
																			value: {
																				description: "The value of the key-value pair. For environment variables, this is the value of the environment variable."

																				type: "string"
																			}
																		}
																		type: "object"
																	}
																	type: "array"
																}
																instanceType: {
																	description: """
		The instance type to use for a multi-node parallel job. 
		 This parameter isn't applicable to single-node container jobs or jobs that run on Fargate resources, and shouldn't be provided.
		"""

																	type: "string"
																}
																resourceRequirements: {
																	description: "The type and amount of resources to assign to a container. This overrides the settings in the job definition. The supported resources include GPU, MEMORY, and VCPU."

																	items: {
																		description: "ResourceRequirement defines the type and amount of a resource to assign to a container. The supported resources include GPU, MEMORY, and VCPU."

																		properties: {
																			resourceType: {
																				description: """
		The type of resource to assign to a container. The supported resources include GPU, MEMORY, and VCPU. 
		 Type is a required field
		"""

																				enum: [
																					"GPU",
																					"MEMORY",
																					"VCPU",
																				]
																				type: "string"
																			}
																			value: {
																				description: """
		The quantity of the specified resource to reserve for the container. The values vary based on the type specified. 
		 type=\"GPU\" 
		 The number of physical GPUs to reserve for the container. The number of GPUs reserved for all containers in a job shouldn't exceed the number of available GPUs on the compute resource that the job is launched on. 
		 GPUs are not available for jobs that are running on Fargate resources. 
		 type=\"MEMORY\" 
		 The memory hard limit (in MiB) present to the container. This parameter is supported for jobs that are running on EC2 resources. If your container attempts to exceed the memory specified, the container is terminated. This parameter maps to Memory in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --memory option to docker run (https://docs.docker.com/engine/reference/run/). You must specify at least 4 MiB of memory for a job. This is required but can be specified in several places for multi-node parallel (MNP) jobs. It must be specified for each node at least once. This parameter maps to Memory in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --memory option to docker run (https://docs.docker.com/engine/reference/run/). 
		 If you're trying to maximize your resource utilization by providing your jobs as much memory as possible for a particular instance type, see Memory Management (https://docs.aws.amazon.com/batch/latest/userguide/memory-management.html) in the Batch User Guide. 
		 For jobs that are running on Fargate resources, then value is the hard limit (in MiB), and must match one of the supported values and the VCPU values must be one of the values supported for that memory value. 
		 value = 512 
		 VCPU = 0.25 
		 value = 1024 
		 VCPU = 0.25 or 0.5 
		 value = 2048 
		 VCPU = 0.25, 0.5, or 1 
		 value = 3072 
		 VCPU = 0.5, or 1 
		 value = 4096 
		 VCPU = 0.5, 1, or 2 
		 value = 5120, 6144, or 7168 
		 VCPU = 1 or 2 
		 value = 8192 
		 VCPU = 1, 2, or 4 
		 value = 9216, 10240, 11264, 12288, 13312, 14336, 15360, or 16384 
		 VCPU = 2 or 4 
		 value = 17408, 18432, 19456, 20480, 21504, 22528, 23552, 24576, 25600, 26624, 27648, 28672, 29696, or 30720 
		 VCPU = 4 
		 type=\"VCPU\" 
		 The number of vCPUs reserved for the container. This parameter maps to CpuShares in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --cpu-shares option to docker run (https://docs.docker.com/engine/reference/run/). Each vCPU is equivalent to 1,024 CPU shares. For EC2 resources, you must specify at least one vCPU. This is required but can be specified in several places; it must be specified for each node at least once. 
		 For jobs that are running on Fargate resources, then value must match one of the supported values and the MEMORY values must be one of the values supported for that VCPU value. The supported values are 0.25, 0.5, 1, 2, and 4 
		 value = 0.25 
		 MEMORY = 512, 1024, or 2048 
		 value = 0.5 
		 MEMORY = 1024, 2048, 3072, or 4096 
		 value = 1 
		 MEMORY = 2048, 3072, 4096, 5120, 6144, 7168, or 8192 
		 value = 2 
		 MEMORY = 4096, 5120, 6144, 7168, 8192, 9216, 10240, 11264, 12288, 13312, 14336, 15360, or 16384 
		 value = 4 
		 MEMORY = 8192, 9216, 10240, 11264, 12288, 13312, 14336, 15360, 16384, 17408, 18432, 19456, 20480, 21504, 22528, 23552, 24576, 25600, 26624, 27648, 28672, 29696, or 30720 
		 Value is a required field
		"""

																				type: "string"
																			}
																		}
																		required: [
																			"resourceType",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
														targetNodes: {
															description: """
		The range of nodes, using node index values, that's used to override. A range of 0:3 indicates nodes with index values of 0 through 3. If the starting range value is omitted (:n), then 0 is used to start the range. If the ending range value is omitted (n:), then the highest possible node index is used to end the range. 
		 TargetNodes is a required field
		"""

															type: "string"
														}
													}
													required: [
														"targetNodes",
													]
													type: "object"
												}
												type: "array"
											}
											numNodes: {
												description: """
		The number of nodes to use with a multi-node parallel job. This value overrides the number of nodes that are specified in the job definition. To use this override: 
		 * There must be at least one node range in your job definition that has an open upper boundary (such as : or n:). 
		 * The lower boundary of the node range specified in the job definition must be fewer than the number of nodes specified in the override. 
		 * The main node index specified in the job definition must be fewer than the number of nodes specified in the override.
		"""

												format: "int64"
												type:   "integer"
											}
										}
										type: "object"
									}
									parameters: {
										additionalProperties: type: "string"
										description: "Additional parameters passed to the job that replace parameter substitution placeholders that are set in the job definition. Parameters are specified as a key and value pair mapping. Parameters in a SubmitJob request override any corresponding parameter defaults from the job definition."

										type: "object"
									}
									propagateTags: {
										description: "Specifies whether to propagate the tags from the job or job definition to the corresponding Amazon ECS task. If no value is specified, the tags aren't propagated. Tags can only be propagated to the tasks during task creation. For tags with the same name, job tags are given priority over job definitions tags. If the total number of combined tags from the job and job definition is over 50, the job is moved to the FAILED state. When specified, this overrides the tag propagation setting in the job definition."

										type: "boolean"
									}
									region: {
										description: "Region is which region the Function will be created."
										type:        "string"
									}
									retryStrategy: {
										description: "The retry strategy to use for failed jobs from this SubmitJob operation. When a retry strategy is specified here, it overrides the retry strategy defined in the job definition."

										properties: {
											attempts: {
												description: "The number of times to move a job to the RUNNABLE status. You can specify between 1 and 10 attempts. If the value of attempts is greater than one, the job is retried on failure the same number of attempts as the value."

												format: "int64"
												type:   "integer"
											}
											evaluateOnExit: {
												description: "Array of up to 5 objects that specify conditions under which the job should be retried or failed. If this parameter is specified, then the attempts parameter must also be specified."

												items: {
													description: "EvaluateOnExit specifies a set of conditions to be met, and an action to take (RETRY or EXIT) if all conditions are met."

													properties: {
														action: {
															description: "Specifies the action to take if all of the specified conditions (onStatusReason, onReason, and onExitCode) are met. The values aren't case sensitive. (AWS gives lowercase back!) Action is a required field"

															enum: [
																"retry",
																"exit",
															]
															type: "string"
														}
														onExitCode: {
															description: "Contains a glob pattern to match against the decimal representation of the ExitCode returned for a job. The pattern can be up to 512 characters in length. It can contain only numbers, and can optionally end with an asterisk (*) so that only the start of the string needs to be an exact match."

															type: "string"
														}
														onReason: {
															description: "Contains a glob pattern to match against the Reason returned for a job. The pattern can be up to 512 characters in length. It can contain letters, numbers, periods (.), colons (:), and white space (including spaces and tabs). It can optionally end with an asterisk (*) so that only the start of the string needs to be an exact match."

															type: "string"
														}
														onStatusReason: {
															description: "Contains a glob pattern to match against the StatusReason returned for a job. The pattern can be up to 512 characters in length. It can contain letters, numbers, periods (.), colons (:), and white space (including spaces or tabs). It can optionally end with an asterisk (*) so that only the start of the string needs to be an exact match."

															type: "string"
														}
													}
													required: [
														"action",
													]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									tags: {
										additionalProperties: type: "string"
										description: "The tags that you apply to the job request to help you categorize and organize your resources. Each tag consists of a key and an optional value. For more information, see Tagging Amazon Web Services Resources (https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html) in Amazon Web Services General Reference."

										type: "object"
									}
									timeout: {
										description: "The timeout configuration for this SubmitJob operation. You can specify a timeout duration after which Batch terminates your jobs if they haven't finished. If a job is terminated due to a timeout, it isn't retried. The minimum value for the timeout is 60 seconds. This configuration overrides any timeout configuration specified in the job definition. For array jobs, child jobs have the same timeout configuration as the parent job. For more information, see Job Timeouts (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/job_timeouts.html) in the Amazon Elastic Container Service Developer Guide."

										properties: attemptDurationSeconds: {
											description: "The time duration in seconds (measured from the job attempt's startedAt timestamp) after which Batch terminates your jobs if they have not finished. The minimum value for the timeout is 60 seconds."

											format: "int64"
											type:   "integer"
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
						description: "A JobStatus represents the observed state of a Job."
						properties: {
							atProvider: {
								description: "JobObservation keeps the state for the external resource"
								properties: {
									arrayProperties: {
										description: "The array properties of the job, if it is an array job."

										properties: {
											index: {
												description: "The job index within the array that's associated with this job. This parameter is returned for array job children."

												format: "int64"
												type:   "integer"
											}
											size: {
												description: "The size of the array job. This parameter is returned for parent array jobs."

												format: "int64"
												type:   "integer"
											}
											statusSummary: {
												additionalProperties: {
													format: "int64"
													type:   "integer"
												}
												description: "A summary of the number of array job children in each available job status. This parameter is returned for parent array jobs."

												type: "object"
											}
										}
										type: "object"
									}
									attempts: {
										description: "A list of job attempts associated with this job."
										items: {
											description: "AttemptDetail defines a job attempt for observation"
											properties: {
												container: {
													description: "Details about the container in this job attempt."
													properties: {
														containerInstanceArn: {
															description: "The Amazon Resource Name (ARN) of the Amazon ECS container instance that hosts the job attempt."

															type: "string"
														}
														exitCode: {
															description: "The exit code for the job attempt. A non-zero exit code is considered a failure."

															format: "int64"
															type:   "integer"
														}
														logStreamName: {
															description: "The name of the CloudWatch Logs log stream associated with the container. The log group for Batch jobs is /aws/batch/job. Each container attempt receives a log stream name when they reach the RUNNING status."

															type: "string"
														}
														networkInterfaces: {
															description: "The network interfaces associated with the job attempt."

															items: {
																description: "NetworkInterface defines the elastic network interface for a multi-node parallel job node for observation."

																properties: {
																	attachmentId: {
																		description: "The attachment ID for the network interface."

																		type: "string"
																	}
																	ipv6Address: {
																		description: "The private IPv6 address for the network interface."

																		type: "string"
																	}
																	privateIpv4Address: {
																		description: "The private IPv4 address for the network interface."

																		type: "string"
																	}
																}
																type: "object"
															}
															type: "array"
														}
														reason: {
															description: "A short (255 max characters) human-readable string to provide additional details about a running or stopped container."

															type: "string"
														}
														taskArn: {
															description: "The Amazon Resource Name (ARN) of the Amazon ECS task that's associated with the job attempt. Each container attempt receives a task ARN when they reach the STARTING status."

															type: "string"
														}
													}
													type: "object"
												}
												startedAt: {
													description: "The Unix timestamp (in milliseconds) for when the attempt was started (when the attempt transitioned from the STARTING state to the RUNNING state)."

													format: "int64"
													type:   "integer"
												}
												statusReason: {
													description: "A short, human-readable string to provide additional details about the current status of the job attempt."

													type: "string"
												}
												stoppedAt: {
													description: "The Unix timestamp (in milliseconds) for when the attempt was stopped (when the attempt transitioned from the RUNNING state to a terminal state, such as SUCCEEDED or FAILED)."

													format: "int64"
													type:   "integer"
												}
											}
											type: "object"
										}
										type: "array"
									}
									createdAt: {
										description: "The Unix timestamp (in milliseconds) for when the job was created. For non-array jobs and parent array jobs, this is when the job entered the SUBMITTED state (at the time SubmitJob was called). For array child jobs, this is when the child job was spawned by its parent and entered the PENDING state."

										format: "int64"
										type:   "integer"
									}
									jobArn: {
										description: "The Amazon Resource Name (ARN) of the job."
										type:        "string"
									}
									jobId: {
										description: "The ID for the job."
										type:        "string"
									}
									startedAt: {
										description: "The Unix timestamp (in milliseconds) for when the job was started (when the job transitioned from the STARTING state to the RUNNING state). This parameter isn't provided for child jobs of array jobs or multi-node parallel jobs."

										format: "int64"
										type:   "integer"
									}
									status: {
										description: """
		The current status for the job. 
		 If your jobs don't progress to STARTING, see Jobs Stuck in RUNNABLE Status (https://docs.aws.amazon.com/batch/latest/userguide/troubleshooting.html#job_stuck_in_runnable) in the troubleshooting section of the Batch User Guide.
		"""

										type: "string"
									}
									statusReason: {
										description: "A short, human-readable string to provide additional details about the current status of the job."

										type: "string"
									}
									stoppedAt: {
										description: "The Unix timestamp (in milliseconds) for when the job was stopped (when the job transitioned from the RUNNING state to a terminal state, such as SUCCEEDED or FAILED)."

										format: "int64"
										type:   "integer"
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
