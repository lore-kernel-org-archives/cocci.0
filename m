Return-Path: <SRS0=pcGb=CS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9A2C433E2
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 19:23:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A5B21D6C
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 19:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="SIfU5AkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A5B21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089JMPN8001218;
	Wed, 9 Sep 2020 21:22:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3905B5F8F;
	Wed,  9 Sep 2020 21:22:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D57464316
 for <cocci@systeme.lip6.fr>; Wed,  9 Sep 2020 21:10:49 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089JAnXI020745
 for <cocci@systeme.lip6.fr>; Wed, 9 Sep 2020 21:10:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1599678648;
 bh=DsQUTeT0KzcRiGGPDRrUQ7WslVTtknel6etEzrS1aJ4=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=SIfU5AkAwf8TtDcU88FD9taJf+SvzpwFgzZvlgQOSTwNwEp7uwiF26uKhCzUvFadF
 i+eKGDGhJwXXc1GJJDyb6jTUL5vpk5a8UvebMBzifcW0sVlGHvxAvbdHf53Nz5naQG
 MevpRRkUEWAuBYlXj7P3JRvIs478wMxJMH4t5WcI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.79.254]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjJWR-1kob1r2p3P-00dU5Z; Wed, 09
 Sep 2020 21:10:48 +0200
To: Jaskaran Singh <jaskaran.singh@collabora.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <53573bbd-d550-b1b9-49f4-a84fabe20115@web.de>
Date: Wed, 9 Sep 2020 21:10:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:HPvG1Af2OcPdX37jPPA3/KrBPk/FJ/t5V2edF7YbMJM2QjuHzW+
 5kFnqCTeHgbemDGxxwDhu6Ah6sCZB1Rd774obSh92ZoUx0nHsFVy18WlvmoRkrS/ZXRyUpb
 hLGsJQF0vqKfZ75OkBLguBhL5seX3SGN7CwoCSwHxib2bziv9w/MOmRX9p7mxBfxB0efDzb
 3X4bv6nxzlCGWNumqeczQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MX+BWnGLXEg=:lKhTrgPsuvs2N7kqyZ28dg
 awyJdgwS74AXx4MidnuL1cy8MDx2vwVXkH4heeeMkUEUPCOnfHbUHIznQDFf3PpEaw6lzKRkx
 Bix6BpKsRmmzbkjcicjVKGeeuNAdALEshyxGX3kaNauwlWFqWfYUKd5HL8hLMKk460fefylg2
 I5olwpAjK7y/h6POzi7MKJ5x60OcePiKJyMs5a4+aKgNa230Q9jkmWjV1jiQxYFjlu3sHyOgc
 mkt9+T+dUSdUsR5ATqYfO0UY0onKt1yKCU0UB6ZUxvl0BZjntrsluvcAlh8B5nR0QSGWsz95l
 0spiecUpZJeKCYUF7AGRrP3kHFwMscxogPtbwCU0IfonfOCmPXdFy5Y+/0tHMMAVaYN/DYWD8
 gJvshO8HHv+hv2PPnFlUom5izjXrvMA2l+l31HsQXbFcV1WS6iOR+pscctDj42utWEgcHvC7L
 ZvdVZTBAidsheqcRdAOMwYtopcP4i5HIV5fpfW3GiL5xBFOiMWAmOr6eaBh6eNzQSYx44Mm9+
 HMwaJMTvFA9JB6XTdHzAeScYJ5mY3eRPuXFTwSqypVtA4taykNXbjBhvhQMEhmIqtez8U4m6P
 uJ5O7crILaAlbcNrFFoHVbXdIZuE46wLcwdCnKiPQSk9BdifNZSEcKgSZwKkmiZwVvRHPugEO
 7GkqLa7N2GFNu/hblfwm/Yz/ndMAAxOj8Q08QhHCWcp2ilCq013kNT9Uf2G47Rc/lncfmNuKH
 w+z389koy1pNpS/gBQJ2hXkTV04J4JYmYsz0bR4FtZV2Cb2vs2XDqcJD95+ek9HgxTgwbAB/I
 XehqZMo0qPzljNnWPYG5l7P4rHZEabpg8tv1QTu4TqaFjEtygcSH9IdT86If7VFtEY50OuKcM
 GWJ8UftLa5szm+UFqJeOIYU27IUTfL70SF3FhbJdyaS8CrCyLGI9uhqES2Xygv26ymJ1Wf38y
 E+WARqlU52fqNFHmsoR7mbS6gVCRkZWG2xS5UtOQpiNESNeelSYF/KA8f7E+CU52kpHUsTQBJ
 nr7U6chD2TIOYV3VRWMJqBvKD6Z+eQynnJ/J+CBXn14mPBiyxgdulE4Lrk0ks9NnLQSLiN+6B
 9YlBu9fwgUtQK9ewISfur8wm4JfbnS8W9uBJuoxwG9z7hiGiTeRvhGi+0Se3JRRWbVsQjhjHa
 fjdS4cwaSstaznDv8LhSGPY9AnQa1jerTI9Dw0wJjklfmIQqikqMTwQFJKe4X3IaRDgg5v1ZJ
 J4wJg+RKInbTIL7ypE66ar0EsPcHauxIAA26keQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Sep 2020 21:22:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 09 Sep 2020 21:10:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 09 Sep 2020 21:22:23 +0200
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [RFC PATCH 0/3] parsing_c: Optimize recursive header
	file parsing
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

PiBUaGlzIHBhdGNoIHNlcmllcyBhaW1zIHRvIG9wdGltaXplIHBlcmZvcm1hbmNlIGZvciByZWN1
cnNpdmVseSBwYXJzaW5nCj4gaGVhZGVyIGZpbGVzIGluIENvY2NpbmVsbGUuCgpJIGFtIGN1cmlv
dXMgaG93IHlvdSBnb3QgZW5jb3VyYWdlZCB0byBwaWNrIHN1Y2ggYSBzb2Z0d2FyZSBkZXZlbG9w
bWVudApjaGFsbGVuZ2UgdXAuCgoKPiBpdCB3b3VsZCB0YWtlIGNsb3NlIHRvIDcgaG91cnMgdG8g
Y29tcGxldGUuCgpUaGlzIGlzIHVuZm9ydHVuYXRlLgoKSG93IGRvIHlvdSB0aGluayBhYm91dCB0
byBvZmZlciBhbnkgbW9yZSBpbmZvcm1hdGlvbiAoYmVzaWRlcyB0aGUKbWVudGlvbmVkIHByb2Nl
c3NvcikgZm9yIGZ1cnRoZXIgYmVuY2htYXJraW5nIHB1cnBvc2VzPwpodHRwczovL2dpdGh1Yi5j
b20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vlcy8xMzMKCgo+IFRoZSBvcHRpbWl6YXRpb24g
dGhhdCB0aGlzIHBhdGNoIHNlcmllcyBpbXBsZW1lbnRzIHJlZHVjZXMgdGhhdCB0aW1lIHRvIDEg
aG91ci4KClN1Y2ggYSBzY2FsZSBvZiBpbXByb3ZlbWVudCBpcyBpbXByZXNzaXZlLgoKCj4gLSBT
a2lwcGluZyB1bnBhcnNhYmxlIGxvY2F0aW9ucyBpbiBoZWFkZXIgZmlsZXM6IFNraXBwaW5nIHRv
cC1sZXZlbCBpdGVtcwo+ICAgaW4gYSBoZWFkZXIgZmlsZSB0aGF0IGNhbm5vdCBiZSBwYXJzZWQu
IOKApgoKV2lsbCBhbnkgZnVydGhlciBzb2Z0d2FyZSBldm9sdXRpb24gaGFwcGVuIGFjY29yZGlu
ZyB0byBhIHRvcGljIGxpa2UK4oCcRXhjbHVzaW9uIG9mIHVuc3VwcG9ydGVkIHNvdXJjZSBjb2Rl
IHBhcnRz4oCdPwpodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vl
cy8yMAoKCj4gLSBSZWN1cnNpdmVseSBwYXJzZSBhbGwgaGVhZGVyIGZpbGVzIG9ubHkgb25jZSBh
bmQgYnVpbGQgYSBsYXJnZSB0eXBlCj4gICBlbnZpcm9ubWVudC4gVXNlIHRoZSBkZXBlbmRlbmN5
IGdyYXBoIHRvIGRldGVybWluZSByZWFjaGFiaWxpdHkuIOKApgoKQXJlIHlvdSBsb29raW5nIGZv
ciB0aGUgc3VwcG9ydCBvZiBoZWFkZXIgZmlsZSDigJxwcmVjb21waWxhdGlvbuKAnT8KClJlZ2Fy
ZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVt
ZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
