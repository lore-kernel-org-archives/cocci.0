Return-Path: <SRS0=eKzF=QV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A93C43381
	for <cocci@archiver.kernel.org>; Thu, 14 Feb 2019 21:13:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C5F218FF
	for <cocci@archiver.kernel.org>; Thu, 14 Feb 2019 21:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="Dehnr8ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C5F218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1ELDBM3008854
          ; Thu, 14 Feb 2019 22:13:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 67F1776FA;
	Thu, 14 Feb 2019 22:13:11 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 91F5476F4
 for <cocci@systeme.lip6.fr>; Thu, 14 Feb 2019 22:13:09 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1ELD7fK026254
 for <cocci@systeme.lip6.fr>; Thu, 14 Feb 2019 22:13:08 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 83A9E14FA
 for <cocci@systeme.lip6.fr>; Thu, 14 Feb 2019 22:13:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-language:content-type:content-type:mime-version:date
 :date:message-id:subject:subject:from:from:received:received
 :received; s=dkim20160331; t=1550178786; x=1551993187; bh=1Atiqm
 NXGERz4XbWGFeS0N8EUjSLOQ2v9kFunUbE7Vw=; b=Dehnr8eizUXFxNLlKeB2av
 cEcLtvoA0iduJaYKiutTrkf1NX5IMelibHSXsybWAdALlVL6MtN1zfYR74319jEn
 AjyvtEahZLBIKDZxS84Gag9DaA/7sm09sT8HOfGbx1udmWcPfQPEIpmsGl4KWp0b
 LwfxH3/h/RRZp4pXcqx+j7ykuI8ysli9W5bFArf7atAQY8VizLx0HCXgD/DLZ9ev
 ivmPOmmq49axcOVfeJlkXmmz108yhu3VD9f5cSa93p3/g2RJD1kUkygRSn/W3pHy
 P56OdxKZmaO6s4dvO/ws0j8vkSLEXudSHTwJ5PieHoAYQmxfOzRJOBQMoQLi/71r
 s1MURbFST7I3DNKWalY+bnDhV3Fdzva48sOQNiEce2kV/8uN+XaU/+tm4B1hndU8
 LbXlu2e4LiLDfTdyk21vHrGoT3ua6EJwgk8K0b8V4iONSW0AX5gHsn0qnbwBZH7U
 CX/okujxtwDjq19yKG463p3pgxHb9KSYXRBG88kequMLfHFyBIS7oTLrDcHsY55v
 HIUAfFDr/SYYLajbRrIzPGTktqdGJXyJLTobhirdsGfKuSeldSxzPZYnkrEG0lo3
 Fo6Tcu9D0zKyzNy4vfS4GboiBl6v9Hb1sUhu8dzFOzME/rv5dxZyoF7GbVdLKrL6
 Xj/8EFdgBHjDAe1BtDfvU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7bim3cmCFfUu for <cocci@systeme.lip6.fr>;
 Thu, 14 Feb 2019 22:13:06 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
 by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 81FF7E7F
 for <cocci@systeme.lip6.fr>; Thu, 14 Feb 2019 22:13:06 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
 by int-mx002.mykolab.com (Postfix) with ESMTPS id 6C0DC25C4
 for <cocci@systeme.lip6.fr>; Thu, 14 Feb 2019 22:13:06 +0100 (CET)
To: cocci@systeme.lip6.fr
From: Michael Stefaniuc <mstefani@mykolab.com>
Openpgp: preference=signencrypt
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
 a1TPymfo6IGo9y4Anj05IAwUKKSPJez3LojfovAYMEryuQINBFNETU8BEAD2GkRuwYIX8RZt
 rxtlr5m3mVvxeW4k+Zq7LfFDJ4tGFDDIQAGWPK1RfljVjvPSPxzsoj+KynXnIqw9e6PoSNg3
 tDMQaKvaLpzAKRUZIRJrIdCNuXQxvVI6Jxgg3GVbFider//67y+8rBJE5+QZp5zaIS4ifm90
 9NnHtOvr0ddJ1r26IwOo8/Pyg7y+bTN/Xuu5qr/zOeTcdJMtaQ2kbBh3IU2FSRGvUZTG9UNg
 aU54KKX7+Zu3cziEK87r89Y1fZTr0rZfdQNaUwivxHY4nOXN+EAFl3mfaHnYIsdSDG3mqza8
 RgoqLJpOGvl0JVlyYI9jgOvi05q+kFzGlZj1raAgnImzXh3p2se1sxUuXrmYkQt9b9OrFiCf
 XYuWEVgNoW6qpmzYHkjOGBcATANhv9JBoNbMQEsg7oeyeCZzI3se8yXkif89NLB3MmLFHcPV
 ui8Pv/6Y9/MAHq6ohM7AVJtOKt21jsb8R+Me3k5BoHkdU3iUAviScLKqiR5v5eL084gZtijv
 2ZgGfw1bNcX3y7VYsw5omvw042uGxzA76tm9hRjxDKK9OA/GAtkv20gusA4fZXUSuy7RRJ8N
 T7U24WD4lRLCBjkNnV4izQHr9qwM6I/5/jP8mguRSL7HguxBLcyL7ZQ01aQALcc43v/p5Vw4
 96b3Et/nZrVw04xtwwvuhQARAQABiE8EGBECAA8CGwwFAlNET6oFCQlmA9sACgkQ0ei8kcpE
 1VGjvgCfWX5kaF0YptgUFItMH6U8kA6vnRsAoJkVZPLvJDyYi4TiEaZXyk+3DKPf
Message-ID: <fb42aa05-f4d0-53cb-7eda-4f0a5db6cd3c@mykolab.com>
Date: Thu, 14 Feb 2019 22:12:55 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------FDEC7820FFC77E141FADCC56"
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 14 Feb 2019 22:13:12 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 14 Feb 2019 22:13:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Qualifiers for field types get lost
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
--------------FDEC7820FFC77E141FADCC56
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello,

I have this trivial script to remove useless casts to self:
@ disable drop_cast @
type T;
T E;
@@
- (T)
     E

It works but I'm hitting false positives when the code casts away
qualifiers for field types. Please see the attached test case:
- Good: Cast is kept in foo()
- Bad: Cast is dropped in baz()

Applying the generated diff will lead to a gcc warning:
$ gcc -c  qualifier.c
qualifier.c: In function ‘baz’:
qualifier.c:12:12: warning: return discards ‘const’ qualifier from
pointer target type [-Wdiscarded-qualifiers]
     return &b->i;
            ^~~~~

I tried disabling the optional_qualifier iso but that has no effect:
- Not needed for the foo() case
- No effect for the baz() case

I even tried prepending an alternation with "const T good;" but the cast
still gets removed.

thanks
bye
	michael

--------------FDEC7820FFC77E141FADCC56
Content-Type: text/x-csrc;
 name="qualifier.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="qualifier.c"

int *foo(const int *i)
{
    return (int *)i;
}

struct bar {
    int i;
};

int *baz(const struct bar *b)
{
    return (int *)&b->i;
}

--------------FDEC7820FFC77E141FADCC56
Content-Type: text/plain; charset=UTF-8;
 name="qualifier.cocci"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="qualifier.cocci"

QCBkaXNhYmxlIGRyb3BfY2FzdCBACnR5cGUgVDsKVCBFOwpAQAotIChUKQogICAgIEUK
--------------FDEC7820FFC77E141FADCC56
Content-Type: chemical/x-shelx;
 name="qualifier.res"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="qualifier.res"

--- qualifier.c
+++ /tmp/cocci-output-8975-c8cf2c-qualifier.c
@@ -9,5 +9,5 @@ struct bar {
 
 int *baz(const struct bar *b)
 {
-    return (int *)&b->i;
+    return &b->i;
 }

--------------FDEC7820FFC77E141FADCC56
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------FDEC7820FFC77E141FADCC56--
