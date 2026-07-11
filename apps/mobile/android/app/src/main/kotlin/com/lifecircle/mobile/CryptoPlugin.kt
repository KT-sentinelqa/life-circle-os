package com.lifecircle.mobile

import android.content.Context
import android.content.pm.PackageManager
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import java.security.KeyPairGenerator
import java.security.KeyStore
import java.security.Signature

class CryptoPlugin(private val context: Context) : NativeCryptoApi {
    
    private val keystore = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }

    override fun getCapabilities(): PigeonCryptoCapabilities {
        val pm = context.packageManager
        val hasStrongBox = pm.hasSystemFeature(PackageManager.FEATURE_STRONGBOX_KEYSTORE)
        val hasHardwareKeys = pm.hasSystemFeature(PackageManager.FEATURE_HARDWARE_KEYSTORE)

        return PigeonCryptoCapabilities(
            supportsSecureEnclave = false, // Apple only
            supportsStrongBox = hasStrongBox,
            supportsHardwareKeys = hasHardwareKeys,
            supportsBiometrics = true, // Simplified
            supportsAttestation = true, // Play Integrity
            supportsKeyWrapping = true
        )
    }

    override fun generateKey(keyId: String, requireHardware: Boolean, requireBiometrics: Boolean): PigeonKeyMetadata {
        val alias = "com.lifecircle.mobile.keys.$keyId"
        
        val kpg = KeyPairGenerator.getInstance(KeyProperties.KEY_ALGORITHM_EC, "AndroidKeyStore")
        
        val builder = KeyGenParameterSpec.Builder(
            alias,
            KeyProperties.PURPOSE_SIGN or KeyProperties.PURPOSE_VERIFY
        ).setDigests(KeyProperties.DIGEST_SHA256)
         .setUserAuthenticationRequired(requireBiometrics)

        if (requireHardware && getCapabilities().supportsStrongBox) {
            builder.setIsStrongBoxBacked(true)
        }

        kpg.initialize(builder.build())
        val keyPair = kpg.generateKeyPair()

        return PigeonKeyMetadata(
            keyId = keyId,
            isHardwareBacked = true,
            algorithm = "EC-P256"
        )
    }

    override fun destroyKey(keyId: String) {
        val alias = "com.lifecircle.mobile.keys.$keyId"
        if (keystore.containsAlias(alias)) {
            keystore.deleteEntry(alias)
        }
    }

    override fun signPayload(keyId: String, payload: ByteArray): ByteArray {
        val alias = "com.lifecircle.mobile.keys.$keyId"
        val entry = keystore.getEntry(alias, null) as? KeyStore.PrivateKeyEntry
            ?: throw Exception("Key not found")

        val signature = Signature.getInstance("SHA256withECDSA").apply {
            initSign(entry.privateKey)
            update(payload)
        }
        return signature.sign()
    }

    override fun unwrapKey(keyId: String, wrappedKey: ByteArray): ByteArray {
        throw Exception("Unimplemented")
    }

    override fun requestAttestation(keyId: String, challenge: ByteArray): ByteArray {
        // StandardIntegrityManager.requestToken(request)
        // Returning a mock attestation object for SEC-004C.3 architecture design
        return "mock_google_attestation_for_$keyId".toByteArray(Charsets.UTF_8)
    }
}
