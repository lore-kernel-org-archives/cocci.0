Return-Path: <SRS0=oZAC=4P=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE2FC4BA24
	for <cocci@archiver.kernel.org>; Thu, 27 Feb 2020 09:56:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11428222C2
	for <cocci@archiver.kernel.org>; Thu, 27 Feb 2020 09:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11428222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01R9uBIs018246;
	Thu, 27 Feb 2020 10:56:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EA7E377FC;
	Thu, 27 Feb 2020 10:56:10 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 713B777FA
 for <cocci@systeme.lip6.fr>; Thu, 27 Feb 2020 10:56:09 +0100 (CET)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01R9u8WR005304
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 27 Feb 2020 10:56:08 +0100 (CET)
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.53])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 9BD9D4125D;
 Thu, 27 Feb 2020 10:56:08 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [195.83.24.202])
 by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 96E6C80BA4;
 Thu, 27 Feb 2020 10:56:08 +0100 (CET)
Received: from yttrium.home (lfbn-gre-1-320-180.w90-112.abo.wanadoo.fr
 [90.112.40.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: palixn@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 7397360381;
 Thu, 27 Feb 2020 10:56:08 +0100 (CET)
To: Julia Lawall <julia.lawall@inria.fr>
References: <786d2ea9-621f-bcc4-b626-aed6454784e2@yaerobi.com>
 <alpine.DEB.2.21.2002041556540.3345@hadrien>
 <909d202d-9a8a-d010-107b-80c07febcb0f@yaerobi.com>
 <65ec26be-3b40-4248-4fc6-e30f6785f9b1@univ-grenoble-alpes.fr>
 <alpine.DEB.2.21.2002271044550.4309@hadrien>
From: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
Organization: =?UTF-8?Q?Universit=c3=a9_Grenoble-Alpes?=
Message-ID: <1183e7d0-b6e4-834d-5b27-47c43661bae6@univ-grenoble-alpes.fr>
Date: Thu, 27 Feb 2020 10:56:08 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002271044550.4309@hadrien>
Content-Language: en-GB
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Feb 2020 10:56:11 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 27 Feb 2020 10:56:08 +0100 (CET)
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

TGUgMjcvMDIvMjAyMCDDoCAxMDo0NSwgSnVsaWEgTGF3YWxsIGEgw6ljcml0wqA6Cj4gCj4gCj4g
T24gVGh1LCAyNyBGZWIgMjAyMCwgTmljb2xhcyBQYWxpeCB3cm90ZToKPiAKPj4gSGkgRW1tYW51
ZWwsCj4+Cj4+IEluc3RlYWQgb2YgcG9ydGluZyB0byBHT2JqZWN0IGRpcmVjdGx5LAo+PiBjYW4g
d2UgdXNlIFB5R1RLQ29tcGF0ID8KPj4KPj4gaHR0cHM6Ly93aWtpLmdub21lLm9yZy9Qcm9qZWN0
cy9QeUdPYmplY3QvUHlHVEtDb21wYXQKPiAKPiBUaGUgcHJvYmxlbSBpcyByZXNvbHZlZCBieSBy
ZW1vdmluZyB0aGUgcHl0aG9uIGZpbGUgdGhhdCByZWxpZWQgb24gdGhlCj4gdW5hdmFpbGFibGUg
bGlicmFyeS4gIEkgZG9uJ3QgdGhpbmsgdGhhdCB0aGF0IHB5dGhvbiBmaWxlIGlzIHVzZWZ1bC4K
Ckl0IGxvb2tzIGxpa2UgcHl0aG9uL2NvY2NpbGliL2NvY2NpZ3VpIGNvbnRhaW5zIHRoZSBvZmZl
bmRpbmcgZmlsZXM6CmNvY2NpZ3VpLnB5LCBweWd1aS5nbGFkZSBhbmQgcHlndWkuZ3JhZGVwLgpC
dXQgYWNjb3JkaW5nIHRvIHZpbWNvbS5weSBhbmQgdmltZW1iZWQucHksIHRoZXNlIGxhdGVycyBh
bHNvIGRlcGVuZCBvZiBHVEsuCgpTaG91bGQgdGhlIGNvY2NpZ3VpIGZvbGRlciBiZSBlbnRpcmVs
eSByZW1vdmVkID8KCj4gCj4ganVsaWEKPiAKPj4KPj4gUmVnYXJkcywKPj4KPj4gTGUgMDQvMDIv
MjAyMCDDoCAxNjoyNSwgZWFtYW51IGEgw6ljcml0wqA6Cj4+PiBIaSEKPj4+Cj4+PiBPbiAwNC8w
Mi8yMDIwIDExOjU5LCBKdWxpYSBMYXdhbGwgd3JvdGU6Cj4+Pj4gT24gVHVlLCA0IEZlYiAyMDIw
LCBlYW1hbnUgd3JvdGU6Cj4+Pj4KPj4+Pj4gSGkgZXZlcnlib2R5LAo+Pj4+Pgo+Pj4+PiBTb3Jy
eSBpZiB0aGlzIGlzc3VlcyBpcyBkdXBsaWNhdGVkLCBJIGFtIG5ldyBpbiB0aGUgbWFpbGluZyBs
aXN0Cj4+Pj4+IGFuZCBpbiBhIHZlcnkgcXVpY2tseSBzZWFyY2hpbmcgSSBkaWRuJ3QgZm91bmQg
YWJvdXQgdGhpcyBpc3N1ZS4KPj4+Pj4KPj4+Pj4gSSBhbSB3b3JraW5nIG9uIENvY2NpbmVsbGUg
cGFja2FnZSBvbiBEZWJpYW4KPj4+PiBUaGFua3MhCj4+Pj4KPj4+Pj4gYW5kIGN1cnJlbnRseQo+
Pj4+PiBleGlzdCB0aGUgbmV4dCBidWcgWzFdLgo+Pj4+Pgo+Pj4+PiBUaGVyZSBpcyBhbnkgcGxh
biB0byBwb3J0IHRvIHVzZSBHT2JqZWN0IEluc3Ryb3NwZWN0aW9uPwo+Pj4+Pgo+Pj4+PiBbMV0g
aHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcvY2dpLWJpbi9idWdyZXBvcnQuY2dpP2J1Zz04ODUyNjcK
Pj4+PiBJIHRoaW5rIHdlIHNob3VsZCBqdXN0IGRyb3AgdGhlIGNvZGUgdGhhdCBkZXBlbmRzIG9u
IGl0LiAgSXQgd2FzIGFkZGVkIGZvcgo+Pj4+IGEgTVMgdGhlc2lzIG1vcmUgdGhhbiAxMCB5ZWFy
cyBhZ28sIGFuZCBJIGRvbid0IHRoaW5rIGFueW9uZSBoYXMgdXNlZCBpdAo+Pj4+IHNpbmNlLgo+
Pj4+Cj4+Pj4gSSB3aWxsIGxvb2sgaW50byBpdC4KPj4+Cj4+PiBHcmVhdCwgaWYgeW91IG5lZWQg
aGVscCwgSSBjYW4gaGVscCA6LSkKPj4+Cj4+PiBJIHdpbGwgd2FpdCBmb3IgYW55IG5ld3MuIFRo
YW5rcwo+Pj4KPj4+IGVhbWFudQo+Pj4+Cj4+Pj4ganVsaWEKPj4+Cj4+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gQ29jY2kgbWFpbGluZyBsaXN0
Cj4+PiBDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKPj4+IGh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21h
aWxtYW4vbGlzdGluZm8vY29jY2kKPj4+Cj4+Cj4+Cj4+IC0tCj4+IE5pY29sYXMgUGFsaXgKPj4g
aHR0cDovL2xpZy1tZW1icmVzLmltYWcuZnIvcGFsaXgvCj4+Cj4gCgoKLS0gCk5pY29sYXMgUGFs
aXgKaHR0cDovL2xpZy1tZW1icmVzLmltYWcuZnIvcGFsaXgvCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0
ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2Nj
aQo=
