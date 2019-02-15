Return-Path: <SRS0=7OsK=QW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EC8C43381
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 22:32:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3DC222D9
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 22:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="TKRUtb9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3DC222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1FMVxSF022934
          ; Fri, 15 Feb 2019 23:31:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5EBB376FA;
	Fri, 15 Feb 2019 23:31:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0F0E776F7
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 23:31:57 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1FMVs9v018430
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 23:31:55 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTP id B0981411C7;
 Fri, 15 Feb 2019 23:31:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-language:content-type:content-type:in-reply-to
 :mime-version:date:date:message-id:from:from:references:subject
 :subject:received:received:received; s=dkim20160331; t=
 1550269913; x=1552084314; bh=a/3kWLdEl9eHycFN8jJNGxl/xFfVQkMsom3
 qnRxFnxs=; b=TKRUtb9GlsRtd8Riq3xtbpLOqgWcX16k3rHcat/il5uDoIyeNPQ
 XAMPj4xV+aNP6wmDFXAYa9Yufhgc0ndGXJ6U2qttR754PE2FYPSCiY/R4HSDKpXJ
 HpTfcnm3dVtyd6tAPR3BdbbVVM9Q/eZyeBEozgLngPdk0PvTigTqd/smZ/tkvmxp
 eX5vgysAq4ZTqOY4+E+KQY8RXoI0c9OG1BT6If0H85GKYP76OfHSFmKcEB6X1g8c
 KxPmsiD7GQwOJZYOuv6/O6byGAdCjtcsni4eb0jeh0mC+LimW2bwU/kXAgSb3GQE
 Hqeth/8oIzpk2hGNS80y0dhug3/ZM9AqupGOczwXjtdlWE1s/KyJ1YQgZziPWBYB
 HgGTvgw3m+Vvf7lh3TI/K7gJO34ibImm5FgvrXVcIW0xPrqjGBIVPH6T2uvcc6AL
 9gHzVEAuSugwhUUSx3fVavx20PCwSJABmZzevaiVAbhwXAoLHT3bAPIzaois6st5
 9KkLA1Cy3Dw29i0MXGKCRshry5n2WfvKnBvEqGcFTP3F94NaOAVBUdp8KRstwTr1
 Q30gxP+tfqrD8Uour0KhrxDRfl7dyYLqLyUeNcIarUQsirSh69C3I8NbUm4gxz3/
 5U0Q5C4nTGmRz0lSHY6m2VQnxkYHQ0OfF/RpEkbuWqnNZK3nhL0PB6ao=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aJ8MJlTyrpCw; Fri, 15 Feb 2019 23:31:53 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 9A70041160;
 Fri, 15 Feb 2019 23:31:53 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
 by int-mx003.mykolab.com (Postfix) with ESMTPS id 636B8AA1;
 Fri, 15 Feb 2019 23:31:53 +0100 (CET)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <fb42aa05-f4d0-53cb-7eda-4f0a5db6cd3c@mykolab.com>
 <alpine.DEB.2.21.1902152203380.2572@hadrien>
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
Message-ID: <0e8b1430-1538-cc24-8644-2ed8baa24276@mykolab.com>
Date: Fri, 15 Feb 2019 23:31:51 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902152203380.2572@hadrien>
Content-Type: multipart/mixed; boundary="------------20B5A5560EE3240F5ACD4CA8"
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 23:32:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 23:31:55 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Qualifiers for field types get lost
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
--------------20B5A5560EE3240F5ACD4CA8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2/15/19 10:04 PM, Julia Lawall wrote:
> 
> 
> On Thu, 14 Feb 2019, Michael Stefaniuc wrote:
> 
>> Hello,
>>
>> I have this trivial script to remove useless casts to self:
>> @ disable drop_cast @
>> type T;
>> T E;
>> @@
>> - (T)
>>      E
>>
>> It works but I'm hitting false positives when the code casts away
>> qualifiers for field types. Please see the attached test case:
>> - Good: Cast is kept in foo()
>> - Bad: Cast is dropped in baz()
>>
>> Applying the generated diff will lead to a gcc warning:
>> $ gcc -c  qualifier.c
>> qualifier.c: In function ‘baz’:
>> qualifier.c:12:12: warning: return discards ‘const’ qualifier from
>> pointer target type [-Wdiscarded-qualifiers]
>>      return &b->i;
>>             ^~~~~
>>
>> I tried disabling the optional_qualifier iso but that has no effect:
>> - Not needed for the foo() case
>> - No effect for the baz() case
>>
>> I even tried prepending an alternation with "const T good;" but the cast
>> still gets removed.
> 
> The const is now propagated to the fields.  Let me know if there are
> further problems.
Many thanks!

I tested it and it removed all but 1 false positive.
I have also validated that it removed only false positives.

There's a qualifier propagation issue left in the case the field is an
array. I have attached a patch that extends the tests/qualifier.c test
case to demonstrate the problem.

But actually I am happy about that leftover false positive as that gave
me a new idea of how to remove some more casts:
https://source.winehq.org/patches/data/158631


Thanks again!
bye
	michael



--------------20B5A5560EE3240F5ACD4CA8
Content-Type: text/x-patch;
 name="0001-Expand-the-qualifier-propagation-test-with-array-fie.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Expand-the-qualifier-propagation-test-with-array-fie.pa";
 filename*1="tch"

From 7000ce04c9e11a1815783a93dbe9082d22b53a30 Mon Sep 17 00:00:00 2001
From: Michael Stefaniuc <mstefani@mykolab.com>
Date: Fri, 15 Feb 2019 23:09:18 +0100
Subject: [PATCH] Expand the qualifier propagation test with array fields

Signed-off-by: Michael Stefaniuc <mstefani@mykolab.com>
---
 tests/qualifier.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/qualifier.c b/tests/qualifier.c
index 05af05f1..149f67f3 100644
--- a/tests/qualifier.c
+++ b/tests/qualifier.c
@@ -10,14 +10,21 @@ int *foo2(int *i)
 
 struct bar {
     int i;
+    int j[2];
 };
 
 int *baz(const struct bar *b)
 {
-    return (int *)&b->i;
+    if (b->i)
+        return (int *)&b->i;
+    else
+        return (int *)&b->j[0];
 }
 
 int *baz2(struct bar *b)
 {
-    return (int *)&b->i;
+    if (b->i)
+        return (int *)&b->i;
+    else
+        return (int *)&b->j[0];
 }
-- 
2.20.1


--------------20B5A5560EE3240F5ACD4CA8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------20B5A5560EE3240F5ACD4CA8--
