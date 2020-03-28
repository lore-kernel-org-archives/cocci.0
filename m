Return-Path: <SRS0=tDau=5O=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B6EC43331
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 07:22:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B68E20748
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 07:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JUObUgRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B68E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02T7M5Ug019944;
	Sun, 29 Mar 2020 09:22:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BA3177823;
	Sun, 29 Mar 2020 09:22:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 153DB66CB
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 09:53:43 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:b2d])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02S8rfVs011990
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 09:53:41 +0100 (CET)
Received: by mail-yb1-xb2d.google.com with SMTP id x63so5977398ybx.2
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VcMXP9kKkoDSkAWpwZibgZEebuHA/f4VzON6mG+RLvo=;
 b=JUObUgREFSOVke/eCuZ4G+0EhvK+rWozJZgWgkfBGJI9r3P9/Su+o+HTSyZOF67sGH
 dNsRWiQe175l9AU2xXx9XtLB/z02YVC3yoO8/IpiLT9KwTWvnDp/Ctd20VhOjztafiT4
 sqOpbfdwoMNRQuje3GkRUz68A7L2jq3hWBVwMoBXhl01+F2Cyp3vshzhHN1EUoW74G0d
 W11OYDzk9A+MDtAKT6ukIvmZYCcloylK2QR+Dj1XyNbGfdwb6bpnWFQ74D58/2WOKtyo
 VJ0tWCoK0kvzJkT1W8WXQm6Eh8pY16M03mUtqkpP9+cmJ+zCpgMmZ2PpHwE+05+Rj78g
 riVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VcMXP9kKkoDSkAWpwZibgZEebuHA/f4VzON6mG+RLvo=;
 b=YHnjWpcrhg1FWTJM94D9x+JLHA68tbq6N0RdinAeR9SMh+l0yROF/n8anxV1h2x5S4
 oTK5VCOjtbSdHPdfiXYw+UGIa0EqdzwToWORKKurwo2ySZQNAjDldmGPAOcVScctwAiw
 LIDRkc2d/1x/s81aKVHv1zlhke1wSTYJs7QH5aU/hbnnonKc0DzjFT90jPHQZLmKrTSQ
 5IOKMgGIf9McIvjVo0nLtFrL1uFBlUczMR0vfL8Pfcfa2CnPlOpMaZQ7fBgFfLStkIMU
 RDY1V6N+8ebfWYwvQkCmOfVAOtQ5bkTpu23ovMPjLYhDuH8AV0Lq8Y/LK+AIOMoCPySB
 uaww==
X-Gm-Message-State: ANhLgQ0zXfxyMz18baBhIgBfqNWZHBI1KmqqWNznCGcO3UBJy2wXkm0p
 n+W+XD3MH/Sq6nvB4xeIKpNI0156MoHw9wX1pwjPsg==
X-Google-Smtp-Source: ADFU+vvlKy21P6FfgcE5xtIgg+AHvek5xsesheRSeKeLs8jWRYEgjd819dYreTrbjtVaRkYNPaWsh6pk+FIFDnb7KD4=
X-Received: by 2002:a25:ccd0:: with SMTP id l199mr4734314ybf.446.1585385620467; 
 Sat, 28 Mar 2020 01:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-6-walken@google.com>
 <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
 <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
 <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
In-Reply-To: <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
From: Michel Lespinasse <walken@google.com>
Date: Sat, 28 Mar 2020 01:53:27 -0700
Message-ID: <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 29 Mar 2020 09:22:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 28 Mar 2020 09:53:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sun, 29 Mar 2020 09:22:02 +0200
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>, Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>,
        Liam Howlett <Liam.Howlett@oracle.com>, Ying Han <yinghan@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Coccinelle <cocci@systeme.lip6.fr>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Cocci] [v3 05/10] mmap locking API: convert mmap_sem call
 sites missed by coccinelle
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

T24gU2F0LCBNYXIgMjgsIDIwMjAgYXQgMTozOSBBTSBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVs
ZnJpbmdAd2ViLmRlPiB3cm90ZToKPiA+IEkgd291bGQgYmUgaW50ZXJlc3RlZCB0byBmaW5kIG91
dCB3aHkgY29jY2luZWxsZSB3YXNuJ3QgYWJsZSB0byBkbyB0aGUKPiA+IGxhc3QgMSUsIGJ1dCBv
bmx5IGFzIHBhcnQgb2YgYSBsb25nLXRlcm0gbGVhcm5pbmcgcHJvY2VzcyBvbiBnZXR0aW5nCj4g
PiBiZXR0ZXIgd2l0aCBjb2NjaW5lbGxlIC0g4oCmCj4KPiBIb3cgd2lsbCBjb3JyZXNwb25kaW5n
IHNvZnR3YXJlIGRldmVsb3BtZW50IHJlc291cmNlcyBldm9sdmU/CgpJIGRvbid0IHRoaW5rIEkg
dW5kZXJzdGFuZCB0aGUgcXVlc3Rpb24sIG9yLCBhY3R1YWxseSwgYXJlIHlvdSBhc2tpbmcKbWUg
b3IgdGhlIGNvY2NpbmVsbGUgZGV2ZWxvcGVycyA/CgotLSAKTWljaGVsICJXYWxrZW4iIExlc3Bp
bmFzc2UKQSBwcm9ncmFtIGlzIG5ldmVyIGZ1bGx5IGRlYnVnZ2VkIHVudGlsIHRoZSBsYXN0IHVz
ZXIgZGllcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
Q29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUu
bGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
