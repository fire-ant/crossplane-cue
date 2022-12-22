package database_azure_crossplane_io_mysqlserverfirewallrules

customresourcedefinition: "mysqlserverfirewallrules.database.azure.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "mysqlserverfirewallrules.database.azure.crossplane.io"
	}
	spec: {
		group: "database.azure.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"azure",
			]
			kind:     "MySQLServerFirewallRule"
			listKind: "MySQLServerFirewallRuleList"
			plural:   "mysqlserverfirewallrules"
			singular: "mysqlserverfirewallrule"
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
				jsonPath: ".status.state"
				name:     "STATE"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1alpha3"
			schema: openAPIV3Schema: {
				description: "A MySQLServerFirewallRule is a managed resource that represents an Azure MySQL firewall rule."

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
						description: "A FirewallRuleSpec defines the desired state of an Azure SQL firewall rule."

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
								description: "FirewallRuleParameters define the desired state of an Azure SQL firewall rule."

								properties: {
									properties: {
										description: "FirewallRuleProperties - Resource properties."
										properties: {
											endIpAddress: {
												description: "EndIPAddress of the IP range this firewall rule allows."

												type: "string"
											}
											startIpAddress: {
												description: "StartIPAddress of the IP range this firewall rule allows."

												type: "string"
											}
										}
										required: [
											"endIpAddress",
											"startIpAddress",
										]
										type: "object"
									}
									resourceGroupName: {
										description: "ResourceGroupName - Name of the Firewall Rule's resource group."

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
										description: "ResourceGroupNameSelector - Selects a ResourceGroup to reference."

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
										description: "ServerName - Name of the Firewall Rule's server."
										type:        "string"
									}
									serverNameRef: {
										description: "ServerNameRef - A reference to the Firewall Rule's MySQLServer."

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
										description: "ServerNameSelector - Selects a MySQLServer to reference."
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
								}
								required: [
									"properties",
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
						description: "A FirewallRuleStatus represents the status of an Azure SQL firewall rule."

						properties: {
							atProvider: {
								description: "A FirewallRuleObservation represents the observed state of an Azure SQL firewall rule."

								properties: {
									id: {
										description: "ID - Resource ID"
										type:        "string"
									}
									type: {
										description: "Type - Resource type."
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
