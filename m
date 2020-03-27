Return-Path: <SRS0=pejK=5M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D2CC43331
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 18:24:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE582072F
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 18:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kwk8Dwxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE582072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02RIOEPY006426;
	Fri, 27 Mar 2020 19:24:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A5D7C7812;
	Fri, 27 Mar 2020 19:24:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 417AA3B63
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 09:08:58 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:b33])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02R88uX7028866
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 09:08:56 +0100 (CET)
Received: by mail-yb1-xb33.google.com with SMTP id a5so552428ybo.7
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XiMf0KkPfznb6FzIwAvwq95s3d+SISV4oAUy80r1jBU=;
 b=kwk8DwxxgB7iwpHOeQc9TXfa94ZbGOPhFuvPq1S3Mpcavp3kszwj6w9nEZo+gpMGuj
 +aaanYNyZyMeDwoV5hKoDUiJ7wQOKxthh2JaS43zDcZ5mHf3hYvR62d33ymy5Pqvh+jE
 Kj7uGc825KQsbcuH3K3a+rL2ch0upA7s1bXe/AygGRuYR3UrleRTCY6T+7rSWgnarSX3
 /yqgu31cmz6UG0j3lQz80CHEDscl/v8RMIaJ7PMOx9j8w5Eu/ufGcMShf3hc47iS6fys
 fjXDuDiNfDkbEJ4auU7FFp5EhU69N+ddqIxRdplVx1V/MSSKG+1vfEUVsI3aD3mqxAly
 I7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XiMf0KkPfznb6FzIwAvwq95s3d+SISV4oAUy80r1jBU=;
 b=o0fIgoBRp+pOtnltQxz0/+8zG6ghrIMFsvT8z7RSUiTACjFuA5qq0e0zmUgYTohyEF
 +UW9IokKl7Hd2CkUmxpSRy704HKnkhmWzK/lJJ+ipkoHTVthm5fyIEiVHCpqm58QIzMK
 l+JkRyLBHy9d3sarXor5KoZdB18mrcqfWWOAe6UQiEyqW49EJ7n9+e1wPdzAzmS+LPNg
 qTcYhYRrZNz5+fgLf23hKWwPYOkujN3QfuzRxCT9M5ZqtgHOhtoB20CY8kcz7RxWdMuO
 l9y1iuAO1idvYkIeFaggQHvmQKqwxhBuBC5m5AB4C7h29/ESGE/NoqCQL/V4zuWsEZzR
 9YZQ==
X-Gm-Message-State: ANhLgQ3p4E5Qs/oYWDkSdqERifCi9783PASITwVYKzA8UHe/81q4fe/T
 LLbbb4STo5Ed+bos9thAQ9vYWVKxMFxv4c8ffOrQCA==
X-Google-Smtp-Source: ADFU+vvVq0fsXgz6sgEvSt1ud/23H5X6PO3tAJOOpxVg7c9hJFoFeSYPNiP1hACneWrUMhEi8KHKQQnpElzByJhAOEI=
X-Received: by 2002:a25:15c8:: with SMTP id 191mr3376784ybv.452.1585296535460; 
 Fri, 27 Mar 2020 01:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200327021058.221911-1-walken@google.com>
 <20200327021058.221911-5-walken@google.com>
 <d780d91f-43fa-b2ec-1a08-80013b153a56@web.de>
 <CANN689E-SZhv3tvYc11cNuvGwCi1V1n1ztAnLkUPGvvz7C85dQ@mail.gmail.com>
 <bc15b633-68ab-a121-53c6-32972ef1ad9b@web.de>
In-Reply-To: <bc15b633-68ab-a121-53c6-32972ef1ad9b@web.de>
From: Michel Lespinasse <walken@google.com>
Date: Fri, 27 Mar 2020 01:08:43 -0700
Message-ID: <CANN689EG-mYEUvfqHQQm_TBYtu0VSuVsWz3R5LnTOkAHW=4b+g@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 19:24:14 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 27 Mar 2020 09:08:57 +0100 (CET)
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
Subject: Re: [Cocci] [v2 04/10] mmap locking API: use coccinelle to convert
 mmap_sem rwsem call sites
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

T24gRnJpLCBNYXIgMjcsIDIwMjAgYXQgMTowMCBBTSBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVs
ZnJpbmdAd2ViLmRlPiB3cm90ZToKPgo+ID4+PiBUaGUgY2hhbmdlIGlzIGdlbmVyYXRlZCB1c2lu
ZyBjb2NjaW5lbGxlIHdpdGggdGhlIGZvbGxvd2luZyBydWxlczoKPiA+Pgo+ID4+IFdvdWxkIHlv
dSBsaWtlIHRvIGFwcGx5IG9ubHkgYSBzaW5nbGUgU21QTCBydWxlIGhlcmU/Cj4gPgo+ID4gSSB0
aGluayB0aGlzIHZlcnNpb24gb2YgdGhlIHBhdGNoIGlzIGFscmVhZHkgYSBzaW5nbGUgcnVsZSwK
PiA+IHNpbWlsYXIgdG8gd2hhdCB5b3Ugc3VnZ2VzdGVkID8KPgo+IFllcy4gLSBCdXQgeW91IHJl
cGVhdGVkIHRoZSB3b3JkaW5nIOKAnHJ1bGVz4oCdIGluIHRoZSBjaGFuZ2UgZGVzY3JpcHRpb24u
Cj4gQXJlIHRoZXJlIGFueSBvdGhlciBzb2Z0d2FyZSBleHRlbnNpb25zIHN0aWxsIGluIHRoZSB3
YWl0aW5nIHF1ZXVlPwoKQWggeWVzLCBJIGRpZCBub3QgY2hhbmdlIHRoZSB3b3JkaW5nIGJlZm9y
ZSB0aGUgaW5jbHVkZWQgLmNvY2NpIGZpbGUuCgpJIGRvIG5vdCBoYXZlIGFueSBtb3JlIGNvY2Np
bmVsbGUgcGF0Y2hlcyB0byBwdXNoIGluIHRoZSBuZWFyIGZ1dHVyZS4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2Np
QHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZv
L2NvY2NpCg==
