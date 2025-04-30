package br.com.roberto.msloaddatabase.application.payloads

import com.fasterxml.jackson.annotation.JsonProperty

data class Object (
    val key : String,
    val sequencer : String,
    val size : Int,
    val eTag : String
)
data class OwnerIdentity(
    val principalId: String
)

data class Bucket(
    val name: String,
    val ownerIdentity: OwnerIdentity,
    val arn: String
)

data class S3(
    val s3SchemaVersion: Double,
    val configurationId: String,
    val bucket: Bucket,
    @JsonProperty("object") val `object`: Object
)

data class ResponseElements(
    @JsonProperty("x-amz-request-id") val xAmzRequestId: String,
    @JsonProperty("x-amz-id-2") val xAmzId2: String
)

data class RequestParameters(
    val sourceIPAddress: String
)

data class UserIdentity(
    val principalId: String
)

data class Records(
    val eventVersion: Double,
    val eventSource: String,
    val awsRegion: String,
    val eventTime: String,
    val eventName: String,
    val userIdentity: UserIdentity,
    val requestParameters: RequestParameters,
    val responseElements: ResponseElements,
    val s3: S3
)

data class JsonReceiveMessage(
    @JsonProperty("Records") val records: List<Records>
)



