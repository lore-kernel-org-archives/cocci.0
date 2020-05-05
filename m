Return-Path: <SRS0=zNwH=6T=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38911C47256
	for <cocci@archiver.kernel.org>; Tue,  5 May 2020 08:50:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B41D20675
	for <cocci@archiver.kernel.org>; Tue,  5 May 2020 08:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B41D20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0458oS8b014271;
	Tue, 5 May 2020 10:50:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A91C3775A;
	Tue,  5 May 2020 10:50:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A807D3E6B
 for <cocci@systeme.lip6.fr>; Tue,  5 May 2020 10:50:27 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0458oQHQ015008
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 5 May 2020 10:50:26 +0200 (CEST)
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.53])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 765D0411B9;
 Tue,  5 May 2020 10:50:25 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 70D48804B5;
 Tue,  5 May 2020 10:50:25 +0200 (CEST)
Received: from yttrium.home (lfbn-gre-1-320-180.w90-112.abo.wanadoo.fr
 [90.112.40.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: palixn@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 4C8B74005E;
 Tue,  5 May 2020 10:50:25 +0200 (CEST)
To: Kaspar Schleiser <kaspar@schleiser.de>,
        Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
References: <alpine.DEB.2.21.1909302142430.2925@hadrien>
 <eccc921f-c5f5-6dc5-5233-75f0fc16cb51@schleiser.de>
From: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
Organization: =?UTF-8?Q?Universit=c3=a9_Grenoble-Alpes?=
Message-ID: <904fcac6-77cb-b44b-07fd-430bf3596614@univ-grenoble-alpes.fr>
Date: Tue, 5 May 2020 10:50:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eccc921f-c5f5-6dc5-5233-75f0fc16cb51@schleiser.de>
Content-Language: en-GB
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 05 May 2020 10:50:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 05 May 2020 10:50:26 +0200 (CEST)
X-Greylist: Whitelist-UGA SMTP Authentifie (palixn@univ-grenoble-alpes.fr) via
 submission-587 ACL (100)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] 1.0.8 on Ubuntu
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

SGkgS2FzcGFyLAoKSSB0aGluayB5b3UgY291bGQgdHJ5IHRoZSBmb2xsb3dpbmcgdmVyc2lvbiAo
aW50ZW5kZWQgZm9yIDIwLjEwKS4KaHR0cHM6Ly9sYXVuY2hwYWQubmV0L3VidW50dS8rc291cmNl
L2NvY2NpbmVsbGUvMS4wLjguZGViLTIKCk5vdGUgdGhhdCB0aGVyZSBpcyBubyBvZmZpY2lhbCBV
YnVudHUgcmVsZWFzZSBmb3IgMjAuMDQuCkkgdGhpbmsgaXQgZHVlIHRvIGFuIGlzc3VlIHdpdGgg
dGhlIFB5dGhvbiBhbmQgR1RLIG1pZ3JhdGlvbgp0byBuZXdlciB2ZXJzaW9uIGZpeGVkIHRoZW4u
CgpBbHRlcm5hdGl2ZWx5LCB5b3UgY2FuIGFsc28gdHJ5IHRoZSBmb2xsb3dpbmcgY29tbWFuZHM6
CgphcHQtZ2V0IGJ1aWxkLWRlcCBjb2NjaW5lbGxlCmFwdC1nZXQgc291cmNlIGNvY2NpbmVsbGUK
CndpdGggdGhlIFBQQSB2ZXJzaW9uIG9yIHRoZSBzb3VyY2UuCgpMZSAwNS8wNS8yMDIwIMOgIDEw
OjE2LCBLYXNwYXIgU2NobGVpc2VyIGEgw6ljcml0wqA6Cj4gSGksCj4gCj4gSSdtIGhhdmluZyBp
c3N1ZXMgZ2V0dGluZyBjb2NjaW5lbGxlIGludG8gYW4gVWJ1bnR1IGNvbnRhaW5lci4KPiAKPiBP
biA5LzMwLzE5IDk6NDMgUE0sIEp1bGlhIExhd2FsbCB3cm90ZToKPj4gRm9yIHRob3NlIHdobyB1
c2UgVWJ1bnR1LCBhIFBQQSBpcyBhdmFpbGFibGU6Cj4+Cj4+IGh0dHBzOi8vbGF1bmNocGFkLm5l
dC9+bnBhbGl4LythcmNoaXZlL3VidW50dS9jb2NjaW5lbGxlLytwYWNrYWdlcwo+IAo+IEhvdyBj
YW4gSSBoZWxwIGdldHRpbmcgdGhpcyBidWlsdCBmb3IgVWJ1bnR1IDIwLjA0IChGb2NhbCBGb3Nz
YSk/Cj4gCj4gVGhlIHByZWNvbXBpbGVkIGJpbmFyeSBsaW5rcyBpbiBbMV0gcG9pbnQgdG8gbm9u
ZXhpc3RpbmcgZmlsZXMuCj4gCj4gb3BhbSBzZWVtcyB0byBoYXZlIGlzc3VlcyB3aGVuIHJ1biB3
aXRoaW4gY29udGFpbmVyczoKPiAKPiAtLS0tCj4gW0VSUk9SXSBUaGUgY29tcGlsYXRpb24gb2Yg
b2NhbWwtc3lzdGVtIGZhaWxlZCBhdAo+ICIvcm9vdC8ub3BhbS9vcGFtLWluaXQvaG9va3Mvc2Fu
ZGJveC5zaCBidWlsZCBvY2FtbCBnZW5fb2NhbWxfY29uZmlnLm1sIi4KPiAuLi4KPiAjIGJ3cmFw
OiBDcmVhdGluZyBuZXcgbmFtZXNwYWNlIGZhaWxlZDogT3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQK
PiAtLS0tCj4gCj4gS2FzcGFyCj4gWzFdIGh0dHA6Ly9jb2NjaW5lbGxlLmxpcDYuZnIvZG93bmxv
YWQucGhwCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBDb2NjaSBtYWlsaW5nIGxpc3QKPiBDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKPiBodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCj4gCgoKLS0gCk5pY29sYXMgUGFs
aXgKaHR0cDovL2xpZy1tZW1icmVzLmltYWcuZnIvcGFsaXgvCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0
ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2Nj
aQo=
