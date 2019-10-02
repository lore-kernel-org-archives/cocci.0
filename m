Return-Path: <SRS0=3rke=X3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7DEC4360C
	for <cocci@archiver.kernel.org>; Wed,  2 Oct 2019 21:05:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A97217D7
	for <cocci@archiver.kernel.org>; Wed,  2 Oct 2019 21:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="iPH9X1Os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A97217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x92L5RvB021452;
	Wed, 2 Oct 2019 23:05:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5F06077B4;
	Wed,  2 Oct 2019 23:05:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7F58077B2
 for <cocci@systeme.lip6.fr>; Wed,  2 Oct 2019 23:05:25 +0200 (CEST)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.40])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x92L5OgN022223
 for <cocci@systeme.lip6.fr>; Wed, 2 Oct 2019 23:05:25 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 0AB86B80
 for <cocci@systeme.lip6.fr>; Wed,  2 Oct 2019 23:05:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-language:content-type:content-type:mime-version:date
 :date:message-id:subject:subject:from:from:received:received
 :received; s=dkim20160331; t=1570050323; x=1571864724; bh=qOEUr+
 XdyQd4F6z7+DltaC7xfNRHoJrJqcMxR1Y+POI=; b=iPH9X1Osci+yPNCVXyJlfj
 xXrXxomxzOlgAGJjLWyZ1JENQDBH8MgLKLyqsqv0o54ZfBsLaO1egFbCihnbL2Bk
 FJiUqHx20SCnp2j33vQn1kQr/ZkSVHUF4kY/xyCjOV6I2xcw41OyQObHZwcVIT+8
 eTGT+/t3n56BvYHBLhQ5kiPOFWE7RonpP8+b3hpBTjUtZ41yRTwqfOznlPIDPxhp
 umlq3XWfdf2myWCkMSfkliUe7yeWhAm5kBBUlKM/7h6EpuqJnMCeIDa4+ir6A4iq
 OIQMI/iQiR8DwOdyvjQhlPMEmrCacLsTDTYT3O/VNLjI8zS5QYQ36mbdLhWxSAGa
 zXaxqwpFAwACCY6fwhxnnbXPjNhgbaP5G4fsLtZHseRwWkAD605S5W41od1NEhQ4
 jY+XlU2WwZgerCs/n3Hrk2lls11mPgJbslwCwQcGy4XnskbnZKcLGFpYL83cEwcS
 RAz3lYdy4zL9iDGRGvwkZCKdGtaEb762eEfk8HkBLCgnZQW+C7TykuNlV5UHSWzo
 83eEHOhNXtBpQRUxFn2+slbSjOnrVERDVyF8Ytm/3qb8fs7lE9bg7sz0i+L8uWsW
 CLRcvmmmj1kSzfW/GB51seIIBOtrniyJ25tB7Z9VqaC4DUXIIEdYMaYyvFq14uWe
 Pnj3ADsPOwF9oWaNQFbfs=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zjbr_lZLjhXJ for <cocci@systeme.lip6.fr>;
 Wed,  2 Oct 2019 23:05:23 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 7F46217E
 for <cocci@systeme.lip6.fr>; Wed,  2 Oct 2019 23:05:23 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
 by int-mx003.mykolab.com (Postfix) with ESMTPS id 46B4BBAF
 for <cocci@systeme.lip6.fr>; Wed,  2 Oct 2019 23:05:23 +0200 (CEST)
To: Coccinelle <cocci@systeme.lip6.fr>
From: Michael Stefaniuc <mstefani@mykolab.com>
Autocrypt: addr=mstefani@mykolab.com; prefer-encrypt=mutual; keydata=
 mQGiBEBzHYsRBACu8uw/xP4j/RYT/HBhw46jwNx9tJaHUADksKmmNRMVnpAX768sVFOMz+rO
 4Zfx0pGoaMrfw5yCh3v+fwh7hh8mMutZ6HmtOZho10hd/Kp+1JSpFDVP5b92ATr2Yexd+SXz
 jSbCDGLjGGpPWEEtNzu4UhdRwIIymdQqVTx6aCvscwCgvsbD+M9kmUWdToQI/H6QYsNBmukD
 /iPmBemMiw69xBzH+pLCpfdlnundj/ZXXdUO86Br6reg9q5m5Vv4ClyTHMIXcd6Dnm43S2Z9
 OvCDwtBMm+Hu5H89/B6E0NSyknn7CMciD3bLklFGQl4isyF+6Gnd5MTr1cM1Pm0EtYmCAdhK
 +h9SW2NWnPQOr2b3KRrn6rFRumTqA/0YDv8IvVRQZjv9DqK4YP7/va7GGUJHS44ksPyHuQXI
 gZVvHgE5ntSjBeUULoTk6vY55JTdgj3w2BdW9zvjUD9O7kDCf/sx74YvInw3bHsTDo4C7mr3
 QPWIVHKF63dElZwTNL+W0pzwDi6nBnu6RGpiQgI6gktIE13ySF1HjoKAjbQ1TWljaGFlbCBT
 dGVmYW5pdWMgKGVuYyBwd2Qga2V5KSA8bXN0ZWZhbmlAcmVkaGF0LmNvbT6IXwQTEQIAHwQL
 BwMCAxUCAwMWAgECHgECF4AFAlNET0gFCRw3Mz0ACgkQ0ei8kcpE1VFHMgCgtPjwlA34jJ2F
 a1TPymfo6IGo9y4Anj05IAwUKKSPJez3LojfovAYMEry
Message-ID: <c0801ee0-c227-5d9d-50ff-3ad872621808@mykolab.com>
Date: Wed, 2 Oct 2019 23:05:03 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------28BB4BDB3A56A5EDD970C1C5"
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 02 Oct 2019 23:05:27 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 02 Oct 2019 23:05:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Missing support in SmPL for wide char character constants
 and string literals
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

This is a multi-part message in MIME format.
--------------28BB4BDB3A56A5EDD970C1C5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello!

SmPL doesn't support the character constants of the form:
u'c', U'c', L'c'

nor the string literals of the form:
u8"", u"", U"", L""

A test case is attached as a patch for the coccinelle tests.

minus: parse error:
  File "tests/wchar.cocci", line 8, column 22, charpos = 106
  around = ''',
  whole content = - char16_t zero = u'\0';


thanks
bye
	michael

--------------28BB4BDB3A56A5EDD970C1C5
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Add-test-for-wide-char-character-constants-and-strin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-test-for-wide-char-character-constants-and-strin.pa";
 filename*1="tch"

From 5e96aa0f530f1bac644b0a38fff512b22c2d52a3 Mon Sep 17 00:00:00 2001
From: Michael Stefaniuc <mstefani@mykolab.com>
Date: Wed, 2 Oct 2019 22:50:10 +0200
Subject: [PATCH] Add test for wide char character constants and string
 literals

Signed-off-by: Michael Stefaniuc <mstefani@mykolab.com>
---
 tests/wchar.c     | 13 +++++++++++++
 tests/wchar.cocci | 29 +++++++++++++++++++++++++++++
 tests/wchar.res   |  4 ++++
 3 files changed, 46 insertions(+)
 create mode 100644 tests/wchar.c
 create mode 100644 tests/wchar.cocci
 create mode 100644 tests/wchar.res

diff --git a/tests/wchar.c b/tests/wchar.c
new file mode 100644
index 00000000..0fde305a
--- /dev/null
+++ b/tests/wchar.c
@@ -0,0 +1,13 @@
+#include <stddef.h>
+#include <uchar.h>
+int main () {
+    char zero = '\0';
+    char16_t zero_utf16 = u'\0';
+    char32_t zero_utf32 = U'\0';
+    wchar_t zeroL = L'\0';
+    char empty[] = "";
+    char empty_utf8[] = u8"";
+    char16_t empty_utf16[] = u"";
+    char32_t empty_utf32[] = U"";
+    wchar_t emptyL[] = L"";
+}
diff --git a/tests/wchar.cocci b/tests/wchar.cocci
new file mode 100644
index 00000000..cdb6cb44
--- /dev/null
+++ b/tests/wchar.cocci
@@ -0,0 +1,29 @@
+@@
+typedef char16_t, char32_t, wchar_t;
+identifier zero;
+@@
+(
+- char zero = '\0';
+|
+- char16_t zero = u'\0';
+|
+- char32_t zero = U'\0';
+|
+- wchar_t zero = L'\0';
+)
+
+
+@@
+identifier empty;
+@@
+(
+- char empty[] = "";
+|
+- char empty[] = u8""
+|
+- char16_t empty[] = u"";
+|
+- char32_t empty[] = U"";
+|
+- wchar_t empty[] = L"";
+)
diff --git a/tests/wchar.res b/tests/wchar.res
new file mode 100644
index 00000000..aa1f2134
--- /dev/null
+++ b/tests/wchar.res
@@ -0,0 +1,4 @@
+#include <stddef.h>
+#include <uchar.h>
+int main () {
+}
-- 
2.20.1


--------------28BB4BDB3A56A5EDD970C1C5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------28BB4BDB3A56A5EDD970C1C5--
