package ec2_aws_crossplane_io_securitygroups

customresourcedefinition: "securitygroups.ec2.aws.crossplane.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.8.0"
		creationTimestamp: null
		name:              "securitygroups.ec2.aws.crossplane.io"
	}
	spec: {
		group: "ec2.aws.crossplane.io"
		names: {
			categories: [
				"crossplane",
				"managed",
				"aws",
			]
			kind:     "SecurityGroup"
			listKind: "SecurityGroupList"
			plural:   "securitygroups"
			singular: "securitygroup"
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
				name:     "ID"
				type:     "string"
			}, {
				jsonPath: ".spec.forProvider.vpcId"
				name:     "VPC"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "AGE"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "A SecurityGroup is a managed resource that represents an AWS VPC Security Group."

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
						description: "A SecurityGroupSpec defines the desired state of a SecurityGroup."
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
								description: "SecurityGroupParameters define the desired state of an AWS VPC Security Group."

								properties: {
									description: {
										description: "A description of the security group."
										type:        "string"
									}
									egress: {
										description: "[EC2-VPC] One or more outbound rules associated with the security group."

										items: {
											description: "IPPermission Describes a set of permissions for a security group rule."

											properties: {
												fromPort: {
													description: "The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type number. A value of -1 indicates all ICMP/ICMPv6 types. If you specify all ICMP/ICMPv6 types, you must specify all codes."

													format: "int32"
													type:   "integer"
												}
												ipProtocol: {
													description: """
		The IP protocol name (tcp, udp, icmp, icmpv6) or number (see Protocol Numbers (http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml)). 
		 [VPC only] Use -1 to specify all protocols. When authorizing security group rules, specifying -1 or a protocol number other than tcp, udp, icmp, or icmpv6 allows traffic on all ports, regardless of any port range you specify. For tcp, udp, and icmp, you must specify a port range. For icmpv6, the port range is optional; if you omit the port range, traffic for all types and codes is allowed.
		"""

													type: "string"
												}
												ipRanges: {
													description: "The IPv4 ranges."
													items: {
														description: "IPRange describes an IPv4 range."
														properties: {
															cidrIp: {
																description: "The IPv4 CIDR range. You can either specify a CIDR range or a source security group, not both. To specify a single IPv4 address, use the /32 prefix length."

																type: "string"
															}
															description: {
																description: """
		A description for the security group rule that references this IPv4 address range. 
		 Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=&;{}!$*
		"""

																type: "string"
															}
														}
														required: [
															"cidrIp",
														]
														type: "object"
													}
													type: "array"
												}
												ipv6Ranges: {
													description: """
		The IPv6 ranges. 
		 [VPC only]
		"""
													items: {
														description: "IPv6Range describes an IPv6 range."
														properties: {
															cidrIPv6: {
																description: "The IPv6 CIDR range. You can either specify a CIDR range or a source security group, not both. To specify a single IPv6 address, use the /128 prefix length."

																type: "string"
															}
															description: {
																description: """
		A description for the security group rule that references this IPv6 address range. 
		 Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=&;{}!$*
		"""

																type: "string"
															}
														}
														required: [
															"cidrIPv6",
														]
														type: "object"
													}
													type: "array"
												}
												prefixListIds: {
													description: """
		PrefixListIDs for an AWS service. With outbound rules, this is the AWS service to access through a VPC endpoint from instances associated with the security group. 
		 [VPC only]
		"""

													items: {
														description: "PrefixListID describes a prefix list ID."
														properties: {
															description: {
																description: """
		A description for the security group rule that references this prefix list ID. 
		 Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*
		"""

																type: "string"
															}
															prefixListId: {
																description: "The ID of the prefix."
																type:        "string"
															}
														}
														required: [
															"prefixListId",
														]
														type: "object"
													}
													type: "array"
												}
												toPort: {
													description: "The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code. A value of -1 indicates all ICMP/ICMPv6 codes. If you specify all ICMP/ICMPv6 types, you must specify all codes."

													format: "int32"
													type:   "integer"
												}
												userIdGroupPairs: {
													description: "UserIDGroupPairs are the source security group and AWS account ID pairs. It contains one or more accounts and security groups to allow flows from security groups of other accounts."

													items: {
														description: "UserIDGroupPair describes a security group and AWS account ID pair."

														properties: {
															description: {
																description: """
		A description for the security group rule that references this user ID group pair. 
		 Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*
		"""

																type: "string"
															}
															groupId: {
																description: "The ID of the security group."
																type:        "string"
															}
															groupIdRef: {
																description: "GroupIDRef reference a security group to retrieve its GroupID"

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
															groupIdSelector: {
																description: "GroupIDSelector selects reference to a security group to retrieve its GroupID"

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
															groupName: {
																description: """
		The name of the security group. In a request, use this parameter for a security group in EC2-Classic or a default VPC only. For a security group in a nondefault VPC, use the security group ID. 
		 For a referenced security group in another VPC, this value is not returned if the referenced security group is deleted.
		"""

																type: "string"
															}
															userId: {
																description: """
		The ID of an AWS account. 
		 For a referenced security group in another VPC, the account ID of the referenced security group is returned in the response. If the referenced security group is deleted, this value is not returned. 
		 [EC2-Classic] Required when adding or removing rules that reference a security group in another AWS account.
		"""

																type: "string"
															}
															vpcId: {
																description: "The ID of the VPC for the referenced security group, if applicable."

																type: "string"
															}
															vpcIdRef: {
																description: "VPCIDRef reference a VPC to retrieve its vpcId"

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
															vpcIdSelector: {
																description: "VPCIDSelector selects reference to a VPC to retrieve its vpcId"

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
															vpcPeeringConnectionId: {
																description: "The ID of the VPC peering connection, if applicable."

																type: "string"
															}
														}
														type: "object"
													}
													type: "array"
												}
											}
											required: [
												"ipProtocol",
											]
											type: "object"
										}
										type: "array"
									}
									groupName: {
										description: "The name of the security group."
										type:        "string"
									}
									ignoreEgress: {
										description: "Dont manage the egress settings for the created resource"
										type:        "boolean"
									}
									ignoreIngress: {
										description: "Dont manage the ingress settings for the created resource"

										type: "boolean"
									}
									ingress: {
										description: "One or more inbound rules associated with the security group."

										items: {
											description: "IPPermission Describes a set of permissions for a security group rule."

											properties: {
												fromPort: {
													description: "The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type number. A value of -1 indicates all ICMP/ICMPv6 types. If you specify all ICMP/ICMPv6 types, you must specify all codes."

													format: "int32"
													type:   "integer"
												}
												ipProtocol: {
													description: """
		The IP protocol name (tcp, udp, icmp, icmpv6) or number (see Protocol Numbers (http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml)). 
		 [VPC only] Use -1 to specify all protocols. When authorizing security group rules, specifying -1 or a protocol number other than tcp, udp, icmp, or icmpv6 allows traffic on all ports, regardless of any port range you specify. For tcp, udp, and icmp, you must specify a port range. For icmpv6, the port range is optional; if you omit the port range, traffic for all types and codes is allowed.
		"""

													type: "string"
												}
												ipRanges: {
													description: "The IPv4 ranges."
													items: {
														description: "IPRange describes an IPv4 range."
														properties: {
															cidrIp: {
																description: "The IPv4 CIDR range. You can either specify a CIDR range or a source security group, not both. To specify a single IPv4 address, use the /32 prefix length."

																type: "string"
															}
															description: {
																description: """
		A description for the security group rule that references this IPv4 address range. 
		 Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=&;{}!$*
		"""

																type: "string"
															}
														}
														required: [
															"cidrIp",
														]
														type: "object"
													}
													type: "array"
												}
												ipv6Ranges: {
													description: """
		The IPv6 ranges. 
		 [VPC only]
		"""
													items: {
														description: "IPv6Range describes an IPv6 range."
														properties: {
															cidrIPv6: {
																description: "The IPv6 CIDR range. You can either specify a CIDR range or a source security group, not both. To specify a single IPv6 address, use the /128 prefix length."

																type: "string"
															}
															description: {
																description: """
		A description for the security group rule that references this IPv6 address range. 
		 Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=&;{}!$*
		"""

																type: "string"
															}
														}
														required: [
															"cidrIPv6",
														]
														type: "object"
													}
													type: "array"
												}
												prefixListIds: {
													description: """
		PrefixListIDs for an AWS service. With outbound rules, this is the AWS service to access through a VPC endpoint from instances associated with the security group. 
		 [VPC only]
		"""

													items: {
														description: "PrefixListID describes a prefix list ID."
														properties: {
															description: {
																description: """
		A description for the security group rule that references this prefix list ID. 
		 Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*
		"""

																type: "string"
															}
															prefixListId: {
																description: "The ID of the prefix."
																type:        "string"
															}
														}
														required: [
															"prefixListId",
														]
														type: "object"
													}
													type: "array"
												}
												toPort: {
													description: "The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code. A value of -1 indicates all ICMP/ICMPv6 codes. If you specify all ICMP/ICMPv6 types, you must specify all codes."

													format: "int32"
													type:   "integer"
												}
												userIdGroupPairs: {
													description: "UserIDGroupPairs are the source security group and AWS account ID pairs. It contains one or more accounts and security groups to allow flows from security groups of other accounts."

													items: {
														description: "UserIDGroupPair describes a security group and AWS account ID pair."

														properties: {
															description: {
																description: """
		A description for the security group rule that references this user ID group pair. 
		 Constraints: Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*
		"""

																type: "string"
															}
															groupId: {
																description: "The ID of the security group."
																type:        "string"
															}
															groupIdRef: {
																description: "GroupIDRef reference a security group to retrieve its GroupID"

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
															groupIdSelector: {
																description: "GroupIDSelector selects reference to a security group to retrieve its GroupID"

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
															groupName: {
																description: """
		The name of the security group. In a request, use this parameter for a security group in EC2-Classic or a default VPC only. For a security group in a nondefault VPC, use the security group ID. 
		 For a referenced security group in another VPC, this value is not returned if the referenced security group is deleted.
		"""

																type: "string"
															}
															userId: {
																description: """
		The ID of an AWS account. 
		 For a referenced security group in another VPC, the account ID of the referenced security group is returned in the response. If the referenced security group is deleted, this value is not returned. 
		 [EC2-Classic] Required when adding or removing rules that reference a security group in another AWS account.
		"""

																type: "string"
															}
															vpcId: {
																description: "The ID of the VPC for the referenced security group, if applicable."

																type: "string"
															}
															vpcIdRef: {
																description: "VPCIDRef reference a VPC to retrieve its vpcId"

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
															vpcIdSelector: {
																description: "VPCIDSelector selects reference to a VPC to retrieve its vpcId"

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
															vpcPeeringConnectionId: {
																description: "The ID of the VPC peering connection, if applicable."

																type: "string"
															}
														}
														type: "object"
													}
													type: "array"
												}
											}
											required: [
												"ipProtocol",
											]
											type: "object"
										}
										type: "array"
									}
									region: {
										description: "Region is the region you'd like your SecurityGroup to be created in."

										type: "string"
									}
									tags: {
										description: "Tags represents to current ec2 tags."
										items: {
											description: "Tag defines a tag"
											properties: {
												key: {
													description: "Key is the name of the tag."
													type:        "string"
												}
												value: {
													description: "Value is the value of the tag."
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
									vpcId: {
										description: "VPCID is the ID of the VPC."
										type:        "string"
									}
									vpcIdRef: {
										description: "VPCIDRef references a VPC to and retrieves its vpcId"
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
									vpcIdSelector: {
										description: "VPCIDSelector selects a reference to a VPC to and retrieves its vpcId"

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
									"description",
									"groupName",
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
						description: "A SecurityGroupStatus represents the observed state of a SecurityGroup."

						properties: {
							atProvider: {
								description: "SecurityGroupObservation keeps the state for the external resource"

								properties: {
									ownerId: {
										description: "The AWS account ID of the owner of the security group."
										type:        "string"
									}
									securityGroupID: {
										description: "SecurityGroupID is the ID of the SecurityGroup."
										type:        "string"
									}
								}
								required: [
									"ownerId",
									"securityGroupID",
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
