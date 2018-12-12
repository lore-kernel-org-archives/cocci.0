Return-Path: <SRS0=XveF=OV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F315EC65BAF
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 22:52:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3532020851
	for <cocci@archiver.kernel.org>; Wed, 12 Dec 2018 22:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3532020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCMqDvx013189
          ; Wed, 12 Dec 2018 23:52:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C466176AB;
	Wed, 12 Dec 2018 23:52:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0339560D7
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 23:52:12 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de [144.76.43.93])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBCMqBQO022015
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 23:52:11 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id 2CCE847C948
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 22:52:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id 4SNWzysAPtOM; Wed, 12 Dec 2018 22:52:10 +0000 (UTC)
Received: from [10.2.1.203] (port-92-195-24-223.dynamic.qsc.de [92.195.24.223])
 by mail.sysmocom.de (Postfix) with ESMTPSA id 1496547C93B
 for <cocci@systeme.lip6.fr>; Wed, 12 Dec 2018 22:52:10 +0000 (UTC)
To: cocci@systeme.lip6.fr
References: <a752b0e8-8ed0-1e86-eff7-3d91e87b11ae@sysmocom.de>
 <alpine.DEB.2.20.1812121322240.4125@hadrien>
From: Max <msuraev@sysmocom.de>
Message-ID: <b9f9b797-8f26-8034-7958-6182f5813e26@sysmocom.de>
Date: Wed, 12 Dec 2018 19:00:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1812121322240.4125@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 12 Dec 2018 23:52:14 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 12 Dec 2018 23:52:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
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

U3BsZW5kaWQsIHdvcmtlZCBsaWtlIGEgY2hhcm0gb25jZSBJJ3ZlIGxlZnQgb25seSAiZXhwcmVz
c2lvbiBhLCBiLCBjIiAKaW4gdGhlIGhlYWRlci4gVGhhbmsgeW91IGZvciBxdWljayBhbmQgZGV0
YWlsZWQgcmVzcG9uc2UuCgpPbiBhIHJlbGF0ZWQgbm90ZTogd291bGQgaXQgYmUgcG9zc2libGUg
dG8gcmVtb3ZlIG9sZCBtdWx0aS1saW5lICNkZWZpbmUgCnVzaW5nIHNwYXRjaCBhcyB3ZWxsPwoK
VGhhdCdzIG9mIGNvdXJzZSBtb3JlIG9mIGEgbml0cGlja2luZyBidXQgd291bGQgYmUgbmljZSB0
byBnZXQgcmlkIG9mIAp0aGUgb2xkIGRlZmluaXRpb24gb25jZSBpdCdzIG5vdCB1c2VkIGFueW1v
cmUgYXMgd2VsbC4KCk15IGF0dGVtcHRzIGF0IHRoYXQgcmVzdWx0ZWQgb25seSBpbiAibm90aGlu
ZyB0byBhdHRhY2ggcHJhZ21hIHRvIiBlcnJvciAKc28gaXQgc2VlbXMgbGlrZSAjZGVmaW5lIGl0
c2VsZiBpcyBoYW5kbGVkIGFzIGEgc3BlY2lhbCBjYXNlIG9mIHNvbWUgCnNvcnQgd2hpbGUgdGhl
IHVzZSBvZiBtYWNybyBhbmQgZnVuY3Rpb24gaXMgZXF1aXZhbGVudC4KCjEyLjEyLjE4IDEzOjI2
LCBKdWxpYSBMYXdhbGwg0L/QuNGI0LXRgjoKPgo+IEFjdHVhbGx5LCB0aGUgZmFjdCB0aGF0IG9s
ZF9qdW5rIGFuZCBuZXdfc3R1ZmYgYXJlIGRlZmluZWQgYXMgbWFjcm9zIGlzCj4gaXJyZWxldmFu
dCBmb3IgdGhpcyBydWxlLiAgQ29jY2luZWxsZSB3aWxsIGp1c3QgbG9vayBhdCB0aGUgY2FsbHMu
ICBJdAo+IGRvZXNuJ3QgZXhwbGFuZCBtYWNyb3MsIHNvIGl0IGRvZXNuJ3Qga25vdyB3aGV0aGVy
IHRoZSBjYWxsIGlzIHRvIGEgbWFjcgo+IG9yIHRvIGEgZnVuY3Rpb24uCj4KPiBqdWxpYQoKLS0g
Ci0gTWF4IFN1cmFldiA8bXN1cmFldkBzeXNtb2NvbS5kZT4gICAgICAgaHR0cDovL3d3dy5zeXNt
b2NvbS5kZS8KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KKiBzeXNtb2NvbSAtIHN5c3RlbXMgZm9yIG1vYmlsZSBj
b21tdW5pY2F0aW9ucyBHbWJICiogQWx0LU1vYWJpdCA5MwoqIDEwNTU5IEJlcmxpbiwgR2VybWFu
eQoqIFNpdHogLyBSZWdpc3RlcmVkIG9mZmljZTogQmVybGluLCBIUkIgMTM0MTU4IEIKKiBHZXNj
aGFlZnRzZnVlaHJlciAvIE1hbmFnaW5nIERpcmVjdG9yczogSGFyYWxkIFdlbHRlCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
