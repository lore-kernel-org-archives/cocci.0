Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FEBC43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 15:26:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09AC20815
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 15:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09AC20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIFQ1In014283
          ; Tue, 18 Dec 2018 16:26:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B0E46740A;
	Tue, 18 Dec 2018 16:26:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DA80B3A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 16:25:59 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de
 [IPv6:2a01:4f8:191:444c:0:0:2:4] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIFPw2B025877
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 16:25:58 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id F3C3A4B73AD
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 15:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id 20WgbjICQgXF; Tue, 18 Dec 2018 15:25:57 +0000 (UTC)
Received: from [10.9.1.140] (ds9.sysmocom.de [90.187.64.137])
 by mail.sysmocom.de (Postfix) with ESMTPSA id AD1784B7396
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 15:25:56 +0000 (UTC)
To: cocci@systeme.lip6.fr
References: <a752b0e8-8ed0-1e86-eff7-3d91e87b11ae@sysmocom.de>
 <alpine.DEB.2.20.1812121322240.4125@hadrien>
 <b9f9b797-8f26-8034-7958-6182f5813e26@sysmocom.de>
 <alpine.DEB.2.21.1812130723160.2458@hadrien>
 <768d794a-e7a6-b011-f9af-5bb5a38b3c4a@sysmocom.de>
 <alpine.DEB.2.21.1812132056230.2465@hadrien>
 <e59c00ae-6b97-f8b4-6dca-dc23ffb7d414@sysmocom.de>
From: Max <msuraev@sysmocom.de>
Message-ID: <21bb981f-083a-8501-5db3-4a544f5c9646@sysmocom.de>
Date: Tue, 18 Dec 2018 16:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e59c00ae-6b97-f8b4-6dca-dc23ffb7d414@sysmocom.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 16:26:02 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 18 Dec 2018 16:25:58 +0100 (CET)
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

SXMgdGhlcmUgYSB3YXkgdG8gY29tYmluZSB0aG9zZSAyIHBhdGNoZXMgaW4gb25lIGZpbGU/CgpG
b3IgZXhhbXBsZSwgZm9sbG93aW5nIHNwYXRjaDoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCgovLyBzcGF0Y2ggLS1pbi1wbGFjZSAtLXNwLWZpbGUgbXkuc3BhdGNoIHRlc3RzL3Rlc3Qu
YwoKQEAKQEAKLSAjZGVmaW5lIE9MRChtc2csIGRhdGEsIGxlbikgLi4uCgpAQApleHByZXNzaW9u
IGEsIGIsIGM7CkBACi0gT0xEKGEsIGIsIGMpOworIGlmICghbXlfZnVuYyhhLCBiLCBjKSkKK8Kg
IGFib3J0KCk7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fCgpHaXZlcyBtZSBmb2xsb3dp
bmcgZXJyb3I6CgpydWxlIHN0YXJ0aW5nIG9uIGxpbmUgMjogbm9kZSAyNTogW2VuZF1bXSBpbiBz
b21ldGhpbmdfZWxzZSByZWFjaGFibGUgYnkgCmluY29uc2lzdGVudCBjb250cm9sLWZsb3cgcGF0
aHMKCndoaWNoIEkgZG9uJ3Qga25vdyBob3cgdG8gaW50ZXJwcmV0LgoKLS0gCi0gTWF4IFN1cmFl
diA8bXN1cmFldkBzeXNtb2NvbS5kZT4gICAgICAgaHR0cDovL3d3dy5zeXNtb2NvbS5kZS8KPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KKiBzeXNtb2NvbSAtIHN5c3RlbXMgZm9yIG1vYmlsZSBjb21tdW5pY2F0aW9u
cyBHbWJICiogQWx0LU1vYWJpdCA5MwoqIDEwNTU5IEJlcmxpbiwgR2VybWFueQoqIFNpdHogLyBS
ZWdpc3RlcmVkIG9mZmljZTogQmVybGluLCBIUkIgMTM0MTU4IEIKKiBHZXNjaGFlZnRzZnVlaHJl
ciAvIE1hbmFnaW5nIERpcmVjdG9yczogSGFyYWxkIFdlbHRlCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lz
dGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29j
Y2kK
