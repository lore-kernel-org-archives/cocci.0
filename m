Return-Path: <SRS0=FowQ=Q3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9092EC43381
	for <cocci@archiver.kernel.org>; Wed, 20 Feb 2019 19:46:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC852086A
	for <cocci@archiver.kernel.org>; Wed, 20 Feb 2019 19:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="UnvpynbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC852086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1KJkWgu006234
          ; Wed, 20 Feb 2019 20:46:32 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B944376FF;
	Wed, 20 Feb 2019 20:46:32 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7C582764A
 for <cocci@systeme.lip6.fr>; Wed, 20 Feb 2019 20:46:31 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1KJkUNb018267
 for <cocci@systeme.lip6.fr>; Wed, 20 Feb 2019 20:46:30 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 233683A5F
 for <cocci@systeme.lip6.fr>; Wed, 20 Feb 2019 20:46:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-language:content-type:content-type:mime-version:date
 :date:message-id:subject:subject:from:from:received:received
 :received; s=dkim20160331; t=1550691989; x=1552506390; bh=SLkthc
 IeBpZfzExVSGPe7Do6hq5AZZS5Gc/Wi1bkXeU=; b=UnvpynbK0p2KTi8HRjJot0
 PxYEypbwff/Ko+wrqKrQJFrJndHn9msPR1Le6ZkQ6+ORDf/2vWfTHm3g+icDxMAe
 NeMVt1sra3QV4jBR542Q6vkZHkMe4/NchcwSKt4Umiz26/rnmB9ZdedXErKhf08V
 tt/4V/r1jSQu6B+H9ld4StgvffS6/hpQbT116kp9cdV6gynXDND59uOw+sh/NNOT
 tWs/z4NoSR/P29jmQ0AgQHk0PsrLLF3dOKe87IlB3NkIfnnuLfsnux+sNeeom5nT
 t28bqHYQfwCHRauilfcbrXwNm/QM6owj2bMQSFsFCxrB+hszmBsm+amPks7e1SB6
 wsdhEFO70d1Inl7iOZDTSVpCCgmyAfTigqsAowL5hf8WFjrMgR/XvT0sjYF6sHsK
 5nKkvTwjpHxKiwaVcQhVJA/QNxuaH9Inh3+ForB5dd83g4Kc0UNSexleu9hp+jcd
 Tsq0oFcjprb9IGgzi4c5JjsGwTd+7YRg5xRSJq23WJB6UYCN96ICkzVosOumdObB
 XTlGfD13bGdVxx5AIugAn0C6fqhAl8FO8pv0N/LrHqxptm0WwAPpr4q5ZcWcScqz
 pUnKRjJJLzyg/7rFJIvMOC4KjOZEFlRdI+kgKLq3NEEY8Nn6y9MeCqtp/WWOCWin
 VKUmG2iUGK9/DTD+3Rg38=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rA82uEZri5M8 for <cocci@systeme.lip6.fr>;
 Wed, 20 Feb 2019 20:46:29 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
 by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 1DF903A5C
 for <cocci@systeme.lip6.fr>; Wed, 20 Feb 2019 20:46:29 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
 by int-mx003.mykolab.com (Postfix) with ESMTPS id 0539DAB8
 for <cocci@systeme.lip6.fr>; Wed, 20 Feb 2019 20:46:28 +0100 (CET)
To: Coccinelle <cocci@systeme.lip6.fr>
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
Message-ID: <9b04d689-5786-517b-afcc-30c71f5c687e@mykolab.com>
Date: Wed, 20 Feb 2019 20:46:18 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------432718155F2B4030D944B619"
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 20 Feb 2019 20:46:34 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 20 Feb 2019 20:46:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Capturing comments / whitespace with statement list?
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
--------------432718155F2B4030D944B619
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

is there a way to capture in a statement list the comments and empty
lines between statements?

I've got asked for scripting help to merge a ton of helper functions
into their only caller.

Of course it is trivial to do with coccinelle. But the comments and
empty lines get lost in the process:

  spatch merge.cocci -D func=foo_base merge.c > merge.diff


It is not a big issue, only about 55 functions to merge. So I can either
use the above script and add the comments and newlines back. Or copy the
stuff manually.

thanks
bye
	michael



--------------432718155F2B4030D944B619
Content-Type: text/plain; charset=UTF-8;
 name="merge.cocci"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="merge.cocci"

QGJhc2VACmlkZW50aWZpZXIgdmlydHVhbC5mdW5jOwpzdGF0ZW1lbnQgbGlzdCBib2R5Owp0
eXBlIFQ7CkBACi0gVCBmdW5jKC4uLikgeyBib2R5IH0KCgpAQAppZGVudGlmaWVyIHZpcnR1
YWwuZnVuYzsKc3RhdGVtZW50IGxpc3QgYmFzZS5ib2R5OwpAQAotIHJldHVybiBmdW5jKC4u
Lik7CisgYm9keQo=
--------------432718155F2B4030D944B619
Content-Type: text/x-csrc;
 name="merge.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="merge.c"

int foo_base(int i, int j)
{
    i++;
    /* Now increment j too */
    j++;

    return i + j;
}

int foo(int i, int j)
{
    return foo_base(i, j);
}

--------------432718155F2B4030D944B619
Content-Type: text/x-patch;
 name="merge.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="merge.diff"

--- /tmp/merge.c
+++ /tmp/cocci-output-18706-5610a6-merge.c
@@ -1,13 +1,8 @@
-int foo_base(int i, int j)
-{
-    i++;
-    /* Now increment j too */
-    j++;
 
-    return i + j;
-}
 
 int foo(int i, int j)
 {
-    return foo_base(i, j);
+    i++;
+    j++;
+    return i + j;
 }

--------------432718155F2B4030D944B619
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------432718155F2B4030D944B619--
