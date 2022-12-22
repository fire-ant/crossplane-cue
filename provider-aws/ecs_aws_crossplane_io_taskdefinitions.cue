package ecs_aws_crossplane_io_taskdefinitions

customresourcedefinition: "taskdefinitions.ecs.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "taskdefinitions.ecs.aws.crossplane.io"
	}
	spec: {
		group: "ecs.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "TaskDefinition"
			listKind: "TaskDefinitionList"
			plural:   "taskdefinitions"
			singular: "taskdefinition"
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
				description: "TaskDefinition is the Schema for the TaskDefinitions API"
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
						description: "TaskDefinitionSpec defines the desired state of TaskDefinition"
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
								description: "TaskDefinitionParameters defines the desired state of TaskDefinition"

								properties: {
									containerDefinitions: {
										description: "A list of container definitions in JSON format that describe the different containers that make up your task."

										items: {
											properties: {
												command: {
													items: type: "string"
													type: "array"
												}
												cpu: {
													format: "int64"
													type:   "integer"
												}
												dependsOn: {
													items: {
														properties: {
															condition: type: "string"
															containerName: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												disableNetworking: type: "boolean"
												dnsSearchDomains: {
													items: type: "string"
													type: "array"
												}
												dnsServers: {
													items: type: "string"
													type: "array"
												}
												dockerLabels: {
													additionalProperties: type: "string"
													type: "object"
												}
												dockerSecurityOptions: {
													items: type: "string"
													type: "array"
												}
												entryPoint: {
													items: type: "string"
													type: "array"
												}
												environment: {
													items: {
														properties: {
															name: type: "string"
															value: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												environmentFiles: {
													items: {
														properties: {
															type_: type: "string"
															value: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												essential: type: "boolean"
												extraHosts: {
													items: {
														properties: {
															hostname: type: "string"
															ipAddress: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												firelensConfiguration: {
													description: "The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more information, see Custom Log Routing (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html) in the Amazon Elastic Container Service Developer Guide."

													properties: {
														options: {
															additionalProperties: type: "string"
															type: "object"
														}
														type_: type: "string"
													}
													type: "object"
												}
												healthCheck: {
													description: """
		An object representing a container health check. Health check parameters that are specified in a container definition override any Docker health checks that exist in the container image (such as those specified in a parent image or from the image's Dockerfile). 
		 The Amazon ECS container agent only monitors and reports on the health checks specified in the task definition. Amazon ECS does not monitor Docker health checks that are embedded in a container image and not specified in the container definition. Health check parameters that are specified in a container definition override any Docker health checks that exist in the container image. 
		 You can view the health status of both individual containers and a task with the DescribeTasks API operation or when viewing the task details in the console. 
		 The following describes the possible healthStatus values for a container: 
		 * HEALTHY-The container health check has passed successfully. 
		 * UNHEALTHY-The container health check has failed. 
		 * UNKNOWN-The container health check is being evaluated or there's no container health check defined. 
		 The following describes the possible healthStatus values for a task. The container health check status of nonessential containers do not have an effect on the health status of a task. 
		 * HEALTHY-All essential containers within the task have passed their health checks. 
		 * UNHEALTHY-One or more essential containers have failed their health check. 
		 * UNKNOWN-The essential containers within the task are still having their health checks evaluated or there are no container health checks defined. 
		 If a task is run manually, and not as part of a service, the task will continue its lifecycle regardless of its health status. For tasks that are part of a service, if the task reports as unhealthy then the task will be stopped and the service scheduler will replace it. 
		 The following are notes about container health check support: 
		 * Container health checks require version 1.17.0 or greater of the Amazon ECS container agent. For more information, see Updating the Amazon ECS Container Agent (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html). 
		 * Container health checks are supported for Fargate tasks if you're using platform version 1.1.0 or greater. For more information, see Fargate Platform Versions (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html). 
		 * Container health checks aren't supported for tasks that are part of a service that's configured to use a Classic Load Balancer.
		"""

													properties: {
														command: {
															items: type: "string"
															type: "array"
														}
														interval: {
															format: "int64"
															type:   "integer"
														}
														retries: {
															format: "int64"
															type:   "integer"
														}
														startPeriod: {
															format: "int64"
															type:   "integer"
														}
														timeout: {
															format: "int64"
															type:   "integer"
														}
													}
													type: "object"
												}
												hostname: type: "string"
												image: type: "string"
												interactive: type: "boolean"
												links: {
													items: type: "string"
													type: "array"
												}
												linuxParameters: {
													description: "Linux-specific options that are applied to the container, such as Linux KernelCapabilities."

													properties: {
														capabilities: {
															description: "The Linux capabilities for the container that are added to or dropped from the default configuration provided by Docker. For more information about the default capabilities and the non-default available capabilities, see Runtime privilege and Linux capabilities (https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) in the Docker run reference. For more detailed information about these Linux capabilities, see the capabilities(7) (http://man7.org/linux/man-pages/man7/capabilities.7.html) Linux manual page."

															properties: {
																add: {
																	items: type: "string"
																	type: "array"
																}
																drop: {
																	items: type: "string"
																	type: "array"
																}
															}
															type: "object"
														}
														devices: {
															items: {
																properties: {
																	containerPath: type: "string"
																	hostPath: type: "string"
																	permissions: {
																		items: type: "string"
																		type: "array"
																	}
																}
																type: "object"
															}
															type: "array"
														}
														initProcessEnabled: type: "boolean"
														maxSwap: {
															format: "int64"
															type:   "integer"
														}
														sharedMemorySize: {
															format: "int64"
															type:   "integer"
														}
														swappiness: {
															format: "int64"
															type:   "integer"
														}
														tmpfs: {
															items: {
																properties: {
																	containerPath: type: "string"
																	mountOptions: {
																		items: type: "string"
																		type: "array"
																	}
																	size: {
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
												logConfiguration: {
													description: """
		The log configuration for the container. This parameter maps to LogConfig in the Create a container (https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.35/) and the --log-driver option to docker run (https://docs.docker.com/engine/reference/commandline/run/). 
		 By default, containers use the same logging driver that the Docker daemon uses. However, the container might use a different logging driver than the Docker daemon by specifying a log driver configuration in the container definition. For more information about the options for different supported log drivers, see Configure logging drivers (https://docs.docker.com/engine/admin/logging/overview/) in the Docker documentation. 
		 Understand the following when specifying a log configuration for your containers. 
		 * Amazon ECS currently supports a subset of the logging drivers available to the Docker daemon (shown in the valid values below). Additional log drivers may be available in future releases of the Amazon ECS container agent. 
		 * This parameter requires version 1.18 of the Docker Remote API or greater on your container instance. 
		 * For tasks that are hosted on Amazon EC2 instances, the Amazon ECS container agent must register the available logging drivers with the ECS_AVAILABLE_LOGGING_DRIVERS environment variable before containers placed on that instance can use these log configuration options. For more information, see Amazon ECS container agent configuration (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the Amazon Elastic Container Service Developer Guide. 
		 * For tasks that are on Fargate, because you don't have access to the underlying infrastructure your tasks are hosted on, any additional software needed must be installed outside of the task. For example, the Fluentd output aggregators or a remote host running Logstash to send Gelf logs to.
		"""

													properties: {
														logDriver: type: "string"
														options: {
															additionalProperties: type: "string"
															type: "object"
														}
														secretOptions: {
															items: {
																properties: {
																	name: type: "string"
																	valueFrom: type: "string"
																}
																type: "object"
															}
															type: "array"
														}
													}
													type: "object"
												}
												memory: {
													format: "int64"
													type:   "integer"
												}
												memoryReservation: {
													format: "int64"
													type:   "integer"
												}
												mountPoints: {
													items: {
														properties: {
															containerPath: type: "string"
															readOnly: type: "boolean"
															sourceVolume: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												name: type: "string"
												portMappings: {
													items: {
														properties: {
															containerPort: {
																format: "int64"
																type:   "integer"
															}
															hostPort: {
																format: "int64"
																type:   "integer"
															}
															protocol: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												privileged: type: "boolean"
												pseudoTerminal: type: "boolean"
												readonlyRootFilesystem: type: "boolean"
												repositoryCredentials: {
													description: "The repository credentials for private registry authentication."

													properties: credentialsParameter: type: "string"
													type: "object"
												}
												resourceRequirements: {
													items: {
														properties: {
															type_: type: "string"
															value: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												secrets: {
													items: {
														properties: {
															name: type: "string"
															valueFrom: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												startTimeout: {
													format: "int64"
													type:   "integer"
												}
												stopTimeout: {
													format: "int64"
													type:   "integer"
												}
												systemControls: {
													items: {
														properties: {
															namespace: type: "string"
															value: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												ulimits: {
													items: {
														properties: {
															hardLimit: {
																format: "int64"
																type:   "integer"
															}
															name: type: "string"
															softLimit: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
													type: "array"
												}
												user: type: "string"
												volumesFrom: {
													items: {
														properties: {
															readOnly: type: "boolean"
															sourceContainer: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												workingDirectory: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									cpu: {
										description: """
		The number of CPU units used by the task. It can be expressed as an integer using CPU units (for example, 1024) or as a string using vCPUs (for example, 1 vCPU or 1 vcpu) in a task definition. String values are converted to an integer indicating the CPU units when the task definition is registered. 
		 Task-level CPU and memory parameters are ignored for Windows containers. We recommend specifying container-level resources for Windows containers. 
		 If you're using the EC2 launch type, this field is optional. Supported values are between 128 CPU units (0.125 vCPUs) and 10240 CPU units (10 vCPUs). 
		 If you're using the Fargate launch type, this field is required and you must use one of the following values, which determines your range of supported values for the memory parameter: 
		 The CPU units cannot be less than 1 vCPU when you use Windows containers on Fargate. 
		 * 256 (.25 vCPU) - Available memory values: 512 (0.5 GB), 1024 (1 GB), 2048 (2 GB) 
		 * 512 (.5 vCPU) - Available memory values: 1024 (1 GB), 2048 (2 GB), 3072 (3 GB), 4096 (4 GB) 
		 * 1024 (1 vCPU) - Available memory values: 2048 (2 GB), 3072 (3 GB), 4096 (4 GB), 5120 (5 GB), 6144 (6 GB), 7168 (7 GB), 8192 (8 GB) 
		 * 2048 (2 vCPU) - Available memory values: Between 4096 (4 GB) and 16384 (16 GB) in increments of 1024 (1 GB) 
		 * 4096 (4 vCPU) - Available memory values: Between 8192 (8 GB) and 30720 (30 GB) in increments of 1024 (1 GB)
		"""

										type: "string"
									}
									ephemeralStorage: {
										description: """
		The amount of ephemeral storage to allocate for the task. This parameter is used to expand the total amount of ephemeral storage available, beyond the default amount, for tasks hosted on Fargate. For more information, see Fargate task storage (https://docs.aws.amazon.com/AmazonECS/latest/userguide/using_data_volumes.html) in the Amazon ECS User Guide for Fargate. 
		 This parameter is only supported for tasks hosted on Fargate using the following platform versions: 
		 * Linux platform version 1.4.0 or later. 
		 * Windows platform version 1.0.0 or later.
		"""

										properties: sizeInGiB: {
											format: "int64"
											type:   "integer"
										}
										type: "object"
									}
									executionRoleARN: {
										description: "The Amazon Resource Name (ARN) of the task execution role that grants the Amazon ECS container agent permission to make Amazon Web Services API calls on your behalf. The task execution IAM role is required depending on the requirements of your task. For more information, see Amazon ECS task execution IAM role (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html) in the Amazon Elastic Container Service Developer Guide."

										type: "string"
									}
									executionRoleARNRef: {
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
									executionRoleARNSelector: {
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
									family: {
										description: "You must specify a family for a task definition. You can use it track multiple versions of the same task definition. The family is used as a name for your task definition. Up to 255 letters (uppercase and lowercase), numbers, underscores, and hyphens are allowed."

										type: "string"
									}
									inferenceAccelerators: {
										description: "The Elastic Inference accelerators to use for the containers in the task."

										items: {
											properties: {
												deviceName: type: "string"
												deviceType: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									ipcMode: {
										description: """
		The IPC resource namespace to use for the containers in the task. The valid values are host, task, or none. If host is specified, then all containers within the tasks that specified the host IPC mode on the same container instance share the same IPC resources with the host Amazon EC2 instance. If task is specified, all containers within the specified task share the same IPC resources. If none is specified, then IPC resources within the containers of a task are private and not shared with other containers in a task or on the container instance. If no value is specified, then the IPC resource namespace sharing depends on the Docker daemon setting on the container instance. For more information, see IPC settings (https://docs.docker.com/engine/reference/run/#ipc-settings---ipc) in the Docker run reference. 
		 If the host IPC mode is used, be aware that there is a heightened risk of undesired IPC namespace expose. For more information, see Docker security (https://docs.docker.com/engine/security/security/). 
		 If you are setting namespaced kernel parameters using systemControls for the containers in the task, the following will apply to your IPC resource namespace. For more information, see System Controls (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html) in the Amazon Elastic Container Service Developer Guide. 
		 * For tasks that use the host IPC mode, IPC namespace related systemControls are not supported. 
		 * For tasks that use the task IPC mode, IPC namespace related systemControls will apply to all containers within a task. 
		 This parameter is not supported for Windows containers or tasks run on Fargate.
		"""

										type: "string"
									}
									memory: {
										description: """
		The amount of memory (in MiB) used by the task. It can be expressed as an integer using MiB (for example ,1024) or as a string using GB (for example, 1GB or 1 GB) in a task definition. String values are converted to an integer indicating the MiB when the task definition is registered. 
		 Task-level CPU and memory parameters are ignored for Windows containers. We recommend specifying container-level resources for Windows containers. 
		 If using the EC2 launch type, this field is optional. 
		 If using the Fargate launch type, this field is required and you must use one of the following values. This determines your range of supported values for the cpu parameter. 
		 The CPU units cannot be less than 1 vCPU when you use Windows containers on Fargate. 
		 * 512 (0.5 GB), 1024 (1 GB), 2048 (2 GB) - Available cpu values: 256 (.25 vCPU) 
		 * 1024 (1 GB), 2048 (2 GB), 3072 (3 GB), 4096 (4 GB) - Available cpu values: 512 (.5 vCPU) 
		 * 2048 (2 GB), 3072 (3 GB), 4096 (4 GB), 5120 (5 GB), 6144 (6 GB), 7168 (7 GB), 8192 (8 GB) - Available cpu values: 1024 (1 vCPU) 
		 * Between 4096 (4 GB) and 16384 (16 GB) in increments of 1024 (1 GB) - Available cpu values: 2048 (2 vCPU) 
		 * Between 8192 (8 GB) and 30720 (30 GB) in increments of 1024 (1 GB) - Available cpu values: 4096 (4 vCPU)
		"""

										type: "string"
									}
									networkMode: {
										description: """
		The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host. If no network mode is specified, the default is bridge. 
		 For Amazon ECS tasks on Fargate, the awsvpc network mode is required. For Amazon ECS tasks on Amazon EC2 Linux instances, any network mode can be used. For Amazon ECS tasks on Amazon EC2 Windows instances, <default> or awsvpc can be used. If the network mode is set to none, you cannot specify port mappings in your container definitions, and the tasks containers do not have external connectivity. The host and awsvpc network modes offer the highest networking performance for containers because they use the EC2 network stack instead of the virtualized network stack provided by the bridge mode. 
		 With the host and awsvpc network modes, exposed container ports are mapped directly to the corresponding host port (for the host network mode) or the attached elastic network interface port (for the awsvpc network mode), so you cannot take advantage of dynamic host port mappings. 
		 When using the host network mode, you should not run containers using the root user (UID 0). It is considered best practice to use a non-root user. 
		 If the network mode is awsvpc, the task is allocated an elastic network interface, and you must specify a NetworkConfiguration value when you create a service or run a task with the task definition. For more information, see Task Networking (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html) in the Amazon Elastic Container Service Developer Guide. 
		 If the network mode is host, you cannot run multiple instantiations of the same task on a single container instance when port mappings are used. 
		 For more information, see Network settings (https://docs.docker.com/engine/reference/run/#network-settings) in the Docker run reference.
		"""

										type: "string"
									}
									pidMode: {
										description: """
		The process namespace to use for the containers in the task. The valid values are host or task. If host is specified, then all containers within the tasks that specified the host PID mode on the same container instance share the same process namespace with the host Amazon EC2 instance. If task is specified, all containers within the specified task share the same process namespace. If no value is specified, the default is a private namespace. For more information, see PID settings (https://docs.docker.com/engine/reference/run/#pid-settings---pid) in the Docker run reference. 
		 If the host PID mode is used, be aware that there is a heightened risk of undesired process namespace expose. For more information, see Docker security (https://docs.docker.com/engine/security/security/). 
		 This parameter is not supported for Windows containers or tasks run on Fargate.
		"""

										type: "string"
									}
									placementConstraints: {
										description: "An array of placement constraint objects to use for the task. You can specify a maximum of 10 constraints for each task. This limit includes constraints in the task definition and those specified at runtime."

										items: {
											properties: {
												expression: type: "string"
												type_: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									proxyConfiguration: {
										description: """
		The configuration details for the App Mesh proxy. 
		 For tasks hosted on Amazon EC2 instances, the container instances require at least version 1.26.0 of the container agent and at least version 1.26.0-1 of the ecs-init package to use a proxy configuration. If your container instances are launched from the Amazon ECS-optimized AMI version 20190301 or later, then they contain the required versions of the container agent and ecs-init. For more information, see Amazon ECS-optimized AMI versions (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-ami-versions.html) in the Amazon Elastic Container Service Developer Guide.
		"""

										properties: {
											containerName: type: "string"
											properties: {
												items: {
													properties: {
														name: type: "string"
														value: type: "string"
													}
													type: "object"
												}
												type: "array"
											}
											type_: type: "string"
										}
										type: "object"
									}
									region: {
										description: "Region is which region the TaskDefinition will be created."

										type: "string"
									}
									requiresCompatibilities: {
										description: "The task launch type that Amazon ECS validates the task definition against. A client exception is returned if the task definition doesn't validate against the compatibilities specified. If no value is specified, the parameter is omitted from the response."

										items: type: "string"
										type: "array"
									}
									runtimePlatform: {
										description: """
		The operating system that your tasks definitions run on. A platform family is specified only for tasks using the Fargate launch type. 
		 When you specify a task definition in a service, this value must match the runtimePlatform value of the service.
		"""

										properties: {
											cpuArchitecture: type: "string"
											operatingSystemFamily: type: "string"
										}
										type: "object"
									}
									tags: {
										description: """
		The metadata that you apply to the task definition to help you categorize and organize them. Each tag consists of a key and an optional value. You define both of them. 
		 The following basic restrictions apply to tags: 
		 * Maximum number of tags per resource - 50 
		 * For each resource, each tag key must be unique, and each tag key can have only one value. 
		 * Maximum key length - 128 Unicode characters in UTF-8 
		 * Maximum value length - 256 Unicode characters in UTF-8 
		 * If your tagging schema is used across multiple services and resources, remember that other services may have restrictions on allowed characters. Generally allowed characters are: letters, numbers, and spaces representable in UTF-8, and the following characters: + - = . _ : / @. 
		 * Tag keys and values are case-sensitive. 
		 * Do not use aws:, AWS:, or any upper or lowercase combination of such as a prefix for either keys or values as it is reserved for Amazon Web Services use. You cannot edit or delete tag keys or values with this prefix. Tags with this prefix do not count against your tags per resource limit.
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
									taskRoleARN: {
										description: "The short name or full Amazon Resource Name (ARN) of the IAM role that containers in this task can assume. All containers in this task are granted the permissions that are specified in this role. For more information, see IAM Roles for Tasks (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) in the Amazon Elastic Container Service Developer Guide. A list of volume definitions in JSON format that containers in your task may use."

										type: "string"
									}
									taskRoleARNRef: {
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
									taskRoleARNSelector: {
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
									volumes: {
										items: {
											description: "CustomVolume provides custom parameters for the Volume type"

											properties: {
												dockerVolumeConfiguration: {
													description: "This parameter is specified when you are using Docker volumes. Docker volumes are only supported when you are using the EC2 launch type. Windows containers only support the use of the local driver. To use bind mounts, specify a host instead."

													properties: {
														autoprovision: type: "boolean"
														driver: type: "string"
														driverOpts: {
															additionalProperties: type: "string"
															type: "object"
														}
														labels: {
															additionalProperties: type: "string"
															type: "object"
														}
														scope: type: "string"
													}
													type: "object"
												}
												efsVolumeConfiguration: {
													description: "This parameter is specified when you are using an Amazon Elastic File System file system for task storage. For more information, see Amazon EFS Volumes (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/efs-volumes.html) in the Amazon Elastic Container Service Developer Guide."

													properties: {
														authorizationConfig: {
															description: "The authorization configuration details for the Amazon EFS file system."

															properties: {
																accessPointID: {
																	description: "The Amazon EFS access point ID to use. If an access point is specified, the root directory value specified in the EFSVolumeConfiguration must either be omitted or set to / which will enforce the path set on the EFS access point. If an access point is used, transit encryption must be enabled in the EFSVolumeConfiguration. For more information, see Working with Amazon EFS Access Points (https://docs.aws.amazon.com/efs/latest/ug/efs-access-points.html) in the Amazon Elastic File System User Guide."

																	type: "string"
																}
																accessPointIDRef: {
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
																accessPointIDSelector: {
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
																iam: {
																	description: "Determines whether to use the Amazon ECS task IAM role defined in a task definition when mounting the Amazon EFS file system. If enabled, transit encryption must be enabled in the EFSVolumeConfiguration. If this parameter is omitted, the default value of DISABLED is used. For more information, see Using Amazon EFS Access Points (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/efs-volumes.html#efs-volume-accesspoints) in the Amazon Elastic Container Service Developer Guide."

																	type: "string"
																}
															}
															type: "object"
														}
														fileSystemID: type: "string"
														fileSystemIDRef: {
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
														fileSystemIDSelector: {
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
														rootDirectory: type: "string"
														transitEncryption: type: "string"
														transitEncryptionPort: {
															format: "int64"
															type:   "integer"
														}
													}
													type: "object"
												}
												fsxWindowsFileServerVolumeConfiguration: {
													description: """
		This parameter is specified when you are using Amazon FSx for Windows File Server (https://docs.aws.amazon.com/fsx/latest/WindowsGuide/what-is.html) file system for task storage. 
		 For more information and the input format, see Amazon FSx for Windows File Server Volumes (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/wfsx-volumes.html) in the Amazon Elastic Container Service Developer Guide.
		"""

													properties: {
														authorizationConfig: {
															description: """
		The authorization configuration details for Amazon FSx for Windows File Server file system. See FSxWindowsFileServerVolumeConfiguration (https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FSxWindowsFileServerVolumeConfiguration.html) in the Amazon Elastic Container Service API Reference. 
		 For more information and the input format, see Amazon FSx for Windows File Server Volumes (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/wfsx-volumes.html) in the Amazon Elastic Container Service Developer Guide.
		"""

															properties: {
																credentialsParameter: type: "string"
																domain: type: "string"
															}
															type: "object"
														}
														fileSystemID: type: "string"
														rootDirectory: type: "string"
													}
													type: "object"
												}
												host: {
													description: "Details on a container instance bind mount host volume."

													properties: sourcePath: type: "string"
													type: "object"
												}
												name: type: "string"
											}
											required: [
												"name",
											]
											type: "object"
										}
										type: "array"
									}
								}
								required: [
									"containerDefinitions",
									"family",
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
						description: "TaskDefinitionStatus defines the observed state of TaskDefinition."
						properties: {
							atProvider: {
								description: "TaskDefinitionObservation defines the observed state of TaskDefinition"

								properties: taskDefinition: {
									description: "The full description of the registered task definition."
									properties: {
										compatibilities: {
											items: type: "string"
											type: "array"
										}
										containerDefinitions: {
											items: {
												properties: {
													command: {
														items: type: "string"
														type: "array"
													}
													cpu: {
														format: "int64"
														type:   "integer"
													}
													dependsOn: {
														items: {
															properties: {
																condition: type: "string"
																containerName: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													disableNetworking: type: "boolean"
													dnsSearchDomains: {
														items: type: "string"
														type: "array"
													}
													dnsServers: {
														items: type: "string"
														type: "array"
													}
													dockerLabels: {
														additionalProperties: type: "string"
														type: "object"
													}
													dockerSecurityOptions: {
														items: type: "string"
														type: "array"
													}
													entryPoint: {
														items: type: "string"
														type: "array"
													}
													environment: {
														items: {
															properties: {
																name: type: "string"
																value: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													environmentFiles: {
														items: {
															properties: {
																type_: type: "string"
																value: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													essential: type: "boolean"
													extraHosts: {
														items: {
															properties: {
																hostname: type: "string"
																ipAddress: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													firelensConfiguration: {
														description: "The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more information, see Custom Log Routing (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html) in the Amazon Elastic Container Service Developer Guide."

														properties: {
															options: {
																additionalProperties: type: "string"
																type: "object"
															}
															type_: type: "string"
														}
														type: "object"
													}
													healthCheck: {
														description: """
		An object representing a container health check. Health check parameters that are specified in a container definition override any Docker health checks that exist in the container image (such as those specified in a parent image or from the image's Dockerfile). 
		 The Amazon ECS container agent only monitors and reports on the health checks specified in the task definition. Amazon ECS does not monitor Docker health checks that are embedded in a container image and not specified in the container definition. Health check parameters that are specified in a container definition override any Docker health checks that exist in the container image. 
		 You can view the health status of both individual containers and a task with the DescribeTasks API operation or when viewing the task details in the console. 
		 The following describes the possible healthStatus values for a container: 
		 * HEALTHY-The container health check has passed successfully. 
		 * UNHEALTHY-The container health check has failed. 
		 * UNKNOWN-The container health check is being evaluated or there's no container health check defined. 
		 The following describes the possible healthStatus values for a task. The container health check status of nonessential containers do not have an effect on the health status of a task. 
		 * HEALTHY-All essential containers within the task have passed their health checks. 
		 * UNHEALTHY-One or more essential containers have failed their health check. 
		 * UNKNOWN-The essential containers within the task are still having their health checks evaluated or there are no container health checks defined. 
		 If a task is run manually, and not as part of a service, the task will continue its lifecycle regardless of its health status. For tasks that are part of a service, if the task reports as unhealthy then the task will be stopped and the service scheduler will replace it. 
		 The following are notes about container health check support: 
		 * Container health checks require version 1.17.0 or greater of the Amazon ECS container agent. For more information, see Updating the Amazon ECS Container Agent (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html). 
		 * Container health checks are supported for Fargate tasks if you're using platform version 1.1.0 or greater. For more information, see Fargate Platform Versions (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html). 
		 * Container health checks aren't supported for tasks that are part of a service that's configured to use a Classic Load Balancer.
		"""

														properties: {
															command: {
																items: type: "string"
																type: "array"
															}
															interval: {
																format: "int64"
																type:   "integer"
															}
															retries: {
																format: "int64"
																type:   "integer"
															}
															startPeriod: {
																format: "int64"
																type:   "integer"
															}
															timeout: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
													hostname: type: "string"
													image: type: "string"
													interactive: type: "boolean"
													links: {
														items: type: "string"
														type: "array"
													}
													linuxParameters: {
														description: "Linux-specific options that are applied to the container, such as Linux KernelCapabilities."

														properties: {
															capabilities: {
																description: "The Linux capabilities for the container that are added to or dropped from the default configuration provided by Docker. For more information about the default capabilities and the non-default available capabilities, see Runtime privilege and Linux capabilities (https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) in the Docker run reference. For more detailed information about these Linux capabilities, see the capabilities(7) (http://man7.org/linux/man-pages/man7/capabilities.7.html) Linux manual page."

																properties: {
																	add: {
																		items: type: "string"
																		type: "array"
																	}
																	drop: {
																		items: type: "string"
																		type: "array"
																	}
																}
																type: "object"
															}
															devices: {
																items: {
																	properties: {
																		containerPath: type: "string"
																		hostPath: type: "string"
																		permissions: {
																			items: type: "string"
																			type: "array"
																		}
																	}
																	type: "object"
																}
																type: "array"
															}
															initProcessEnabled: type: "boolean"
															maxSwap: {
																format: "int64"
																type:   "integer"
															}
															sharedMemorySize: {
																format: "int64"
																type:   "integer"
															}
															swappiness: {
																format: "int64"
																type:   "integer"
															}
															tmpfs: {
																items: {
																	properties: {
																		containerPath: type: "string"
																		mountOptions: {
																			items: type: "string"
																			type: "array"
																		}
																		size: {
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
													logConfiguration: {
														description: """
		The log configuration for the container. This parameter maps to LogConfig in the Create a container (https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.35/) and the --log-driver option to docker run (https://docs.docker.com/engine/reference/commandline/run/). 
		 By default, containers use the same logging driver that the Docker daemon uses. However, the container might use a different logging driver than the Docker daemon by specifying a log driver configuration in the container definition. For more information about the options for different supported log drivers, see Configure logging drivers (https://docs.docker.com/engine/admin/logging/overview/) in the Docker documentation. 
		 Understand the following when specifying a log configuration for your containers. 
		 * Amazon ECS currently supports a subset of the logging drivers available to the Docker daemon (shown in the valid values below). Additional log drivers may be available in future releases of the Amazon ECS container agent. 
		 * This parameter requires version 1.18 of the Docker Remote API or greater on your container instance. 
		 * For tasks that are hosted on Amazon EC2 instances, the Amazon ECS container agent must register the available logging drivers with the ECS_AVAILABLE_LOGGING_DRIVERS environment variable before containers placed on that instance can use these log configuration options. For more information, see Amazon ECS container agent configuration (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the Amazon Elastic Container Service Developer Guide. 
		 * For tasks that are on Fargate, because you don't have access to the underlying infrastructure your tasks are hosted on, any additional software needed must be installed outside of the task. For example, the Fluentd output aggregators or a remote host running Logstash to send Gelf logs to.
		"""

														properties: {
															logDriver: type: "string"
															options: {
																additionalProperties: type: "string"
																type: "object"
															}
															secretOptions: {
																items: {
																	properties: {
																		name: type: "string"
																		valueFrom: type: "string"
																	}
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
													memory: {
														format: "int64"
														type:   "integer"
													}
													memoryReservation: {
														format: "int64"
														type:   "integer"
													}
													mountPoints: {
														items: {
															properties: {
																containerPath: type: "string"
																readOnly: type: "boolean"
																sourceVolume: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													name: type: "string"
													portMappings: {
														items: {
															properties: {
																containerPort: {
																	format: "int64"
																	type:   "integer"
																}
																hostPort: {
																	format: "int64"
																	type:   "integer"
																}
																protocol: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													privileged: type: "boolean"
													pseudoTerminal: type: "boolean"
													readonlyRootFilesystem: type: "boolean"
													repositoryCredentials: {
														description: "The repository credentials for private registry authentication."

														properties: credentialsParameter: type: "string"
														type: "object"
													}
													resourceRequirements: {
														items: {
															properties: {
																type_: type: "string"
																value: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													secrets: {
														items: {
															properties: {
																name: type: "string"
																valueFrom: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													startTimeout: {
														format: "int64"
														type:   "integer"
													}
													stopTimeout: {
														format: "int64"
														type:   "integer"
													}
													systemControls: {
														items: {
															properties: {
																namespace: type: "string"
																value: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													ulimits: {
														items: {
															properties: {
																hardLimit: {
																	format: "int64"
																	type:   "integer"
																}
																name: type: "string"
																softLimit: {
																	format: "int64"
																	type:   "integer"
																}
															}
															type: "object"
														}
														type: "array"
													}
													user: type: "string"
													volumesFrom: {
														items: {
															properties: {
																readOnly: type: "boolean"
																sourceContainer: type: "string"
															}
															type: "object"
														}
														type: "array"
													}
													workingDirectory: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										cpu: type: "string"
										deregisteredAt: {
											format: "date-time"
											type:   "string"
										}
										ephemeralStorage: {
											description: """
		The amount of ephemeral storage to allocate for the task. This parameter is used to expand the total amount of ephemeral storage available, beyond the default amount, for tasks hosted on Fargate. For more information, see Fargate task storage (https://docs.aws.amazon.com/AmazonECS/latest/userguide/using_data_volumes.html) in the Amazon ECS User Guide for Fargate. 
		 This parameter is only supported for tasks hosted on Fargate using Linux platform version 1.4.0 or later. This parameter is not supported for Windows containers on Fargate.
		"""

											properties: sizeInGiB: {
												format: "int64"
												type:   "integer"
											}
											type: "object"
										}
										executionRoleARN: type: "string"
										family: type: "string"
										inferenceAccelerators: {
											items: {
												properties: {
													deviceName: type: "string"
													deviceType: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										ipcMode: type: "string"
										memory: type: "string"
										networkMode: type: "string"
										pidMode: type: "string"
										placementConstraints: {
											items: {
												properties: {
													expression: type: "string"
													type_: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										proxyConfiguration: {
											description: """
		The configuration details for the App Mesh proxy. 
		 For tasks that use the EC2 launch type, the container instances require at least version 1.26.0 of the container agent and at least version 1.26.0-1 of the ecs-init package to use a proxy configuration. If your container instances are launched from the Amazon ECS optimized AMI version 20190301 or later, then they contain the required versions of the container agent and ecs-init. For more information, see Amazon ECS-optimized Linux AMI (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html)
		"""

											properties: {
												containerName: type: "string"
												properties: {
													items: {
														properties: {
															name: type: "string"
															value: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												type_: type: "string"
											}
											type: "object"
										}
										registeredAt: {
											format: "date-time"
											type:   "string"
										}
										registeredBy: type: "string"
										requiresAttributes: {
											items: {
												properties: {
													name: type: "string"
													targetID: type: "string"
													targetType: type: "string"
													value: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
										requiresCompatibilities: {
											items: type: "string"
											type: "array"
										}
										revision: {
											format: "int64"
											type:   "integer"
										}
										runtimePlatform: {
											description: """
		Information about the platform for the Amazon ECS service or task. 
		 For more informataion about RuntimePlatform, see RuntimePlatform (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#runtime-platform) in the Amazon Elastic Container Service Developer Guide.
		"""

											properties: {
												cpuArchitecture: type: "string"
												operatingSystemFamily: type: "string"
											}
											type: "object"
										}
										status: type: "string"
										taskDefinitionARN: type: "string"
										taskRoleARN: type: "string"
										volumes: {
											items: {
												properties: {
													dockerVolumeConfiguration: {
														description: "This parameter is specified when you're using Docker volumes. Docker volumes are only supported when you're using the EC2 launch type. Windows containers only support the use of the local driver. To use bind mounts, specify a host instead."

														properties: {
															autoprovision: type: "boolean"
															driver: type: "string"
															driverOpts: {
																additionalProperties: type: "string"
																type: "object"
															}
															labels: {
																additionalProperties: type: "string"
																type: "object"
															}
															scope: type: "string"
														}
														type: "object"
													}
													efsVolumeConfiguration: {
														description: "This parameter is specified when you're using an Amazon Elastic File System file system for task storage. For more information, see Amazon EFS Volumes (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/efs-volumes.html) in the Amazon Elastic Container Service Developer Guide."

														properties: {
															authorizationConfig: {
																description: "The authorization configuration details for the Amazon EFS file system."

																properties: {
																	accessPointID: type: "string"
																	iam: type: "string"
																}
																type: "object"
															}
															fileSystemID: type: "string"
															rootDirectory: type: "string"
															transitEncryption: type: "string"
															transitEncryptionPort: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
													fsxWindowsFileServerVolumeConfiguration: {
														description: """
		This parameter is specified when you're using Amazon FSx for Windows File Server (https://docs.aws.amazon.com/fsx/latest/WindowsGuide/what-is.html) file system for task storage. 
		 For more information and the input format, see Amazon FSx for Windows File Server Volumes (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/wfsx-volumes.html) in the Amazon Elastic Container Service Developer Guide.
		"""

														properties: {
															authorizationConfig: {
																description: """
		The authorization configuration details for Amazon FSx for Windows File Server file system. See FSxWindowsFileServerVolumeConfiguration (https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FSxWindowsFileServerVolumeConfiguration.html) in the Amazon Elastic Container Service API Reference. 
		 For more information and the input format, see Amazon FSx for Windows File Server Volumes (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/wfsx-volumes.html) in the Amazon Elastic Container Service Developer Guide.
		"""

																properties: {
																	credentialsParameter: type: "string"
																	domain: type: "string"
																}
																type: "object"
															}
															fileSystemID: type: "string"
															rootDirectory: type: "string"
														}
														type: "object"
													}
													host: {
														description: "Details on a container instance bind mount host volume."

														properties: sourcePath: type: "string"
														type: "object"
													}
													name: type: "string"
												}
												type: "object"
											}
											type: "array"
										}
									}
									type: "object"
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
