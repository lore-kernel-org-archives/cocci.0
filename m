Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACB4C433DF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 06:53:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43976206A4
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 06:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ZEztG88I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43976206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0586qxqB022160;
	Mon, 8 Jun 2020 08:52:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 45C147783;
	Mon,  8 Jun 2020 08:52:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1A5A744A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 08:52:57 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0586qurb020354
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 08:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591599175;
 bh=de/E1gVu3UGwKaDJeFH3VVPMI9cHddaZKs33JjOfD40=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=ZEztG88IRZN+3iXSm8M51AGJ9/ih1ffF/C+waiLItWRpyA+PP8kkgYUFmcYAuoTWY
 lq8XQxDmvePpBROZGW/bzY9T7Atoq3KrfBPaF8QFPHRebvTSBQwFsudi+BvmLup/Ay
 WiaVR8OiQZ/ESARu+bM8YMIhh8IQooSo+jkh8PCc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKa2F-1jhMy838Kd-0022KG; Mon, 08
 Jun 2020 08:52:55 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Denis Efremov <efremov@ispras.ru>
Message-ID: <a759a96e-c01a-84e0-7f04-f0ff2a3aa0ef@web.de>
Date: Mon, 8 Jun 2020 08:52:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:67u0TU6OIA1oE513FCQTzlqwAYyd4wk3snyTol2Lnzw5kH0jJlD
 2dlN/wWmXTvLfsmKBVL9n66hW+d8nAl/bBdTsoJqr8JOWwzB6KbqKBvPHYOVF5Hpw9VOSNN
 2TQfuWzowTFLmYVvUmxIF4Rc5YtzKR9zfhnPjdAp5YpiVs4C3uJE3/AhBBycNaaIXLcP6qX
 nchcYPP50AJYpDLWQYg1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wVbfeyKDpMQ=:FeJRCzsES+APEg/emtLMK3
 FeJjPSX7qktfZSSOCk9ZixAG57nE28zIVVRL7YZtpbXBiw3kW0NezbxhKSnRy02nv+yOllTnW
 GimytPhFhENwZCjZq+x5RfGOIZpJp7BcJ2iDDVbDiFZGVFNK9BxTNc5ujcOy3E/oFG0b+pIov
 FyVCrylWJDSeauBYFxaQvBZC0KgaNrt0yZ1MNWfqlORq57FUpjHMuqbjVBFP/mqU80bl+GkKg
 OZGI2tWfuk/QfjcgAFde8BxS2t78+LJIgRkS45OqrDogEpg5mEA3RRab4yXVBE6aaHMqaOEuV
 yOI2LAr0y72AfMoQVAR9fxAU61DLaVgspcs99vK2W02HxkPl6REonGfclhNVRq0pGvsxzH65m
 Y9h83dmEDBE0qm2dY4CEBKW6cW5XnOxzx77ieilIgkqiWEF+YdLbwdmGv05/Mk5gxf/NOcVwY
 oE71+WzGghmCV71AgGpqV+O2Lxcge564F7hQ/sMSTi43Xdy/0Mh+FmV3d1NrNJPAzOmbEdT2b
 QHKUFlKA4tJ3TulgsOMoZfl2+h+cev9unrNlhtNuiD79+rXjI/jqoCfqBeblsBp1s+Ig9FEm8
 64TBBMGZum5vzhsGrC1QYHWSpsuzU28AXAv5vLmY5qlE03NIdgXJvI8+h9UrHVi27bnSYGFrn
 3PFRT+KTNsHLz3/tAJmE2wt8apgPL2HD8JXCGW87enA9cEmDIQWI3z1RkFUzVHPc5KjQwvTVT
 bAN04lMHBC0eXj4uJiECWRTSoMOPn6sCR49UIZMyCOsSR5+D7dBQaOPeIj56YPTubGGTcBe3u
 clqSc035u5n0GvJFhasScKoL64NBmK/yL+HbpJae8r2A3I3/cw+nXOPuHG4TBm3/GUtZ4LN1a
 hmDsStfNfxfkbDgYV9VQeW3ng5fbyGYkIFwpUesAL3MIZ+gMtJ9aBVp7GxZgVkSF7AT+4eqCT
 +ZFHIPuw9cNzTSB0goX1h3zXnAO7CuAYDYnCGHFsGApf6cmT/wGPmnuAgGHMD5FpD3yttxlm+
 uo6Z3ncHsj2Kv/Ph4QZG8ng/5UBunbOVivZQJ5bXlN1e6ZlXNRyUsfuBpkGQoA24i2SSkEXlr
 PY2VAYQZiNe5inGMiyxeZ85U3IopOG5Sv2B6Xr83//0LUfJxE4sVYuCGOzpTNYt9R6zN+88lx
 htiIaBuU7Tn2sMtVG5/DwCwWTqE9tL+iZKVpnNgLnnvezWARyeJjWGpzqfci0OURoFRqj5KDw
 xHPpkzgijTgOb203N
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 08:52:59 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 08:52:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Suppressing a couple of matches
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

PiBMZXQgdXMgc3VwcG9zZSB0aGF0IEkgd2FudCB0byBzdXBwcmVzcyBhIGNvdXBsZSBvZiBtYXRj
aGVzIGJlY2F1c2UgdGhleSBhcmUgZmFsc2UtcG9zaXRpdmVzLgoKRG8geW91IHRyeSB0byBhdm9p
ZCB0aGUgZ2VuZXJhdGlvbiBvZiBmYWxzZSBwb3NpdGl2ZXMgZm9yIHlvdXIgc291cmNlIGNvZGUg
YW5hbHlzaXM/CgoKPiBIb3dldmVyLCBJIHN0aWxsIHdhbnQgdG8gY2hlY2sgdGhleSBleGlzdHMg
aW4gZmluYWxpemUgYmxvY2sgYW5kIHByaW50IGEgd2FybmluZyBvdGhlcndpc2UuCj4gVGhpcyBp
cyBzb21lIGtpbmQgb2Ygc2VsZi1jaGVjayBmb3IgYSBydWxlLgoKSSBtaWdodCBzdHVtYmxlIG9u
IHVuZGVyc3RhbmRpbmcgZGlmZmljdWx0aWVzIGFjY29yZGluZyB0byBzdWNoIGEgdGVyc2UgZGVz
Y3JpcHRpb24Kb2YgYSBzb2Z0d2FyZSBkZXNpZ24gZ29hbC4KCgo+ICMgQWx3YXlzIHByaW50cyBb
XS4gSXMgaXQgbm9ybWFsPwo+ICNwcmludChjb2NjaS5maWxlcygpKQoKKiBBcmUgeW91IGxvb2tp
bmcgZm9yIGJldHRlciBkb2N1bWVudGF0aW9uIG9mIHRoaXMgcHJvZ3JhbW1pbmcgaW50ZXJmYWNl
PwoKKiBXaGljaCBpbmZvcm1hdGlvbiBkbyB5b3UgZXhwZWN0IHRvIGJlIGF2YWlsYWJsZSBpbiBh
IFNtUEwgaW5pdGlhbGlzYXRpb24gcnVsZT8KCgo+IGRlZiByZWxldmFudChwKTogIyBzdXBwcmVz
cyBmdW5jdGlvbnMgZnJvbSBibGFja2xpc3QK4oCmCj4gCXJldHVybiBGYWxzZSBpZiBibGFja2xp
c3QgJiB7IGVsLmN1cnJlbnRfZWxlbWVudCBmb3IgZWwgaW4gcCB9IGVsc2UgVHJ1ZSAjIGludGVy
c2VjdGlvbgoKVG8gd2hpY2ggaW5mb3JtYXRpb24gc2hvdWxkIHRoZSB2YXJpYWJsZSDigJxlbOKA
nSByZWZlcj8KCgo+IEBycCBkZXBlbmRzIG9uIHBhdGNoQAo+IHBvc2l0aW9uIHA6IHNjcmlwdDpw
eXRob24oKSB7IHJlbGV2YW50KHApIH07Cj4gQEAKPgo+IC0gZnVuY3Rpb24xQHAoKTsKCkNhbiB0
aGUgdXNlIG9mIGEgbWV0YXZhcmlhYmxlIHdpdGggdGhlIHR5cGUg4oCcaWRlbnRpZmllcuKAnSBi
ZSBldmVudHVhbGx5IGFsc28gaGVscGZ1bD8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29j
Y2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGlu
Zm8vY29jY2kK
