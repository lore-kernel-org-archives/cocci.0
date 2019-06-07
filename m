Return-Path: <SRS0=qtAw=UG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FFBC2BCA1
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 18:49:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C3B208C0
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 18:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="A4LLpbCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C3B208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57In0kr013597;
	Fri, 7 Jun 2019 20:49:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3F98D7770;
	Fri,  7 Jun 2019 20:49:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 59CA2776C
 for <cocci@systeme.lip6.fr>; Fri,  7 Jun 2019 20:48:59 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57Imw9w011620
 for <cocci@systeme.lip6.fr>; Fri, 7 Jun 2019 20:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1559933338;
 bh=DIeV+Ud8yUp7axc9FSoho4JWtqwBlaSWNfpF1s60O5U=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=A4LLpbCTpobL3PnIfDrTq4XD8y/ANxwwMr0EvQF13WaIlvmXboM8fw0optwytVxHj
 7U6HilCScvH52iGJeW9tOizv7svZzxCmDWgTM+XGF2Szy6y/anNZ8T12Um3/QG4FFE
 2v4yMcYYBkaqbgE/nzohCkSIN7UKkLBLQfsY7DGg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([93.133.66.13]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgHPM-1gnq1e1T5I-00ngkf; Fri, 07
 Jun 2019 20:48:58 +0200
To: Enrico Weigelt <lkml@metux.net>
References: <5c138195-ac1a-4ad6-c6e6-720acd4ea34f@metux.net>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <111faed6-ada9-63d8-b09c-2e6faf678351@web.de>
Date: Fri, 7 Jun 2019 20:48:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5c138195-ac1a-4ad6-c6e6-720acd4ea34f@metux.net>
Content-Language: en-GB
X-Provags-ID: V03:K1:NSfZz/1foQ/nUAkv62uFxyxo2u4T+ZrcA7MKm6ZB7TD0BoRbytU
 z5YCcO9jJD7TabBnVx19wl9zrLtdqkJht2NsZhRlryk05+pqWcJPlNf7sDsuJwODeQmN3Ni
 ZEz4eKPPobjZjsiLo9l15dzbo96iEYyjkAdPpCFkBPp2VWd2t6ValgRxDuovObgum8e+Jeu
 jFj98VpsM6bJiAUtxWg0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KZcdwU2FPq4=:DMA/qCBhxG5JjGl2uJralN
 RFuSap9SumDT7rZWc9x1splZkpnsGT9CzDSxyxIpDgBgd9jkjPrKT09f+jZxLkVEqoEK5yvTB
 vWBc1BOzOl/l4GVd1dJa14Yyzjar/TcLGeD1lN1IBeWoh6NRZvoj5um7ZDAwnjhdUKZX2qzZM
 bmcmErsfYR1OfOkNHVRXhsI39Owb4Dp47e/p+ZXI0bgwj56Po+xnbxk/jdI8qtXLuVg5p3I8f
 Pn5avCzLe7Yz6GYjuVvrQkTBukFoPzJ1UxboTd4odGyPkZKHD/2weVXBIiOs97FfGqtSYxUBT
 hguejuiNo6+LRmtPXoLT+um8x894s4KIleeUJjTfH5oh5/Q4c2xU+6BMe1++S7PZ6U7jLlJ58
 7IUBK5wn2vZx2DBGwQvbmGWHZvT0KDyRAmAyA0NSLy03ogXsWPGErNNEt8Ud/Q0hpXu8yo74C
 8d7yHW77rCXGLCylS3dbyEybpg+ouKTeSmTGFSzkrzBhxPdVUFJUznv+RM2AP4LsGNb9bNBRH
 Q0y9opGHgCFxYESlX17n8bEd1yjc2D7l6zWamCWVORKlNPI65UXTGND52SV1dBli+4VfM0HgC
 Z4Kbqh8Y/hlQlHcwG39jU9qdwjVxOevQ1IGPtbotJT6+GgWhAxneHcwcYOyXpS2hlV0kMBZQ6
 DL3CExQBzrm9tphJJOSzuk67OR8ajx+WSXWJzUmK3n3w/SxungN8sT4ib+g4niymeppXFN0h5
 EQ0vplVIvCKCq7Wsw0Bo71MsObl6z9TPDT34/XBDr+Z42GfUH3gHCRFDoj4UaIjO4p58OD/ZE
 kU3wvUZViUTdIUFMm+fCUDZJ8XMrnyusBChqcCV+927ReInOOf7B3wAQYSZ2b7MC3LjeCfk3V
 8Q53AM3KsMXmszSb602diuN4F+kMAdoRE/SWRH2M1VuGheyUKGyau9/cidqw5fRL8N2VERN+S
 BaUISCOFPkkdF1H06UOrVjDK7fKacI87BotSlXJsPpVmaBFTpQEOS
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Jun 2019 20:49:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 07 Jun 2019 20:48:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to replace obsolete #ifdef's?
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

PiBKdXN0IHdyYXBwaW5nIHRoZSBhc3NpZ25tZW50IGludG8gdGhlIG1hY3JvIGNhbGwgdHVybmVk
IG91dCB0byBiZSBlYXN5LgoKSSBhbSBjdXJpb3VzIGhvdyB5b3VyIHRyYW5zZm9ybWF0aW9uIGFw
cHJvYWNoZXMgd2lsbCBldm9sdmUgZnVydGhlci4KCgo+IEJ1dCBJIGhhdmVuJ3QgZm91bmQgYSB3
YXkgdG8gcmVtb3ZlIHRoZSBub3cgI2lmZGVmIDooCgpUaGUgc3VwcG9ydCBmb3IgcHJlcHJvY2Vz
c29yIGZ1bmN0aW9uYWxpdHkgaXMgbGltaXRlZCBieSB0aGUgc2VtYW50aWMgcGF0Y2gKbGFuZ3Vh
Z2Ugc28gZmFyLgpXb3VsZCB5b3UgbGlrZSB0byB0cnkgYW5vdGhlciBTbVBMIHNjcmlwdCB2YXJp
YW50IG91dD8KCkByZXBsYWNlbWVudEAKY29uc3RhbnQgdGV4dDsKZXhwcmVzc2lvbiB2YWx1ZTsK
aWRlbnRpZmllciBteV9uYW1lOwp0eXBlIGRyaXZlcl90eXBlOwpAQAogc3RhdGljCiBkcml2ZXJf
dHlwZQogbXlfbmFtZSA9IHsKICAgICAgICAgICAuZHJpdmVyID0gewotICAgICAgICAgICAgICAg
ICAgICAubmFtZSA9IHRleHQsCi0gICAgICAgICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9
IHZhbHVlLAotICAgICAgICAgICAgICAgICAgICB9LAorICAgICAgICAgICAgICAgICAgICAubmFt
ZSA9IHRleHQsCisgICAgICAgICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNo
X3B0cih2YWx1ZSksCisgICAgICAgICAgICAgICAgICAgIH0sCiAuLi4KICAgICAgICAgICB9OwoK
CkRvIHlvdSBmaW5kIHRoZSBmb2xsb3dpbmcgdGVzdCByZXN1bHQgYWNjZXB0YWJsZSBmaW5hbGx5
PwoKCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IHNwYXRjaCB+
L1Byb2pla3RlL0NvY2NpbmVsbGUvUHJvYmUvV2VpZ2VsdDguY29jY2kgc291bmQvc29jL2NvZGVj
cy9wY20zMDYwLWkyYy5jCmluaXRfZGVmc19idWlsdGluczogL3Vzci9sb2NhbC9iaW4vLi4vbGli
L2NvY2NpbmVsbGUvc3RhbmRhcmQuaArigKYKQEAgLTQ1LDkgKzQ1LDcgQEAgTU9EVUxFX0RFVklD
RV9UQUJMRShvZiwgcGNtMzA2MF9vZl9tYXRjaAogc3RhdGljIHN0cnVjdCBpMmNfZHJpdmVyIHBj
bTMwNjBfaTJjX2RyaXZlciA9IHsKIAkuZHJpdmVyID0gewogCQkubmFtZSA9ICJwY20zMDYwIiwK
LSNpZmRlZiBDT05GSUdfT0YKLQkJLm9mX21hdGNoX3RhYmxlID0gcGNtMzA2MF9vZl9tYXRjaCwK
LSNlbmRpZiAvKiBDT05GSUdfT0YgKi8KKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRy
KHBjbTMwNjBfb2ZfbWF0Y2gpLAogCX0sCiAJLmlkX3RhYmxlID0gcGNtMzA2MF9pMmNfaWQsCiAJ
LnByb2JlID0gcGNtMzA2MF9pMmNfcHJvYmUsCgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApD
b2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0
aW5mby9jb2NjaQo=
