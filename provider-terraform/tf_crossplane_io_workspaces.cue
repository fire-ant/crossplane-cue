package tf_crossplane_io_workspaces

customresourcedefinition: "workspaces.tf.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.10.0"
		creationTimestamp: null
		name:              "workspaces.tf.crossplane.io"
	}
	spec: {
		group: "tf.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"terraform",
			]
			kind:     "Workspace"
			listKind: "WorkspaceList"
			plural:   "workspaces"
			singular: "workspace"
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
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "A Workspace of Terraform Configuration."
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
						description: "A WorkspaceSpec defines the desired state of a Workspace."
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
								description: "WorkspaceParameters are the configurable fields of a Workspace."

								properties: {
									applyArgs: {
										description: "Arguments to be included in the terraform apply CLI command"

										items: type: "string"
										type: "array"
									}
									destroyArgs: {
										description: "Arguments to be included in the terraform destroy CLI command"

										items: type: "string"
										type: "array"
									}
									entrypoint: {
										default:     ""
										description: "Entrypoint for `terraform init` within the module"
										type:        "string"
									}
									initArgs: {
										description: "Arguments to be included in the terraform init CLI command"

										items: type: "string"
										type: "array"
									}
									module: {
										description: "The root module of this workspace; i.e. the module containing its main.tf file. When the workspace's source is 'Remote' (the default) this can be any address supported by terraform init -from-module, for example a git repository or an S3 bucket. When the workspace's source is 'Inline' the content of a simple main.tf file may be written inline."

										type: "string"
									}
									planArgs: {
										description: "Arguments to be included in the terraform plan CLI command"

										items: type: "string"
										type: "array"
									}
									source: {
										description: "Source of the root module of this workspace."
										enum: [
											"Remote",
											"Inline",
										]
										type: "string"
									}
									varFiles: {
										description: "Files of configuration variables. Explicitly declared vars take precedence."

										items: {
											description: "A VarFile is a file containing many Terraform variables."
											properties: {
												configMapKeyRef: {
													description: "A ConfigMap key containing the vars file."
													properties: {
														key: {
															description: "Key within the referenced resource."
															type:        "string"
														}
														name: {
															description: "Name of the referenced resource."
															type:        "string"
														}
														namespace: {
															description: "Namespace of the referenced resource."
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
												format: {
													default:     "HCL"
													description: "Format of this vars file."
													enum: [
														"HCL",
														"JSON",
													]
													type: "string"
												}
												secretKeyRef: {
													description: "A Secret key containing the vars file."
													properties: {
														key: {
															description: "Key within the referenced resource."
															type:        "string"
														}
														name: {
															description: "Name of the referenced resource."
															type:        "string"
														}
														namespace: {
															description: "Namespace of the referenced resource."
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
												source: {
													description: "Source of this vars file."
													enum: [
														"ConfigMapKey",
														"SecretKey",
													]
													type: "string"
												}
											}
											required: [
												"source",
											]
											type: "object"
										}
										type: "array"
									}
									vars: {
										description: "Configuration variables."
										items: {
											description: "A Var represents a Terraform configuration variable."
											properties: {
												key: type: "string"
												value: type: "string"
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
									"module",
									"source",
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
						description: "A WorkspaceStatus represents the observed state of a Workspace."
						properties: {
							atProvider: {
								description: "WorkspaceObservation are the observable fields of a Workspace."
								properties: outputs: {
									additionalProperties: type: "string"
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
}
