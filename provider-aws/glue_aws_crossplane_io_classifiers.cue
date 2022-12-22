package glue_aws_crossplane_io_classifiers

customresourcedefinition: "classifiers.glue.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "classifiers.glue.aws.crossplane.io"
	}
	spec: {
		group: "glue.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "Classifier"
			listKind: "ClassifierList"
			plural:   "classifiers"
			singular: "classifier"
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
				description: "Classifier is the Schema for the Classifiers API"
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
						description: "ClassifierSpec defines the desired state of Classifier"
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
								description: "ClassifierParameters defines the desired state of Classifier"
								properties: {
									csvClassifier: {
										description: "A CSVClassifier object specifying the classifier to create."

										properties: {
											allowSingleColumn: {
												description: "Enables the processing of files that contain only one column."

												type: "boolean"
											}
											containsHeader: {
												description: "Indicates whether the CSV file contains a header. UNKNOWN = \"Detect headings\" PRESENT = \"Has headings\" ABSENT = \"No headings\""

												enum: [
													"UNKNOWN",
													"PRESENT",
													"ABSENT",
												]
												type: "string"
											}
											delimiter: {
												description: "A custom symbol to denote what separates each column entry in the row."

												type: "string"
											}
											disableValueTrimming: {
												description: "Specifies not to trim values before identifying the type of column values. The default value is true."

												type: "boolean"
											}
											header: {
												description: "A list of strings representing column names."
												items: type: "string"
												type: "array"
											}
											quoteSymbol: {
												description: "A custom symbol to denote what combines content into a single column value. Must be different from the column delimiter."

												type: "string"
											}
										}
										type: "object"
									}
									grokClassifier: {
										description: "A GrokClassifier object specifying the classifier to create."

										properties: {
											classification: {
												description: "An identifier of the data format that the classifier matches, such as Twitter, JSON, Omniture logs, Amazon CloudWatch Logs, and so on."

												type: "string"
											}
											customPatterns: {
												description: "Optional custom grok patterns used by this classifier."
												type:        "string"
											}
											grokPattern: {
												description: "The grok pattern used by this classifier."
												type:        "string"
											}
										}
										required: [
											"classification",
											"grokPattern",
										]
										type: "object"
									}
									jsonClassifier: {
										description: "A JsonClassifier object specifying the classifier to create."

										properties: jsonPath: {
											description: "A JsonPath string defining the JSON data for the classifier to classify. Glue supports a subset of JsonPath, as described in Writing JsonPath Custom Classifiers (https://docs.aws.amazon.com/glue/latest/dg/custom-classifier.html#custom-classifier-json)."

											type: "string"
										}
										type: "object"
									}
									region: {
										description: "Region is which region the Classifier will be created."
										type:        "string"
									}
									xmlClassifier: {
										description: "A XMLClassifier object specifying the classifier to create."

										properties: {
											classification: {
												description: "An identifier of the data format that the classifier matches. Classification is a required field"

												type: "string"
											}
											rowTag: {
												description: "The XML tag designating the element that contains each record in an XML document being parsed. This can't identify a self-closing element (closed by />). An empty row element that contains only attributes can be parsed as long as it ends with a closing tag (for example, <row item_a=\"A\" item_b=\"B\"></row> is okay, but <row item_a=\"A\" item_b=\"B\" /> is not)."

												type: "string"
											}
										}
										required: [
											"classification",
										]
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
						description: "ClassifierStatus defines the observed state of Classifier."
						properties: {
							atProvider: {
								description: "ClassifierObservation defines the observed state of Classifier"
								properties: {
									creationTime: {
										description: "The time that this classifier was registered."
										format:      "date-time"
										type:        "string"
									}
									lastUpdated: {
										description: "The time that this classifier was last updated."
										format:      "date-time"
										type:        "string"
									}
									version: {
										description: "The version of this classifier."
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
