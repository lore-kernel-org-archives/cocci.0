Return-Path: <SRS0=uT6i=YQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F68CA9EB6
	for <cocci@archiver.kernel.org>; Wed, 23 Oct 2019 14:09:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191A621906
	for <cocci@archiver.kernel.org>; Wed, 23 Oct 2019 14:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jsBUv3p0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191A621906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9NE9KY7021152;
	Wed, 23 Oct 2019 16:09:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 520A877BB;
	Wed, 23 Oct 2019 16:09:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 269B877B4
 for <cocci@systeme.lip6.fr>; Wed, 23 Oct 2019 16:09:18 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9NE9HZH023299;
 Wed, 23 Oct 2019 16:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571839731;
 bh=thrBfTIZn0Xo8KD2USqAVOUR/TzBwrmlYGigvc+aavk=;
 h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
 b=jsBUv3p0ifz/k1uOqyLa5FdgqqKk0TYY96bt9qeRohBStDHfunqpcgeD7+n4A3BKl
 4HUZO6pYrgkmch3rV63hT1+GFF+XzzvFIAPyI35s8NEbRD+LJ+CV0UgnGYOL0pEa3r
 Xz2G21BuXrdg4R/XB0vxAOr0SCBvl7ZzZ7kxpfaQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.140.249]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxOHm-1hvIvh05G6-016vLz; Wed, 23
 Oct 2019 16:08:51 +0200
References: <alpine.DEB.2.21.1910231054250.2335@hadrien>
To: Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2dc38508-b7af-b5bf-2829-52c75514e499@web.de>
Date: Wed, 23 Oct 2019 16:08:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910231054250.2335@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:3MsvW4J/EgMNOu/jrpLkCHoMI0E63eNLqvDaSmqdhmijs3FY0jF
 TXq9FuAgZYSLmpfs9gnVBAxzXe1gjQ0OZdpvwLCRz0mm6vKzb/bv14q3vCIu/6fKl3ISRTZ
 3PCNoWh4NeKjyB27HCZbGD0n8/6Nf7MQQ8KtPvV4OdIQJwCGGwxrONB7HGDng8wbjpO5Q+0
 PjHt51Z0zE+X499KHIvHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7VG5PPrXF3c=:ZQMZee/t9aY2ckhZHUZn2q
 nXhLj5HW1r5Zp0K9fiw4xMzE1S0KvNn4s4gDUpcvx1H2dLw1NVvZ9YfvnNDCluNqdq6Vr28Zu
 LCtunZsZFqLp9PgEP+XS3RwbT2UcKCYxSIQ0eYhY9Ltxp4g9s5dSf6oLcpO+CV0WZSHCNZsam
 90eOIFzd+HQnOxpUD/5Z2B1Gce+uvelRcf0/181kjo3nIQlgiFF5sCixh55zsMgvbZ7LSty5w
 J9CyczcWxb+EIe3ldEJLOXnSEI/3iRhKbyBgMqTJk3g+HghMIwsHy+wV+O8MRd6Vyiw6vBlrD
 j1+0xNCQsUtsovVIN5seem37Z0XuIp+t08iU15YBMkJALQf8wWN9Yw8JFle8udo9R1aGT/B7N
 UvhRy9nAGvSvVxfn65BL79SdNXxspsdOFzvEWXmCDwSG6+7pg8be+/jH29q5arVzXZKCMR5wE
 FCVMgVSAn77bO6XqbQzRfzJ+4f8uS/lVRs1aQru1q+9E1s0QaUImoD3oswL8fYpm60E/1Kv4C
 vtqazmdJUpZfq1JfOgcciW1vbDO1si/pKJ23xK6w8BIrUVH2D8GEqUElG5XuRIePIQxacckv1
 raiqH88+klkj6FslnRwAdji/psy6N0GFYsjTNa5l30G3ygyfOchNDpx8bn5oufKU4FJWhNqrH
 azihxe6jPb5M4IQCSeJeIulsdnFYbNemxEm+hTZCzGQWQPifAHKfBHZaWviclI8/IM0wpl7fN
 zaz54Brbe/AV9il+ztKf3qqJriIWyrU+rKl2+ZRn0YHs77vlENfq+rxqQjOZWPtxv/5rQAWgT
 MT1JMHiSRwD29ZZtwRNaNC646WWYHEJe2HeC+b+Rlcqf+8BZDTOFhg+lRWYhGNnQ232CxPFbB
 detSGCg6Drs7+3oucoVhHqplGHq3DM2hHTY9G04oPsw+kwAOLjT1dLh7FQ4PMOH1BfRaUn/SX
 oFB5W0pFOnQkG0yT3+gc78e91vuj3aSmbF52aHI127YnLs4KxyeeFPeIJzzt4jEOcertsnoUk
 vjk0m50MoNOhaHK6HjTUEG9R2JNiEI2eSuB4vhLDc59JSrqeb+Sz1uvs5AF69AdBBQ/Gc+6i+
 SK3DQiPASDQTiJLJy++3k32/DwONF+Axw0acfU1bEU5U9DPZfCKkBOlv6N7qMXtrrE+Ct8tF+
 r1uHtjgB3+EBOsBwn046h6nr+t2SLjTzrp/h9Tqeyj84iaHCTZRCrxpyid5EC9OOtXqefZgDI
 IXVDJLQQOTPixnvSf0OcnL4+Jdq5ipYn5ZqZvJh+i1bAwFVTmS9CLjvwOOkY=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Oct 2019 16:09:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 23 Oct 2019 16:09:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        zhongshiqi <zhong.shiqi@zte.com.cn>
Subject: Re: [Cocci] [PATCH] coccicheck: Configuring COCCI parameter for
 supporting a directory search
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

PiBXaGF0IGlzIHRoZSByZWxhdGlvbiBiZXR3ZWVuIHRoZSBsYXN0IHR3byBpZiBicmFuY2hlcz8K
CkEgc21hbGwgYWRkaXRpb24gaXMgcHJvcG9zZWQgZm9yIHRoaXMgYmFzaCBzY3JpcHQuCgoKPiBJ
ZiB0aGUgZmlyc3Qgb25lIGZhaWxzLCBkb2VzIHRoYXQgbWVhbiB0aGF0ICRDT0NDSSBoYXMgbm8g
ZGVmaW5pdGlvbj8KCk5vLiAtIEl0IHdhcyBjaGVja2VkIGlmIGFuIGVtcHR5IHN0aW5nIHdhcyBw
YXNzZWQuCkEgZmlsZSBzeXN0ZW0gY2hlY2sgaXMgdHJpZWQgdGhlbiB0byBkZXRlcm1pbmUgaWYg
YSB2YWxpZCBkaXJlY3Rvcnkgd2FzIHNwZWNpZmllZC4KVGhpcyBwYXJhbWV0ZXIgY291bGQgYmUg
dXNlZCB0aGVuIGZvciB0aGUgc3BlY2lmaWNhdGlvbiBvZiBhIHNwZWNpZmljIHN0YXJ0CmRpcmVj
dG9yeSBmb3IgY2FsbGluZyB0aGUgdG9vbCDigJxmaW5k4oCdLCBjb3VsZG4ndCBpdD8KCgo+IElu
IHRoYXQgY2FzZSwgaXMgdGhlIGZpbmFsIGVsc2UgdXNlZnVsPwoKSG9wZWZ1bGx5LCB5ZXMuCgpX
aGljaCBzb2Z0d2FyZSBiZWhhdmlvdXIgZG8geW91IGV4cGVjdCBmb3IgYSBzdHJpbmcgd2hpY2gg
d291bGQgbm90CmJlIHJlY29nbmlzZWQgYXMgYW4gdXNhYmxlIGRpcmVjdG9yeSBpbiBhIHNwZWNp
ZmljIG1vbWVudApkdXJpbmcgc2NyaXB0IGV4ZWN1dGlvbj8KClJlZ2FyZHMsCk1hcmt1cwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5n
IGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxt
YW4vbGlzdGluZm8vY29jY2kK
