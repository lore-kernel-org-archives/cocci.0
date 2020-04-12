Return-Path: <SRS0=MFMu=54=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D867FC2BA2B
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 14:35:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11157206E5
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 14:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="T/cngMzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11157206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03CEZG7J006642;
	Sun, 12 Apr 2020 16:35:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6719D77F9;
	Sun, 12 Apr 2020 16:35:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7F366775A
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 16:35:14 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03CEZDLp019751
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 16:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586702111;
 bh=4Djx5djuGB/o/PY5zisp9Lis4t8ESrsLnhJ34bC74y8=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=T/cngMzPrpkPd/VMSVB+Y0TFM6fkOzQJEXoYJkcQif6dHh91ldPfomXjBJeLLZGi/
 ac0Edfboq9Q8/mT6GNZz7WyE+OT1LbJrsQ+yYhdi/LBCnbTlt6zF+xEQaSBqQMNWCp
 lBg5czRbzTFH30OUsDFA6HrRS3+H8dH1LaD4Zgk8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.125.27]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MN4Oy-1jLStz33Xc-006izU; Sun, 12
 Apr 2020 16:35:11 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
 <37f5b3b3-0971-89e1-5010-9924e5b50810@web.de>
 <alpine.DEB.2.21.2004121526470.2419@hadrien>
 <924f5f7f-11a5-816e-0760-3a01cca58696@web.de>
 <alpine.DEB.2.21.2004121624180.2419@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <47a4593f-986a-b528-a537-8a94105195f1@web.de>
Date: Sun, 12 Apr 2020 16:35:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004121624180.2419@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:XvfaZTY9bWIqcVuLvJNy6Z5d7lJi9hMRMBXY08lRtgSPuACuAWP
 5KgZktiOx0TTWRAOfw9cInY+6cn4fQYnveRnGbSm+cTaGy8aAK92GpB+8ARdgDse87TB8gi
 Kzjor7FDP6oP4FO6pNQxbB7ltuTq7kOGEIh0xsyATM00+52EYfWRlqN69+iScl8JSxdku+C
 jmNU9LgcPIWid/4FQblxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/LsIh9fxRe4=:xOdcuZ8oZ+VZiKzi86hpOr
 pdfqYDmqzF7iGWZ904x5JEHemmqOnWz4Ach1DvS6GnPqNZYBm5qT/dBHlEcvduF6DvVurzyys
 XIl5v5aDNlmLWNeyNa9rndp3ssvY8Pxkl6JiVB4i1b19O1SxvA+iamWTxx3kt3BLL3njct+Ct
 GEkK5rM3VRx1qhHJ8JzvOaTxf/kf3LRW3b3Nd6zq3qC2MhSr/xY7GH2ZSnmdstdHstzMjtUUy
 2evxvCIIdKv5qcYWM09Mxu/pqBT7bcMaoacCflUJAIIyGKZqpzyDEvfjXCeWiOL7sHg4lgI43
 4ZLDC6+0yNBcSzDLONAYNt6d9/ObOM6+TrQXb9zxTaCepHCiGJvRUsL7vFQB+gp5sZArWhboH
 EjWI2D1udaWHj8ZMijDZWXo34lbWpBBoH0WJyuCk6R7urGlCQH+VU6Nn+itVnmEzjEwis5YAt
 YRXaJrX1M7Ck+pnE87OZsQc68k9IZxzVNhPdyTckam4e2LeuesfiUOkGgxFRkBoCc6+xaR8Kd
 aczOkFF6EQMPudL0YJdXQYHrmQOAQwwRM03ZLraRoq4t+pTosM0DGoZ6j+T5Lf84ytYTq147t
 YTKQPXcgyhhtc21sr20n47o5d6ACWni049LNk4xSe/KWCyguanlpZJNOcoPS0BZHKVeJcbiN+
 zc4mnhY21cSvX77tOeXFtgNPojkZQ1Rd9a99FfkLt4/LiZCaWuTOPqBrGJPA1Uv4D9pjaRKSg
 +Hs5NkQNb1Jfzg6PvT2L+8p7kBe2HzfInEYiubIm0Hu3UbUSznjs7AGKwxOlJrXk37l9n4M48
 hsd27xo+EOTG3QYZcRNJnv/W8iPZg7agWWgYYz0Ce7C4/PmHoA+ptovlMIP5RHi7RyByc7OCg
 FdDCAmA3v7gGKxuiw1U0aznM8MaZrjaf8O3fDY9vLSkL+j5AmH10XRnxJeNYWnssL8/IzMr12
 0u+N7sJybJNGgf/wEEYDpszeRDtBQUClusfM09rW7huKSeM8OFrB+tOliGjkBFaacOOjIjpDO
 H5j8sEAGmMYIoUZ+Hr7EeqdtIIiiblbX+LinyQmJq/bUURHjQ5PM9x3k6LTPMnE5fi6Jdyb0B
 /Q1NhChzD23su407VAgs+UxRCkv53RSrZCtIo/Fwi9gBZtkxz5KEBvFcmhapmzJlvVvp14E8Z
 ItZpeF4blHphWBGpepbXy9To4MzDEDjCwSTTQg3afS26w9+bi+5vETGbQTzveNika614iRrly
 TnWXfNBJ7iGFIs6M0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 16:35:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 16:35:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reporting variations of condition checks according to
 function calls
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

Pj4+PiBAZGlzcGxheTJACj4+Pj4gZXhwcmVzc2lvbiBjaGVjazsKPj4+PiBwb3NpdGlvbiBkaXNw
bGF5MS5wOwo+Pj4+IHN0YXRlbWVudCBkaXNwbGF5MS5pcywgZGlzcGxheTEuZXM7Cj4+Pgo+Pj4g
VGhlIHByb2JsZW0gaXMgdGhhdCB5b3UgaW5oZXJpdCBlcy4gIFNpbmNlIHlvdSBpbmhlcml0IGl0
LCBDb2NjaW5lbGxlCj4+PiBjb25zaWRlcnMgdGhhdCBpdHMgcHJlc2VuY2UgaXMgaW1wb3J0YW50
LCBhbmQgc28gdGhlIGlzb21vcnBoaXNtIHdpbGwgbm90Cj4+PiBlbGltaW5hdGUgaXQuCj4+Cj4+
IFRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbiBvZiBzdWNoIGNvbnNlcXVlbmNlcyBieSB0aGUg
bWV0YXZhcmlhYmxlIGluaGVyaXRhbmNlLgoKSXQgc2VlbXMgdGhhdCB0aGUgc3BlY2lmaWNhdGlv
biBvZiB0aGUgaW5oZXJpdGFuY2UgZm9yIHRoZSBtZXRhdmFyaWFibGUg4oCcZXPigJ0KY2FuIGJl
ICh0ZW1wb3JhcmlseSkgb21pdHRlZCBhcyBhIHdvcmthcm91bmQuCgoKPj4+IEl0IGlzIHN1ZmZp
Y2llbnQgdG8gbWFrZSBhbm90aGVyIHBhdHRlcm4gZm9yIHRoZSBjYXNlIHdpdGggbm8gZWxzZS4K
Pj4KPj4gSSBtaWdodCBzdHVtYmxlIG9uIGFub3RoZXIgc29mdHdhcmUgZGVzaWduIGNvbmZsaWN0
IChvciB0aGUgbmVlZAo+PiBmb3IgY29ycmVzcG9uZGluZyBzb2Z0d2FyZSBleHRlbnNpb25zKS4K
Pj4KPj4gSSB0cmllZCB0aGUgc3BlY2lmaWNhdGlvbiBvZiB0aGUgU21QTCBydWxlIOKAnGRpc3Bs
YXky4oCdIG91dCBiZWNhdXNlIEkgd2FudGVkCj4+IHRvIGRldGVybWluZSB0aGUgc291cmNlIGNv
ZGUgd2hpY2ggd2FzIG1hdGNoZWQgYnkgdGhlIFNtUEwgbmVzdCBjb25zdHJ1Y3QKPj4gaW4gdGhl
IFNtUEwgcnVsZSDigJxkaXNwbGF5MeKAnS4KPj4gVGhlIHNwZWNpZmljYXRpb24gb2YgYSBTbVBM
IGRpc2p1bmN0aW9uIGluIHRoZSBmaXJzdCBydWxlIHdvdWxkIHRyaWdnZXIKPj4gb3RoZXIga25v
d24gZGV2ZWxvcG1lbnQgZGlmZmljdWx0aWVzIChvciBvcGVuIGlzc3VlcyksIHdvdWxkbid0IGl0
Pwo+Cj4gTm8gaWRlYS4KCkkgd291bGQgcHJlZmVyIHRvIGZpbmQgdGhlIHNob3duIHN0YXRlbWVu
dCBjb21iaW5hdGlvbiBieSBhIHNpbmdsZSBTbVBMIHJ1bGUuCkNhbiB0aGUgbWF0Y2hlZCBzb3Vy
Y2UgY29kZSBmcm9tIHRoZSBjb25zdHJ1Y3Qg4oCcPCsuLi4gZSAuLi4rPuKAnSBiZSBhc3NpZ25l
ZAp0byBhIG1ldGF2YXJpYWJsZSBsaWtlIOKAnGNoZWNr4oCdPwoKUmVnYXJkcywKTWFya3VzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxp
bmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFp
bG1hbi9saXN0aW5mby9jb2NjaQo=
