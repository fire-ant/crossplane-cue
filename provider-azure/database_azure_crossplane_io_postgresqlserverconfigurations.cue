package database_azure_crossplane_io_postgresqlserverconfigurations

customresourcedefinition: "postgresqlserverconfigurations.database.azure.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "postgresqlserverconfigurations.database.azure.crossplane.io"
	}
	spec: {
		group: "database.azure.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"azure",
			]
			kind:     "PostgreSQLServerConfiguration"
			listKind: "PostgreSQLServerConfigurationList"
			plural:   "postgresqlserverconfigurations"
			singular: "postgresqlserverconfiguration"
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
				jsonPath: ".spec.forProvider.version"
				name:     "VERSION"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "A PostgreSQLServerConfiguration is a managed resource that represents an Azure PostgreSQL Server Configuration."

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
						description: "A SQLServerConfigurationSpec defines the desired state of a SQLServer Configuration."

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
								description: "SQLServerConfigurationParameters define the desired state of an Azure SQL Database Server Configuration, either PostgreSQL or MySQL Configuration."

								properties: {
									name: {
										description: "Name - Configuration name to be applied"
										type:        "string"
									}
									resourceGroupName: {
										description: "ResourceGroupName specifies the name of the resource group that should contain this SQLServer."

										type: "string"
									}
									resourceGroupNameRef: {
										description: "ResourceGroupNameRef - A reference to a ResourceGroup object to retrieve its name"

										properties: name: {
											description: "Name of the referenced object."
											type:        "string"
										}
										required: [
											"name",
										]
										type: "object"
									}
									resourceGroupNameSelector: {
										description: "ResourceGroupNameSelector - A selector for a ResourceGroup object to retrieve its name"

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
										}
										type: "object"
									}
									serverName: {
										description: "ServerName specifies the name of the server that this configuration applies to."

										type: "string"
									}
									serverNameRef: {
										description: "ServerNameRef - A reference to a server object to retrieve its name"

										properties: name: {
											description: "Name of the referenced object."
											type:        "string"
										}
										required: [
											"name",
										]
										type: "object"
									}
									serverNameSelector: {
										description: "ServerNameSelector - A selector for a server object to retrieve its name"

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
										}
										type: "object"
									}
									value: {
										description: "Value - Configuration value to be applied Can be left unset to read the current value as a result of late-initialization."

										type: "string"
									}
								}
								required: [
									"name",
								]
								type: "object"
							}
							providerConfigRef: {
								default: name: "default"
								description: "ProviderConfigReference specifies how the provider that will be used to create, observe, update, and delete this managed resource should be configured."

								properties: name: {
									description: "Name of the referenced object."
									type:        "string"
								}
								required: [
									"name",
								]
								type: "object"
							}
							providerRef: {
								description: "ProviderReference specifies the provider that will be used to create, observe, update, and delete this managed resource. Deprecated: Please use ProviderConfigReference, i.e. `providerConfigRef`"

								properties: name: {
									description: "Name of the referenced object."
									type:        "string"
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

										properties: name: {
											description: "Name of the referenced object."
											type:        "string"
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
						description: "A SQLServerConfigurationStatus represents the observed state of a SQLServerConfiguration."

						properties: {
							atProvider: {
								description: "SQLServerConfigurationObservation represents the current state of Azure SQL resource."

								properties: {
									dataType: {
										description: "DataType - Data type for the configuration"
										type:        "string"
									}
									defaultValue: {
										description: "DefaultValue - Default value for this configuration"
										type:        "string"
									}
									description: {
										description: "Description - Description for the configuration"
										type:        "string"
									}
									id: {
										description: "ID - Resource ID"
										type:        "string"
									}
									lastOperation: {
										description: "LastOperation represents the state of the last operation started by the controller."

										properties: {
											errorMessage: {
												description: "ErrorMessage represents the error that occurred during the operation."

												type: "string"
											}
											method: {
												description: "Method is HTTP method that the initial request is made with."

												type: "string"
											}
											pollingUrl: {
												description: "PollingURL is used to fetch the status of the given operation."

												type: "string"
											}
											status: {
												description: "Status represents the status of the operation."
												type:        "string"
											}
										}
										type: "object"
									}
									name: {
										description: "Name - Resource name."
										type:        "string"
									}
									source: {
										description: "Source - Applied configuration source"
										type:        "string"
									}
									type: {
										description: "Type - Resource type."
										type:        "string"
									}
									value: {
										description: "Value - Applied configuration value"
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
