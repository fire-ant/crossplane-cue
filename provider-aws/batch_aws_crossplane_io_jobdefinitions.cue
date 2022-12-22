package batch_aws_crossplane_io_jobdefinitions

customresourcedefinition: "jobdefinitions.batch.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "jobdefinitions.batch.aws.crossplane.io"
	}
	spec: {
		group: "batch.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "JobDefinition"
			listKind: "JobDefinitionList"
			plural:   "jobdefinitions"
			singular: "jobdefinition"
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
				description: "A JobDefinition is a managed resource that represents an AWS Batch JobDefinition."

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
						description: "A JobDefinitionSpec defines the desired state of a JobDefinition."
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
								description: "JobDefinitionParameters define the desired state of a Batch JobDefinition"

								properties: {
									containerProperties: {
										description: """
		An object with various properties specific to single-node container-based jobs. If the job definition's type parameter is container, then you must specify either containerProperties or nodeProperties. 
		 If the job runs on Fargate resources, then you must not specify nodeProperties; use only containerProperties.
		"""

										properties: {
											command: {
												description: "The command that's passed to the container. This parameter maps to Cmd in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the COMMAND parameter to docker run (https://docs.docker.com/engine/reference/run/). For more information, see https://docs.docker.com/engine/reference/builder/#cmd (https://docs.docker.com/engine/reference/builder/#cmd)."

												items: type: "string"
												type: "array"
											}
											environment: {
												description: """
		The environment variables to pass to a container. This parameter maps to Env in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --env option to docker run (https://docs.docker.com/engine/reference/run/). 
		 We don't recommend using plaintext environment variables for sensitive information, such as credential data. 
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
											executionRoleARNRef: {
												description: "ExecutionRoleARNRef is a reference to an ARN of the IAM role used to set the ExecutionRoleARN."

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
												description: "ExecutionRoleARNSelector selects references to an ARN of the IAM role used to set the ExecutionRoleARN."

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
											executionRoleArn: {
												description: "The Amazon Resource Name (ARN) of the execution role that Batch can assume. For jobs that run on Fargate resources, you must provide an execution role. For more information, see Batch execution IAM role (https://docs.aws.amazon.com/batch/latest/userguide/execution-IAM-role.html) in the Batch User Guide."

												type: "string"
											}
											fargatePlatformConfiguration: {
												description: "The platform configuration for jobs that are running on Fargate resources. Jobs that are running on EC2 resources must not specify this parameter."

												properties: platformVersion: {
													description: "The Fargate platform version where the jobs are running. A platform version is specified only for jobs that are running on Fargate resources. If one isn't specified, the LATEST platform version is used by default. This uses a recent, approved version of the Fargate platform for compute resources. For more information, see Fargate platform versions (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the Amazon Elastic Container Service Developer Guide."

													type: "string"
												}
												type: "object"
											}
											image: {
												description: """
		The image used to start a container. This string is passed directly to the Docker daemon. Images in the Docker Hub registry are available by default. Other repositories are specified with repository-url/image:tag . Up to 255 letters (uppercase and lowercase), numbers, hyphens, underscores, colons, periods, forward slashes, and number signs are allowed. This parameter maps to Image in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the IMAGE parameter of docker run (https://docs.docker.com/engine/reference/run/). 
		 Docker image architecture must match the processor architecture of the compute resources that they're scheduled on. For example, ARM-based Docker images can only run on ARM-based compute resources. 
		 * Images in Amazon ECR repositories use the full registry and repository URI (for example, 012345678910.dkr.ecr.<region-name>.amazonaws.com/<repository-name>). 
		 * Images in official repositories on Docker Hub use a single name (for example, ubuntu or mongo). 
		 * Images in other repositories on Docker Hub are qualified with an organization name (for example, amazon/amazon-ecs-agent). 
		 * Images in other online repositories are qualified further by a domain name (for example, quay.io/assemblyline/ubuntu).
		"""

												type: "string"
											}
											instanceType: {
												description: """
		The instance type to use for a multi-node parallel job. All node groups in a multi-node parallel job must use the same instance type. 
		 This parameter isn't applicable to single-node container jobs or jobs that run on Fargate resources, and shouldn't be provided.
		"""

												type: "string"
											}
											jobRoleARNRef: {
												description: "JobRoleARNRef is a reference to an ARN of the IAM role used to set the JobRoleARN."

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
											jobRoleARNSelector: {
												description: "JobRoleARNSelector selects references to an ARN of the IAM role used to set the JobRoleARN."

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
											jobRoleArn: {
												description: "The Amazon Resource Name (ARN) of the IAM role that the container can assume for Amazon Web Services permissions. For more information, see IAM Roles for Tasks (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) in the Amazon Elastic Container Service Developer Guide."

												type: "string"
											}
											linuxParameters: {
												description: "Linux-specific modifications that are applied to the container, such as details for device mappings."

												properties: {
													devices: {
														description: """
		Any host devices to expose to the container. This parameter maps to Devices in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --device option to docker run (https://docs.docker.com/engine/reference/run/). 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

														items: {
															description: """
		Device defines a container instance host device. 
		 This object isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

															properties: {
																containerPath: {
																	description: "The path inside the container that's used to expose the host device. By default, the hostPath value is used."

																	type: "string"
																}
																hostPath: {
																	description: """
		The path for the device on the host container instance. 
		 HostPath is a required field
		"""

																	type: "string"
																}
																permissions: {
																	description: "The explicit permissions to provide to the container for the device. By default, the container has permissions for read, write, and mknod for the device."

																	items: type: "string"
																	type: "array"
																}
															}
															required: [
																"hostPath",
															]
															type: "object"
														}
														type: "array"
													}
													initProcessEnabled: {
														description: "If true, run an init process inside the container that forwards signals and reaps processes. This parameter maps to the --init option to docker run (https://docs.docker.com/engine/reference/run/). This parameter requires version 1.25 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log into your container instance and run the following command: sudo docker version | grep \"Server API version\""

														type: "boolean"
													}
													maxSwap: {
														description: """
		The total amount of swap memory (in MiB) a container can use. This parameter is translated to the --memory-swap option to docker run (https://docs.docker.com/engine/reference/run/) where the value is the sum of the container memory plus the maxSwap value. For more information, see --memory-swap details (https://docs.docker.com/config/containers/resource_constraints/#--memory-swap-details) in the Docker documentation. 
		 If a maxSwap value of 0 is specified, the container doesn't use swap. Accepted values are 0 or any positive integer. If the maxSwap parameter is omitted, the container doesn't use the swap configuration for the container instance it is running on. A maxSwap value must be set for the swappiness parameter to be used. 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

														format: "int64"
														type:   "integer"
													}
													sharedMemorySize: {
														description: """
		The value for the size (in MiB) of the /dev/shm volume. This parameter maps to the --shm-size option to docker run (https://docs.docker.com/engine/reference/run/). 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

														format: "int64"
														type:   "integer"
													}
													swappiness: {
														description: """
		This allows you to tune a container's memory swappiness behavior. A swappiness value of 0 causes swapping not to happen unless absolutely necessary. A swappiness value of 100 causes pages to be swapped very aggressively. Accepted values are whole numbers between 0 and 100. If the swappiness parameter isn't specified, a default value of 60 is used. If a value isn't specified for maxSwap, then this parameter is ignored. If maxSwap is set to 0, the container doesn't use swap. This parameter maps to the --memory-swappiness option to docker run (https://docs.docker.com/engine/reference/run/). 
		 Consider the following when you use a per-container swap configuration. 
		 * Swap space must be enabled and allocated on the container instance for the containers to use. The Amazon ECS optimized AMIs don't have swap enabled by default. You must enable swap on the instance to use this feature. For more information, see Instance Store Swap Volumes (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-store-swap-volumes.html) in the Amazon EC2 User Guide for Linux Instances or How do I allocate memory to work as swap space in an Amazon EC2 instance by using a swap file? (http://aws.amazon.com/premiumsupport/knowledge-center/ec2-memory-swap-file/) 
		 * The swap space parameters are only supported for job definitions using EC2 resources. 
		 * If the maxSwap and swappiness parameters are omitted from a job definition, each container will have a default swappiness value of 60, and the total swap usage will be limited to two times the memory reservation of the container. 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

														format: "int64"
														type:   "integer"
													}
													tmpfs: {
														description: """
		The container path, mount options, and size (in MiB) of the tmpfs mount. This parameter maps to the --tmpfs option to docker run (https://docs.docker.com/engine/reference/run/). 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

														items: {
															description: """
		Tmpfs defines the container path, mount options, and size of the tmpfs mount. 
		 This object isn't applicable to jobs that are running on Fargate resources.
		"""

															properties: {
																containerPath: {
																	description: """
		The absolute file path in the container where the tmpfs volume is mounted. 
		 ContainerPath is a required field
		"""

																	type: "string"
																}
																mountOptions: {
																	description: """
		The list of tmpfs volume mount options. 
		 Valid values: \"defaults\" | \"ro\" | \"rw\" | \"suid\" | \"nosuid\" | \"dev\" | \"nodev\" | \"exec\" | \"noexec\" | \"sync\" | \"async\" | \"dirsync\" | \"remount\" | \"mand\" | \"nomand\" | \"atime\" | \"noatime\" | \"diratime\" | \"nodiratime\" | \"bind\" | \"rbind\" | \"unbindable\" | \"runbindable\" | \"private\" | \"rprivate\" | \"shared\" | \"rshared\" | \"slave\" | \"rslave\" | \"relatime\" | \"norelatime\" | \"strictatime\" | \"nostrictatime\" | \"mode\" | \"uid\" | \"gid\" | \"nr_inodes\" | \"nr_blocks\" | \"mpol\"
		"""

																	items: type: "string"
																	type: "array"
																}
																size: {
																	description: """
		The size (in MiB) of the tmpfs volume. 
		 Size is a required field
		"""

																	format: "int64"
																	type:   "integer"
																}
															}
															required: [
																"containerPath",
																"size",
															]
															type: "object"
														}
														type: "array"
													}
												}
												type: "object"
											}
											logConfiguration: {
												description: """
		The log configuration specification for the container. 
		 This parameter maps to LogConfig in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --log-driver option to docker run (https://docs.docker.com/engine/reference/run/). By default, containers use the same logging driver that the Docker daemon uses. However the container might use a different logging driver than the Docker daemon by specifying a log driver with this parameter in the container definition. To use a different logging driver for a container, the log system must be configured properly on the container instance (or on a different log server for remote logging options). For more information on the options for different supported log drivers, see Configure logging drivers (https://docs.docker.com/engine/admin/logging/overview/) in the Docker documentation. 
		 Batch currently supports a subset of the logging drivers available to the Docker daemon (shown in the LogConfiguration data type). 
		 This parameter requires version 1.18 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log into your container instance and run the following command: sudo docker version | grep \"Server API version\" 
		 The Amazon ECS container agent running on a container instance must register the logging drivers available on that instance with the ECS_AVAILABLE_LOGGING_DRIVERS environment variable before containers placed on that instance can use these log configuration options. For more information, see Amazon ECS Container Agent Configuration (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the Amazon Elastic Container Service Developer Guide.
		"""

												properties: {
													logDriver: {
														description: """
		The log driver to use for the container. The valid values listed for this parameter are log drivers that the Amazon ECS container agent can communicate with by default. 
		 The supported log drivers are awslogs, fluentd, gelf, json-file, journald, logentries, syslog, and splunk. 
		 Jobs that are running on Fargate resources are restricted to the awslogs and splunk log drivers. 
		 awslogs 
		 Specifies the Amazon CloudWatch Logs logging driver. For more information, see Using the awslogs Log Driver (https://docs.aws.amazon.com/batch/latest/userguide/using_awslogs.html) in the Batch User Guide and Amazon CloudWatch Logs logging driver (https://docs.docker.com/config/containers/logging/awslogs/) in the Docker documentation. 
		 fluentd 
		 Specifies the Fluentd logging driver. For more information, including usage and options, see Fluentd logging driver (https://docs.docker.com/config/containers/logging/fluentd/) in the Docker documentation. 
		 gelf 
		 Specifies the Graylog Extended Format (GELF) logging driver. For more information, including usage and options, see Graylog Extended Format logging driver (https://docs.docker.com/config/containers/logging/gelf/) in the Docker documentation. 
		 journald 
		 Specifies the journald logging driver. For more information, including usage and options, see Journald logging driver (https://docs.docker.com/config/containers/logging/journald/) in the Docker documentation. 
		 json-file 
		 Specifies the JSON file logging driver. For more information, including usage and options, see JSON File logging driver (https://docs.docker.com/config/containers/logging/json-file/) in the Docker documentation. 
		 splunk 
		 Specifies the Splunk logging driver. For more information, including usage and options, see Splunk logging driver (https://docs.docker.com/config/containers/logging/splunk/) in the Docker documentation. 
		 syslog 
		 Specifies the syslog logging driver. For more information, including usage and options, see Syslog logging driver (https://docs.docker.com/config/containers/logging/syslog/) in the Docker documentation. 
		 If you have a custom driver that's not listed earlier that you want to work with the Amazon ECS container agent, you can fork the Amazon ECS container agent project that's available on GitHub (https://github.com/aws/amazon-ecs-agent) and customize it to work with that driver. We encourage you to submit pull requests for changes that you want to have included. However, Amazon Web Services doesn't currently support running modified copies of this software. 
		 This parameter requires version 1.18 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log into your container instance and run the following command: sudo docker version | grep \"Server API version\" 
		 LogDriver is a required field
		"""

														enum: [
															"json-file",
															"syslog",
															"journald",
															"gelf",
															"fluentd",
															"awslogs",
															"splunk",
														]
														type: "string"
													}
													options: {
														additionalProperties: type: "string"
														description: "The configuration options to send to the log driver. This parameter requires version 1.19 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log into your container instance and run the following command: sudo docker version | grep \"Server API version\""

														type: "object"
													}
													secretOptions: {
														description: "The secrets to pass to the log configuration. For more information, see Specifying Sensitive Data (https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html) in the Batch User Guide."

														items: {
															description: """
		Secret defines the secret to expose to your container. Secrets can be exposed to a container in the following ways: 
		 * To inject sensitive data into your containers as environment variables, use the secrets container definition parameter. 
		 * To reference sensitive information in the log configuration of a container, use the secretOptions container definition parameter. 
		 For more information, see Specifying sensitive data (https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html) in the Batch User Guide.
		"""

															properties: {
																name: {
																	description: """
		The name of the secret. 
		 Name is a required field
		"""

																	type: "string"
																}
																valueFrom: {
																	description: """
		The secret to expose to the container. The supported values are either the full ARN of the Secrets Manager secret or the full ARN of the parameter in the Amazon Web Services Systems Manager Parameter Store. 
		 If the Amazon Web Services Systems Manager Parameter Store parameter exists in the same Region as the job you're launching, then you can use either the full ARN or name of the parameter. If the parameter exists in a different Region, then the full ARN must be specified. 
		 ValueFrom is a required field
		"""

																	type: "string"
																}
															}
															required: [
																"name",
																"valueFrom",
															]
															type: "object"
														}
														type: "array"
													}
												}
												required: [
													"logDriver",
												]
												type: "object"
											}
											mountPoints: {
												description: "The mount points for data volumes in your container. This parameter maps to Volumes in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --volume option to docker run (https://docs.docker.com/engine/reference/run/)."

												items: {
													description: "MountPoint defines the details on a Docker volume mount point that's used in a job's container properties. This parameter maps to Volumes in the Create a container (https://docs.docker.com/engine/reference/api/docker_remote_api_v1.19/#create-a-container) section of the Docker Remote API and the --volume option to docker run."

													properties: {
														containerPath: {
															description: "The path on the container where the host volume is mounted."

															type: "string"
														}
														readOnly: {
															description: "If this value is true, the container has read-only access to the volume. Otherwise, the container can write to the volume. The default value is false."

															type: "boolean"
														}
														sourceVolume: {
															description: "The name of the volume to mount."
															type:        "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
											networkConfiguration: {
												description: "The network configuration for jobs that are running on Fargate resources. Jobs that are running on EC2 resources must not specify this parameter."

												properties: assignPublicIp: {
													description: "Indicates whether the job should have a public IP address. For a job that is running on Fargate resources in a private subnet to send outbound traffic to the internet (for example, to pull container images), the private subnet requires a NAT gateway be attached to route requests to the internet. For more information, see Amazon ECS task networking (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html). The default value is \"DISABLED\"."

													enum: [
														"ENABLED",
														"DISABLED",
													]
													type: "string"
												}
												type: "object"
											}
											privileged: {
												description: """
		When this parameter is true, the container is given elevated permissions on the host container instance (similar to the root user). This parameter maps to Privileged in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --privileged option to docker run (https://docs.docker.com/engine/reference/run/). The default value is false. 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided, or specified as false.
		"""

												type: "boolean"
											}
											readonlyRootFilesystem: {
												description: "When this parameter is true, the container is given read-only access to its root file system. This parameter maps to ReadonlyRootfs in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --read-only option to docker run."

												type: "boolean"
											}
											resourceRequirements: {
												description: "The type and amount of resources to assign to a container. The supported resources include GPU, MEMORY, and VCPU."

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
											secrets: {
												description: "The secrets for the container. For more information, see Specifying sensitive data (https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html) in the Batch User Guide."

												items: {
													description: """
		Secret defines the secret to expose to your container. Secrets can be exposed to a container in the following ways: 
		 * To inject sensitive data into your containers as environment variables, use the secrets container definition parameter. 
		 * To reference sensitive information in the log configuration of a container, use the secretOptions container definition parameter. 
		 For more information, see Specifying sensitive data (https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html) in the Batch User Guide.
		"""

													properties: {
														name: {
															description: """
		The name of the secret. 
		 Name is a required field
		"""

															type: "string"
														}
														valueFrom: {
															description: """
		The secret to expose to the container. The supported values are either the full ARN of the Secrets Manager secret or the full ARN of the parameter in the Amazon Web Services Systems Manager Parameter Store. 
		 If the Amazon Web Services Systems Manager Parameter Store parameter exists in the same Region as the job you're launching, then you can use either the full ARN or name of the parameter. If the parameter exists in a different Region, then the full ARN must be specified. 
		 ValueFrom is a required field
		"""

															type: "string"
														}
													}
													required: [
														"name",
														"valueFrom",
													]
													type: "object"
												}
												type: "array"
											}
											ulimits: {
												description: """
		A list of ulimits to set in the container. This parameter maps to Ulimits in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --ulimit option to docker run (https://docs.docker.com/engine/reference/run/). 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

												items: {
													description: """
		Ulimit defines the ulimit settings to pass to the container. 
		 This object isn't applicable to jobs that are running on Fargate resources.
		"""

													properties: {
														hardLimit: {
															description: """
		The hard limit for the ulimit type. 
		 HardLimit is a required field
		"""

															format: "int64"
															type:   "integer"
														}
														name: {
															description: """
		The type of the ulimit. 
		 Name is a required field
		"""

															type: "string"
														}
														softLimit: {
															description: """
		The soft limit for the ulimit type. 
		 SoftLimit is a required field
		"""

															format: "int64"
															type:   "integer"
														}
													}
													required: [
														"hardLimit",
														"name",
														"softLimit",
													]
													type: "object"
												}
												type: "array"
											}
											user: {
												description: "The user name to use inside the container. This parameter maps to User in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --user option to docker run (https://docs.docker.com/engine/reference/run/)."

												type: "string"
											}
											volumes: {
												description: "A list of data volumes used in a job."
												items: {
													description: "Volume defines a data volume used in a job's container properties."

													properties: {
														efsVolumeConfiguration: {
															description: "This parameter is specified when you are using an Amazon Elastic File System file system for job storage. Jobs that are running on Fargate resources must specify a platformVersion of at least 1.4.0."

															properties: {
																authorizationConfig: {
																	description: "The authorization configuration details for the Amazon EFS file system."

																	properties: {
																		accessPointId: {
																			description: "The Amazon EFS access point ID to use. If an access point is specified, the root directory value specified in the EFSVolumeConfiguration must either be omitted or set to / which will enforce the path set on the EFS access point. If an access point is used, transit encryption must be enabled in the EFSVolumeConfiguration. For more information, see Working with Amazon EFS Access Points (https://docs.aws.amazon.com/efs/latest/ug/efs-access-points.html) in the Amazon Elastic File System User Guide."

																			type: "string"
																		}
																		accessPointIdRef: {
																			description: "AccessPointIDRef are references to AccessPoint used to set the AccessPointID."

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
																		accessPointIdSelector: {
																			description: "AccessPointIDSelector selects references to AccessPoint used to set the AccessPointID."

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
																			description: "Whether or not to use the Batch job IAM role defined in a job definition when mounting the Amazon EFS file system. If enabled, transit encryption must be enabled in the EFSVolumeConfiguration. If this parameter is omitted, the default value of DISABLED is used. For more information, see Using Amazon EFS Access Points (https://docs.aws.amazon.com/batch/latest/userguide/efs-volumes.html#efs-volume-accesspoints) in the Batch User Guide. EFS IAM authorization requires that TransitEncryption be ENABLED and that a JobRoleArn is specified."

																			enum: [
																				"ENABLED",
																				"DISABLED",
																			]
																			type: "string"
																		}
																	}
																	type: "object"
																}
																fileSystemId: {
																	description: """
		The Amazon EFS file system ID to use. 
		 FileSystemID is a required field
		"""

																	type: "string"
																}
																fileSystemIdRef: {
																	description: "FileSystemIDRef are references to Filesystem used to set the FileSystemID."

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
																fileSystemIdSelector: {
																	description: "FileSystemIDSelector selects references to Filesystem used to set the FileSystemID."

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
																rootDirectory: {
																	description: """
		The directory within the Amazon EFS file system to mount as the root directory inside the host. If this parameter is omitted, the root of the Amazon EFS volume is used instead. Specifying / has the same effect as omitting this parameter. The maximum length is 4,096 characters. 
		 If an EFS access point is specified in the authorizationConfig, the root directory parameter must either be omitted or set to /, which enforces the path set on the Amazon EFS access point.
		"""

																	type: "string"
																}
																transitEncryption: {
																	description: "Determines whether to enable encryption for Amazon EFS data in transit between the Amazon ECS host and the Amazon EFS server. Transit encryption must be enabled if Amazon EFS IAM authorization is used. If this parameter is omitted, the default value of DISABLED is used. For more information, see Encrypting data in transit (https://docs.aws.amazon.com/efs/latest/ug/encryption-in-transit.html) in the Amazon Elastic File System User Guide."

																	enum: [
																		"ENABLED",
																		"DISABLED",
																	]
																	type: "string"
																}
																transitEncryptionPort: {
																	description: "The port to use when sending encrypted data between the Amazon ECS host and the Amazon EFS server. If you don't specify a transit encryption port, it uses the port selection strategy that the Amazon EFS mount helper uses. The value must be between 0 and 65,535. For more information, see EFS Mount Helper (https://docs.aws.amazon.com/efs/latest/ug/efs-mount-helper.html) in the Amazon Elastic File System User Guide."

																	format: "int64"
																	type:   "integer"
																}
															}
															type: "object"
														}
														host: {
															description: """
		The contents of the host parameter determine whether your data volume persists on the host container instance and where it is stored. If the host parameter is empty, then the Docker daemon assigns a host path for your data volume. However, the data isn't guaranteed to persist after the containers associated with it stop running. 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

															properties: sourcePath: {
																description: """
		The path on the host container instance that's presented to the container. If this parameter is empty, then the Docker daemon has assigned a host path for you. If this parameter contains a file location, then the data volume persists at the specified location on the host container instance until you delete it manually. If the source path location doesn't exist on the host container instance, the Docker daemon creates it. If the location does exist, the contents of the source path folder are exported. 
		 This parameter isn't applicable to jobs that run on Fargate resources and shouldn't be provided.
		"""

																type: "string"
															}
															type: "object"
														}
														name: {
															description: "The name of the volume. Up to 255 letters (uppercase and lowercase), numbers, hyphens, and underscores are allowed. This name is referenced in the sourceVolume parameter of container definition mountPoints."

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
									jobDefinitionType: {
										description: """
		The type of job definition. For more information about multi-node parallel jobs, see Creating a multi-node parallel job definition (https://docs.aws.amazon.com/batch/latest/userguide/multi-node-job-def.html) in the Batch User Guide. 
		 If the job is run on Fargate resources, then multinode isn't supported. 
		 Type is a required field
		"""

										enum: [
											"container",
											"multinode",
										]
										type: "string"
									}
									nodeProperties: {
										description: """
		An object with various properties specific to multi-node parallel jobs. 
		 If the job runs on Fargate resources, then you must not specify nodeProperties; use containerProperties instead.
		"""

										properties: {
											mainNode: {
												description: """
		Specifies the node index for the main node of a multi-node parallel job. This node index value must be fewer than the number of nodes. 
		 MainNode is a required field
		"""

												format: "int64"
												type:   "integer"
											}
											nodeRangeProperties: {
												description: """
		A list of node ranges and their properties associated with a multi-node parallel job. 
		 NodeRangeProperties is a required field
		"""

												items: {
													description: "NodeRangeProperty defines the properties of the node range for a multi-node parallel job."

													properties: {
														container: {
															description: "The container details for the node range."
															properties: {
																command: {
																	description: "The command that's passed to the container. This parameter maps to Cmd in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the COMMAND parameter to docker run (https://docs.docker.com/engine/reference/run/). For more information, see https://docs.docker.com/engine/reference/builder/#cmd (https://docs.docker.com/engine/reference/builder/#cmd)."

																	items: type: "string"
																	type: "array"
																}
																environment: {
																	description: """
		The environment variables to pass to a container. This parameter maps to Env in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --env option to docker run (https://docs.docker.com/engine/reference/run/). 
		 We don't recommend using plaintext environment variables for sensitive information, such as credential data. 
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
																executionRoleARNRef: {
																	description: "ExecutionRoleARNRef is a reference to an ARN of the IAM role used to set the ExecutionRoleARN."

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
																	description: "ExecutionRoleARNSelector selects references to an ARN of the IAM role used to set the ExecutionRoleARN."

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
																executionRoleArn: {
																	description: "The Amazon Resource Name (ARN) of the execution role that Batch can assume. For jobs that run on Fargate resources, you must provide an execution role. For more information, see Batch execution IAM role (https://docs.aws.amazon.com/batch/latest/userguide/execution-IAM-role.html) in the Batch User Guide."

																	type: "string"
																}
																fargatePlatformConfiguration: {
																	description: "The platform configuration for jobs that are running on Fargate resources. Jobs that are running on EC2 resources must not specify this parameter."

																	properties: platformVersion: {
																		description: "The Fargate platform version where the jobs are running. A platform version is specified only for jobs that are running on Fargate resources. If one isn't specified, the LATEST platform version is used by default. This uses a recent, approved version of the Fargate platform for compute resources. For more information, see Fargate platform versions (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the Amazon Elastic Container Service Developer Guide."

																		type: "string"
																	}
																	type: "object"
																}
																image: {
																	description: """
		The image used to start a container. This string is passed directly to the Docker daemon. Images in the Docker Hub registry are available by default. Other repositories are specified with repository-url/image:tag . Up to 255 letters (uppercase and lowercase), numbers, hyphens, underscores, colons, periods, forward slashes, and number signs are allowed. This parameter maps to Image in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the IMAGE parameter of docker run (https://docs.docker.com/engine/reference/run/). 
		 Docker image architecture must match the processor architecture of the compute resources that they're scheduled on. For example, ARM-based Docker images can only run on ARM-based compute resources. 
		 * Images in Amazon ECR repositories use the full registry and repository URI (for example, 012345678910.dkr.ecr.<region-name>.amazonaws.com/<repository-name>). 
		 * Images in official repositories on Docker Hub use a single name (for example, ubuntu or mongo). 
		 * Images in other repositories on Docker Hub are qualified with an organization name (for example, amazon/amazon-ecs-agent). 
		 * Images in other online repositories are qualified further by a domain name (for example, quay.io/assemblyline/ubuntu).
		"""

																	type: "string"
																}
																instanceType: {
																	description: """
		The instance type to use for a multi-node parallel job. All node groups in a multi-node parallel job must use the same instance type. 
		 This parameter isn't applicable to single-node container jobs or jobs that run on Fargate resources, and shouldn't be provided.
		"""

																	type: "string"
																}
																jobRoleARNRef: {
																	description: "JobRoleARNRef is a reference to an ARN of the IAM role used to set the JobRoleARN."

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
																jobRoleARNSelector: {
																	description: "JobRoleARNSelector selects references to an ARN of the IAM role used to set the JobRoleARN."

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
																jobRoleArn: {
																	description: "The Amazon Resource Name (ARN) of the IAM role that the container can assume for Amazon Web Services permissions. For more information, see IAM Roles for Tasks (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) in the Amazon Elastic Container Service Developer Guide."

																	type: "string"
																}
																linuxParameters: {
																	description: "Linux-specific modifications that are applied to the container, such as details for device mappings."

																	properties: {
																		devices: {
																			description: """
		Any host devices to expose to the container. This parameter maps to Devices in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --device option to docker run (https://docs.docker.com/engine/reference/run/). 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

																			items: {
																				description: """
		Device defines a container instance host device. 
		 This object isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

																				properties: {
																					containerPath: {
																						description: "The path inside the container that's used to expose the host device. By default, the hostPath value is used."

																						type: "string"
																					}
																					hostPath: {
																						description: """
		The path for the device on the host container instance. 
		 HostPath is a required field
		"""

																						type: "string"
																					}
																					permissions: {
																						description: "The explicit permissions to provide to the container for the device. By default, the container has permissions for read, write, and mknod for the device."

																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"hostPath",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		initProcessEnabled: {
																			description: "If true, run an init process inside the container that forwards signals and reaps processes. This parameter maps to the --init option to docker run (https://docs.docker.com/engine/reference/run/). This parameter requires version 1.25 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log into your container instance and run the following command: sudo docker version | grep \"Server API version\""

																			type: "boolean"
																		}
																		maxSwap: {
																			description: """
		The total amount of swap memory (in MiB) a container can use. This parameter is translated to the --memory-swap option to docker run (https://docs.docker.com/engine/reference/run/) where the value is the sum of the container memory plus the maxSwap value. For more information, see --memory-swap details (https://docs.docker.com/config/containers/resource_constraints/#--memory-swap-details) in the Docker documentation. 
		 If a maxSwap value of 0 is specified, the container doesn't use swap. Accepted values are 0 or any positive integer. If the maxSwap parameter is omitted, the container doesn't use the swap configuration for the container instance it is running on. A maxSwap value must be set for the swappiness parameter to be used. 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

																			format: "int64"
																			type:   "integer"
																		}
																		sharedMemorySize: {
																			description: """
		The value for the size (in MiB) of the /dev/shm volume. This parameter maps to the --shm-size option to docker run (https://docs.docker.com/engine/reference/run/). 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

																			format: "int64"
																			type:   "integer"
																		}
																		swappiness: {
																			description: """
		This allows you to tune a container's memory swappiness behavior. A swappiness value of 0 causes swapping not to happen unless absolutely necessary. A swappiness value of 100 causes pages to be swapped very aggressively. Accepted values are whole numbers between 0 and 100. If the swappiness parameter isn't specified, a default value of 60 is used. If a value isn't specified for maxSwap, then this parameter is ignored. If maxSwap is set to 0, the container doesn't use swap. This parameter maps to the --memory-swappiness option to docker run (https://docs.docker.com/engine/reference/run/). 
		 Consider the following when you use a per-container swap configuration. 
		 * Swap space must be enabled and allocated on the container instance for the containers to use. The Amazon ECS optimized AMIs don't have swap enabled by default. You must enable swap on the instance to use this feature. For more information, see Instance Store Swap Volumes (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-store-swap-volumes.html) in the Amazon EC2 User Guide for Linux Instances or How do I allocate memory to work as swap space in an Amazon EC2 instance by using a swap file? (http://aws.amazon.com/premiumsupport/knowledge-center/ec2-memory-swap-file/) 
		 * The swap space parameters are only supported for job definitions using EC2 resources. 
		 * If the maxSwap and swappiness parameters are omitted from a job definition, each container will have a default swappiness value of 60, and the total swap usage will be limited to two times the memory reservation of the container. 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

																			format: "int64"
																			type:   "integer"
																		}
																		tmpfs: {
																			description: """
		The container path, mount options, and size (in MiB) of the tmpfs mount. This parameter maps to the --tmpfs option to docker run (https://docs.docker.com/engine/reference/run/). 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

																			items: {
																				description: """
		Tmpfs defines the container path, mount options, and size of the tmpfs mount. 
		 This object isn't applicable to jobs that are running on Fargate resources.
		"""

																				properties: {
																					containerPath: {
																						description: """
		The absolute file path in the container where the tmpfs volume is mounted. 
		 ContainerPath is a required field
		"""

																						type: "string"
																					}
																					mountOptions: {
																						description: """
		The list of tmpfs volume mount options. 
		 Valid values: \"defaults\" | \"ro\" | \"rw\" | \"suid\" | \"nosuid\" | \"dev\" | \"nodev\" | \"exec\" | \"noexec\" | \"sync\" | \"async\" | \"dirsync\" | \"remount\" | \"mand\" | \"nomand\" | \"atime\" | \"noatime\" | \"diratime\" | \"nodiratime\" | \"bind\" | \"rbind\" | \"unbindable\" | \"runbindable\" | \"private\" | \"rprivate\" | \"shared\" | \"rshared\" | \"slave\" | \"rslave\" | \"relatime\" | \"norelatime\" | \"strictatime\" | \"nostrictatime\" | \"mode\" | \"uid\" | \"gid\" | \"nr_inodes\" | \"nr_blocks\" | \"mpol\"
		"""

																						items: type: "string"
																						type: "array"
																					}
																					size: {
																						description: """
		The size (in MiB) of the tmpfs volume. 
		 Size is a required field
		"""

																						format: "int64"
																						type:   "integer"
																					}
																				}
																				required: [
																					"containerPath",
																					"size",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																	}
																	type: "object"
																}
																logConfiguration: {
																	description: """
		The log configuration specification for the container. 
		 This parameter maps to LogConfig in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --log-driver option to docker run (https://docs.docker.com/engine/reference/run/). By default, containers use the same logging driver that the Docker daemon uses. However the container might use a different logging driver than the Docker daemon by specifying a log driver with this parameter in the container definition. To use a different logging driver for a container, the log system must be configured properly on the container instance (or on a different log server for remote logging options). For more information on the options for different supported log drivers, see Configure logging drivers (https://docs.docker.com/engine/admin/logging/overview/) in the Docker documentation. 
		 Batch currently supports a subset of the logging drivers available to the Docker daemon (shown in the LogConfiguration data type). 
		 This parameter requires version 1.18 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log into your container instance and run the following command: sudo docker version | grep \"Server API version\" 
		 The Amazon ECS container agent running on a container instance must register the logging drivers available on that instance with the ECS_AVAILABLE_LOGGING_DRIVERS environment variable before containers placed on that instance can use these log configuration options. For more information, see Amazon ECS Container Agent Configuration (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the Amazon Elastic Container Service Developer Guide.
		"""

																	properties: {
																		logDriver: {
																			description: """
		The log driver to use for the container. The valid values listed for this parameter are log drivers that the Amazon ECS container agent can communicate with by default. 
		 The supported log drivers are awslogs, fluentd, gelf, json-file, journald, logentries, syslog, and splunk. 
		 Jobs that are running on Fargate resources are restricted to the awslogs and splunk log drivers. 
		 awslogs 
		 Specifies the Amazon CloudWatch Logs logging driver. For more information, see Using the awslogs Log Driver (https://docs.aws.amazon.com/batch/latest/userguide/using_awslogs.html) in the Batch User Guide and Amazon CloudWatch Logs logging driver (https://docs.docker.com/config/containers/logging/awslogs/) in the Docker documentation. 
		 fluentd 
		 Specifies the Fluentd logging driver. For more information, including usage and options, see Fluentd logging driver (https://docs.docker.com/config/containers/logging/fluentd/) in the Docker documentation. 
		 gelf 
		 Specifies the Graylog Extended Format (GELF) logging driver. For more information, including usage and options, see Graylog Extended Format logging driver (https://docs.docker.com/config/containers/logging/gelf/) in the Docker documentation. 
		 journald 
		 Specifies the journald logging driver. For more information, including usage and options, see Journald logging driver (https://docs.docker.com/config/containers/logging/journald/) in the Docker documentation. 
		 json-file 
		 Specifies the JSON file logging driver. For more information, including usage and options, see JSON File logging driver (https://docs.docker.com/config/containers/logging/json-file/) in the Docker documentation. 
		 splunk 
		 Specifies the Splunk logging driver. For more information, including usage and options, see Splunk logging driver (https://docs.docker.com/config/containers/logging/splunk/) in the Docker documentation. 
		 syslog 
		 Specifies the syslog logging driver. For more information, including usage and options, see Syslog logging driver (https://docs.docker.com/config/containers/logging/syslog/) in the Docker documentation. 
		 If you have a custom driver that's not listed earlier that you want to work with the Amazon ECS container agent, you can fork the Amazon ECS container agent project that's available on GitHub (https://github.com/aws/amazon-ecs-agent) and customize it to work with that driver. We encourage you to submit pull requests for changes that you want to have included. However, Amazon Web Services doesn't currently support running modified copies of this software. 
		 This parameter requires version 1.18 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log into your container instance and run the following command: sudo docker version | grep \"Server API version\" 
		 LogDriver is a required field
		"""

																			enum: [
																				"json-file",
																				"syslog",
																				"journald",
																				"gelf",
																				"fluentd",
																				"awslogs",
																				"splunk",
																			]
																			type: "string"
																		}
																		options: {
																			additionalProperties: type: "string"
																			description: "The configuration options to send to the log driver. This parameter requires version 1.19 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log into your container instance and run the following command: sudo docker version | grep \"Server API version\""

																			type: "object"
																		}
																		secretOptions: {
																			description: "The secrets to pass to the log configuration. For more information, see Specifying Sensitive Data (https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html) in the Batch User Guide."

																			items: {
																				description: """
		Secret defines the secret to expose to your container. Secrets can be exposed to a container in the following ways: 
		 * To inject sensitive data into your containers as environment variables, use the secrets container definition parameter. 
		 * To reference sensitive information in the log configuration of a container, use the secretOptions container definition parameter. 
		 For more information, see Specifying sensitive data (https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html) in the Batch User Guide.
		"""

																				properties: {
																					name: {
																						description: """
		The name of the secret. 
		 Name is a required field
		"""

																						type: "string"
																					}
																					valueFrom: {
																						description: """
		The secret to expose to the container. The supported values are either the full ARN of the Secrets Manager secret or the full ARN of the parameter in the Amazon Web Services Systems Manager Parameter Store. 
		 If the Amazon Web Services Systems Manager Parameter Store parameter exists in the same Region as the job you're launching, then you can use either the full ARN or name of the parameter. If the parameter exists in a different Region, then the full ARN must be specified. 
		 ValueFrom is a required field
		"""

																						type: "string"
																					}
																				}
																				required: [
																					"name",
																					"valueFrom",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																	}
																	required: [
																		"logDriver",
																	]
																	type: "object"
																}
																mountPoints: {
																	description: "The mount points for data volumes in your container. This parameter maps to Volumes in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --volume option to docker run (https://docs.docker.com/engine/reference/run/)."

																	items: {
																		description: "MountPoint defines the details on a Docker volume mount point that's used in a job's container properties. This parameter maps to Volumes in the Create a container (https://docs.docker.com/engine/reference/api/docker_remote_api_v1.19/#create-a-container) section of the Docker Remote API and the --volume option to docker run."

																		properties: {
																			containerPath: {
																				description: "The path on the container where the host volume is mounted."

																				type: "string"
																			}
																			readOnly: {
																				description: "If this value is true, the container has read-only access to the volume. Otherwise, the container can write to the volume. The default value is false."

																				type: "boolean"
																			}
																			sourceVolume: {
																				description: "The name of the volume to mount."
																				type:        "string"
																			}
																		}
																		type: "object"
																	}
																	type: "array"
																}
																networkConfiguration: {
																	description: "The network configuration for jobs that are running on Fargate resources. Jobs that are running on EC2 resources must not specify this parameter."

																	properties: assignPublicIp: {
																		description: "Indicates whether the job should have a public IP address. For a job that is running on Fargate resources in a private subnet to send outbound traffic to the internet (for example, to pull container images), the private subnet requires a NAT gateway be attached to route requests to the internet. For more information, see Amazon ECS task networking (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html). The default value is \"DISABLED\"."

																		enum: [
																			"ENABLED",
																			"DISABLED",
																		]
																		type: "string"
																	}
																	type: "object"
																}
																privileged: {
																	description: """
		When this parameter is true, the container is given elevated permissions on the host container instance (similar to the root user). This parameter maps to Privileged in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --privileged option to docker run (https://docs.docker.com/engine/reference/run/). The default value is false. 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided, or specified as false.
		"""

																	type: "boolean"
																}
																readonlyRootFilesystem: {
																	description: "When this parameter is true, the container is given read-only access to its root file system. This parameter maps to ReadonlyRootfs in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --read-only option to docker run."

																	type: "boolean"
																}
																resourceRequirements: {
																	description: "The type and amount of resources to assign to a container. The supported resources include GPU, MEMORY, and VCPU."

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
																secrets: {
																	description: "The secrets for the container. For more information, see Specifying sensitive data (https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html) in the Batch User Guide."

																	items: {
																		description: """
		Secret defines the secret to expose to your container. Secrets can be exposed to a container in the following ways: 
		 * To inject sensitive data into your containers as environment variables, use the secrets container definition parameter. 
		 * To reference sensitive information in the log configuration of a container, use the secretOptions container definition parameter. 
		 For more information, see Specifying sensitive data (https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html) in the Batch User Guide.
		"""

																		properties: {
																			name: {
																				description: """
		The name of the secret. 
		 Name is a required field
		"""

																				type: "string"
																			}
																			valueFrom: {
																				description: """
		The secret to expose to the container. The supported values are either the full ARN of the Secrets Manager secret or the full ARN of the parameter in the Amazon Web Services Systems Manager Parameter Store. 
		 If the Amazon Web Services Systems Manager Parameter Store parameter exists in the same Region as the job you're launching, then you can use either the full ARN or name of the parameter. If the parameter exists in a different Region, then the full ARN must be specified. 
		 ValueFrom is a required field
		"""

																				type: "string"
																			}
																		}
																		required: [
																			"name",
																			"valueFrom",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																ulimits: {
																	description: """
		A list of ulimits to set in the container. This parameter maps to Ulimits in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --ulimit option to docker run (https://docs.docker.com/engine/reference/run/). 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

																	items: {
																		description: """
		Ulimit defines the ulimit settings to pass to the container. 
		 This object isn't applicable to jobs that are running on Fargate resources.
		"""

																		properties: {
																			hardLimit: {
																				description: """
		The hard limit for the ulimit type. 
		 HardLimit is a required field
		"""

																				format: "int64"
																				type:   "integer"
																			}
																			name: {
																				description: """
		The type of the ulimit. 
		 Name is a required field
		"""

																				type: "string"
																			}
																			softLimit: {
																				description: """
		The soft limit for the ulimit type. 
		 SoftLimit is a required field
		"""

																				format: "int64"
																				type:   "integer"
																			}
																		}
																		required: [
																			"hardLimit",
																			"name",
																			"softLimit",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																user: {
																	description: "The user name to use inside the container. This parameter maps to User in the Create a container (https://docs.docker.com/engine/api/v1.23/#create-a-container) section of the Docker Remote API (https://docs.docker.com/engine/api/v1.23/) and the --user option to docker run (https://docs.docker.com/engine/reference/run/)."

																	type: "string"
																}
																volumes: {
																	description: "A list of data volumes used in a job."
																	items: {
																		description: "Volume defines a data volume used in a job's container properties."

																		properties: {
																			efsVolumeConfiguration: {
																				description: "This parameter is specified when you are using an Amazon Elastic File System file system for job storage. Jobs that are running on Fargate resources must specify a platformVersion of at least 1.4.0."

																				properties: {
																					authorizationConfig: {
																						description: "The authorization configuration details for the Amazon EFS file system."

																						properties: {
																							accessPointId: {
																								description: "The Amazon EFS access point ID to use. If an access point is specified, the root directory value specified in the EFSVolumeConfiguration must either be omitted or set to / which will enforce the path set on the EFS access point. If an access point is used, transit encryption must be enabled in the EFSVolumeConfiguration. For more information, see Working with Amazon EFS Access Points (https://docs.aws.amazon.com/efs/latest/ug/efs-access-points.html) in the Amazon Elastic File System User Guide."

																								type: "string"
																							}
																							accessPointIdRef: {
																								description: "AccessPointIDRef are references to AccessPoint used to set the AccessPointID."

																								properties: {
																									name: {
																										description: "Name of the referenced object."

																										type: "string"
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
																							accessPointIdSelector: {
																								description: "AccessPointIDSelector selects references to AccessPoint used to set the AccessPointID."

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
																								description: "Whether or not to use the Batch job IAM role defined in a job definition when mounting the Amazon EFS file system. If enabled, transit encryption must be enabled in the EFSVolumeConfiguration. If this parameter is omitted, the default value of DISABLED is used. For more information, see Using Amazon EFS Access Points (https://docs.aws.amazon.com/batch/latest/userguide/efs-volumes.html#efs-volume-accesspoints) in the Batch User Guide. EFS IAM authorization requires that TransitEncryption be ENABLED and that a JobRoleArn is specified."

																								enum: [
																									"ENABLED",
																									"DISABLED",
																								]
																								type: "string"
																							}
																						}
																						type: "object"
																					}
																					fileSystemId: {
																						description: """
		The Amazon EFS file system ID to use. 
		 FileSystemID is a required field
		"""

																						type: "string"
																					}
																					fileSystemIdRef: {
																						description: "FileSystemIDRef are references to Filesystem used to set the FileSystemID."

																						properties: {
																							name: {
																								description: "Name of the referenced object."

																								type: "string"
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
																					fileSystemIdSelector: {
																						description: "FileSystemIDSelector selects references to Filesystem used to set the FileSystemID."

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
																					rootDirectory: {
																						description: """
		The directory within the Amazon EFS file system to mount as the root directory inside the host. If this parameter is omitted, the root of the Amazon EFS volume is used instead. Specifying / has the same effect as omitting this parameter. The maximum length is 4,096 characters. 
		 If an EFS access point is specified in the authorizationConfig, the root directory parameter must either be omitted or set to /, which enforces the path set on the Amazon EFS access point.
		"""

																						type: "string"
																					}
																					transitEncryption: {
																						description: "Determines whether to enable encryption for Amazon EFS data in transit between the Amazon ECS host and the Amazon EFS server. Transit encryption must be enabled if Amazon EFS IAM authorization is used. If this parameter is omitted, the default value of DISABLED is used. For more information, see Encrypting data in transit (https://docs.aws.amazon.com/efs/latest/ug/encryption-in-transit.html) in the Amazon Elastic File System User Guide."

																						enum: [
																							"ENABLED",
																							"DISABLED",
																						]
																						type: "string"
																					}
																					transitEncryptionPort: {
																						description: "The port to use when sending encrypted data between the Amazon ECS host and the Amazon EFS server. If you don't specify a transit encryption port, it uses the port selection strategy that the Amazon EFS mount helper uses. The value must be between 0 and 65,535. For more information, see EFS Mount Helper (https://docs.aws.amazon.com/efs/latest/ug/efs-mount-helper.html) in the Amazon Elastic File System User Guide."

																						format: "int64"
																						type:   "integer"
																					}
																				}
																				type: "object"
																			}
																			host: {
																				description: """
		The contents of the host parameter determine whether your data volume persists on the host container instance and where it is stored. If the host parameter is empty, then the Docker daemon assigns a host path for your data volume. However, the data isn't guaranteed to persist after the containers associated with it stop running. 
		 This parameter isn't applicable to jobs that are running on Fargate resources and shouldn't be provided.
		"""

																				properties: sourcePath: {
																					description: """
		The path on the host container instance that's presented to the container. If this parameter is empty, then the Docker daemon has assigned a host path for you. If this parameter contains a file location, then the data volume persists at the specified location on the host container instance until you delete it manually. If the source path location doesn't exist on the host container instance, the Docker daemon creates it. If the location does exist, the contents of the source path folder are exported. 
		 This parameter isn't applicable to jobs that run on Fargate resources and shouldn't be provided.
		"""

																					type: "string"
																				}
																				type: "object"
																			}
																			name: {
																				description: "The name of the volume. Up to 255 letters (uppercase and lowercase), numbers, hyphens, and underscores are allowed. This name is referenced in the sourceVolume parameter of container definition mountPoints."

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
														targetNodes: {
															description: """
		The range of nodes, using node index values. A range of 0:3 indicates nodes with index values of 0 through 3. If the starting range value is omitted (:n), then 0 is used to start the range. If the ending range value is omitted (n:), then the highest possible node index is used to end the range. Your accumulative node ranges must account for all nodes (0:n). You can nest node ranges, for example 0:10 and 4:5, in which case the 4:5 range properties override the 0:10 properties. 
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
		The number of nodes associated with a multi-node parallel job. 
		 NumNodes is a required field
		"""

												format: "int64"
												type:   "integer"
											}
										}
										required: [
											"mainNode",
											"nodeRangeProperties",
											"numNodes",
										]
										type: "object"
									}
									parameters: {
										additionalProperties: type: "string"
										description: "Default parameter substitution placeholders to set in the job definition. Parameters are specified as a key-value pair mapping. Parameters in a SubmitJob request override any corresponding parameter defaults from the job definition."

										type: "object"
									}
									platformCapabilities: {
										description: "The platform capabilities required by the job definition. If no value is specified, it defaults to EC2. To run the job on Fargate resources, specify FARGATE."

										items: type: "string"
										type: "array"
									}
									propagateTags: {
										description: "Specifies whether to propagate the tags from the job or job definition to the corresponding Amazon ECS task. If no value is specified, the tags are not propagated. Tags can only be propagated to the tasks during task creation. For tags with the same name, job tags are given priority over job definitions tags. If the total number of combined tags from the job and job definition is over 50, the job is moved to the FAILED state."

										type: "boolean"
									}
									region: {
										description: "Region is which region the Function will be created."
										type:        "string"
									}
									retryStrategy: {
										description: "The retry strategy to use for failed jobs that are submitted with this job definition. Any retry strategy that's specified during a SubmitJob operation overrides the retry strategy defined here. If a job is terminated due to a timeout, it isn't retried."

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
										description: "The tags that you apply to the job definition to help you categorize and organize your resources. Each tag consists of a key and an optional value. For more information, see Tagging Amazon Web Services Resources (https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html) in Batch User Guide."

										type: "object"
									}
									timeout: {
										description: "The timeout configuration for jobs that are submitted with this job definition, after which Batch terminates your jobs if they have not finished. If a job is terminated due to a timeout, it isn't retried. The minimum value for the timeout is 60 seconds. Any timeout configuration that's specified during a SubmitJob operation overrides the timeout configuration defined here. For more information, see Job Timeouts (https://docs.aws.amazon.com/batch/latest/userguide/job_timeouts.html) in the Batch User Guide."

										properties: attemptDurationSeconds: {
											description: "The time duration in seconds (measured from the job attempt's startedAt timestamp) after which Batch terminates your jobs if they have not finished. The minimum value for the timeout is 60 seconds."

											format: "int64"
											type:   "integer"
										}
										type: "object"
									}
								}
								required: [
									"jobDefinitionType",
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
						description: "A JobDefinitionStatus represents the observed state of a JobDefinition."

						properties: {
							atProvider: {
								description: "JobDefinitionObservation keeps the state for the external resource"

								properties: {
									jobDefinitionArn: {
										description: "The Amazon Resource Name (ARN) for the job definition."
										type:        "string"
									}
									revision: {
										description: "The revision of the job definition."
										format:      "int64"
										type:        "integer"
									}
									status: {
										description: "The status of the job definition."
										type:        "string"
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
