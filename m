Return-Path: <SRS0=uwmw=AM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CF8C433DF
	for <cocci@archiver.kernel.org>; Wed,  1 Jul 2020 15:19:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64192206C3
	for <cocci@archiver.kernel.org>; Wed,  1 Jul 2020 15:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C71K5/fQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64192206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 061FJblv004473;
	Wed, 1 Jul 2020 17:19:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2C226776E;
	Wed,  1 Jul 2020 17:19:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5D126742B
 for <cocci@systeme.lip6.fr>; Wed,  1 Jul 2020 17:19:35 +0200 (CEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231:0:0:0:1])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 061FJV7V005929
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 1 Jul 2020 17:19:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=RMq+iE1LUPENeNcgBeF0Dm87bPYKtg4gXNNVgu26xNQ=; b=C71K5/fQGisGL/dr162sd1/BB0
 PKXUXMzoOs1afRIhld7BQ9X7Pr4/y1MLjs8gQLGV98nh88bgZ+pw2CnwPL2I6DoGrBt4SfCuJAAAG
 Pbceya8bm8et3ppzsfP50Wvq/oYOsVgqyFo5BK1gm47jR1/SeiqtHL7E1uSIqRP3ol+8eUm2K8jaV
 RcKZR8XfcKONRxcIRVyd6WaPpfjCHJRSvjxe+UkOETlAlE2laAv2k9yPX0dwWOM0YC83jwEnr2My/
 PkNAvhmO2EZhzSFBzyX2BrWqufyNegvBKJWrUEHfZ2RFpKKcNJ+nDVl4U7AsHWZD66vIjR/cTDZm9
 14ntrsQg==;
Received: from [2601:1c0:6280:3f0::19c2]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqeWF-00086O-TU; Wed, 01 Jul 2020 15:19:28 +0000
To: Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
 <648d287e-3636-1858-1439-103d317f8571@web.de>
 <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
 <65db3f88-1ac8-374d-e3fe-2ea0970ffd67@web.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <30b722ca-1bd8-2b96-ca41-1e9bc7212b66@infradead.org>
Date: Wed, 1 Jul 2020 08:19:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <65db3f88-1ac8-374d-e3fe-2ea0970ffd67@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 01 Jul 2020 17:19:37 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 01 Jul 2020 17:19:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [Cocci] [v2] Documentation: Coccinelle: fix typos and command
	example
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

T24gNy8xLzIwIDg6MTUgQU0sIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+Pj4gV291bGQgeW91IGxp
a2UgdG8gaW50ZWdyYXRlIGFueSBtb3JlIGRldGFpbHMgZnJvbSB0aGUgcnVubmluZyBwYXRjaCBy
ZXZpZXc/Cj4+Cj4+IEkgYW0gc2F0aXNmaWVkIHdpdGggdGhlIGN1cnJlbnQgcGF0Y2guCj4gCj4g
SSBnb3QgYW4gb3RoZXIgc29mdHdhcmUgZGV2ZWxvcG1lbnQgaW1wcmVzc2lvbi4KPiAKPiAKPj4g
Tm8gZG91YnQgdGhhdCBhbnkgZG9jdW1lbnRhdGlvbiBjYW4gYmUgaW1wcm92ZWQsIGFsbW9zdCBh
ZCBpbmZpbml0dW0sCj4+IGJ1dCBJJ20gbm90IHRyeWluZyB0byBkbyB0aGF0Lgo+IAo+IERvIHdl
IHN0dW1ibGUgb24gYSB0YXJnZXQgY29uZmxpY3QgYWNjb3JkaW5nIHRvIGEgc3BlY2lmaWMgdGVj
aG5pY2FsIGRldGFpbD8KPiAKPiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIGNvbXBhcmUgc291
cmNlIGNvZGUgYW5hbHlzaXMgcmVzdWx0cwo+IGZyb20gcHJvZ3JhbXMgbGlrZSDigJxzcGFyc2Xi
gJ0gYW5kIOKAnHNwYXRjaOKAnSAoYnkgdGhlIG1lbnRpb25lZCBtYWtlIGNvbW1hbmQpPwoKTm9u
ZSBvZiB0aGF0IGhhcyBhbnl0aGluZyB0byBkbyB3aXRoIHRoZSBjdXJyZW50IHBhdGNoLgoKSnVs
aWEsIGRvIHlvdSBoYXZlIGFueSBjb21tZW50cyBhYm91dCB0aGUgY3VycmVudCBwYXRjaD8gKHYy
KQoKdGhhbmtzLgoKLS0gCn5SYW5keQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpo
dHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
