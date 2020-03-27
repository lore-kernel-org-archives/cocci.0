Return-Path: <SRS0=pejK=5M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F88CC43331
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 18:24:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C032072F
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="P7EwGWtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C032072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02RIOEB8012946;
	Fri, 27 Mar 2020 19:24:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2A2B87812;
	Fri, 27 Mar 2020 19:24:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0DFF83B63
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 08:44:44 +0100 (CET)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:b44])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02R7igNA025145
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 08:44:43 +0100 (CET)
Received: by mail-yb1-xb44.google.com with SMTP id l84so4075452ybb.1
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fuJBH1/qFJ0xcFrTragWViWx3N3gcqaqROLp9eE2znM=;
 b=P7EwGWtFPjtTjEzIV0rKm6jn99Yc1fMjxaFRXJ1zH6pEW8ueA6Y6ksIM0Jc7DNqF8p
 rgxpJlJ042hYCS7ekPQefhJWZAWqMAGpmIwZg1VGogMthR0SuKq1CahCLOWZ4YgfK//l
 neFT2gm6oKLmcbdiVPxifGuQqPmtiLVQ/bDPk0E5xz3rzPxLIjSwMgeXwdedkOYeznn1
 uLsJBBd/XmvExI0hVcB0bMSdN65LuAMItjbNMWaNgVLmOyKD603LHdWpfRtxC7UUUzYp
 5BkYOKLd32ZzxusItUg94/LR/yu5BKCkyaeAJTC4Ku/NPkxulfGPTlP9Ce8Ep/mFbYDF
 bsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fuJBH1/qFJ0xcFrTragWViWx3N3gcqaqROLp9eE2znM=;
 b=sEgSbpYQptPpt10vqgwu18ar2AKTO7AEGhKGai47ZPdBwFHmt9htfeKcnlx9nYSL5Q
 0UpdZkpEux7SMMFeeAnGft4sKWFF702PohTJvADJHK+NHIJGXuFttN13jy0ewHNKeDWo
 x3s60QyHbishRX47cNRYGHoRHDmkPwBHEqAstXQhBL1rw3BYPnv/XMqkxpnI8KMB52t8
 reEQjizPVDaY+0EFDkhYksRPuvocICjJNxYX9v2Pr0cJA6M0GW1n/vrmoAXbaIThtH3l
 vGpy72gj/x5HuIphIIJQMelV/ZfreIpOPACYTGel3MTontpfJ/t7TY/PSHMEJRiKznMJ
 w8bg==
X-Gm-Message-State: ANhLgQ2eoFQnifKl27XEDY7r7CWygophBG7goV6cJIMtW79zWW/dVLU1
 KbF7BAU7Vpa63EwEv+h52M3xJxz42wTu1rUKj5T52A==
X-Google-Smtp-Source: ADFU+vuq4HJ6geuH9mDBbQTCLLZdmNY6A4XEtkti7le78Dg4PDcoGQ027nMwXseJyxdatD0xpwnX38cOtr1cMkaCAHI=
X-Received: by 2002:a25:ccd0:: with SMTP id
 l199mr19110500ybf.446.1585295081895; 
 Fri, 27 Mar 2020 00:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200327021058.221911-1-walken@google.com>
 <20200327021058.221911-5-walken@google.com>
 <d780d91f-43fa-b2ec-1a08-80013b153a56@web.de>
In-Reply-To: <d780d91f-43fa-b2ec-1a08-80013b153a56@web.de>
From: Michel Lespinasse <walken@google.com>
Date: Fri, 27 Mar 2020 00:44:29 -0700
Message-ID: <CANN689E-SZhv3tvYc11cNuvGwCi1V1n1ztAnLkUPGvvz7C85dQ@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 19:24:14 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 27 Mar 2020 08:44:43 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 27 Mar 2020 19:24:12 +0100
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>, Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>,
        Liam Howlett <Liam.Howlett@oracle.com>, Ying Han <yinghan@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Coccinelle <cocci@systeme.lip6.fr>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Cocci] [PATCH v2 04/10] mmap locking API: use coccinelle to
 convert mmap_sem rwsem call sites
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

T24gRnJpLCBNYXIgMjcsIDIwMjAgYXQgMTI6MjIgQU0gTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5F
bGZyaW5nQHdlYi5kZT4gd3JvdGU6Cj4KPiA+IFRoaXMgY2hhbmdlIGNvbnZlcnRzIHRoZSBleGlz
dGluZyBtbWFwX3NlbSByd3NlbSBjYWxscyB0byB1c2UgdGhlIG5ldwo+ID4gbW1hcCBsb2NraW5n
IEFQSSBpbnN0ZWFkLgo+ID4KPiA+IFRoZSBjaGFuZ2UgaXMgZ2VuZXJhdGVkIHVzaW5nIGNvY2Np
bmVsbGUgd2l0aCB0aGUgZm9sbG93aW5nIHJ1bGVzOgo+Cj4gV291bGQgeW91IGxpa2UgdG8gYXBw
bHkgb25seSBhIHNpbmdsZSBTbVBMIHJ1bGUgaGVyZT8KCkkgdGhpbmsgdGhpcyB2ZXJzaW9uIG9m
IHRoZSBwYXRjaCBpcyBhbHJlYWR5IGEgc2luZ2xlIHJ1bGUsIHNpbWlsYXIgdG8Kd2hhdCB5b3Ug
c3VnZ2VzdGVkID8KCj4gPiAvLyBzcGF0Y2ggLS1zcC1maWxlIG1tYXBfbG9ja19hcGkuY29jY2kg
LS1pbi1wbGFjZSAtLWluY2x1ZGUtaGVhZGVycyAtLWRpciAuCj4KPiBDb21tYW5kIHBhcmFtZXRl
cnMgbGlrZSDigJwtLWpvYnMgOCAtLWNodW5rc2l6ZSAx4oCdIGNhbiBiZSBhbHNvIGhlbHBmdWwK
PiBmb3IgYSBwYXJhbGxlbCBleGVjdXRpb24gb2YgdGhlIGRlc2lyZWQgc29mdHdhcmUgdHJhbnNm
b3JtYXRpb24uCj4KPiBJIHN1Z2dlc3QgdG8gY29uc2lkZXIgYW5vdGhlciBwb3NzaWJpbGl0eSBm
b3IgYSBiaXQgb2YgZmluZS10dW5pbmcgaW4gdGhlIHNob3duCj4gU21QTCBzY3JpcHQgaWYgeW91
IHdvdWxkIGV2ZW50dWFsbHkgY2FyZSBmb3IgbmljZXIgcnVuIHRpbWUgY2hhcmFjdGVyaXN0aWNz
Cj4gZm9yIHRoZSBhcHBsaWNhdGlvbiBvZiBzdWNoIGEgU21QTCBkaXNqdW5jdGlvbi4KPiBIb3cg
ZG8geW91IHRoaW5rIGFib3V0IHRvIG9yZGVyIHRoZSBlbGVtZW50cyBhY2NvcmRpbmcgdG8gYSBw
cm9iYWJsZQo+IGZ1bmN0aW9uIGNhbGwgZnJlcXVlbmN5PwoKSSdtIG5vdCBzdXJlIGl0IG1hdHRl
cnMgdGhhdCBtdWNoLCBhcyBsb25nIGFzIGl0IHByb2R1Y2VzIHRoZSBjb3JyZWN0CmVuZCByZXN1
bHQuIFRoZSBydW4gdGFrZXMgYWJvdXQgMjUgc2Vjb25kcyBiZWZvcmUgYW55IG9wdGltaXphdGlv
bnMsCndoaWNoIEkgZmluZCB2ZXJ5IGFjY2VwdGFibGUuCgotLSAKTWljaGVsICJXYWxrZW4iIExl
c3BpbmFzc2UKQSBwcm9ncmFtIGlzIG5ldmVyIGZ1bGx5IGRlYnVnZ2VkIHVudGlsIHRoZSBsYXN0
IHVzZXIgZGllcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3Rl
bWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
