package kubernetes_crossplane_io_providerconfigs

customresourcedefinition: "providerconfigs.kubernetes.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "providerconfigs.kubernetes.crossplane.io"
	}
	spec: {
		group: "kubernetes.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"provider",
				"kubernetes",
			]
			kind:     "ProviderConfig"
			listKind: "ProviderConfigList"
			plural:   "providerconfigs"
			singular: "providerconfig"
		}
		scope: "Cluster"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}, {
				jsonPath: ".spec.credentials.secretRef.name"
				name:     "SECRET-NAME"
				priority: 1
				type:     "string"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "A ProviderConfig configures a Template provider."
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
						description: "A ProviderConfigSpec defines the desired state of a ProviderConfig."
						properties: {
							credentials: {
								description: "Credentials used to connect to the Kubernetes API. Typically a kubeconfig file. Use InjectedIdentity for in-cluster config."

								properties: {
									env: {
										description: "Env is a reference to an environment variable that contains credentials that must be used to connect to the provider."

										properties: name: {
											description: "Name is the name of an environment variable."
											type:        "string"
										}
										required: [
											"name",
										]
										type: "object"
									}
									fs: {
										description: "Fs is a reference to a filesystem location that contains credentials that must be used to connect to the provider."

										properties: path: {
											description: "Path is a filesystem path."
											type:        "string"
										}
										required: [
											"path",
										]
										type: "object"
									}
									secretRef: {
										description: "A SecretRef is a reference to a secret key that contains the credentials that must be used to connect to the provider."

										properties: {
											key: {
												description: "The key to select."
												type:        "string"
											}
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
											"key",
											"name",
											"namespace",
										]
										type: "object"
									}
									source: {
										description: "Source of the provider credentials."
										enum: [
											"None",
											"Secret",
											"InjectedIdentity",
											"Environment",
											"Filesystem",
										]
										type: "string"
									}
								}
								required: [
									"source",
								]
								type: "object"
							}
							identity: {
								description: "Identity used to authenticate to the Kubernetes API. The identity credentials can be used to supplement kubeconfig 'credentials', for example by configuring a bearer token source such as OAuth."

								properties: {
									env: {
										description: "Env is a reference to an environment variable that contains credentials that must be used to connect to the provider."

										properties: name: {
											description: "Name is the name of an environment variable."
											type:        "string"
										}
										required: [
											"name",
										]
										type: "object"
									}
									fs: {
										description: "Fs is a reference to a filesystem location that contains credentials that must be used to connect to the provider."

										properties: path: {
											description: "Path is a filesystem path."
											type:        "string"
										}
										required: [
											"path",
										]
										type: "object"
									}
									secretRef: {
										description: "A SecretRef is a reference to a secret key that contains the credentials that must be used to connect to the provider."

										properties: {
											key: {
												description: "The key to select."
												type:        "string"
											}
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
											"key",
											"name",
											"namespace",
										]
										type: "object"
									}
									source: {
										description: "Source of the provider credentials."
										enum: [
											"None",
											"Secret",
											"InjectedIdentity",
											"Environment",
											"Filesystem",
										]
										type: "string"
									}
									type: {
										description: "Type of identity."
										enum: [
											"GoogleApplicationCredentials",
										]
										type: "string"
									}
								}
								required: [
									"source",
									"type",
								]
								type: "object"
							}
						}
						required: [
							"credentials",
						]
						type: "object"
					}
					status: {
						description: "A ProviderConfigStatus reflects the observed state of a ProviderConfig."
						properties: {
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
							users: {
								description: "Users of this provider configuration."
								format:      "int64"
								type:        "integer"
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
