Return-Path: <SRS0=gsjE=T3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13667C04AB3
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 12:00:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806A020883
	for <cocci@archiver.kernel.org>; Mon, 27 May 2019 12:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="oXRjJlZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806A020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4RC0EgD006746;
	Mon, 27 May 2019 14:00:14 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9CE8D774E;
	Mon, 27 May 2019 14:00:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 66BC97747
 for <cocci@systeme.lip6.fr>; Mon, 27 May 2019 14:00:13 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4RC0Cf1026454;
 Mon, 27 May 2019 14:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558958412;
 bh=sYxkmoutk4f70bVnouIsaQzyfAnHNsbP0nHuEpQal5c=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=oXRjJlZcLcmM3kDme7lgH5d6cyQIvixms7V50aeH2ipUaYrootW44ZpWen2cQgRg/
 M2RR9S93G0gUYbHrtdnQ0yxGhFiHtydd39Q0SbgzMbqxR6Sd9P4hqKY0zzjAWlLPW/
 75fa9L4MY1zTToOZAcXSzJhDhjhStmVgXE5xIvDc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([2.243.140.65]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPHC8-1hZc1E0Dmy-004QDV; Mon, 27
 May 2019 14:00:12 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <7be9b8ed-cb53-bd25-cbcf-638abe5de086@web.de>
 <alpine.DEB.2.21.1905270727490.2513@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a238e87b-f89b-ab3e-d1b2-161ec2734faf@web.de>
Date: Mon, 27 May 2019 14:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905270727490.2513@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:CWdmeunATNYUTQKD+T7xR1j2tZiCEUxJyntL8/RAxhEI5DH66cS
 5C3dd82Mp240sCotOnnf454NVaYeAVp1eLZzREkRi0LUqZv62zHqBKUJyFXWQEbGtd/ZQmQ
 QpEl424KaZVrji58bzGQ0eqI+aBd5OwAInIaKn3E4JjxpA/OA+DQXzAv6g4m0xiKwMOb3sm
 wVbZhI8zntDjaqTZidDfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kULZSC7Gg4o=:0EJQ47VeeWn9p82PvSztk8
 Yf6uxdQHnQFQbfFwCkZj7GdrVrgZbtf4CNaIArMV4IxmD0t/Piy3hdYg1FBt/JorVE4L54HpK
 zWmGmfyWXe4FLiI3a8bqHF5F+fvo4KtV7bulQzD/iPYEVsgvj4xRvM1cw7V3c9bu7Y3cw9FkN
 Am9O/GAjSWt6QCocfRPnozeHyPn6/zmRtjlJlnwh+PoJ6uqLY3u9iXMyu60zN0gs1m1GhlQdn
 xZ1/w0kFKvT/eeaXOcPEf3uH8qRrS34SpIt8kQl8FuA/BBwnK5oKxzO3jkmwL2AKCvHbpXYzc
 LKSMBAinfJL7dHeAuTA6gLklOt/ld2+5Ti/utarI7Cudh1u8BfA9CldeNR1VZO+6JfmX8/eQy
 rKG4DoKmMQtQlP7COma9Vq18kVfXqC9BE+7fhSp4t4JIRf5uQuHIAfAFTTrOB7mIjpIBUVGWF
 JWQNWBhX8gS8Kk+oMXMb37dirTT90JqGPvkLPINmENVhxu5nEmo3aAP6AfK7BcW5N4IFwV2lA
 J0juSJApm98M9FV9jvnzJvBOw+SYgXymwm7MM3N07fK1swkEYuwSC9qcXdMybCkuKSkXjyTIz
 bIgb8LMRk65v7yg25AegiQ0y8lLitQZR3AVpB+BLT6ufTeZSuKgbtBa8h+qDPX1F5Vwot15zl
 7J52etKWVXDw7X2bFjbf5ukdM98HOTRW9fbZE4TkMfNJdEth+s1kd9k2Oct2ohg5VQQuRRdPQ
 mI/0f63wMiVAP6trNQuM0Hfh5YmI91gg0rTmHlPtytzPYaiAQ54A9v1xQNYkKEDWrdCrewP7e
 stj/Met0nxCiyenWrNldhBzMYZHrscdG9qf5lOX4D8JoXRbCO4H2OpA4Womt1EMPPhlWgPE6m
 ZeBf7JmIbs+4HMQRmxDXD/viG2XZBh2uNgCix8kDfbNs0L0AbBPPvSG7Q1lOj0cMVKSocNFzs
 C4Az+j6Vqr3T7ASxAEpptplmYDmXklaWeXLhSbQzXwTuvZhVUuIXY
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 27 May 2019 14:00:15 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 27 May 2019 14:00:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking structures for usage of OCaml variables with
 inherited SmPL data
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

PiBCZXNpZGVzIGNvbW1lbnRzLCBldmVyeXRoaW5nIGlzIGVpdGhlciBhIHN0cmluZyBvciBhIHBv
c2l0aW9uLAo+IGllIHR5cGUgcG9zIGxpc3QsIHdoZXJlIHRoZSB0eXBlIHBvcyBpcyBmb3VuZCBp
biBtYW4gQ29jY2lsaWIuCgpIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIGltcHJvdmUgdGhlIHBy
b2dyYW1taW5nIGludGVyZmFjZSBkZXNjcmlwdGlvbnMgaGVyZT8KCldoaWNoIGRhdGEgc3RydWN0
dXJlcyB3b3VsZCBiZSByZWxldmFudCBmb3IgdGhlIG1ldGF2YXJpYWJsZSDigJxpZGVudGlmaWVy
4oCdPwpEbyB0aGV5IHJlZmVyIG9ubHkgdG8gdGhlIGRhdGEgdHlwZSDigJxBc3RfYy5tZXRhdmFy
X2JpbmRpbmdfa2luZOKAnT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVt
ZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
