Return-Path: <SRS0=ZbCT=R5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02F1C43381
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 23:47:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27EB2075D
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 23:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="L9THFZ3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27EB2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2QNlBTI001114
          ; Wed, 27 Mar 2019 00:47:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8345C7725;
	Wed, 27 Mar 2019 00:47:11 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 728D07711
 for <cocci@systeme.lip6.fr>; Wed, 27 Mar 2019 00:47:09 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.40])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2QNl8JQ018843
 for <cocci@systeme.lip6.fr>; Wed, 27 Mar 2019 00:47:08 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTP id CEFD06A1
 for <cocci@systeme.lip6.fr>; Wed, 27 Mar 2019 00:47:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-language:content-type:content-type:mime-version:date
 :date:message-id:subject:subject:from:from:received:received
 :received; s=dkim20160331; t=1553644026; x=1555458427; bh=0M60SP
 a2gJ74XlMMHJ1A4c23kcvwBYmPBBUM/lE9L6g=; b=L9THFZ3H7o0IvcROZL2dwL
 YfHJhSwa0NouLfhKNFBKbp3ervSlBhaP3LPE3n5zf8upfdDAHRY8w7SMH1izF1xF
 yFEUEFtWZWH4bF+qmrC6rYYdigfSI1dBrZeffd/rFtDp/65fSuJV521/em/4sWZy
 mWK30iF8lqLnfGS/8TGZ9/8i/C2osrfFW1grUtLGFh3bOsQeO3x2sQmmf9dZuVCW
 reAjNPztLkpc6Px3/zX1Ywp7HV35uG9ujCDmcCSiiGi5N37M6DHwfIanQtF0ot81
 I4EN1WhGhsIadXoo4yM5BIeBNS0NHn9Q/k8sOWlhp2+qVeJpCEyEyhDWECFcA86D
 bsUHhn/nLxrZgQ9cV8/pRBZQoA4tGD0v4gZp2DgZfCcXL3se+LvgPAyT3w4jm8ZD
 TuyVitnQe8+IEOKNIPKN5witec0hZZVpUPn+ZLbCCUEbII8ABbMUHP2Sq0t5Kc5t
 kepwKfPuhWEYseQh4lnmarPAY62t9lVp7UEE3SV09lI18B4pIpZAdC6XvzrCkAUr
 NaqGOW5PDUcb+SVn8k1M8wHs8fiIfFLudTL9xos9Pc3vSDtnHtfcVwYDo+vuk9VJ
 KLdjQOh74fy5AuXNl/6jty57qWrlVkD3LMKMPGt6kYgRA3QnJJsw3OPknfrAZWrR
 CElptxpK2DbGaazkMwfRc=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KSLY4xwEGGhj for <cocci@systeme.lip6.fr>;
 Wed, 27 Mar 2019 00:47:06 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id B08C11D7
 for <cocci@systeme.lip6.fr>; Wed, 27 Mar 2019 00:47:06 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
 by int-mx003.mykolab.com (Postfix) with ESMTPS id A0E90BDA
 for <cocci@systeme.lip6.fr>; Wed, 27 Mar 2019 00:47:06 +0100 (CET)
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
Message-ID: <51927c57-784e-6154-7032-0a4a266ac6f0@mykolab.com>
Date: Wed, 27 Mar 2019 00:46:57 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F3231AEA7295566A3E269EA8"
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 27 Mar 2019 00:47:12 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 27 Mar 2019 00:47:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Capturing all array initializers?
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
--------------F3231AEA7295566A3E269EA8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

I'm trying to do this transformation,
from:
    const WCHAR wstr[] = {'u','t','f','1','6','
','s','t','r','i','n','g','\0'};
to:
    const WCHAR wstr[] = u"utf16 string";

I had hoped to be able to use an expression list for the array
initializer, but that produces a parse error. I know that technically an
array initializer is not an expression list, but it looks like one.
Is there another metavariable that I can use instead?


A way to workaround that would be to use something like:
@r@
typedef WCHAR;
identifier wstr;
constant ch;
position p;
@@
 const WCHAR wstr[] = { ..., ch@p, ..., '\0' };


That would make the subsequent script:python rule run once for each
char. With some surprises though:
- The initializers ch get sorted before script:python runs. Thus the
position is needed to undo the sorting.
- More surprisingly, without @p the initializers get even deduplicated.

This workaround is doable but tedious. Before I go down that rabbit hole
I prefer to check if there's a better alternative.

thanks
bye
	michael

--------------F3231AEA7295566A3E269EA8
Content-Type: text/x-csrc;
 name="wchar.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="wchar.c"

const WCHAR wstr[] = {'u','t','f','1','6',' ','s','t','r','i','n','g','\0'};

--------------F3231AEA7295566A3E269EA8
Content-Type: text/plain; charset=UTF-8;
 name="wstr.cocci"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="wstr.cocci"

QHJACnR5cGVkZWYgV0NIQVI7CmlkZW50aWZpZXIgd3N0cjsKY29uc3RhbnQgY2g7CnBvc2l0
aW9uIHA7CkBACiBjb25zdCBXQ0hBUiB3c3RyW10gPSB7IC4uLiwgY2hAcCwgLi4uLCAnXDAn
IH07CgoKQHNjcmlwdDpweXRob25ACndzdHIgPDwgci53c3RyOwpjaCA8PCByLmNoOwpwIDw8
IHIucDsKQEAKcHJpbnQod3N0ciwgY2gpCg==
--------------F3231AEA7295566A3E269EA8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--------------F3231AEA7295566A3E269EA8--
