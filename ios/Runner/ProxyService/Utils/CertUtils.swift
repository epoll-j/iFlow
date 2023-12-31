//
//  CertUtils.swift
//  Runner
//
//  Created by Dubhe on 2023/8/20.
//

import Foundation
import NIO
import CNIOBoringSSL
import NIOSSL

let cert = [UInt8]("""
-----BEGIN CERTIFICATE-----
MIID8zCCAtugAwIBAgIUWKCMdjKleDUyMCqsHGxtOPCWFzowDQYJKoZIhvcNAQEL
BQAwgZoxCzAJBgNVBAYTAlpIMRIwEAYDVQQIDAlHdWFuZ0RvbmcxEjAQBgNVBAcM
CUd1YW5nWmhvdTEOMAwGA1UECgwFaWZsb3cxEzARBgNVBAsMCmlmbG93Lm1vYmkx
HDAaBgNVBAMME21vYmkuaWZsb3cubWl0bS1hcHAxIDAeBgkqhkiG9w0BCQEWEWVw
b2xsQGZveG1haWwuY29tMB4XDTIzMTIzMDE0MzAxM1oXDTI0MTIyOTE0MzAxM1ow
gZoxCzAJBgNVBAYTAlpIMRIwEAYDVQQIDAlHdWFuZ0RvbmcxEjAQBgNVBAcMCUd1
YW5nWmhvdTEOMAwGA1UECgwFaWZsb3cxEzARBgNVBAsMCmlmbG93Lm1vYmkxHDAa
BgNVBAMME21vYmkuaWZsb3cubWl0bS1hcHAxIDAeBgkqhkiG9w0BCQEWEWVwb2xs
QGZveG1haWwuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwJz+
QOVWqQsRrgGlh0PLOPxTBrCHGJqD8PMSHYHrlZBhzTTIKCSVutQuksEPBXpTU1eR
WNWHqeDDhdT0V0egWqqOqEDAr8p+w1Zq4BHOnzBx6khfSt3G/zfnuYyZloSJvk/A
O+9PpOZa+mA28FgZlhssLqlsdGEXYSN0KJP/+fCNAZZcj8t/qhWqiW4d1BFgGRpb
PAhaFc8W9nGeuHX0nt7QGdssAnyTiuwZJNNRQ3zd14eYlqSk/YWK1iavhe8MPwbP
ASGCO+SuEEHkS1KEele1vCmlJVdkg437yUcjFfSpMw3qUK/G/snBIN4r9vIYsO77
5xebdZyWL9QfHD/vsQIDAQABoy8wLTAMBgNVHRMEBTADAQH/MB0GA1UdDgQWBBR9
1b3d+3D1szs4AHd8So/Ie5KT3DANBgkqhkiG9w0BAQsFAAOCAQEAXdzbjZQ6Xnar
9CveRwNiqb0tQxrlpSgPJ8LrZ5tCxL9pa1MAyNb4ZA7X6gxqnFrEThInbgP6MT+l
s3PCsCxwm+KpJ+TO+ulZPOoNq80og/d2NHgkrvY5llPj5xNn0aotO3n9qREG9hUV
p/bdo6pGbDPr8nbY4mP/PRn9rhspWG7mTvk5K+XpJMS90WwHFd3PLbDqmaBZyv3o
nPMmyftQzq0/WrF4FozQX+fvBaDIZMp2DRfDugaU9n88zG1b55iUePpAlpfWu6lV
CR4+wh2SVj6tnDbHJ61zEH15e0Yy9PDJq0xsJohbCdYuY/Vb6D4T1IFSU0IRWvUQ
hZJzLtca/Q==
-----END CERTIFICATE-----
""".utf8)

let privateKey = [UInt8]("""
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAwJz+QOVWqQsRrgGlh0PLOPxTBrCHGJqD8PMSHYHrlZBhzTTI
KCSVutQuksEPBXpTU1eRWNWHqeDDhdT0V0egWqqOqEDAr8p+w1Zq4BHOnzBx6khf
St3G/zfnuYyZloSJvk/AO+9PpOZa+mA28FgZlhssLqlsdGEXYSN0KJP/+fCNAZZc
j8t/qhWqiW4d1BFgGRpbPAhaFc8W9nGeuHX0nt7QGdssAnyTiuwZJNNRQ3zd14eY
lqSk/YWK1iavhe8MPwbPASGCO+SuEEHkS1KEele1vCmlJVdkg437yUcjFfSpMw3q
UK/G/snBIN4r9vIYsO775xebdZyWL9QfHD/vsQIDAQABAoIBABGHeCAsfv7dZ1uA
V4cq5U4nWzWq+nCDx2mLRY/H6MpwxxB83ZEXBfATKrXnugKT8mINqx2m4999pBhZ
nBnBXAJEWWf4lKYAS28Nk1EXGHMmXoelfylPa7KDF6SsULdWZ+QZBUlZwH7PtAyV
6woOioLoWtSto0AoLI+GQXuxPxozi2oGSh92bg+tjlW1icutNmJtwNAF+tgYDLJ5
XBsN2MJ4UkyPUCpslmfMgWbfDp7fWmy+05K5+PfV65q7ajoyw3GB0zf9ar22NqwX
p+72mII6PS+VXg3OoYykReIEU269lXG6+wpN9eQRAMhiRt7wTXYpw7O2Y79IfUpa
zWPaUG0CgYEA5on0ViqTtblX1zJxlpzop7QMMwCmXi5j2sA+mKFR7cP7qzY/qsLw
elY0Gv0ItVv/LcRYU+zwwHD/Jn4EKY5BWhXL7KRtMzA8YDt7wYkhpWP8oIinhq+y
ART8Lz8rwgEasaJ1v9YE5Sa3/TPrreioZyp+kDuNu3SKsB/+CS9FOVMCgYEA1eLD
oF3XGz518f0oEnkk03rA5t8jbIq9rsMJovdWdB7QkaEjYOV+W0Kkvauy93H43/xa
kAnaTnz6Tg3db2vpQhhLAYgDhn637OaLN6KI6ZUHZWpWrvDyALqI0fMSCBZeB4+p
FkPbN9ReTSibIrV9T6wLEtvSWaicueNANrCZ3msCgYBvDMr+6rmGUwaGKc1fgKvt
hKRPuSNqwKvnBq3gdezyPHKxcYtPpWGTfIzS50pXmj4cfLUTkFIUURoHH7K/lb/T
NiaqEjZr7vNWY7DkdDsZ4UUiy1DvZxi2vrYPyD060a9bG+fehaiL/Y+pT2ZaunTM
ZULcFWPbhXL9Dhwfrn6I8wKBgQDVEeT+Md2jJ1MJ8b7kwEg+YNAgbnP0ojYaDfPg
o/M9FKGEIfmDgrugoEBLLuvHc4ORZuy1BwuyGvCjp05LvD2P+XFnIh8Y8c26M2TG
1KT9xNesYQXfmuoKbcj1FeeFpPqhH607H/gXovkadnQtXI1sPCB/9fqUFNOkns2O
bdmq5wKBgFIOe9ucrQqsx59lSLzoWT6HYzX+6FSsrIH/QcBSGPeuY1HNff3Gc7nb
hxhujx4OysjlHZjiDt4nw9Y/LnTsl4mARs7wC3bYWF+r7rcdcWMiZhU/QgbCNK0T
WnAKEhI/tjlJoTfcvF9GndrtDp5n9Xgp/11muMaxIxKlxMbWD3AF
-----END RSA PRIVATE KEY-----
""".utf8)

public class CertUtils: NSObject {
    
    private static let certificate: NIOSSLCertificate = try! NIOSSLCertificate(bytes: cert, format: .pem)
    public static var certPool = NSMutableDictionary()
    
    public static func generateSelfSignedCert(host: String) -> NIOSSLCertificate {
        let pkey = getPrivateKeyPointer(bytes: privateKey)
        let x: OpaquePointer = CNIOBoringSSL_X509_new()!
        CNIOBoringSSL_X509_set_version(x, 2)
        let subject = CNIOBoringSSL_X509_NAME_new()
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "C", MBSTRING_ASC, "SE", -1, -1, 0);
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "ST", MBSTRING_ASC, "", -1, -1, 0);
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "L", MBSTRING_ASC, "", -1, -1, 0);
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "O", MBSTRING_ASC, "Tomduck", -1, -1, 0);
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "OU", MBSTRING_ASC, "", -1, -1, 0);
        CNIOBoringSSL_X509_NAME_add_entry_by_txt(subject, "CN", MBSTRING_ASC, host, -1, -1, 0);

        var serial = randomSerialNumber()
        CNIOBoringSSL_X509_set_serialNumber(x, &serial)
        
        let notBefore = CNIOBoringSSL_ASN1_TIME_new()!
        var now = time(nil)
        CNIOBoringSSL_ASN1_TIME_set(notBefore, now)
        CNIOBoringSSL_X509_set_notBefore(x, notBefore)
        CNIOBoringSSL_ASN1_TIME_free(notBefore)
        
        now += 60 * 60 * 60  // Give ourselves an hour
        let notAfter = CNIOBoringSSL_ASN1_TIME_new()!
        CNIOBoringSSL_ASN1_TIME_set(notAfter, now)
        CNIOBoringSSL_X509_set_notAfter(x, notAfter)
        CNIOBoringSSL_ASN1_TIME_free(notAfter)
        
        CNIOBoringSSL_X509_set_pubkey(x, pkey)
        
        CNIOBoringSSL_X509_set_issuer_name(x, CNIOBoringSSL_X509_get_subject_name(certificate.ref))
        CNIOBoringSSL_X509_set_subject_name(x, subject)
        CNIOBoringSSL_X509_NAME_free(subject)
        addExtension(x509: x, nid: NID_basic_constraints, value: "critical,CA:FALSE")
        addExtension(x509: x, nid: NID_subject_key_identifier, value: "hash")
        addExtension(x509: x, nid: NID_subject_alt_name, value: "DNS:\(host)")
        addExtension(x509: x, nid: NID_ext_key_usage, value: "serverAuth,OCSPSigning")
        
        CNIOBoringSSL_X509_sign(x, pkey, CNIOBoringSSL_EVP_sha256())
        
        let copyCrt = CNIOBoringSSL_X509_dup(x)!
        let cert = NIOSSLCertificate(withOwnedReference: copyCrt)
        CNIOBoringSSL_X509_free(x)
        
        return cert
    }
    
    private static func randomSerialNumber() -> ASN1_INTEGER {
        let bytesToRead = 20
        let fd = open("/dev/urandom", O_RDONLY)
        precondition(fd != -1)
        defer {
            close(fd)
        }

        var readBytes = Array.init(repeating: UInt8(0), count: bytesToRead)
        let readCount = readBytes.withUnsafeMutableBytes {
            return read(fd, $0.baseAddress, bytesToRead)
        }
        precondition(readCount == bytesToRead)

        // Our 20-byte number needs to be converted into an integer. This is
        // too big for Swift's numbers, but BoringSSL can handle it fine.
        let bn = CNIOBoringSSL_BN_new()
        defer {
            CNIOBoringSSL_BN_free(bn)
        }
        
        _ = readBytes.withUnsafeBufferPointer {
            CNIOBoringSSL_BN_bin2bn($0.baseAddress, $0.count, bn)
        }

        // We want to bitshift this right by 1 bit to ensure it's smaller than
        // 2^159.
        CNIOBoringSSL_BN_rshift1(bn, bn)

        // Now we can turn this into our ASN1_INTEGER.
        var asn1int = ASN1_INTEGER()
        CNIOBoringSSL_BN_to_ASN1_INTEGER(bn, &asn1int)

        return asn1int
    }
    
    private static func getPrivateKeyPointer(bytes: [UInt8]) -> OpaquePointer {
        let ref = bytes.withUnsafeBytes { (ptr) -> OpaquePointer? in
            let bio = CNIOBoringSSL_BIO_new_mem_buf(ptr.baseAddress!, ptr.count)!
            defer {
                CNIOBoringSSL_BIO_free(bio)
            }
            
            return CNIOBoringSSL_PEM_read_bio_PrivateKey(bio, nil, nil, nil)
        }
        
        return ref!
    }
    
    private static func addExtension(x509: OpaquePointer, nid: CInt, value: String) {
        var extensionContext = X509V3_CTX()
        
        CNIOBoringSSL_X509V3_set_ctx(&extensionContext, x509, x509, nil, nil, 0)
        let ext = value.withCString { (pointer) in
            return CNIOBoringSSL_X509V3_EXT_nconf_nid(nil, &extensionContext, nid, UnsafeMutablePointer(mutating: pointer))
        }!
        CNIOBoringSSL_X509_add_ext(x509, ext, -1)
        CNIOBoringSSL_X509_EXTENSION_free(ext)
    }
}
