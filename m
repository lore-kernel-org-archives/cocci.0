Return-Path: <SRS0=WLW8=OX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4215C67839
	for <cocci@archiver.kernel.org>; Fri, 14 Dec 2018 11:31:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D2320892
	for <cocci@archiver.kernel.org>; Fri, 14 Dec 2018 11:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D2320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBEBVId9004566
          ; Fri, 14 Dec 2018 12:31:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 718EB76D8;
	Fri, 14 Dec 2018 12:31:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 015EB60D7
 for <cocci@systeme.lip6.fr>; Fri, 14 Dec 2018 12:31:17 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de
 [IPv6:2a01:4f8:191:444c:0:0:2:4] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBEBVFRN011811
 for <cocci@systeme.lip6.fr>; Fri, 14 Dec 2018 12:31:16 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id 6BD8D4AB628
 for <cocci@systeme.lip6.fr>; Fri, 14 Dec 2018 11:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id JEMmC_85MuMe; Fri, 14 Dec 2018 11:31:10 +0000 (UTC)
Received: from [10.9.1.140] (ds9.sysmocom.de [90.187.64.137])
 by mail.sysmocom.de (Postfix) with ESMTPSA id 276324AB614
 for <cocci@systeme.lip6.fr>; Fri, 14 Dec 2018 11:31:10 +0000 (UTC)
To: cocci@systeme.lip6.fr
References: <a752b0e8-8ed0-1e86-eff7-3d91e87b11ae@sysmocom.de>
 <alpine.DEB.2.20.1812121322240.4125@hadrien>
 <b9f9b797-8f26-8034-7958-6182f5813e26@sysmocom.de>
 <alpine.DEB.2.21.1812130723160.2458@hadrien>
 <768d794a-e7a6-b011-f9af-5bb5a38b3c4a@sysmocom.de>
 <alpine.DEB.2.21.1812132056230.2465@hadrien>
From: Max <msuraev@sysmocom.de>
Message-ID: <e59c00ae-6b97-f8b4-6dca-dc23ffb7d414@sysmocom.de>
Date: Fri, 14 Dec 2018 12:31:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812132056230.2465@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Dec 2018 12:31:19 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 14 Dec 2018 12:31:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: Re: [Cocci] replacing defines
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

RGFtbiEgU28gc2ltcGxlIGFuZCBlbGVnYW50LCB0aGFuayB5b3UuCgpJIHdhcyBjb21wbGV0ZWx5
IG92ZXJ0aGlua2luZyBpdC4KCjEzLjEyLjE4IDIwOjU2LCBKdWxpYSBMYXdhbGwg0L/QuNGI0LXR
gjoKPgo+IEBACj4gQEAKPgo+IC0gI2RlZmluZSBvbGRfanVuayhhLGIsYykgLi4uCj4KPiBqdWxp
YQo+Ci0tIAotIE1heCBTdXJhZXYgPG1zdXJhZXZAc3lzbW9jb20uZGU+ICAgICAgIGh0dHA6Ly93
d3cuc3lzbW9jb20uZGUvCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ciogc3lzbW9jb20gLSBzeXN0ZW1zIGZvciBt
b2JpbGUgY29tbXVuaWNhdGlvbnMgR21iSAoqIEFsdC1Nb2FiaXQgOTMKKiAxMDU1OSBCZXJsaW4s
IEdlcm1hbnkKKiBTaXR6IC8gUmVnaXN0ZXJlZCBvZmZpY2U6IEJlcmxpbiwgSFJCIDEzNDE1OCBC
CiogR2VzY2hhZWZ0c2Z1ZWhyZXIgLyBNYW5hZ2luZyBEaXJlY3RvcnM6IEhhcmFsZCBXZWx0ZQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFp
bGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9t
YWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
