Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE68C43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 16:27:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F335421852
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 16:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F335421852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIGR4jg022219
          ; Tue, 18 Dec 2018 17:27:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DAE57740A;
	Tue, 18 Dec 2018 17:27:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 845393A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:27:02 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de
 [IPv6:2a01:4f8:191:444c:0:0:2:4] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIGR16T004870
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:27:01 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id 699A54B8034
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 16:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id PfXc6jxGmksK; Tue, 18 Dec 2018 16:26:59 +0000 (UTC)
Received: from [10.9.1.140] (ds9.sysmocom.de [90.187.64.137])
 by mail.sysmocom.de (Postfix) with ESMTPSA id 9F3CE4B8023
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 16:26:59 +0000 (UTC)
To: cocci@systeme.lip6.fr
References: <a752b0e8-8ed0-1e86-eff7-3d91e87b11ae@sysmocom.de>
 <alpine.DEB.2.20.1812121322240.4125@hadrien>
 <b9f9b797-8f26-8034-7958-6182f5813e26@sysmocom.de>
 <alpine.DEB.2.21.1812130723160.2458@hadrien>
 <768d794a-e7a6-b011-f9af-5bb5a38b3c4a@sysmocom.de>
 <alpine.DEB.2.21.1812132056230.2465@hadrien>
 <e59c00ae-6b97-f8b4-6dca-dc23ffb7d414@sysmocom.de>
 <21bb981f-083a-8501-5db3-4a544f5c9646@sysmocom.de>
 <alpine.DEB.2.20.1812181629290.2886@hadrien>
 <2b642105-f754-51a0-2e8b-c9f7d439d0d5@sysmocom.de>
 <alpine.DEB.2.20.1812181709180.2886@hadrien>
From: Max <msuraev@sysmocom.de>
Message-ID: <24915fbc-1c91-b175-b970-d72de73503c9@sysmocom.de>
Date: Tue, 18 Dec 2018 17:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1812181709180.2886@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 17:27:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 18 Dec 2018 17:27:01 +0100 (CET)
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

VGhhbmsgeW91LCB3b3JrZWQgbGlrZSBhIGNoYXJtLgoKMTguMTIuMTggMTc6MTAsIEp1bGlhIExh
d2FsbCDQv9C40YjQtdGCOgo+Cj4gVGhlcmUgc2VlbXMgdG8gYmUgc29tZXRoaW5nIHVuYW50aWNp
cGF0ZWQgYWJvdXQgdGhlIGNvbnRyb2wtZmxvdyBncmFwaCBvZgo+IGEgbWFjcm8gZGVmaW5pdGlv
bi7CoCBZb3UgY2FuIHVzZSB0aGUgYXJndW1lbnQgLS1hbGxvdy1pbmNvbnNpc3RlbnQtcGF0aHMK
PiB0byBieXBhc3MgdGhpcyBjaGVjay4KPgo+IGp1bGlhCj4KLS0gCi0gTWF4IFN1cmFldiA8bXN1
cmFldkBzeXNtb2NvbS5kZT4gICAgICAgaHR0cDovL3d3dy5zeXNtb2NvbS5kZS8KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KKiBzeXNtb2NvbSAtIHN5c3RlbXMgZm9yIG1vYmlsZSBjb21tdW5pY2F0aW9ucyBHbWJI
CiogQWx0LU1vYWJpdCA5MwoqIDEwNTU5IEJlcmxpbiwgR2VybWFueQoqIFNpdHogLyBSZWdpc3Rl
cmVkIG9mZmljZTogQmVybGluLCBIUkIgMTM0MTU4IEIKKiBHZXNjaGFlZnRzZnVlaHJlciAvIE1h
bmFnaW5nIERpcmVjdG9yczogSGFyYWxkIFdlbHRlCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5s
aXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
