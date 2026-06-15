/**
 * Firebase Cloud Functions - Mishhal Commerce Hub
 *
 * auth/
 *   - verifyMsg91OtpAndGetCustomToken: OTP auth via Msg91
 *
 * inAppPurchase/
 *   - createInAppPurchaseOrder: Create pending Apple IAP transaction
 *   - inAppPurchaseWebhook: RevenueCat webhook handler for course allocation
 */

import * as admin from "firebase-admin";

admin.initializeApp();

export {verifyMsg91OtpAndGetCustomToken} from "./auth/verifyMsg91OtpAndGetCustomToken";
