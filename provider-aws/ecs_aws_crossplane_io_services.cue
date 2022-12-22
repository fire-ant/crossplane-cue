package ecs_aws_crossplane_io_services

customresourcedefinition: "services.ecs.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "services.ecs.aws.crossplane.io"
	}
	spec: {
		group: "ecs.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Service"
			listKind: "ServiceList"
			plural:   "services"
			singular: "service"
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
				description: "Service is the Schema for the Services API"
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
						description: "ServiceSpec defines the desired state of Service"
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
								description: "ServiceParameters defines the desired state of Service"
								properties: {
									capacityProviderStrategy: {
										description: """
		The capacity provider strategy to use for the service. 
		 If a capacityProviderStrategy is specified, the launchType parameter must be omitted. If no capacityProviderStrategy or launchType is specified, the defaultCapacityProviderStrategy for the cluster is used. 
		 A capacity provider strategy may contain a maximum of 6 capacity providers.
		"""

										items: {
											properties: {
												base: {
													format: "int64"
													type:   "integer"
												}
												capacityProvider: type: "string"
												weight: {
													format: "int64"
													type:   "integer"
												}
											}
											type: "object"
										}
										type: "array"
									}
									cluster: {
										description: "The short name or full Amazon Resource Name (ARN) of the cluster on which to run your service. If you do not specify a cluster, the default cluster is assumed."

										type: "string"
									}
									clusterRef: {
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
									clusterSelector: {
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
									deploymentConfiguration: {
										description: "Optional deployment parameters that control how many tasks run during the deployment and the ordering of stopping and starting tasks."

										properties: {
											deploymentCircuitBreaker: {
												description: """
		The deployment circuit breaker can only be used for services using the rolling update (ECS) deployment type that aren't behind a Classic Load Balancer. 
		 The deployment circuit breaker determines whether a service deployment will fail if the service can't reach a steady state. If enabled, a service deployment will transition to a failed state and stop launching new tasks. You can also configure Amazon ECS to roll back your service to the last completed deployment after a failure. For more information, see Rolling update (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-ecs.html) in the Amazon Elastic Container Service Developer Guide.
		"""

												properties: {
													enable: type: "boolean"
													rollback: type: "boolean"
												}
												type: "object"
											}
											maximumPercent: {
												format: "int64"
												type:   "integer"
											}
											minimumHealthyPercent: {
												format: "int64"
												type:   "integer"
											}
										}
										type: "object"
									}
									deploymentController: {
										description: "The deployment controller to use for the service. If no deployment controller is specified, the default value of ECS is used."

										properties: type_: type: "string"
										type: "object"
									}
									desiredCount: {
										description: """
		The number of instantiations of the specified task definition to place and keep running on your cluster. 
		 This is required if schedulingStrategy is REPLICA or isn't specified. If schedulingStrategy is DAEMON then this isn't required.
		"""

										format: "int64"
										type:   "integer"
									}
									enableECSManagedTags: {
										description: "Specifies whether to turn on Amazon ECS managed tags for the tasks within the service. For more information, see Tagging Your Amazon ECS Resources (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-using-tags.html) in the Amazon Elastic Container Service Developer Guide."

										type: "boolean"
									}
									enableExecuteCommand: {
										description: "Determines whether the execute command functionality is enabled for the service. If true, this enables execute command functionality on all containers in the service tasks."

										type: "boolean"
									}
									healthCheckGracePeriodSeconds: {
										description: """
		The period of time, in seconds, that the Amazon ECS service scheduler ignores unhealthy Elastic Load Balancing target health checks after a task has first started. This is only used when your service is configured to use a load balancer. If your service has a load balancer defined and you don't specify a health check grace period value, the default value of 0 is used. 
		 If you do not use an Elastic Load Balancing, we recomend that you use the startPeriod in the task definition healtch check parameters. For more information, see Health check (https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HealthCheck.html). 
		 If your service's tasks take a while to start and respond to Elastic Load Balancing health checks, you can specify a health check grace period of up to 2,147,483,647 seconds (about 69 years). During that time, the Amazon ECS service scheduler ignores health check status. This grace period can prevent the service scheduler from marking tasks as unhealthy and stopping them before they have time to come up.
		"""

										format: "int64"
										type:   "integer"
									}
									launchType: {
										description: """
		The infrastructure that you run your service on. For more information, see Amazon ECS launch types (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html) in the Amazon Elastic Container Service Developer Guide. 
		 The FARGATE launch type runs your tasks on Fargate On-Demand infrastructure. 
		 Fargate Spot infrastructure is available for use but a capacity provider strategy must be used. For more information, see Fargate capacity providers (https://docs.aws.amazon.com/AmazonECS/latest/userguide/fargate-capacity-providers.html) in the Amazon ECS User Guide for Fargate. 
		 The EC2 launch type runs your tasks on Amazon EC2 instances registered to your cluster. 
		 The EXTERNAL launch type runs your tasks on your on-premises server or virtual machine (VM) capacity registered to your cluster. 
		 A service can use either a launch type or a capacity provider strategy. If a launchType is specified, the capacityProviderStrategy parameter must be omitted.
		"""

										type: "string"
									}
									loadBalancers: {
										description: """
		A load balancer object representing the load balancers to use with your service. For more information, see Service Load Balancing (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-load-balancing.html) in the Amazon Elastic Container Service Developer Guide. 
		 If the service is using the rolling update (ECS) deployment controller and using either an Application Load Balancer or Network Load Balancer, you must specify one or more target group ARNs to attach to the service. The service-linked role is required for services that make use of multiple target groups. For more information, see Using service-linked roles for Amazon ECS (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using-service-linked-roles.html) in the Amazon Elastic Container Service Developer Guide. 
		 If the service is using the CODE_DEPLOY deployment controller, the service is required to use either an Application Load Balancer or Network Load Balancer. When creating an CodeDeploy deployment group, you specify two target groups (referred to as a targetGroupPair). During a deployment, CodeDeploy determines which task set in your service has the status PRIMARY and associates one target group with it, and then associates the other target group with the replacement task set. The load balancer can also have up to two listeners: a required listener for production traffic and an optional listener that allows you perform validation tests with Lambda functions before routing production traffic to it. 
		 After you create a service using the ECS deployment controller, the load balancer name or target group ARN, container name, and container port specified in the service definition are immutable. If you are using the CODE_DEPLOY deployment controller, these values can be changed when updating the service. 
		 For Application Load Balancers and Network Load Balancers, this object must contain the load balancer target group ARN, the container name (as it appears in a container definition), and the container port to access from the load balancer. The load balancer name parameter must be omitted. When a task from this service is placed on a container instance, the container instance and port combination is registered as a target in the target group specified here. 
		 For Classic Load Balancers, this object must contain the load balancer name, the container name (as it appears in a container definition), and the container port to access from the load balancer. The target group ARN parameter must be omitted. When a task from this service is placed on a container instance, the container instance is registered with the load balancer specified here. 
		 Services with tasks that use the awsvpc network mode (for example, those with the Fargate launch type) only support Application Load Balancers and Network Load Balancers. Classic Load Balancers are not supported. Also, when you create any target groups for these services, you must choose ip as the target type, not instance, because tasks that use the awsvpc network mode are associated with an elastic network interface, not an Amazon EC2 instance.
		"""

										items: {
											description: "CustomLoadBalancer provides custom parameters for the LoadBalancer type"

											properties: {
												containerName: {
													description: "The name of the container (as it appears in a container definition) to associate with the load balancer."

													type: "string"
												}
												containerPort: {
													description: "The port on the container to associate with the load balancer. This port must correspond to a containerPort in the task definition the tasks in the service are using. For tasks that use the EC2 launch type, the container instance they're launched on must allow ingress traffic on the hostPort of the port mapping."

													format: "int64"
													type:   "integer"
												}
												loadBalancerName: {
													description: """
		The name of the load balancer to associate with the Amazon ECS service or task set. 
		 A load balancer name is only specified when using a Classic Load Balancer. If you are using an Application Load Balancer or a Network Load Balancer the load balancer name parameter should be omitted.
		"""

													type: "string"
												}
												loadBalancerNameRef: {
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
												loadBalancerNameSelector: {
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
												targetGroupARN: {
													description: """
		The full Amazon Resource Name (ARN) of the Elastic Load Balancing target group or groups associated with a service or task set. 
		 A target group ARN is only specified when using an Application Load Balancer or Network Load Balancer. If you're using a Classic Load Balancer, omit the target group ARN. 
		 For services using the ECS deployment controller, you can specify one or multiple target groups. For more information, see Registering multiple target groups with a service (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/register-multiple-targetgroups.html) in the Amazon Elastic Container Service Developer Guide. 
		 For services using the CODE_DEPLOY deployment controller, you're required to define two target groups for the load balancer. For more information, see Blue/green deployment with CodeDeploy (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-bluegreen.html) in the Amazon Elastic Container Service Developer Guide. 
		 If your service's task definition uses the awsvpc network mode, you must choose ip as the target type, not instance. Do this when creating your target groups because tasks that use the awsvpc network mode are associated with an elastic network interface, not an Amazon EC2 instance. This network mode is required for the Fargate launch type.
		"""

													type: "string"
												}
												targetGroupARNRef: {
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
												targetGroupARNSelector: {
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
											}
											type: "object"
										}
										type: "array"
									}
									networkConfiguration: {
										description: "The network configuration for the service. This parameter is required for task definitions that use the awsvpc network mode to receive their own elastic network interface, and it is not supported for other network modes. For more information, see Task networking (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html) in the Amazon Elastic Container Service Developer Guide."

										properties: awsvpcConfiguration: {
											description: "An object representing the networking details for a task or service."

											properties: {
												assignPublicIP: type: "string"
												securityGroupRefs: {
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
												securityGroupSelector: {
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
												securityGroups: {
													items: type: "string"
													type: "array"
												}
												subnetRefs: {
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
												subnetSelector: {
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
												subnets: {
													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										type: "object"
									}
									placementConstraints: {
										description: "An array of placement constraint objects to use for tasks in your service. You can specify a maximum of 10 constraints for each task. This limit includes constraints in the task definition and those specified at runtime."

										items: {
											properties: {
												expression: type: "string"
												type_: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									placementStrategy: {
										description: "The placement strategy objects to use for tasks in your service. You can specify a maximum of 5 strategy rules for each service."

										items: {
											properties: {
												field: type: "string"
												type_: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									platformVersion: {
										description: "The platform version that your tasks in the service are running on. A platform version is specified only for tasks using the Fargate launch type. If one isn't specified, the LATEST platform version is used. For more information, see Fargate platform versions (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the Amazon Elastic Container Service Developer Guide."

										type: "string"
									}
									propagateTags: {
										description: "Specifies whether to propagate the tags from the task definition to the task. If no value is specified, the tags aren't propagated. Tags can only be propagated to the task during task creation. To add tags to a task after task creation, use the TagResource API action."

										type: "string"
									}
									region: {
										description: "Region is which region the Service will be created."
										type:        "string"
									}
									role: {
										description: """
		The name or full Amazon Resource Name (ARN) of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is only permitted if you are using a load balancer with your service and your task definition doesn't use the awsvpc network mode. If you specify the role parameter, you must also specify a load balancer object with the loadBalancers parameter. 
		 If your account has already created the Amazon ECS service-linked role, that role is used for your service unless you specify a role here. The service-linked role is required if your task definition uses the awsvpc network mode or if the service is configured to use service discovery, an external deployment controller, multiple target groups, or Elastic Inference accelerators in which case you don't specify a role here. For more information, see Using service-linked roles for Amazon ECS (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using-service-linked-roles.html) in the Amazon Elastic Container Service Developer Guide. 
		 If your specified role has a path other than /, then you must either specify the full role ARN (this is recommended) or prefix the role name with the path. For example, if a role with the name bar has a path of /foo/ then you would specify /foo/bar as the role name. For more information, see Friendly names and paths (https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-friendly-names) in the IAM User Guide.
		"""

										type: "string"
									}
									schedulingStrategy: {
										description: """
		The scheduling strategy to use for the service. For more information, see Services (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html). 
		 There are two service scheduler strategies available: 
		 * REPLICA-The replica scheduling strategy places and maintains the desired number of tasks across your cluster. By default, the service scheduler spreads tasks across Availability Zones. You can use task placement strategies and constraints to customize task placement decisions. This scheduler strategy is required if the service uses the CODE_DEPLOY or EXTERNAL deployment controller types. 
		 * DAEMON-The daemon scheduling strategy deploys exactly one task on each active container instance that meets all of the task placement constraints that you specify in your cluster. The service scheduler also evaluates the task placement constraints for running tasks and will stop tasks that don't meet the placement constraints. When you're using this strategy, you don't need to specify a desired number of tasks, a task placement strategy, or use Service Auto Scaling policies. Tasks using the Fargate launch type or the CODE_DEPLOY or EXTERNAL deployment controller types don't support the DAEMON scheduling strategy.
		"""

										type: "string"
									}
									serviceRegistries: {
										description: """
		The details of the service discovery registry to associate with this service. For more information, see Service discovery (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-discovery.html). 
		 Each service may be associated with one service registry. Multiple service registries for each service isn't supported.
		"""

										items: {
											properties: {
												containerName: type: "string"
												containerPort: {
													format: "int64"
													type:   "integer"
												}
												port: {
													format: "int64"
													type:   "integer"
												}
												registryARN: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									tags: {
										description: """
		The metadata that you apply to the service to help you categorize and organize them. Each tag consists of a key and an optional value, both of which you define. When a service is deleted, the tags are deleted as well. 
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
									taskDefinition: {
										description: """
		The family and revision (family:revision) or full ARN of the task definition to run in your service. If a revision is not specified, the latest ACTIVE revision is used. 
		 A task definition must be specified if the service is using either the ECS or CODE_DEPLOY deployment controllers.
		"""

										type: "string"
									}
									taskDefinitionRef: {
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
									taskDefinitionSelector: {
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
						description: "ServiceStatus defines the observed state of Service."
						properties: {
							atProvider: {
								description: "ServiceObservation defines the observed state of Service"
								properties: {
									clusterARN: {
										description: "The Amazon Resource Name (ARN) of the cluster that hosts the service."

										type: "string"
									}
									createdAt: {
										description: "The Unix timestamp for the time when the service was created."

										format: "date-time"
										type:   "string"
									}
									createdBy: {
										description: "The principal that created the service."
										type:        "string"
									}
									deployments: {
										description: "The current state of deployments for the service."
										items: {
											properties: {
												capacityProviderStrategy: {
													items: {
														properties: {
															base: {
																format: "int64"
																type:   "integer"
															}
															capacityProvider: type: "string"
															weight: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
													type: "array"
												}
												createdAt: {
													format: "date-time"
													type:   "string"
												}
												desiredCount: {
													format: "int64"
													type:   "integer"
												}
												failedTasks: {
													format: "int64"
													type:   "integer"
												}
												id: type: "string"
												launchType: type: "string"
												networkConfiguration: {
													description: "An object representing the network configuration for a task or service."

													properties: awsvpcConfiguration: {
														description: "An object representing the networking details for a task or service."

														properties: {
															assignPublicIP: type: "string"
															securityGroups: {
																items: type: "string"
																type: "array"
															}
															subnets: {
																items: type: "string"
																type: "array"
															}
														}
														type: "object"
													}
													type: "object"
												}
												pendingCount: {
													format: "int64"
													type:   "integer"
												}
												platformFamily: type: "string"
												platformVersion: type: "string"
												rolloutState: type: "string"
												rolloutStateReason: type: "string"
												runningCount: {
													format: "int64"
													type:   "integer"
												}
												status: type: "string"
												taskDefinition: type: "string"
												updatedAt: {
													format: "date-time"
													type:   "string"
												}
											}
											type: "object"
										}
										type: "array"
									}
									events: {
										description: "The event stream for your service. A maximum of 100 of the latest events are displayed."

										items: {
											properties: {
												createdAt: {
													format: "date-time"
													type:   "string"
												}
												id: type: "string"
												message: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									loadBalancers: {
										description: "A list of Elastic Load Balancing load balancer objects. It contains the load balancer name, the container name, and the container port to access from the load balancer. The container name is as it appears in a container definition."

										items: {
											properties: {
												containerName: type: "string"
												containerPort: {
													format: "int64"
													type:   "integer"
												}
												loadBalancerName: type: "string"
												targetGroupARN: type: "string"
											}
											type: "object"
										}
										type: "array"
									}
									networkConfiguration: {
										description: "The VPC subnet and security group configuration for tasks that receive their own elastic network interface by using the awsvpc networking mode."

										properties: awsvpcConfiguration: {
											description: "An object representing the networking details for a task or service."

											properties: {
												assignPublicIP: type: "string"
												securityGroups: {
													items: type: "string"
													type: "array"
												}
												subnets: {
													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										type: "object"
									}
									pendingCount: {
										description: "The number of tasks in the cluster that are in the PENDING state."

										format: "int64"
										type:   "integer"
									}
									platformFamily: {
										description: """
		The operating system that your tasks in the service run on. A platform family is specified only for tasks using the Fargate launch type. 
		 All tasks that run as part of this service must use the same platformFamily value as the service (for example, LINUX).
		"""

										type: "string"
									}
									roleARN: {
										description: "The ARN of the IAM role that's associated with the service. It allows the Amazon ECS container agent to register container instances with an Elastic Load Balancing load balancer."

										type: "string"
									}
									runningCount: {
										description: "The number of tasks in the cluster that are in the RUNNING state."

										format: "int64"
										type:   "integer"
									}
									serviceARN: {
										description: "The ARN that identifies the service. The ARN contains the arn:aws:ecs namespace, followed by the Region of the service, the Amazon Web Services account ID of the service owner, the service namespace, and then the service name. For example, arn:aws:ecs:region:012345678910:service/my-service."

										type: "string"
									}
									serviceName: {
										description: "The name of your service. Up to 255 letters (uppercase and lowercase), numbers, underscores, and hyphens are allowed. Service names must be unique within a cluster. However, you can have similarly named services in multiple clusters within a Region or across multiple Regions."

										type: "string"
									}
									status: {
										description: "The status of the service. The valid values are ACTIVE, DRAINING, or INACTIVE."

										type: "string"
									}
									taskDefinition: {
										description: "The task definition to use for tasks in the service. This value is specified when the service is created with CreateService, and it can be modified with UpdateService."

										type: "string"
									}
									taskSets: {
										description: "Information about a set of Amazon ECS tasks in either an CodeDeploy or an EXTERNAL deployment. An Amazon ECS task set includes details such as the desired number of tasks, how many tasks are running, and whether the task set serves production traffic."

										items: {
											properties: {
												capacityProviderStrategy: {
													items: {
														properties: {
															base: {
																format: "int64"
																type:   "integer"
															}
															capacityProvider: type: "string"
															weight: {
																format: "int64"
																type:   "integer"
															}
														}
														type: "object"
													}
													type: "array"
												}
												clusterARN: type: "string"
												computedDesiredCount: {
													format: "int64"
													type:   "integer"
												}
												createdAt: {
													format: "date-time"
													type:   "string"
												}
												externalID: type: "string"
												id: type: "string"
												launchType: type: "string"
												loadBalancers: {
													items: {
														properties: {
															containerName: type: "string"
															containerPort: {
																format: "int64"
																type:   "integer"
															}
															loadBalancerName: type: "string"
															targetGroupARN: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												networkConfiguration: {
													description: "An object representing the network configuration for a task or service."

													properties: awsvpcConfiguration: {
														description: "An object representing the networking details for a task or service."

														properties: {
															assignPublicIP: type: "string"
															securityGroups: {
																items: type: "string"
																type: "array"
															}
															subnets: {
																items: type: "string"
																type: "array"
															}
														}
														type: "object"
													}
													type: "object"
												}
												pendingCount: {
													format: "int64"
													type:   "integer"
												}
												platformFamily: type: "string"
												platformVersion: type: "string"
												runningCount: {
													format: "int64"
													type:   "integer"
												}
												scale: {
													description: "A floating-point percentage of the desired number of tasks to place and keep running in the task set."

													properties: {
														unit: type: "string"
														value: type: "number"
													}
													type: "object"
												}
												serviceARN: type: "string"
												serviceRegistries: {
													items: {
														properties: {
															containerName: type: "string"
															containerPort: {
																format: "int64"
																type:   "integer"
															}
															port: {
																format: "int64"
																type:   "integer"
															}
															registryARN: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												stabilityStatus: type: "string"
												stabilityStatusAt: {
													format: "date-time"
													type:   "string"
												}
												startedBy: type: "string"
												status: type: "string"
												tags: {
													items: {
														properties: {
															key: type: "string"
															value: type: "string"
														}
														type: "object"
													}
													type: "array"
												}
												taskDefinition: type: "string"
												taskSetARN: type: "string"
												updatedAt: {
													format: "date-time"
													type:   "string"
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
