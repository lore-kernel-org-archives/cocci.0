Return-Path: <SRS0=zNwH=6T=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C088FC47254
	for <cocci@archiver.kernel.org>; Tue,  5 May 2020 12:05:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7057E206A4
	for <cocci@archiver.kernel.org>; Tue,  5 May 2020 12:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7057E206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 045C5FaA009142;
	Tue, 5 May 2020 14:05:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1F4A6775A;
	Tue,  5 May 2020 14:05:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8079F3E6B
 for <cocci@systeme.lip6.fr>; Tue,  5 May 2020 14:05:13 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 045C5BxL029126
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 5 May 2020 14:05:12 +0200 (CEST)
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.53])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 29FFC41183;
 Tue,  5 May 2020 14:05:11 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 245EC80488;
 Tue,  5 May 2020 14:05:11 +0200 (CEST)
Received: from yttrium.home (lfbn-gre-1-320-180.w90-112.abo.wanadoo.fr
 [90.112.40.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: palixn@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id F406B4005E;
 Tue,  5 May 2020 14:05:10 +0200 (CEST)
To: Kaspar Schleiser <kaspar@schleiser.de>,
        Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
References: <alpine.DEB.2.21.1909302142430.2925@hadrien>
 <eccc921f-c5f5-6dc5-5233-75f0fc16cb51@schleiser.de>
 <904fcac6-77cb-b44b-07fd-430bf3596614@univ-grenoble-alpes.fr>
 <ed125ed8-a2f8-2c1a-b0aa-acf83544cae8@schleiser.de>
From: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
Organization: =?UTF-8?Q?Universit=c3=a9_Grenoble-Alpes?=
Message-ID: <fe7da089-446f-1d37-3d37-b24cdeff2a9f@univ-grenoble-alpes.fr>
Date: Tue, 5 May 2020 14:05:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ed125ed8-a2f8-2c1a-b0aa-acf83544cae8@schleiser.de>
Content-Language: en-GB
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 05 May 2020 14:05:15 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 05 May 2020 14:05:12 +0200 (CEST)
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

CgpMZSAwNS8wNS8yMDIwIMOgIDExOjE2LCBLYXNwYXIgU2NobGVpc2VyIGEgw6ljcml0wqA6Cj4g
SGkgTmljb2xhcywKPiAKPiB0aGFua3MgZm9yIHRoZSBxdWljayByZXBseSEKCllvdSdyZSB3ZWxj
b21lLgoKSnVsaWEsIG1heWJlIGl0IHdvcnRoIHJlY29yZGluZyB0aGUgc2VxdWVuY2Ugb2YgY29t
bWFuZHMgc29tZXdoZXJlLAppbiB0aGUgUkVBRE1FIG9yIHRoZSB3ZWJzaXRlLgoKPiAKPiBPbiA1
LzUvMjAgMTA6NTAgQU0sIE5pY29sYXMgUGFsaXggd3JvdGU6Cj4+IEkgdGhpbmsgeW91IGNvdWxk
IHRyeSB0aGUgZm9sbG93aW5nIHZlcnNpb24gKGludGVuZGVkIGZvciAyMC4xMCkuCj4+IGh0dHBz
Oi8vbGF1bmNocGFkLm5ldC91YnVudHUvK3NvdXJjZS9jb2NjaW5lbGxlLzEuMC44LmRlYi0yCj4g
Cj4gSSBtYW5hZ2VkIHRvIGNvbXBpbGUgdGhlIDE5LjA0IHZlcnNpb24KPiAoY29jY2luZWxsZV8x
LjAuOH4xOS4wNG5wYWxpeDEuZHNjLAo+IGNvY2NpbmVsbGVfMS4wLjh+MTkuMDRucGFsaXgxLnRh
ci54eikuIFNvbWVob3cgSSBtaXNzZWQgdGhhdCB0aGVyZSdzIGEKPiAyMC4xMCB2ZXJzaW9uLgo+
IAo+IFRoZSBjb21tYW5kcyB3ZXJlIHJvdWdobHk6Cj4gCj4gJCBhcHQgaW5zdGFsbCBkZWJoZWxw
ZXIgZGV2c2NyaXB0cyBlcXVpdnMKPiAkIGRwa2ctc291cmNlIC14IGNvY2NpbmVsbGVfMS4wLjh+
MTkuMDRucGFsaXgxLmRzYwo+ICQgY2QgY29jY2luZWxsZS0xLjAuOAo+ICQgbWstYnVpbGQtZGVw
cyAtaQo+ICQgZHBrZy1idWlsZHBhY2thZ2UgLXJmYWtlcm9vdCAtYgo+ICQgYXB0IGluc3RhbGwg
Li4vY29jY2luZWxsZV8xLjAuOH4xOS4wNG5wYWxpeDFfYW1kNjQuZGViCj4gCj4gVGhlIHJlc3Vs
dGluZyAuZGViIGNhbiBiZSBpbnN0YWxsZWQgb24gYW4gb3RoZXJ3aXNlIGNsZWFuIGZvY2FsOmxh
dGVzdAo+IGNvbnRhaW5lci4gVGhlIHNwYXRjaCBiaW5hcnkgc3RhcnRzIChwcmludHMgaGVscCks
IGRpZCBub3QgZG8gZnVydGhlcgo+IHRlc3RpbmcuCj4gCj4gS2FzcGFyCj4gCgoKLS0gCk5pY29s
YXMgUGFsaXgKaHR0cDovL2xpZy1tZW1icmVzLmltYWcuZnIvcGFsaXgvCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2Nj
aUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5m
by9jb2NjaQo=
