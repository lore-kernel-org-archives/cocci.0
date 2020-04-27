Return-Path: <SRS0=J+r8=6L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A15EC54FD0
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 11:27:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C013205C9
	for <cocci@archiver.kernel.org>; Mon, 27 Apr 2020 11:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="W8rMPUR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C013205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03RBR38w003005;
	Mon, 27 Apr 2020 13:27:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8B3247807;
	Mon, 27 Apr 2020 13:27:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 209AC7769
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 13:27:01 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03RBR01U012451
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 27 Apr 2020 13:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587986811;
 bh=u35VrCt8medsivMDHaOutmpmvu9KIs/e9Ch87ZjO3vc=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=W8rMPUR7ZHcqDJKxjm66tJwBzxZYUTYGk/NH1cdSIRSS/z5CqFITv8P/peewO4B90
 nuMdGpnOET0ElQaYE+9l8exuGtixJuIKMm4yFVgohwXxWm0U/Vbc1YokBCDSgVzOg1
 vlYnA/Gwv4frDnqRM1MhZg/3fV3g1z/2zi7v24go=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.190.48]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lpezi-1iwT6r26y6-00fRdt; Mon, 27
 Apr 2020 13:26:51 +0200
To: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>, netdev@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <332befc4-efd1-9303-7c9d-f7f3809cd81e@web.de>
Date: Mon, 27 Apr 2020 13:26:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:m1lzIOTWu5edMqRRyCQJq4KBZcNljlhFecvVYZCKRwFDVenNrCG
 yLvwR/DueaOQGjxOGsTnt1cz3VtG8jQ50xr8vUeCPIPLB0sDNEX5U7vSzG/tfU60KAG33eW
 0TE7b7Kc8rVWeE/bZJMFfoFlvOlnWHNyDOLKt7LejYpIntR0caJnAHv2wUes4InCNqoHTpA
 D2IgUHOeoRPeEpVLMYTRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GnzX39we2Gk=:m04wqwdrjegXNR3MXXhVAW
 /XMWgDlSCRzYcFaiiXewVFjOA/wvi1c0hhkD8WXoRW+1Q+IvO6OM+WjzSLXyw3n4+reY80QAX
 lAlKxHrnd5cVQgH7D7lXEykPlRtTpBIrC136IrP4Aun30bBm4jTGc40OW+R7WFU5IgbW0EtGT
 j5js5O65Bg4F/Dut19gw7TIEdin/dsoquqDy3u8108acjGMF7XChfgpCYI8GZm9Q7EuZ8Jj0S
 E6zE4mfgD0RjlTgBt1gGOxqDBJWY80FpbLCcORunBcftc7y3104M4U2QQsxZYJiAtwCI3sLU+
 dtN3n/miHytRNuyqpR/aoyNi/0Eq8nEJsnu9G8Pscdrrnp7LHgxn7d+pgFgg9fV7SDqPu6xt6
 8Eo1nMqurpSFpu6z0k3PUj2h77Ol6UTrBWWFc8pPo+nFfJZLIF4EPjdYB4OkiNQUaVYEY0PNM
 FZoMZVh+PMocNqYnvr0NUNaFCF8n1LesIe3kHXyxnE/oEJjoOXGQc+tSVjDCH+sdzuxhwDgOI
 xWqFF0bhx7/AcgcJZev2gpu4s1qrR6ZHLAl59fZHSDBhzvIpqK3mCslcF1Too1BWx7CAKSDAK
 s8swH6QWop6DIQDDcxEEtVZ3ru+lz29Clvf/KX13jlFGMA02CcraLSfxY+Tq+lTTwbiq+W4ap
 /3hLNAq5Cywjfmj4qG5i98QitJQI8kBAwAqpjloJl0b2MOky4JTkcxMdE823QCUkA9/iV7S4b
 6sc94rocoiWeBH20OXM+kpaR0VQQUELLOfxwUMThV+R7pVjMD+klOUVRf3hWya0ZL0sGtVqyf
 SoYYLE8YUgryu3eubEsB2oSVwgeUR51YfBmQqOS4Wu210S4rKgyLmZ75cWpddHdl0u8GBNtH7
 MuEjf3pTkERZGlyoUnmDeRmih76J6fuYSEELmlRLLO1bChlFb0caWrBGVNbi3pCU8fMjYg7rF
 FMOoqyaPJCUgbNYuGMawrp6JazYJCkKKC+zQDzTmXzrjG5JM3oOwFQ1jXju02C2ypdRqbC+Rd
 s+BMdR3HN8wlifhwWc8JjOfgfO42bHdw37VFCHMTkaKqJ/oSU+PpZTXey8j56WcxDdAEJ+8kc
 2V881kfFmMpxQUHMIL9EFYsc/6WbfnrPtoLx9DN7dPgU61PvhyHV93/+fLywuZ5k0qHrnYbLA
 ZHEXqdVaXWdakJJuZlV31s8NM/234x2MyZFRfFSfVI0lM+lHot5ZB3gbS6qhE9VKJ0CJbcUX6
 5u9L0RffmvS1Dr7RN
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 13:27:04 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 27 Apr 2020 13:27:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Madalin Bucur <madalin.bucur@nxp.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Cocci] [PATCH] dpaa_eth: Fix comparing pointer to 0
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

PiBGaXhlcyBjb2NjaWNoZWNrIHdhcm5pbmc6Cj4gLi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZHBhYS9kcGFhX2V0aC5jOjIxMTA6MzAtMzE6Cj4gV0FSTklORyBjb21wYXJpbmcgcG9p
bnRlciB0byAwCgpTdWNoIGluZm9ybWF0aW9uIGlzIGFjdHVhbGx5IHByb3ZpZGVkIGJ5IGEga25v
d24gc2NyaXB0IGZvcgp0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UuCmh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9sb2cv
c2NyaXB0cy9jb2NjaW5lbGxlL251bGwvYmFkemVyby5jb2NjaQoKCj4gQXZvaWQgcG9pbnRlciB0
eXBlIHZhbHVlIGNvbXBhcmVkIHRvIDAuCgpCdXQgSSBzdWdnZXN0IHRvIHJlY29uc2lkZXIgY29y
cmVzcG9uZGluZyBzb2Z0d2FyZSBkZXZlbG9wbWVudCBjb25zZXF1ZW5jZXMKYWxzbyBhcm91bmQg
bWVudGlvbmVkIGltcGxlbWVudGF0aW9uIGRldGFpbHMuCgoK4oCmCj4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2RwYWEvZHBhYV9ldGguYwo+IEBAIC0yMTA3LDcgKzIxMDcs
NyBAQCBzdGF0aWMgaW50IGRwYWFfYTA1MDM4NV93YShzdHJ1Y3QgbmV0X2RldmljZSAqbmV0X2Rl
diwgc3RydWN0IHNrX2J1ZmYgKipzKQrigKYKPiAgCXN0YXJ0ID0gUFRSX0FMSUdOKG5ld19za2It
PmRhdGEsIERQQUFfQTA1MDM4NV9BTElHTik7Cj4gLQlpZiAoc3RhcnQgLSBuZXdfc2tiLT5kYXRh
ICE9IDApCj4gKwlpZiAoc3RhcnQgLSBuZXdfc2tiLT5kYXRhKQo+ICAJCXNrYl9yZXNlcnZlKG5l
d19za2IsIHN0YXJ0IC0gbmV3X3NrYi0+ZGF0YSk7CuKApgoKCkkgaW50ZXJwcmV0IHRoZSBzb3Vy
Y2UgY29kZSBpbiB0aGUgd2F5IHRoYXQgYSBzdWJ0cmFjdGlvbiBpcyBwZXJmb3JtZWQKd2l0aCB0
d28gcG9pbnRlcnMuIEkgd291bGQgZXhwZWN0IHRoYXQgc3VjaCBhIHBvaW50ZXIgZGlmZmVyZW5j
ZQpoYXMgZ290IGFuIGludGVncmFsIGRhdGEgdHlwZS4KV2lsbCB0aGlzIHZpZXcgdHJpZ2dlciBh
bnkgZnVydGhlciBzb2Z0d2FyZSBldm9sdXRpb24/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0
CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xp
c3RpbmZvL2NvY2NpCg==
