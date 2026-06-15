import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

const USERS_COLLECTION = "users";

/** Normalize to E.164 (e.g. +919876543210) for Auth lookup. */
function normalizePhoneNumber(phone: string): string {
  const trimmed = phone.trim().replace(/\D/g, "");
  if (!trimmed.length) return phone;
  if (trimmed.length === 10 && trimmed[0] !== "0") {
    return `+91${trimmed}`;
  }
  if (trimmed.length === 12 && trimmed.startsWith("91")) {
    return `+${trimmed}`;
  }
  return `+${trimmed}`;
}

function setCorsHeaders(res: {
  set: (name: string, value: string) => void;
}): void {
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "POST, OPTIONS");
  res.set("Access-Control-Allow-Headers", "Content-Type");
}

export const verifyMsg91OtpAndGetCustomToken = functions.https.onRequest(
  async (req, res) => {
    setCorsHeaders(res);
    if (req.method === "OPTIONS") {
      res.status(204).send("");
      return;
    }

    try {
      let body: { msg91Token?: string } = {};
      if (typeof req.body === "string") {
        body = JSON.parse(req.body);
      } else if (req.body && typeof req.body === "object") {
        body = req.body;
      }

      const { msg91Token } = body;

      if (!msg91Token) {
        res.status(400).json({ error: "Missing msg91Token" });
        return;
      }

      const MSG91_AUTH_KEY = process.env.MSG91_AUTH_KEY || "";
      if (!MSG91_AUTH_KEY) {
        res.status(500).json({ error: "MSG91_AUTH_KEY not set" });
        return;
      }

      const msg91Res = await fetch(
        "https://control.msg91.com/api/v5/widget/verifyAccessToken",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: JSON.stringify({
            "authkey": MSG91_AUTH_KEY,
            "access-token": msg91Token,
          }),
        }
      );

      const msg91Data = (await msg91Res.json()) as { message?: string };
      functions.logger.info("Msg91 response", { msg91Data });

      if (!msg91Res.ok || !msg91Data?.message) {
        res.status(400).json({ error: "Invalid or expired OTP" });
        return;
      }

      const rawPhone = String(msg91Data.message ?? "").trim();
      const phoneNumber = normalizePhoneNumber(rawPhone);

      let userRecord: admin.auth.UserRecord;
      try {
        userRecord = await admin.auth().getUserByPhoneNumber(phoneNumber);
      } catch (error: unknown) {
        const firebaseError = error as { code?: string };
        if (firebaseError.code === "auth/user-not-found") {
          userRecord = await admin.auth().createUser({ phoneNumber });
          functions.logger.info("Created new Auth user", {
            uid: userRecord.uid,
            phoneNumber,
          });
        } else {
          throw error;
        }
      }

      const db = admin.firestore();
      const userDocRef = db.collection(USERS_COLLECTION).doc(userRecord.uid);
      const userDoc = await userDocRef.get();
      if (!userDoc.exists) {
        const minimalUser: Record<string, unknown> = {
          id: userRecord.uid,
          name: null,
          phoneNumber,
          keywords: [],
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        };
        await userDocRef.set(minimalUser);
        functions.logger.info("Created new user doc", { uid: userRecord.uid });
      }

      const firebaseToken = await admin
        .auth()
        .createCustomToken(userRecord.uid);

      res.status(200).json({ firebaseToken, phoneNumber });
    } catch (err: unknown) {
      const message =
        err instanceof Error ? err.message : "Internal server error";
      functions.logger.error("Error verifying OTP", err);
      res.status(500).json({ error: message });
    }
  }
);
