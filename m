Return-Path: <SRS0=nUet=AN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53A8C433E1
	for <cocci@archiver.kernel.org>; Thu,  2 Jul 2020 11:53:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652B620884
	for <cocci@archiver.kernel.org>; Thu,  2 Jul 2020 11:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S5GUDaE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652B620884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 062BqwXi011418;
	Thu, 2 Jul 2020 13:52:58 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BCC3B776E;
	Thu,  2 Jul 2020 13:52:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 155B84084
 for <cocci@systeme.lip6.fr>; Thu,  2 Jul 2020 13:52:57 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236:0:0:0:1])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 062BqsUQ007235
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 2 Jul 2020 13:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=2LYlRU7JyrrAAhL6kWTw5as9ctpjIL2vXkhqlV5CM/E=; b=S5GUDaE5JvUqQIPOl1eeQuBCS8
 umysz5K1Nthmw6mgoG+czq0B+QKng0w6vkTjXPQI56Ntfmp+/5ljciG1tOY4U7g75CKuMZOXLnpMK
 q36t49YZaXD0gpkuFWEk9seK1ASXD4xuJ558ONNZ6sDJwz0k4pKunw943/I9mslrPck9JOJFvNOKe
 ew5wYag8RUgQrZWAvHjJmqd47WkcaRseCmpETgzq9pLS4b8IQbMp+btEbBCPqknZh7J2SRnjasP8b
 IoU0NYLrF3R0FR1awyfcBvVNfnFAvhBGbGqPNcalm/vkDyyAYOy7Mea7QyE7ui0/DPGq18p3fIlCJ
 6gScIk2g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jqxlq-0002WG-FE; Thu, 02 Jul 2020 11:52:50 +0000
Date: Thu, 2 Jul 2020 12:52:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200702115250.GX25523@casper.infradead.org>
References: <def28907-18b9-5b7a-e743-79b0418c946c@infradead.org>
 <63450b02-93f1-1ea0-9e39-c5bb14086ce2@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63450b02-93f1-1ea0-9e39-c5bb14086ce2@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 02 Jul 2020 13:52:59 +0200 (CEST)
X-Greylist: Delayed for 11:44:06 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Thu, 02 Jul 2020 13:52:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Michal Marek <michal.lkml@markovi.net>, Jonathan Corbet <corbet@lwn.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v3] Documentation: Coccinelle: fix various typos
	etc.
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

T24gVGh1LCBKdWwgMDIsIDIwMjAgYXQgMDg6NTY6MjRBTSArMDIwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4g4oCmCj4gPiArKysgbGludXgtbmV4dC0yMDIwMDYyOS9Eb2N1bWVudGF0aW9uL2Rl
di10b29scy9jb2NjaW5lbGxlLnJzdAo+IOKApgo+ID4gQEAgLTI2MCwxMyArMjYwLDEzIEBAIElm
IG5vdCB1c2luZyB0aGUga2VybmVsJ3MgY29jY2ljaGVjayB0YXIKPiDigKYKPiA+IC1XZSBoZWxw
IENvY2NpbmVsbGUgd2hlbiB1c2VkIGFnYWluc3QgTGludXggd2l0aCBhIHNldCBvZiBzZW5zaWJs
ZSBkZWZhdWx0cwo+ID4gK1dlIGhlbHAgQ29jY2luZWxsZSB3aGVuIHVzZWQgYWdhaW5zdCBMaW51
eCB3aXRoIGEgc2V0IG9mIHNlbnNpYmxlIGRlZmF1bHQKPiA+ICBvcHRpb25zIGZvciBMaW51eCB3
aXRoIG91ciBvd24gTGludXggLmNvY2NpY29uZmlnLiBUaGlzIGhpbnRzIHRvIGNvY2NpbmVsbGUK
PiAKPiBBbm90aGVyIHNtYWxsIHdvcmRpbmcgYWRqdXN0bWVudDoKPiAgIOKApiBUaGVzZSBoaW50
cyDigKYKClRoYXQgd291bGQgYmUgYW4gaW5jb3JyZWN0IGFkanVzdG1lbnQuICBVbmZvcnR1bmF0
ZWx5LCB5b3Ugc25pcHBlZCB0aGUKcmVzdCBvZiB0aGUgc2VudGVuY2UgdGhhdCBwdXRzIHRob3Nl
IHR3byB3b3JkcyBpbiBjb250ZXh0LiAgQmFzaWNhbGx5IGl0J3MKc2hvcnRlciBmb3IgIkJ5IGRv
aW5nIHRoaXMsIHdlIGhpbnQgdG8gY29jY2luZWxsZSIgcmF0aGVyIHRoYW4gIlRoZXNlCnRoaW5n
cyBhcmUgaGludHMgdG8gY29jY2luZWxsZSIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5m
cgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
