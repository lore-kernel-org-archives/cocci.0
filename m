Return-Path: <SRS0=tjLV=SO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B16C10F0E
	for <cocci@archiver.kernel.org>; Fri, 12 Apr 2019 07:43:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B1820850
	for <cocci@archiver.kernel.org>; Fri, 12 Apr 2019 07:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LUBKIrSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B1820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3C7hNil014097
          ; Fri, 12 Apr 2019 09:43:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2C51F7727;
	Fri, 12 Apr 2019 09:43:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9C891771D
 for <cocci@systeme.lip6.fr>; Fri, 12 Apr 2019 09:43:21 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3C7hK3V014047
 ; Fri, 12 Apr 2019 09:43:20 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555055000;
 bh=nK/0tb+stKfRamfIEHEGe9wtJXGboPaZn/h4P4P3C00=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=LUBKIrSsgTDFMkWrseWUa8sF/aCcaVEuc59xkR8UL94AgTa+SBtWYYscdBOb1SdEO
 4GVfB8NPv9jwwMcstfuW6RjEA6/gcANOxq/NSAGMQlrM8kQ8WTV+bvLR8kQMi3cZvE
 f1MsjLneSleoiYLQKUv85ZiOE9GFuwQdDi7+n96Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.147.79]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaZQd-1gbAFL0dP5-00mOTx; Fri, 12
 Apr 2019 09:43:20 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <ce2b0c4c-bc85-0341-ca0a-9b158804943a@web.de>
 <alpine.DEB.2.20.1904111728380.3143@hadrien>
 <1e5ae213-aa99-576b-8c1f-d0b8ec391dae@web.de>
 <alpine.DEB.2.20.1904111749350.3143@hadrien>
 <f0095a4f-51b6-5364-e3e0-0d1aec2e0ad5@web.de>
 <alpine.DEB.2.21.1904120912270.2733@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7c773464-9cdb-339b-4917-de091cabe4d4@web.de>
Date: Fri, 12 Apr 2019 09:43:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904120912270.2733@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Kbuu4HgrzPbQltuoDGLmGE56OLXBOMn8QkV5WXpKfjDCawRGJJ0
 5kBFZutBr32glg3u3DtzrSurqkj9linPdjwixpt5W6JuXTXaxoEsbH+V9ju+adVs6p7R/kX
 6JhLtvnVJI/Ab9VUBKKxW+sA3IAGJLQ4pQ+fSrNEj9SYKaPgd80YtywpqsR4Uvhllzzh9QK
 4ygBHAFro1yRL3gtvDeaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ti51ySS6qqE=:5y7FvmSv9B5lLeNl4wwLnZ
 gTB6z6cDAjtCHyjIkwHiy///0EOAK3HUOkP1JYNNVGx9iv57K013Ab1jkIGxwA6Vy5g9fcAOW
 oyyVpsrSAWUrFWdzknbg22Fi8j0jsA8iS/lePyW0bq6jMP1RqKa6f7ZfHj+LvkfK0mE7qnWQV
 mohHm8+duCo5/fRmaLC1MlM+74QVCcAwAdsOf4ap/PEs7EsxQEY9G3nNTNzIrUPDLFut/IkqF
 PfnOOnBlWJtLUpWBQ9FPXMkuDTAN7R4LHh7iQ8zLBLgNaED1NgsT7XJa7wdKO04kpdj9Acw8W
 UjP5VzVaGoQwiJ19vF097WwvtiVMMGtCtptH0o4RVADn2FCkYYnkWbugGHc21QR6/ksXpXGxs
 O/OLJtTfvGZPTRl/iPnKkBA+WHs+cnm+zddpsL7tji5E0Gd+x/ujUcGnsOT1PqETNq8SFyIfq
 KCKLJ7/g6ccGE4WLUGSi4ZBYdPj9zs2KetQUnzJ8afGd0ZSKPfQwJqGwzQ/5SlTFfTQn4CVn6
 1esEmD06TQtGSbJik5haWHzu73osafKKn4zMNYhgbwM8UIimvniAh/vNHY+6Ea/HvrqJ2mRvG
 lFrGWA9yoTCDFykNzIk0FWejPZKVqpcMWcmE5qZiof2RACLUp0H/rmNmN9EUic+iLfxDiXhBh
 G2Obxcz2DBwhALa1DXXCPHJCQH2M1yy4akN9sp2k5LMLpcHYRQyaQ9qUfvoEasPiDnSzoBtH6
 w1KPmJNfWpLAEaXMNBDgccS0bkEi99oYsMqdlLU3MHrvZ8BNHG+kTrFBpHiYMFmrtnZEFqFfl
 PUQAgjebgfGwPPVeMNIuT0cPk/goLG5FZEU3UtN/oYIrd1EhYtlZIa071FdIP+/sskI2sd7cJ
 NVVWZOOFtzSlmLLp0sNN2TP5W2zyTytg0J7lAHvfn1g8V3FTbBsofTaQqJ4GQ55XkI02iqBw9
 wuHc62S/6Rg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 12 Apr 2019 09:43:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 12 Apr 2019 09:43:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Searching for duplicate statements in if branches (with
 SmPL)?
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

Pj4+IElmIHlvdSB3YW50IHRvIGJlIHN1cmUgdGhhdCB5b3UgYXJlbid0IGluIGEgbG9vcCwKPj4K
Pj4gSSBkbyBub3Qgd2FudCB0byBmaWx0ZXIgb24gdGhpcyBpbXBsZW1lbnRhdGlvbiBkZXRhaWwg
Zm9yIHRoZSBzaG93biBhbmFseXNpcyBhcHByb2FjaC4KPgo+IEkgZG9uJ3Qga25vdyB3aGF0IHlv
dSBtZWFuIGJ5ICJJIGRvIG5vdCB3YW50IHRvIi4KCkkgc3VnZ2VzdCB0byBpbXByb3ZlIHRoaXMg
Y2xhcmlmaWNhdGlvbiBieSBhZGRpdGlvbmFsIGNhc2UgZGlzdGluY3Rpb25zLgoKCj4gWW91IG1l
YW4gdGhhdCB5b3Ugd2FudCByZXN1bHRzIHdoZXJlIGJvdGggbWF0Y2hlZCBpZnMgYXJlIGFjdHVh
bGx5IHRoZSBzYW1lLAoKSSBzdWdnZXN0IGFsc28gdG8gYWRqdXN0IHRoaXMgaW50ZXJwcmV0YXRp
b24uCgoqIFlvdSBhcmUgcmlnaHQgdGhhdCBzdWNoIGEgc3BlY2lhbCB1c2UgY2FzZSBpcyBzaG93
biBieSB0aGUgdXBkYXRlIHN1Z2dlc3Rpb24KICDigJxldGhlcm5ldDogdGk6IGVsaW1pbmF0ZSBh
IGJpdCBvZiBkdXBsaWNhdGUgY29kZSBpbiBnYmVfcHJvYmUoKeKAnS4KICBodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAxOS80LzkvOTc5CiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3Jr
L3BhdGNoLzEwNTk4ODgvCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8xNTU0ODY0OTM1
LTgyOTktMS1naXQtc2VuZC1lbWFpbC13ZW4ueWFuZzk5QHp0ZS5jb20uY24vCgoqIEkgd291bGQg
bGlrZSB0byBzZWFyY2ggZm9yIHN0YXRlbWVudHMgd2hpY2ggd2VyZSByZXBlYXRlZCAoZHVwbGlj
YXRlZCkKICBhdCB0aGUgZW5kIG9mIGRpZmZlcmVudCBpZiBicmFuY2hlcyAoYWZ0ZXIgdmFyeWlu
ZyBjb25kaXRpb24gY2hlY2tzKS4KCgo+IGJlY2F1c2UgdGhleSBhcmUgaW4gYSBsb29wLAoKRHVw
bGljYXRlIHN0YXRlbWVudHMgY2FuIG9jY3VyIGFsc28gdGhlcmUuCgoKPiBvciBkbyB5b3UgbWVh
biB0aGF0IHlvdSBhcmUgdG9vIGxhenkgdG8gZXhwcmVzcyB0aGlzIG5lY2Vzc2FyeSBpbmZvcm1h
dGlvbgo+IGluIHlvdXIgcnVsZS4KCldlIGhhdmUgZ290IGEgZGlmZmVyZW50IHVuZGVyc3RhbmRp
bmcgZm9yIHRoZSBkZXNpcmVkIHJlcXVpcmVtZW50cy4KCgo+IEluIHRoZSBsYXR0ZXIgY2FzZSwg
SSBjYW4ndCBoZWxwIHlvdS4KCkkgYXNzdW1lIHRoYXQgdGhpcyBpc3N1ZSB3b3VsZCBuZWVkIGFu
b3RoZXIgY29tbXVuaWNhdGlvbiBhcHByb2FjaC4KCgo+IElmIHlvdSBkb24ndCB3YW50IHRvIGRv
IHdoYXQgaXMgbmVlZGVkLCB0aGVuIGZpbmQgc29tZSBvdGhlciB0b29sLgoKSSBob3BlIHRoYXQg
dGhlIHNvZnR3YXJlIHNpdHVhdGlvbiBjYW4gYmUgY2xhcmlmaWVkIGFuZCBpbXByb3ZlZCBmdXJ0
aGVyLgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
