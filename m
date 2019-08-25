Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AD3C3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 17:35:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E426206E0
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 17:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Tzd8rl+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E426206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PHYqIK007651;
	Sun, 25 Aug 2019 19:34:52 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BE7B376C5;
	Sun, 25 Aug 2019 19:34:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7DEA57694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 19:34:51 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PHYnH7012585;
 Sun, 25 Aug 2019 19:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1566754488;
 bh=/xpT3Jr2gt1Ku0CgMc0URi8W24RHdd/2w4U6YlvCnq0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Tzd8rl+3HfY3TSJ3iOpQt/U32T0BcFy7b1T1g0jPjZ6urckBojSkRXOMqCecqasss
 ZE2wbmATqXQgaA3VAYzyFS8iNrsMybp7/gwjtOxvnIzoonZf9fG/s8wo9hPSqCw7sp
 Fz/Dqd87Pr1IVL8foAyIuxZHnon6q2u37irXBX4w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.160.204]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MaJse-1hmTxY3HPE-00JvMF; Sun, 25
 Aug 2019 19:34:48 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <a7f12c28-0f96-d388-f1f4-57db4d3d880d@web.de>
 <2AE15A09-F219-43DC-81A9-73C13CFC0753@lip6.fr>
 <661aa3dc-3514-3d75-eb3a-9e46843fd02d@web.de>
 <alpine.DEB.2.21.1908251547420.2283@hadrien>
 <c6f15b8d-561e-fda4-1531-191334f1142c@web.de>
 <alpine.DEB.2.21.1908251741460.2366@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <697b83ae-775c-a9c9-61b9-7399ee3ff8ab@web.de>
Date: Sun, 25 Aug 2019 19:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908251741460.2366@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:gEF9oKbD7pbxxGfSOGWTyMdqpoJ4slI7bNJFTNpoSL/K5COtsrJ
 KkMNzzsSiAyxDSqUdC1EvPjQVBAx99GYMj3dR9T0CUtv+S/xc0LCHe0iObR/8Hdvn8bgcIJ
 dWRq9aR7vlirAnXqApw9Y1u+QCtXvV0la7FluCHUKLogrKMJJNRAe/Gq87iNEIPgeJiMnr+
 Qw1ZTYSe6TLH4v3wq2peg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GJd/7dj6Z9g=:4JxN4soA8s1khsmDf1OyV5
 KkrOUtOBzpr2zZXvkeBvQnvWw0Uk1ET1x4A3Su5k55b8ObEk4cdrzeUYunSvnjJcNwhEZcoB0
 EccRN5RMWXUbDln5D7fux4OgdmAOzxO5jTEwwGoVXukrb/ZmvvVWftIhnHRLIPPBVJzJsWVwq
 OvEsS/MTlslhR1iekK9zoOim3yxMEP4nDiqxy1iIbC/ZEe/OdIb1RM94OUwY0FFUAXN3pDWsc
 DPQ4Nf/xhhbxrafDvO7vzK7u/QlqpJmFjUA0cAbYd6/UV6tQiQeTY5+Yqx3E2naUYkb331uWI
 LZ+ZaVYOdpa9ilW1VCiu6DMOPk/mF+C9rV4EAVrcOZhnJgbnSB3eOz4jAzyP0IDM1Wyxh903M
 LyNqT3O31MgaUZybDftNA8ohzPFeRPX7wS8VX2Dmt889sELjehDilcLAqsz9MDiMa/cdw+0gn
 fVuykr9+9cdNUha5kxeTs6y33v9EACMSq8jO32knSOMg3qNy/M/q5o08Zw5sgOrpES0uxwhHd
 XO+XXksWHhjzUaPjoX7b1rQQ1TOslIRz37MVJdcpNiZxBTMBMXVWGynRbZZ8NuXT4r8iAum+n
 PXlJNVWMb5rn0EcGsPIqQ/d0MnVPP4dU8wBeohfhbwtXdA9VwJVKVMn1IB7y4odLm9kKTnZ6Q
 qdHD6UWfFFQ5DppVoVa6Elehyr6P6B1bD/sMgP94ICUpy/7xsa+Ce7Bcz0U01wnB3P7S7zJ3b
 +1fjtti0ewJKzhNN16p6rZOxpSa8rTmRAc18C7rMUoI+/hfeXIaLHKkHtYZKU6uhmE6NrJmIm
 oPHjgE3yySYvFIIMRDLBBB6f3oxuJUwpvihGla5EJ3AVcTxLkGn+tL9aGQYhLLqAqjxOs1l9A
 SPt8LGbyqHzemKjnFMHgPWO60GUkojooJpszRkoMYF17p7ZDxrbN2943Up0VuM0t8ryjGMpin
 mTg5yzUMWiDWMzwUi2qbju8Yq2B8a4CNDxYh6cbevrv0vrWPJBchrPb9lOq2+qDh+X5+F1lXv
 RuMWp49uhkDUp3R34msTY8mO5hz7QhALiWsoV1w3/4u9HxhQxaR+hJC+e2tslj0ZwWqFLzgjp
 bhbqQYbvVIeAAftWg0XuRs6RUuXffM5bKAfXIVkvGRvdouHuGoqzWlQUjojrekvvNZuzCSgqh
 S6FWs=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 19:34:53 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 19:34:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Challenges around asterisk usage in SmPL code
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

PiBJIGRvbid0IGtub3cgd2hhdCB5b3UgYXJlIHRyeWluZyB0byBkby4KCkkgaGF2ZSBjb25zdHJ1
Y3RlZCBhbm90aGVyIFNtUEwgc2NyaXB0IHZhcmlhbnQuCgpAZGlzcGxheUAKZXhwcmVzc2lvbiB4
OwppZGVudGlmaWVyIGFjdGlvbjsKc3RhdGVtZW50IGVzOwpAQAoqaWYgKCF4KQogICAgKDwrLi4u
CiggICBzaXplb2YoKngpCnwKKiAgICp4CnwgICBhY3Rpb24oLi4uLAoqICAgICAgICAgIHgKICAg
ICAgICAgICAsIC4uLikKKQogICAgLi4uKz4pOwogZWxzZQogICAgZXMKCgpUaGlzIGFwcHJvYWNo
IGxvb2tzIHByb21pc2luZyBhdCB0aGUgZmlyc3QgZ2xhbmNlLgpVbmZvcnR1bmF0ZWx5LCBhIGNv
cnJlc3BvbmRpbmcgdGVzdCBleGFtcGxlIHNob3dzIHRoYXQgaXQgaXMKc3RpbGwgaW5jb21wbGV0
ZS4KCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IHNwYXRjaCB+
L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvci9zaG93X251bGxfcG9pbnRlcl91c2FnZTcuY29j
Y2kgaW5pdC9tYWluLmMK4oCmCkBAIC04MTUsOSArODE1LDcgQEAgc3RhdGljIGludCBfX2luaXQg
aW5pdGNhbGxfYmxhY2tsaXN0KGNoYQrigKYKIAkJCWVudHJ5ID0gbWVtYmxvY2tfYWxsb2Moc2l6
ZW9mKCplbnRyeSksCiAJCQkJCSAgICAgICBTTVBfQ0FDSEVfQllURVMpOwotCQkJaWYgKCFlbnRy
eSkKIAkJCQlwYW5pYygiJXM6IEZhaWxlZCB0byBhbGxvY2F0ZSAlenUgYnl0ZXNcbiIsCi0JCQkJ
ICAgICAgX19mdW5jX18sIHNpemVvZigqZW50cnkpKTsK4oCmCgoKV291bGQgeW91IGxpa2UgdG8g
c3VnZ2VzdCBhbnkgZXh0ZW5zaW9ucyBmb3IgdGhlIGV4Y2x1c2lvbgpvZiBzdWNoIGZhbHNlIHBv
c2l0aXZlcz8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZy
Cmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
