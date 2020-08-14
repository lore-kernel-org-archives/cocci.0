Return-Path: <SRS0=LIJV=BY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF00C433E1
	for <cocci@archiver.kernel.org>; Fri, 14 Aug 2020 13:29:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C28920866
	for <cocci@archiver.kernel.org>; Fri, 14 Aug 2020 13:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F56Y4rVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C28920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07EDTTuj014844;
	Fri, 14 Aug 2020 15:29:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AA0EB7780;
	Fri, 14 Aug 2020 15:29:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CAFB93C97
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 15:29:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07EDTRep021484
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 15:29:28 +0200 (CEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A467A20866;
 Fri, 14 Aug 2020 13:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597411766;
 bh=M8IpowAfT+qBbeI+kIkA0UlQOUYyX+jTYiiQpIPwmw8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F56Y4rVIhbN+6XtGPSMHwM5TPr7H/j7x7kEXaCkwOgLXodlV7qRVA7/UjhjKwlkUN
 Le0wU5p/acM1m7zqwOG+LrvENCWLf8vxnftr/3iVMuLat3mnKNV+V0LgVhgEOiBZQl
 ptu2WfHluw1yb3UfxR2Y/PGPxxVh5lPilnafn3Uw=
Date: Fri, 14 Aug 2020 15:29:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200814132948.GA62819@kroah.com>
References: <7733e0b3-91f2-0033-75d6-77947253bfeb@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7733e0b3-91f2-0033-75d6-77947253bfeb@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Aug 2020 15:29:30 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 14 Aug 2020 15:29:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v2] scripts: coccicheck: Change default value
 for parallelism
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

T24gRnJpLCBBdWcgMTQsIDIwMjAgYXQgMDM6MDY6MDZQTSArMDIwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4gPiBhIGRlY3JlYXNlIGluIHBlcmZvcm1hbmNlIGlzIG5vdGVkLiBUaGUgZWxhcHNl
ZCB0aW1lIGlzICBtaW5pbXVtCj4gCj4gQ2FuIHRoZSBmb2xsb3dpbmcgd29yZGluZyB2YXJpYW50
IGJlIG1vcmUgYXBwcm9wcmlhdGU/Cj4gCj4gICBhIGRlY3JlYXNlIHdhcyBub3RpY2VkIGluIHRo
ZSBzb2Z0d2FyZSBwZXJmb3JtYW5jZS4gVGhlIGVsYXBzZWQgdGltZSBpcyBtaW5pbWFsCj4gCj4g
Cj4gPiByZXNwZWN0aXZlbHkgZm9yIHR3byBzZXBhcmF0ZSBydW5zLiDigKYKPiAKPiBDYW4gc3Vj
aCBpbmZvcm1hdGlvbiB0cmlnZ2VyIGZ1cnRoZXIgY29uc2lkZXJhdGlvbnMgZm9yIGJlbmNobWFy
a2luZyBhcHByb2FjaGVzPwo+IAo+IFJlZ2FyZHMsCj4gTWFya3VzCgoKSGksCgpUaGlzIGlzIHRo
ZSBzZW1pLWZyaWVuZGx5IHBhdGNoLWJvdCBvZiBHcmVnIEtyb2FoLUhhcnRtYW4uCgpNYXJrdXMs
IHlvdSBzZWVtIHRvIGhhdmUgc2VudCBhIG5vbnNlbnNpY2FsIG9yIG90aGVyd2lzZSBwb2ludGxl
c3MKcmV2aWV3IGNvbW1lbnQgdG8gYSBwYXRjaCBzdWJtaXNzaW9uIG9uIGEgTGludXgga2VybmVs
IGRldmVsb3BlciBtYWlsaW5nCmxpc3QuICBJIHN0cm9uZ2x5IHN1Z2dlc3QgdGhhdCB5b3Ugbm90
IGRvIHRoaXMgYW55bW9yZS4gIFBsZWFzZSBkbyBub3QKYm90aGVyIGRldmVsb3BlcnMgd2hvIGFy
ZSBhY3RpdmVseSB3b3JraW5nIHRvIHByb2R1Y2UgcGF0Y2hlcyBhbmQKZmVhdHVyZXMgd2l0aCBj
b21tZW50cyB0aGF0LCBpbiB0aGUgZW5kLCBhcmUgYSB3YXN0ZSBvZiB0aW1lLgoKUGF0Y2ggc3Vi
bWl0dGVyLCBwbGVhc2UgaWdub3JlIE1hcmt1cydzIHN1Z2dlc3Rpb247IHlvdSBkbyBub3QgbmVl
ZCB0bwpmb2xsb3cgaXQgYXQgYWxsLiAgVGhlIHBlcnNvbi9ib3QvQUkgdGhhdCBzZW50IGl0IGlz
IGJlaW5nIGlnbm9yZWQgYnkKYWxtb3N0IGFsbCBMaW51eCBrZXJuZWwgbWFpbnRhaW5lcnMgZm9y
IGhhdmluZyBhIHBlcnNpc3RlbnQgcGF0dGVybiBvZgpiZWhhdmlvciBvZiBwcm9kdWNpbmcgZGlz
dHJhY3RpbmcgYW5kIHBvaW50bGVzcyBjb21tZW50YXJ5LCBhbmQKaW5hYmlsaXR5IHRvIGFkYXB0
IHRvIGZlZWRiYWNrLiAgUGxlYXNlIGZlZWwgZnJlZSB0byBhbHNvIGlnbm9yZSBlbWFpbHMKZnJv
bSB0aGVtLgoKdGhhbmtzLAoKZ3JlZyBrLWgncyBwYXRjaCBlbWFpbCBib3QKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNv
Y2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3Rp
bmZvL2NvY2NpCg==
