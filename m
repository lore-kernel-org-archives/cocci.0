Return-Path: <SRS0=AiyZ=YD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BC2C4360C
	for <cocci@archiver.kernel.org>; Thu, 10 Oct 2019 16:26:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BAFF2067B
	for <cocci@archiver.kernel.org>; Thu, 10 Oct 2019 16:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HhoNdUo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAFF2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9AGPwDt026508;
	Thu, 10 Oct 2019 18:25:58 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2E33677AE;
	Thu, 10 Oct 2019 18:25:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DFF0C77AD
 for <cocci@systeme.lip6.fr>; Thu, 10 Oct 2019 18:25:55 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9AGPtxs024698;
 Thu, 10 Oct 2019 18:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570724755;
 bh=WlY2uy56BFyhKHGGfblG8vnswutWRfNtrsnkhPXD92Y=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=HhoNdUo3HvqES6tWaehn1dDIU1YthyykgHDyvlfIknw90sE1DsUtoVa3vkQd3/EpB
 kW1Zkd0OaMAT2kADH8plpk1BftCM2deoI1O4jIfAmCsuervYM9dVLvSGCiksY8oTPJ
 7jEuEgjs/CH/Nm7XZI/GELVoeY2Bp6yG+mlnFwVE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.64.254]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6UxL-1htcFt3zzv-00yQoG; Thu, 10
 Oct 2019 18:25:55 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <8df6513d-36d3-2049-8fb0-28d84c8f9c85@web.de>
 <alpine.DEB.2.21.1910101537280.2305@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cb24a321-e32a-8916-9363-d55539c32c27@web.de>
Date: Thu, 10 Oct 2019 18:25:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910101537280.2305@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:huSuBPZMHWENsgXnRiWoX/g7ZdzL84rXeBW5qxONkmOnGEZ2mZS
 7FotLv9xY2hvU1pzvX0TBJ7g9ovWoX0Mpa4SmxPNmVVsyTnfdNfr2AqNbMwJXWmwpQPFfW3
 zLhQGkStT7njuoc28NPofBmsX+mQcm0x1ZDSWNDHYmBq6nHJloMZsqRY5luHRVhAjepsM+m
 ubv0nJqKxZXKxAPJd6aJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gp2JbseZPCs=:wlP9mhhEu5OEqEGcAx5/4B
 4bqQM501UoHrZDBqHJHhE/A7R9w92WsbnEwxbM8yOkA/jH6pCWO3VdVyDNHbMWbZ4oLIMyz7N
 xGSIq2u8B5g9Y6/7r0jWhhEyqw6gBJpSMShPNCaZ2Rk66YaSpFjjMhNG8+IuELmC089DInYwc
 6NUqN2VUg0v6gujoivr0ibMZGcStVlMYU1AwjBYl/YMGwGm+YoIkyhvRDgRwCTVa3g6PMj7v4
 SnfDZN+KEc/zTWXN0zyT9V3sTF2VHbl1LXfm3JxXTWpkZe4iVqN5G6Bh9HXH3/upJ2nki/9sW
 x/vh7MuN6l1yutxp0tIYwXXT20JoYTNfhm28AUdMxv872U7vmFXxioRKjyJtIujeheHIUNjYg
 EzOGBEeI4QrSzYpY0saKZLOn1PrNDVi85/Qu3s2oXJEm07Rsde9YfRaqn87DaXoBV6IchQxnQ
 QzbqOl/j0TSaMeyBOGxBi86X97GwKPsvOwlh/1P6SpQJ+/sdTgn4uudgAJ60KGLuPGASB/Z3t
 Qv2ZO6NE3o9hNkgKH6RUAFwk/H337NzApBhcF7TN3W5KnAHRuz8jeonsS+a4L40twikohLXvx
 x5rYpTEHymeCClvPqWJJzbKOh7E+8mPm7uk5dbKT9ca8SwBoYdR01Ct6OxQIpSv9q4/b6oMI5
 z/1jfahkCBDdqkoZh5qXRVye4ysKoJWAGTSishM+SRG5ITu73a/ADYw1CE9G3x2FViC1eM5c4
 I9AROPwBE53gQ6HROH1LgMrBF1kDrRFV+g1TUCmfRymu1Y/dMRd58u8sVDcK1LUfJu09OtT3A
 xPpUk1n1qMIeUbUQ3VgheZQRJj95R8F9VbZoYFW4/8r810AptBSXyfKYLU6lkeAcgT/r2BiVU
 IogArbdg/XHmL8V/aWb7gAcZ/xNTxa3yMR23rdhP3cKo+hXu3cYxaxe4uOCdSSRaIdJtO88qB
 1c5s0RcPYnNRSHwkIb1HCXui1FrW60sgL6kn26para4Z4WdH9vIhs6M6496I/GNHVDvyCUu6U
 LMxGwRKGQKkk/NR/ygX3DrqrrkkOT2OYzFmZK/COL+mN6DogBshveytk+4E6rlQA3idLfgcv1
 dd91k1np2WmVZqO3N+Tw83txOaZu7Qx4EjsAWlCNXNxNn6v7xYqpimZikiLrVdqEkKFgTngoz
 vvoWlPxBfb6iJzjGVCwWJoF6gnKD0vl48JncGlRF7YtiwleNdzn4Bljp4WbzgPjQBuEwqDDnP
 Gk2kHTkBNJaWEnvgB2SxWdRLMMleIxCy+Ydn/+H1D35v91Cey1ytMIAo9upA=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 10 Oct 2019 18:25:58 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 10 Oct 2019 18:25:55 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked function
 calls
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

Pj4gSSB3b3VsZCBsaWtlIHRvIGRldGVjdCB0aGF0IGEgY29ycmVzcG9uZGluZyBudWxsIHBvaW50
ZXIgY2hlY2sgd291bGQgYmUgbWlzc2luZwo+PiAoYmVmb3JlIHRoZSBkYXRhIGNhbiBiZSB1c2Vk
IGZvciBmdXJ0aGVyIGRhdGEgcHJvY2Vzc2luZykuCj4KPiAqIHggPSBrbWVtZHVwKC4uLik7Cj4g
ICAuLi4gd2hlbiAhPSB4Cj4gKAo+ICAgeC0+Zgo+IHwKPiAgIGYoLi4uLDwrLi4ueC4uLis+LC4u
LikKPiApCgpUaGlzIGFuYWx5c2lzIGFwcHJvYWNoIGxvb2tzIHByb21pc2luZyBpbiBwcmluY2lw
bGUuIEkgbmVlZGVkIGFub3RoZXIgbW9tZW50CnRvIGJlY29tZSBhd2FyZSB0aGF0IGl0IGluZGlj
YXRlcyBwb2ludGVyIHVzYWdlIHJlcXVpcmVtZW50cwp3aGljaCBjYW4gb2NjYXNpb25hbGx5IG5v
dCBiZSBtZXQgKGxpa2UgaW4gdGhlIG1lbnRpb25lZCBmdW5jdGlvbiDigJxpbXhfcGRfYmluZOKA
nSkuCklmIHRoZSBleHByZXNzaW9uIOKAnHjigJ0gd291bGQgYmUgc3BsaXQgaW50byBhY2Nlc3Nl
cyB0byBkYXRhIHN0cnVjdHVyZSBtZW1iZXJzLAp0aGUgZGF0YSBwcm9jZXNzaW5nIGNhbiBwcm9i
YWJseSByZXN1bHQgaW4gYW5vdGhlciBkZXNpcmFibGUgaW5mb3JtYXRpb24gZGlzcGxheS4KClRo
ZSBwb2ludGVyIHVzYWdlcyB2YXJ5IGluIGFmZmVjdGVkIGZ1bmN0aW9uIGltcGxlbWVudGF0aW9u
cyAoYXMgdXN1YWwpLgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
