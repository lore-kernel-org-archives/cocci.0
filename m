Return-Path: <SRS0=Zs5K=OW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98451C65BAE
	for <cocci@archiver.kernel.org>; Thu, 13 Dec 2018 16:19:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70C620879
	for <cocci@archiver.kernel.org>; Thu, 13 Dec 2018 16:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70C620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBDGJ4ZV023204
          ; Thu, 13 Dec 2018 17:19:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 96FA576D8;
	Thu, 13 Dec 2018 17:19:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 276EF76D5
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 17:19:03 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de
 [IPv6:2a01:4f8:191:444c:0:0:2:4] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBDGJ28v007322
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 17:19:02 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id C82E94A3106
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 16:19:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id jeJK-_YHFrqi; Thu, 13 Dec 2018 16:19:01 +0000 (UTC)
Received: from [10.9.1.140] (ds9.sysmocom.de [90.187.64.137])
 by mail.sysmocom.de (Postfix) with ESMTPSA id E89894A30F4
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 16:19:00 +0000 (UTC)
To: cocci@systeme.lip6.fr
References: <a752b0e8-8ed0-1e86-eff7-3d91e87b11ae@sysmocom.de>
 <alpine.DEB.2.20.1812121322240.4125@hadrien>
 <b9f9b797-8f26-8034-7958-6182f5813e26@sysmocom.de>
 <alpine.DEB.2.21.1812130723160.2458@hadrien>
From: Max <msuraev@sysmocom.de>
Message-ID: <768d794a-e7a6-b011-f9af-5bb5a38b3c4a@sysmocom.de>
Date: Thu, 13 Dec 2018 17:16:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812130723160.2458@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 13 Dec 2018 17:19:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 13 Dec 2018 17:19:02 +0100 (CET)
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

SGVyZSBpdCBpczoKCl9fX19fX19fX19fX19fX19fX19fX19fXwoKQEAKZXhwcmVzc2lvbiBhLCBi
LCBjOwpAQAotIG9sZF9qdW5rKGEsIGIsIGMpOworIGlmICghbmV3X3N0dWZmKGEsIGIsIGMpKQor
wqAgYWJvcnQoKTsKCkBACmlkZW50aWZpZXIgeCwgeSwgejsKQEAKLSAjZGVmaW5lIG9sZF9qdW5r
KHgsIHksIHopCisKX19fX19fX19fX19fX19fX19fX19fX19fCgpUaGlzIHJlc3VsdCBpbiBGYWls
dXJlKCJub3RoaW5nIHRvIGF0dGFjaCBwcmFnbWEgdG8iKSAtIEkndmUgdHJpZWQgCnZhcmlhbnRz
IHdpdGggIi0gI2RlZmluZSBvbGRfanVuayh4LCB5LCB6KSAuLi4iIGFuZCB1c2luZyAiaWRlbnRp
ZmllciAKb2xkX2p1bmsiIGFuZCAiZnVuY3Rpb24gb2xkX2p1bmsiIHdpdGggdGhlIHNhbWUgcmVz
dWx0LgoKSXMgdGhlcmUgc29tZSBzeW50YXggZm9yICJyZW1vdmUgbGluZSB3aGljaCBzdGFydHMg
ZnJvbSB0aGlzIHByZWZpeCIgCndoaWNoIHdvcmtzIHdpdGggbXVsdGlsbmUgZGVmaW5lcyB3aGlj
aCB1c2UgIlwiPwoKSXQgc2VlbXMgbGlrZSB0aGUgIiMiIHN5bWJvbCBpcyBjYXVzaW5nIHRoZSB0
cm91YmxlIGJ1dCBJJ20gbm90IHN1cmUgaWYgCkkgc2hvdWxkIGVzY2FwZSBpdCBzb21laG93IG9y
IHRoZXJlJ3Mgc3BlY2lmaWMgZGVjbGFyYXRpb24gZm9yIG1hY3JvcyAKd2hpY2ggSSBzaG91bGQg
dXNlLgoKV2hhdCB3b3VsZCBiZSB0aGUgcmlnaHQgYXBwcm9hY2ggdG8gZ2V0IHJpZCBvZgoKX19f
X19fX19fX19fX19fX19fX19fX19fCgoKI2RlZmluZSBvbGRfanVuayhhLCBiLCBjKSBpZiAoYykg
XAoKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpbnRmKGEpOyBcCgogwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZWxzZSBcCgogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7IHByaW50Zihi
KTsgfQoKX19fX19fX19fX19fX19fX19fX19fX19fCgp3aXRoIHRoZSBoZWxwIG9mIHNwYXRjaD8K
Ci0tIAotIE1heCBTdXJhZXYgPG1zdXJhZXZAc3lzbW9jb20uZGU+ICAgICAgIGh0dHA6Ly93d3cu
c3lzbW9jb20uZGUvCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ciogc3lzbW9jb20gLSBzeXN0ZW1zIGZvciBtb2Jp
bGUgY29tbXVuaWNhdGlvbnMgR21iSAoqIEFsdC1Nb2FiaXQgOTMKKiAxMDU1OSBCZXJsaW4sIEdl
cm1hbnkKKiBTaXR6IC8gUmVnaXN0ZXJlZCBvZmZpY2U6IEJlcmxpbiwgSFJCIDEzNDE1OCBCCiog
R2VzY2hhZWZ0c2Z1ZWhyZXIgLyBNYW5hZ2luZyBEaXJlY3RvcnM6IEhhcmFsZCBXZWx0ZQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGlu
ZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWls
bWFuL2xpc3RpbmZvL2NvY2NpCg==
