Return-Path: <SRS0=Nj+g=JC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64F3C433ED
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 08:55:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C2D610E8
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 08:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C2D610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1358svfO014756;
	Mon, 5 Apr 2021 10:54:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1D6423CA1;
	Mon,  5 Apr 2021 10:54:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2E19E3C26
 for <cocci@systeme.lip6.fr>; Mon,  5 Apr 2021 10:46:47 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 1358kkcw013133
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 5 Apr 2021 10:46:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1617612405;
 bh=w9o8spyuIBTYwoNRil9r3sKyLl1ktM/+E4e6OLdd75Y=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=V8ChU7XUYpW9uET1NkHz0Z1PKbrNhgG9A0DKsNJAew270iLX/c9si+qdNAIgY4iYo
 qrXOhrVsdf/CLOTCwYHuGUhj+oQJhZkoPAPoxeSYG1QYDVzTLLeoV0+I1RK/NWUqX+
 b2FCjFD+QtRbRTBBjFPMzMgJNwkJSIex3ElCwVE8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.144.25]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCHy-1m0BjB2MPo-00bXTr; Mon, 05
 Apr 2021 10:46:45 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <0756b630-a2d7-f300-3b11-59af33b48631@web.de>
 <alpine.DEB.2.22.394.2103281128560.2854@hadrien>
 <1b5f6d22-5b89-097f-37bd-13b3b2ab011a@web.de>
 <alpine.DEB.2.22.394.2103281244200.2854@hadrien>
 <173fa182-4127-aaba-262e-e3953a81a1e2@web.de>
 <alpine.DEB.2.22.394.2103281343310.2854@hadrien>
 <f720b262-708f-a603-3470-b374db625578@web.de>
 <alpine.DEB.2.22.394.2103281644480.2854@hadrien>
 <fa66fce2-e60e-1907-7c8b-fd9ceedb8086@web.de>
 <alpine.DEB.2.22.394.2104041357060.2958@hadrien>
 <addb2edb-98cb-2834-b1b9-7d44cacda965@web.de>
 <alpine.DEB.2.22.394.2104041419290.2958@hadrien>
 <b9f6aceb-7e68-303d-bd1e-d41a7992b58b@web.de>
 <alpine.DEB.2.22.394.2104050907270.2981@hadrien>
 <8561006e-7dc6-0f62-ecf0-c93146976925@web.de>
 <alpine.DEB.2.22.394.2104050953290.2981@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <771c012f-bc1f-d330-6209-72130e199ae2@web.de>
Date: Mon, 5 Apr 2021 10:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2104050953290.2981@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:mOe8KR9ESmvLQBCMBk/M1mIQ4qZ7FNklUcdnIGWzmVg0ewhFFjS
 7GF8jEMenyFJNc900ZR/qtSzE0gjmQCCYmqxKYr7WD62f2fdeGJubTQLxQPvKxKgEmyTKzD
 QCbIkB378yXRXMsGvqcrONqCtu/Zb6fHFnxJdUDMskU3M+vwzjNSz4b7GT6yleL4Mib7zk2
 Qcyuqta03UWahoBTCXhfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HugxA7lsA4s=:PiBTlYhwid5mUkeESJzO3r
 2l2Nx39GjkjJXJtpwSC5TbLf6CW3iKIO5oZZTeufPn9a2hKObf+PFob6HG4TBOy6VS3mGgjlX
 t0viRLmV6ZQ1+IZuQqeOCVM6RE3i84BXM9LTmUCfu0N8OGOLG/rDFJjggLiqm/81rLQofuZTZ
 fP5asZth5PCWO8veVHcWOYnC+8CIwkKCf3DcEFuciYhr2ewx1Y66UY5pnA1ptV5w5WUVg4jUb
 S0QOcEOHWmda1GfK3U1yL6E2KD/9xOOsJpCXrt7FRgF1SrOxcTLbHswlzG6+K1Xpr44SqgAqW
 JvyCbvZJ6wONXLCUQt7mG9HTpnIi/dQ7zirGsWHISTYxrHwiULzuf9hxYxXEUyOetoq/yznlr
 /sgO0U5kvnVbVfzdqDnC02sgA7BvFnPidc6PNoSh/LLPU1kUyA/lUXTgbyRYhYM+AStq5gbMu
 oxrgC5jqWF49HtikK+kGp7QBifFu9EJRoJdx/M70hsoesNNeWckUVQT8fA61vCiE3IXuSV6GO
 9gPc4rVG8701h9XjpvxRuSVG+HXbvjcp70+Vzy9H5WeFSk9OhqLhaXDZpkwUjb9UmamrZH2ro
 oka1sJNou1IKnwBPjc8qRrNXVMUijU92ZoN9nDDk5gbohZKRxEpxm8DyPs77qga6WvrI3SEiZ
 p0Zi6rx7D+7pok1/3mR9RAXYt5ko5QaCzHxAevQaQFBdZ6q0tBHDQRTBAmm1WdYbZQEKzoZ+t
 WDD9Jfzks49BhyOwSNcacOivZ+VIg3Hz69pAMKnZH28rsZQ6oWlXQIUEYm1YaWzSmvJcPFXPJ
 GiRMWitaWIZJJJcPcq2OlEjXrUwqFThN3ZLNoCvq1s145EvSIjY21b5m/9mkPd0MFsuCoWLVC
 ewFW76qhvuEV9GoO9PLbwZkt3dX3b4XAwDAQfYeD7wj/Om0/TjBV0KQbuHUyH5J9YbO27u3A1
 aiX9q9cgh0WUKm8RcwAqCRl/SQPsW/dfyO7PVkiwurUxZjrsIOP3zmcwLVazEf2n4MWyhU4po
 9mqlDP2bK4C8Pz2L5cZ/TslMlLqyzLIovG2ZQTbGDHmuCikLac4qhePfon85Eia9tU9HQ57nZ
 kBWnySm+hkkgceXKU+AejqObTZA8rm8cr0UyTlouqeUkhc97RVHmUfra6L5rM+BAaABg8pp3b
 jy962CM1iQX9t7Y+NWMmBXl1H+mpyZM2Jg+SLCBYzOrC5iwUyIfdYl6mBxJ17c2AnAr0TVk5q
 UFB7bmIYi4/pT91Ho
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 05 Apr 2021 10:54:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 05 Apr 2021 10:46:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 05 Apr 2021 10:54:55 +0200
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking support for compound expressions (according to
 #define directives)
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

Pj4gSSB3b3VsZCBsaWtlIHRvIGF2b2lkIHRoZSByZXBldGl0aW9uIG9mIHBhcnNpbmcgZWZmb3J0
cyBhcyBtdWNoIGFzIHBvc3NpYmxlLgo+PiBVbmRlciB3aGljaCBjaXJjdW1zdGFuY2VzIGNhbiBy
ZXBsYWNlbWVudCBsaXN0cyBiZSB0YWtlbiBiZXR0ZXIgaW50byBhY2NvdW50Pwo+Cj4gV2h5IGRv
ZXMgbXkgc3VnZ2VzdGlvbiBpbnZvbHZlIGEgcmVwZXRpdGlvbiBvZiBwYXJzaW5nIGVmZm9ydD8K
ClRoZSBzZWxlY3Rpb24gb2YgdGhlIGFwcGxpZWQgcHJvZ3JhbW1pbmcgaW50ZXJmYWNlcyBoYXMg
Z290IHNpZ25pZmljYW50IGluZmx1ZW5jZXMKb24gdGhlIHJ1biB0aW1lIGJlaGF2aW91ci4KClNl
ZSBhbHNvOgpodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vlcy8y
MDAjaXNzdWVjb21tZW50LTY1Mzc3NTI4OAoKCj4gWW91IHdhbnQgdG8gdXNlIGEgcmVnZXhwLgoK
VGhpcyB2aWV3IGRlcGVuZHMgb24gc29tZSBmYWN0b3JzLgpJIHdvdWxkIHByZWZlciB0byBzZWFy
Y2ggZm9yIHN0cmluZyBsaXRlcmFscyAoYW5kIHRoZWlyIGV4Y2x1c2lvbikgYnkgaGlnaGVyIGxl
dmVsIG1lYW5zLgoKCj4gSSdtIGFza2luZyB5b3UgdG8gcHV0IHRoZSByZWdleHAgaW4gYSBweXRo
b24gZnVuY3Rpb24uCgpIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIGltcHJvdmUgdGhlIGZvbGxv
d2luZyBzb2Z0d2FyZSBzaXR1YXRpb24KYmVzaWRlcyB0aGUgYXBwbGljYXRpb24gb2YgcmVndWxh
ciBleHByZXNzaW9ucz8KCkBpbml0aWFsaXplOnB5dGhvbkAKQEAKaW1wb3J0IHJlCgpAZGlzcGxh
eUAKaWRlbnRpZmllciBpID1+ICJeKD86W0EtWl0rXyl7MywzfVtBLVpdKyI7CmV4cHJlc3Npb24g
ZSA6IHNjcmlwdDpweXRob24oKSB7IHJlLm1hdGNoKCciJywgZSkgfTsKQEAKKiNkZWZpbmUgaSBl
CgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL1BpcGVXaXJlL2xva2FsPiBzcGF0Y2ggfi9Qcm9q
ZWt0ZS9Db2NjaW5lbGxlL2phbml0b3Ivc2hvd19kZWZpbmVfdXNhZ2U3LmNvY2NpIHNwYS9pbmNs
dWRlL3NwYS9ub2RlL3R5cGUtaW5mby5oCuKApgogIEZpbGUgIjxzdHJpbmc+IiwgbGluZSA1CiAg
ICBjb2NjaW5lbGxlLnJlc3VsdCA9IChyZSAuIG1hdGNoICggIiAsIGUgKSkKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgpTeW50YXhFcnJvcjogRU9MIHdoaWxl
IHNjYW5uaW5nIHN0cmluZyBsaXRlcmFsCgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2Nj
aUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5m
by9jb2NjaQo=
