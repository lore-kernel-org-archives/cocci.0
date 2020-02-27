Return-Path: <SRS0=oZAC=4P=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861E3C4BA24
	for <cocci@archiver.kernel.org>; Thu, 27 Feb 2020 09:43:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E1D2467F
	for <cocci@archiver.kernel.org>; Thu, 27 Feb 2020 09:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E1D2467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01R9hJ9B017490;
	Thu, 27 Feb 2020 10:43:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3412377FC;
	Thu, 27 Feb 2020 10:43:19 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6655577FA
 for <cocci@systeme.lip6.fr>; Thu, 27 Feb 2020 10:43:16 +0100 (CET)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01R9hFdr021389
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 27 Feb 2020 10:43:15 +0100 (CET)
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.53])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 05DDC41069;
 Thu, 27 Feb 2020 10:43:15 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
 by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 00526806EA;
 Thu, 27 Feb 2020 10:43:15 +0100 (CET)
Received: from yttrium.home (lfbn-gre-1-320-180.w90-112.abo.wanadoo.fr
 [90.112.40.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: palixn@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id CB7BE60386;
 Thu, 27 Feb 2020 10:43:14 +0100 (CET)
To: eamanu <eamanu@yaerobi.com>, Julia Lawall <julia.lawall@inria.fr>
References: <786d2ea9-621f-bcc4-b626-aed6454784e2@yaerobi.com>
 <alpine.DEB.2.21.2002041556540.3345@hadrien>
 <909d202d-9a8a-d010-107b-80c07febcb0f@yaerobi.com>
From: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
Organization: =?UTF-8?Q?Universit=c3=a9_Grenoble-Alpes?=
Message-ID: <65ec26be-3b40-4248-4fc6-e30f6785f9b1@univ-grenoble-alpes.fr>
Date: Thu, 27 Feb 2020 10:43:14 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <909d202d-9a8a-d010-107b-80c07febcb0f@yaerobi.com>
Content-Language: fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Feb 2020 10:43:19 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 27 Feb 2020 10:43:15 +0100 (CET)
X-Greylist: Whitelist-UGA SMTP Authentifie (palixn@univ-grenoble-alpes.fr) via
 submission-587 ACL (99)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle depends on unmaintained pygtk
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

SGkgRW1tYW51ZWwsCgpJbnN0ZWFkIG9mIHBvcnRpbmcgdG8gR09iamVjdCBkaXJlY3RseSwKY2Fu
IHdlIHVzZSBQeUdUS0NvbXBhdCA/CgpodHRwczovL3dpa2kuZ25vbWUub3JnL1Byb2plY3RzL1B5
R09iamVjdC9QeUdUS0NvbXBhdAoKUmVnYXJkcywKCkxlIDA0LzAyLzIwMjAgw6AgMTY6MjUsIGVh
bWFudSBhIMOpY3JpdMKgOgo+IEhpIQo+IAo+IE9uIDA0LzAyLzIwMjAgMTE6NTksIEp1bGlhIExh
d2FsbCB3cm90ZToKPj4gT24gVHVlLCA0IEZlYiAyMDIwLCBlYW1hbnUgd3JvdGU6Cj4+Cj4+PiBI
aSBldmVyeWJvZHksCj4+Pgo+Pj4gU29ycnkgaWYgdGhpcyBpc3N1ZXMgaXMgZHVwbGljYXRlZCwg
SSBhbSBuZXcgaW4gdGhlIG1haWxpbmcgbGlzdAo+Pj4gYW5kIGluIGEgdmVyeSBxdWlja2x5IHNl
YXJjaGluZyBJIGRpZG4ndCBmb3VuZCBhYm91dCB0aGlzIGlzc3VlLgo+Pj4KPj4+IEkgYW0gd29y
a2luZyBvbiBDb2NjaW5lbGxlIHBhY2thZ2Ugb24gRGViaWFuCj4+IFRoYW5rcyEKPj4KPj4+IGFu
ZCBjdXJyZW50bHkKPj4+IGV4aXN0IHRoZSBuZXh0IGJ1ZyBbMV0uCj4+Pgo+Pj4gVGhlcmUgaXMg
YW55IHBsYW4gdG8gcG9ydCB0byB1c2UgR09iamVjdCBJbnN0cm9zcGVjdGlvbj8KPj4+Cj4+PiBb
MV0gaHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcvY2dpLWJpbi9idWdyZXBvcnQuY2dpP2J1Zz04ODUy
NjcKPj4gSSB0aGluayB3ZSBzaG91bGQganVzdCBkcm9wIHRoZSBjb2RlIHRoYXQgZGVwZW5kcyBv
biBpdC4gIEl0IHdhcyBhZGRlZCBmb3IKPj4gYSBNUyB0aGVzaXMgbW9yZSB0aGFuIDEwIHllYXJz
IGFnbywgYW5kIEkgZG9uJ3QgdGhpbmsgYW55b25lIGhhcyB1c2VkIGl0Cj4+IHNpbmNlLgo+Pgo+
PiBJIHdpbGwgbG9vayBpbnRvIGl0Lgo+IAo+IEdyZWF0LCBpZiB5b3UgbmVlZCBoZWxwLCBJIGNh
biBoZWxwIDotKQo+IAo+IEkgd2lsbCB3YWl0IGZvciBhbnkgbmV3cy4gVGhhbmtzCj4gCj4gZWFt
YW51Cj4+Cj4+IGp1bGlhCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBDb2NjaSBtYWlsaW5nIGxpc3QKPiBDb2NjaUBzeXN0ZW1lLmxpcDYuZnIK
PiBodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCj4gCgoKLS0g
Ck5pY29sYXMgUGFsaXgKaHR0cDovL2xpZy1tZW1icmVzLmltYWcuZnIvcGFsaXgvCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlz
dApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9s
aXN0aW5mby9jb2NjaQo=
