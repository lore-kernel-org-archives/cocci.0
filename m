Return-Path: <SRS0=Fhwl=3A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC079C33C9E
	for <cocci@archiver.kernel.org>; Sat, 11 Jan 2020 05:07:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C232077C
	for <cocci@archiver.kernel.org>; Sat, 11 Jan 2020 05:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C232077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00B56k8x003586;
	Sat, 11 Jan 2020 06:06:46 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9B04D77DF;
	Sat, 11 Jan 2020 06:06:46 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8E6197718
 for <cocci@systeme.lip6.fr>; Sat, 11 Jan 2020 06:06:44 +0100 (CET)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00B56g1O012905
 for <cocci@systeme.lip6.fr>; Sat, 11 Jan 2020 06:06:43 +0100 (CET)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R311e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07486; MF=wenyang@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0TnNYIC5_1578719194; 
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com
 fp:SMTPD_---0TnNYIC5_1578719194) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 11 Jan 2020 13:06:39 +0800
To: Markus Elfring <Markus.Elfring@web.de>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
References: <20200110131526.60180-1-wenyang@linux.alibaba.com>
 <91abb141-57b8-7659-25ec-8080e290d846@web.de>
From: Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <c4ada2f2-19b0-91ef-ddf3-a1999f4209ea@linux.alibaba.com>
Date: Sat, 11 Jan 2020 13:06:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <91abb141-57b8-7659-25ec-8080e290d846@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 11 Jan 2020 06:06:47 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 11 Jan 2020 06:06:44 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Cocci] [PATCH v3] coccinelle: semantic patch to check for
 inappropriate do_div() calls
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

CgpPbiAyMDIwLzEvMTEgMTI6MzUg5LiK5Y2ILCBNYXJrdXMgRWxmcmluZyB3cm90ZToKPj4gK0Bp
bml0aWFsaXplOnB5dGhvbkAKPiDigKYKPj4gK2RlZiBmaWx0ZXJfb3V0X3NhZmVfY29uc3RhbnRz
KHN0cik6Cj4g4oCmCj4+ICtkZWYgY29uc3RydWN0X3dhcm5pbmdzKHN0ciwgc3VnZ2VzdGVkX2Z1
bik6Cj4gCj4gKiBJIHN1Z2dlc3Qgb25jZSBtb3JlIHRvIGFkanVzdCB0aGUgZGVwZW5kZW5jeSBz
cGVjaWZpY2F0aW9ucyBmb3IgdGhlIHVzYWdlCj4gICAgb2YgdGhlc2UgZnVuY3Rpb25zIGJ5IFNt
UEwgcnVsZXMuCj4gCgpNb3N0IG9mIHRoZSBmdW5jdGlvbnMgaGVyZSBhcmUgZm9yIGFsbCBvcGVy
YXRpb24gbW9kZXMuCgoKPiAqIENhbiB0aGUgbG9jYWwgdmFyaWFibGUg4oCcbXNn4oCdIGJlIG9t
aXR0ZWQ/Cj4gCj4gCj4+ICtjb2NjaWxpYi5vcmcucHJpbnRfdG9kbyhwWzBdLCBjb25zdHJ1Y3Rf
d2FybmluZ3MoImRpdjY0X3VsIikpCj4gCj4gSSBzdWdnZXN0IGFnYWluIHRvIG1vdmUgdGhlIHBy
ZWZpeCDigJxkaXY2NF/igJ0gaW50byB0aGUgc3RyaW5nIGxpdGVyYWwKPiBvZiB0aGUgZnVuY3Rp
b24gaW1wbGVtZW50YXRpb24uCj4gCgrigJxkaXY2NF91bOKAnSBpbmRpY2F0ZXMgdGhlIGZ1bmN0
aW9uIG5hbWUgd2UgcmVjb21tZW5kLgpBcyBzaG93biBpbiB0aGUgcGF0Y2g6CgorZGVmIGNvbnN0
cnVjdF93YXJuaW5ncyhzdWdnZXN0ZWRfZnVuKToKKyAgICBtc2c9IldBUk5JTkc6IGRvX2Rpdigp
IGRvZXMgYSA2NC1ieS0zMiBkaXZpc2lvbiwgcGxlYXNlIGNvbnNpZGVyIAp1c2luZyAlcyBpbnN0
ZWFkLiIKKyAgICByZXR1cm4gIG1zZyAlIHN1Z2dlc3RlZF9mdW4KLi4uCitjb2NjaWxpYi5vcmcu
cHJpbnRfdG9kbyhwWzBdLCBjb25zdHJ1Y3Rfd2FybmluZ3MoImRpdjY0X3VsIikpCgpJZiB3ZSBk
ZWxldGUgdGhlIHByZWZpeCAiZGl2NjRfIiwgaXQgbWF5IHJlZHVjZSByZWFkYWJpbGl0eS4KCj4g
Cj4gVGhlIFNtUEwgY29kZSBmb3IgdHdvIGRpc2p1bmN0aW9ucyBjb3VsZCBiZWNvbWUgc2hvcnRl
ci4KPiAKCllvdSBtYXkgc3VnZ2VzdCB0byBtb2RpZnkgaXQgYXMgZm9sbG93czoKK0BACisqZG9f
ZGl2KGYsIFwoIGwgXHwgdWwgXHwgdWw2NCBcfCBzbDY0IFwpICk7CgpXZSBhZ3JlZSB3aXRoIEp1
bGlhOgpJIGRvbid0IHNlIGFueSBwb2ludCB0byB0aGlzLiAgVGhlIGNvZGUgbWF0Y2hlZCB3aWxs
IGJlIHRoZSBzYW1lIGluIGJvdGgKY2FzZXMuICBUaGUgb3JpZ2luYWwgY29kZSBpcyBxdWl0ZSBy
ZWFkYWJsZSwgd2l0aG91dCB0aGUgdWdseSBcKCBldGMuCgotLQpSZWdhcmRz77yMCldlbgoKPiBS
ZWdhcmRzLAo+IE1hcmt1cwo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBz
Oi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
