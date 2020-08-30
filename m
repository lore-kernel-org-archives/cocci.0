Return-Path: <SRS0=72o0=CI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11293C433E2
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 06:50:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A902076D
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 06:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A902076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07U6o9jG024315;
	Sun, 30 Aug 2020 08:50:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D9BF27789;
	Sun, 30 Aug 2020 08:50:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 80F113F6C
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 08:50:06 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0008.hostedemail.com
 [216.40.44.8])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07U6o4V2020257
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 08:50:05 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id A0BE118012871
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 06:50:03 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id D9EAF181D341E
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 06:49:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shop91_3310ab427085
X-Filterd-Recvd-Size: 4648
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf05.hostedemail.com (Postfix) with ESMTPA
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 06:49:59 +0000 (UTC)
Message-ID: <de28becbfe76575b18c0bf47567b7f9c20f15f87.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: cocci <cocci@systeme.lip6.fr>
Date: Sat, 29 Aug 2020 23:49:58 -0700
Content-Type: multipart/mixed; boundary="=-S6zLDVSGvy6Ipw55xNez"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 30 Aug 2020 08:50:09 +0200 (CEST)
X-Greylist: Delayed for 50:31:00 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sun, 30 Aug 2020 08:50:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] transform oddity / bug ?
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


--=-S6zLDVSGvy6Ipw55xNez
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Is it me not understanding cocci grammar again?

Given these input and cocci script files:

Why isn't the show_test1 function transformed?
Why is only the show_test2 function transformed?

The only difference between the files is some
commented out lines with a for loop and if test.

$ cat test.c
static ssize_t test1_show(struct device *d,
		struct device_attribute *a,
		char *buffer)
{
	ssize_t rc = 0;

	for (cnt = 0; cnt < s_attr->size; cnt++) {
		if (cnt && !(cnt % 16)) {
			if (PAGE_SIZE - rc)
				buffer[rc++] = '\n';
		}

		rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "%02x ",
				((unsigned char *)s_attr->data)[cnt]);
	}
	return rc;
}

static ssize_t test2_show(struct device *d,
		struct device_attribute *a,
		char *buffer)
{
	ssize_t rc = 0;

//	for (cnt = 0; cnt < s_attr->size; cnt++) {
//		if (cnt && !(cnt % 16)) {
			if (PAGE_SIZE - rc)
				buffer[rc++] = '\n';
//		}
		rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "%02x ",
				((unsigned char *)s_attr->data)[cnt]);
//	}
	return rc;
}
$ cat sysfs_emit_rename.cocci
@@
identifier d_show =~ "^.*show.*$";
identifier arg1, arg2, arg3;
@@
ssize_t d_show(struct device *
-	arg1
+	dev
	, struct device_attribute *
-	arg2
+	attr
	, char *
-	arg3
+	buf
	)
{
	...
(
-	arg1
+	dev
|
-	arg2
+	attr
|
-	arg3
+	buf
)
	... when any
}
$ spatch -sp-file sysfs_emit_rename.cocci test.c 
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
HANDLING: test.c
diff = 
--- test.c
+++ /tmp/cocci-output-68270-4c9b1f-test.c
@@ -16,18 +16,18 @@ static ssize_t test1_show(struct device
 	return rc;
 }
 
-static ssize_t test2_show(struct device *d,
-		struct device_attribute *a,
-		char *buffer)
+static ssize_t test2_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
 {
 	ssize_t rc = 0;
 
 //	for (cnt = 0; cnt < s_attr->size; cnt++) {
 //		if (cnt && !(cnt % 16)) {
 			if (PAGE_SIZE - rc)
-				buffer[rc++] = '\n';
+				buf[rc++] = '\n';
 //		}
-		rc += scnprintf(buffer + rc, PAGE_SIZE - rc, "%02x ",
+		rc += scnprintf(buf + rc, PAGE_SIZE - rc, "%02x ",
 				((unsigned char *)s_attr->data)[cnt]);
 //	}
 	return rc;
$

--=-S6zLDVSGvy6Ipw55xNez
Content-Disposition: attachment; filename="test.c"
Content-Type: text/x-csrc; name="test.c"; charset="ISO-8859-1"
Content-Transfer-Encoding: base64

c3RhdGljIHNzaXplX3QgdGVzdDFfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkLAoJCXN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlICphLAoJCWNoYXIgKmJ1ZmZlcikKewoJc3NpemVfdCByYyA9IDA7CgoJZm9y
IChjbnQgPSAwOyBjbnQgPCBzX2F0dHItPnNpemU7IGNudCsrKSB7CgkJaWYgKGNudCAmJiAhKGNu
dCAlIDE2KSkgewoJCQlpZiAoUEFHRV9TSVpFIC0gcmMpCgkJCQlidWZmZXJbcmMrK10gPSAnXG4n
OwoJCX0KCgkJcmMgKz0gc2NucHJpbnRmKGJ1ZmZlciArIHJjLCBQQUdFX1NJWkUgLSByYywgIiUw
MnggIiwKCQkJCSgodW5zaWduZWQgY2hhciAqKXNfYXR0ci0+ZGF0YSlbY250XSk7Cgl9CglyZXR1
cm4gcmM7Cn0KCnN0YXRpYyBzc2l6ZV90IHRlc3QyX3Nob3coc3RydWN0IGRldmljZSAqZCwKCQlz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYSwKCQljaGFyICpidWZmZXIpCnsKCXNzaXplX3QgcmMg
PSAwOwoKLy8JZm9yIChjbnQgPSAwOyBjbnQgPCBzX2F0dHItPnNpemU7IGNudCsrKSB7Ci8vCQlp
ZiAoY250ICYmICEoY250ICUgMTYpKSB7CgkJCWlmIChQQUdFX1NJWkUgLSByYykKCQkJCWJ1ZmZl
cltyYysrXSA9ICdcbic7Ci8vCQl9CgkJcmMgKz0gc2NucHJpbnRmKGJ1ZmZlciArIHJjLCBQQUdF
X1NJWkUgLSByYywgIiUwMnggIiwKCQkJCSgodW5zaWduZWQgY2hhciAqKXNfYXR0ci0+ZGF0YSlb
Y250XSk7Ci8vCX0KCXJldHVybiByYzsKfQoK


--=-S6zLDVSGvy6Ipw55xNez
Content-Disposition: attachment; filename="sysfs_emit_rename.cocci"
Content-Type: text/plain; name="sysfs_emit_rename.cocci"; charset="ISO-8859-1"
Content-Transfer-Encoding: base64

QEAKaWRlbnRpZmllciBkX3Nob3cgPX4gIl4uKnNob3cuKiQiOwppZGVudGlmaWVyIGFyZzEsIGFy
ZzIsIGFyZzM7CkBACnNzaXplX3QgZF9zaG93KHN0cnVjdCBkZXZpY2UgKgotCWFyZzEKKwlkZXYK
CSwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKgotCWFyZzIKKwlhdHRyCgksIGNoYXIgKgotCWFy
ZzMKKwlidWYKCSkKewoJLi4uCigKLQlhcmcxCisJZGV2CnwKLQlhcmcyCisJYXR0cgp8Ci0JYXJn
MworCWJ1ZgopCgkuLi4gd2hlbiBhbnkKfQo=


--=-S6zLDVSGvy6Ipw55xNez
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--=-S6zLDVSGvy6Ipw55xNez--

