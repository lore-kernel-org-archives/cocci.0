Return-Path: <SRS0=1ddu=H6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A907C433E0
	for <cocci@archiver.kernel.org>; Sun, 28 Feb 2021 20:06:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B128F64E04
	for <cocci@archiver.kernel.org>; Sun, 28 Feb 2021 20:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B128F64E04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11SK6FnZ008991;
	Sun, 28 Feb 2021 21:06:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0A284475C;
	Sun, 28 Feb 2021 21:06:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0CFB13E64
 for <cocci@systeme.lip6.fr>; Sun, 28 Feb 2021 21:02:07 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11SK26td026031
 for <cocci@systeme.lip6.fr>; Sun, 28 Feb 2021 21:02:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1614542525;
 bh=gpTzOnWuznvUvqcHGcZ7eGLjvuhUEfATSqUMhZNe36g=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=ozjp+94RjcqnE7rTaf42qVONP+ilvJVDJY7BTdmpJxP14w7kTDsinYty64nlg/Q+8
 7gKGE4eXZNUPe5hOheTSkoBjaKQsxwVqaEflJKxi+AXjb/yPbgkJ7lfDTJzxZDGBkD
 elZbeHn+hgjws4Y3FEFBa7ldgeB3f5KK0KSvkTBg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.122.194]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lw189-1lsQNc27C9-017j1u; Sun, 28
 Feb 2021 21:02:05 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <alpine.DEB.2.22.394.2102270905410.2926@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <b40328ba-fa6d-972a-3b8e-db5acbdf1692@web.de>
Date: Sun, 28 Feb 2021 21:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2102270905410.2926@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:f8O3t+2v0SUm3I7jIF3I1C1EmQAyHkag3YeOtXjRX54UJza1zJ8
 VTMzfx4YtQYKWIHSxMLOpOWsZasbRAQ9vlAcSJW2pXZZ67m5QDkTl/45uqFlxUcCnrF+1/J
 d+5PCTwpAkO1LrHeGQqtS3VpkEWf4NYCuT/un6spG4vxCtrNpKw0Gs6PlM62pkCRxYaRcmK
 qlHbbbHJEsTOPfzQlPCMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:STpQfM/hMWQ=:tcbcHJtw8R22l7AnfaJTfr
 5ztlPoCAk+x3rMgnBfIjZoKMlHKVsWcE1hLD/UlvPnM1y0GfVmA4OI8hMVTFwNrKsZ9qF+QHN
 6GhoSET5Zk+8j9gJFcjoHI3Wl8Vn+J0igWoOuqst3l/DyF9rLsZpA1Yuaq7OljlukHTBVIJ/+
 ZpaDEeH17/Gdxlfvy3kBvb7q+9HjqYMf+KtqF8FitCVGm3QLmgDjWjnZszR1IUTdnxTz1Zw8b
 p6Q15Mqqxq5aFnaP7uSmE3Kolwa/FipbvPTQKmoLT/8WGIpTWh6fnhJTbtsFxs/lB+/ySHC8C
 BZKINeeolPt1MAFItzv4/PEvasyqJnD26qQTrk20wrAu/y0AJTJj732G6WvS5a5nwSdglHRnD
 nnWKkAIvAmpM1hCROb61nhn8KgSMOoRPal8qTJ1Mw8dK9ap6BoKv4lvpdLxencvITtPukBH+X
 tyuZtgyXGfjzyyYuVRVj5njMLLTgxiGxNL5B1F9YEt1+KH4C5leJvx0Q0lAWHssbzo8DyfYXL
 q8Cw0czsFgKSImMehfSM6e7JCVQBIk9MXPrQvD+Q8hydSiwfytddhVezHczzrS0u+0SL25qmN
 CMpzWEEdrdzQvK06+D1Rxpld9N5MJULGTtd2Bp7+6m7oG4CbUtIg8/WR+kv6+guNFU35k5ouL
 aVJFDcDYxqpJJiDpRk5YCfmgnumOoGDt3F/kFRJcGP6RHOEmV5QLncQugEwKGX38wt9EJeksi
 bzW7U5ZzOKyaYr6i4MT4vLAA4Y1tlExfLbRHya0Mi4FB+nTdsDKFC9x7cP5ehbuu08rMklTlh
 6wI0bVtVGlTdDC1aljpAkaq2b27WN6aJ0G/sWC9+vv4FV53peoYANwrys6hBVljt5zjVf5aSX
 WpFcvQjsFeVYN/PM0qNg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 28 Feb 2021 21:06:15 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 28 Feb 2021 21:02:06 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 28 Feb 2021 21:06:13 +0100
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking evolution according to version 1.1.0
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

PiBBIG5ldyB2ZXJzaW9uIDEuMS4wIGhhcyBiZWVuIHJlbGVhc2VkLgoKVGhhbmtzLgoKSSBoYXZl
IGRhcmVkIHRvIGFjdGl2YXRlIGFsc28gYSBjdXJyZW50IE9DYW1sIHZlcnNpb24gYnkgdGhlIGNv
bW1hbmQK4oCcb3BhbSBzd2l0Y2ggY3JlYXRlIDQuMTIuMOKAnS4KSSBoYXZlIHRyaWVkIHRvIHJl
YnVpbGQgeW91ciBzb2Z0d2FyZSBhY2NvcmRpbmdseS4KCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0
ZS9Db2NjaW5lbGxlLzIwMTYwMjA1PiBtYWtlIGRpc3RjbGVhbiAmJiBnaXQgY2hlY2tvdXQgbWFz
dGVyICYmIGdpdCBwdWxsICYmIC4vYXV0b2dlbiAmJiAuL2NvbmZpZ3VyZSAmJiBlY2hvICIkKC4v
dmVyc2lvbi5zaCkiICYmIGdyZXAgVkVSU0lPTj0xIE1ha2VmaWxlLmNvbmZpZwoKCk5vdyBJIHN0
dW1ibGUgb24gdGhlIGZvbGxvd2luZyBlcnJvciBtZXNzYWdlLgoKZWxmcmluZ0BTb25uZTp+L1By
b2pla3RlL0NvY2NpbmVsbGUvMjAxNjAyMDU+IExBTkc9QyBtYWtlIHdvcmxkCm1ha2UgLUMgYnVu
ZGxlcy9zdGRjb21wYXQgYWxsCm1ha2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeSAnL2hvbWUvZWxm
cmluZy9Qcm9qZWt0ZS9Db2NjaW5lbGxlLzIwMTYwMjA1L2J1bmRsZXMvc3RkY29tcGF0JwpjZCBz
dGRjb21wYXQtY3VycmVudDsgbWFrZSAmJiBjcCAqLm1saSAqLmNtaSAqLmNteCAqLmNtYSAqLmNt
eGEgKi5hICouaCAuLgptYWtlWzJdOiBFbnRlcmluZyBkaXJlY3RvcnkgJy9ob21lL2VsZnJpbmcv
UHJvamVrdGUvQ29jY2luZWxsZS8yMDE2MDIwNS9idW5kbGVzL3N0ZGNvbXBhdC9zdGRjb21wYXQt
Y3VycmVudCcKbWFrZSAgYWxsLWFtCm1ha2VbM106IEVudGVyaW5nIGRpcmVjdG9yeSAnL2hvbWUv
ZWxmcmluZy9Qcm9qZWt0ZS9Db2NjaW5lbGxlLzIwMTYwMjA1L2J1bmRsZXMvc3RkY29tcGF0L3N0
ZGNvbXBhdC1jdXJyZW50JwpvY2FtbGZpbmQgb2NhbWxvcHQgLWMgLXBhY2thZ2Ugc2VxIC1wYWNr
YWdlIHVjaGFyIC1iaW4tYW5ub3QgLW5vLWFsaWFzLWRlcHMgLUkgLiAtYWxlcnQgLWRlcHJlY2F0
ZWQgc3RkY29tcGF0X19hcmdfcy5tbGkgLW8gc3RkY29tcGF0X19hcmdfcy5jbWkKRmlsZSAic3Rk
Y29tcGF0X19hcmdfcy5tbGkiLCBsaW5lcyAzLTE3LCBjaGFyYWN0ZXJzIDAtMzg6CiAzIHwgdHlw
ZSBzcGVjID0gQXJnLnNwZWMgPQogNCB8ICAgfCBVbml0IG9mICh1bml0IC0+IHVuaXQpCiA1IHwg
ICB8IEJvb2wgb2YgKGJvb2wgLT4gdW5pdCkKIDYgfCAgIHwgU2V0IG9mIGJvb2wgcmVmCiA3IHwg
ICB8IENsZWFyIG9mIGJvb2wgcmVmCi4uLgoxNCB8ICAgfCBUdXBsZSBvZiBzcGVjIGxpc3QKMTUg
fCAgIHwgU3ltYm9sIG9mIHN0cmluZyBsaXN0ICogKHN0cmluZyAtPiB1bml0KQoxNiB8ICAgfCBS
ZXN0IG9mIChzdHJpbmcgLT4gdW5pdCkKMTcgfCAgIHwgRXhwYW5kIG9mIChzdHJpbmcgLT4gc3Ry
aW5nIGFycmF5KS4KRXJyb3I6IFRoaXMgdmFyaWFudCBvciByZWNvcmQgZGVmaW5pdGlvbiBkb2Vz
IG5vdCBtYXRjaCB0aGF0IG9mIHR5cGUgQXJnLnNwZWMKICAgICAgIENvbnN0cnVjdG9ycyBudW1i
ZXIgMTQgaGF2ZSBkaWZmZXJlbnQgbmFtZXMsIFJlc3RfYWxsIGFuZCBFeHBhbmQuCm1ha2VbM106
ICoqKiBbTWFrZWZpbGU6MTYxMjogc3RkY29tcGF0X19hcmdfcy5jbWldIEVycm9yIDIK4oCmCgoK
V291bGQgeW91IGxpa2UgdG8gcG9pbnQgYW55IGNvcnJlc3BvbmRpbmcgYWRqdXN0bWVudHMgb3V0
PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
