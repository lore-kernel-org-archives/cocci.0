Return-Path: <SRS0=tHwe=7W=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3056CC433DF
	for <cocci@archiver.kernel.org>; Tue,  9 Jun 2020 18:20:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EAB82067B
	for <cocci@archiver.kernel.org>; Tue,  9 Jun 2020 18:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IuZnnz2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAB82067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 059IKMrD002349;
	Tue, 9 Jun 2020 20:20:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C13237783;
	Tue,  9 Jun 2020 20:20:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 436BA3F9A
 for <cocci@systeme.lip6.fr>; Tue,  9 Jun 2020 20:20:21 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 059IKI5p020278
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 9 Jun 2020 20:20:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591726817;
 bh=ulun1BEbdYvsQkOTzFPSx/jOGqd6Kej3nJH7PLDIRKs=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=IuZnnz2HA6HfKP+xYvM7msXd7QA4CX10RJ71bJQ77qJuo3PTIcDK4H8Vp3ANdDSLH
 TBTBMk4tRV/3LlbzjpL2IdfPtETpw+bQi2Y6/2EBHwRbH1ssWvRiPA+UwyboBiGlCJ
 I+MW+hjk9KBNlwkVHVW0zQSHm8PvM2hCOexgsBxI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([77.6.55.3]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxfKp-1it7P80Spn-017BBs; Tue, 09
 Jun 2020 20:20:17 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <88d56de0-0a22-3371-ebd9-0ccbbc81f76e@web.de>
 <alpine.DEB.2.21.2006091952570.2516@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <158f8704-dde3-f9af-b13d-d02ebdc2b77b@web.de>
Date: Tue, 9 Jun 2020 20:20:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006091952570.2516@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:pj3oMzIg+UVZBr1Q8dBo5UsV9F4nxz5ogT4FdTeiXnn63ysHPYj
 UNP8dkOWaDE5MfMwxyzigqtHp0vVljHLgvspZVLJ3odPWnPUSos7xYx7lKt41XjL7YL/qVB
 KRG4Xthm9e6xKTk+Fdq0nHj96/uIDDZfBEEKuDE5l7DJcwV5vrJVXcAQ1VJIGNolLTpLaXs
 WcxYBZdgC8pw6pGUEswkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vLionz2Ae+g=:2u2Yp1qzEpN1+p+FNLITqQ
 i8jTcNWe0P5L7cWGQ6OruoL9xuaMdrzcff4+ClQdk6dV6u3bMb/Vfh6WKIYzY3hZnd9kNGWOC
 G5WG1Vwa1+4xpwX47szxWS4Q5l1cXunKAdjPQXLKlS+14uqWX+4HGjwZasT6xyoGnmxmNxhP+
 s9jjXTUlTRmqNJUHfDJdzP5DCeBuMH/4TqVHkrt+11yY7UgZbWgzIi5Ijhrh+vWGELmanjqxk
 WbqZPcLGpMuKlKRQrtCPDk49GN8Gn2qB1Rc7De2k9Oy4Mbk4uh8QHhAr0oRGeVdMuktfXM7fM
 S44HS5yqpaag90c+oMX/rEHcx+br9Ha91G1cX1bpdtJjD2xmj4+HMtn7JDS4IvdCZkb6FfKTd
 ksHdjXjy0gKERHLHJbUaJlrbUbfssdNkwhF0/UZVlZ6PTQHBIAeUTKrIJFvfCXqEPTwcKy7jW
 1VCFi5n+Vd7sht7gRoC2b0WafQKyqWxYdTbqYUYFt2n7wA8v6dVwEIXWiSdz3egMWpq2YC4nw
 tDZylSoE3Iqtb9bLH7Vyn+1WGGFd+NI7VzY6mGIzle0ICPA3hru5J9RVDTbswSn45yXNH45kD
 5iXKxxwRV/RBK8V3v6mkMSpJ7fWaRuMArwl67SyFCIXY4X4+nT7ZXzyv6PF6Xufhl9XHKeS4W
 j2ZvY3mR9dzqp6mpWV2ltOSNi7xsk5JP0Y9A3L7kdRJoSzt5b+DLMa2hhqulcv0uJ8diXKnIb
 bZiDAno1TwEm5zCnwd2pdlgik2Bkx8I1PqFjeIxr3eOlWfw8hVt4jt6Kms/iFsfldoBvpga+o
 tpuHpEdLu89CkdTIwKPDs2U9a990XLvwqwy4Ie7GlmDSVzfGBgfbeBPAyj2Nyy1LYOX7QI6tU
 vK4CHAYUZqNwYn0IFsZ65m8Dyv0kHwXzdvGfebdWlTZ2BeSj/9qhKyUxdIrJfnQuglufI4L/K
 MIALro8fC+8/MiZS1mILC5ITDBYbDCEdaMOk4+iYk+CM5xk8lramRe54zngQMPk8WK2FAVwfi
 Uk4iezycMzdS3dPYYknhoUWSjgei4AC4Zjtpr2vxBRvM9wV3NGOwI9O7jcH0NT6uZi/zUDL7t
 oBYH8ZW2HKp/CKa9vb2znzPHDGMzHN1yOoH3oDWK6EItuwZgTO7+dLWmt0RRjci5Nz7BNXlk0
 fm59DMdTOcC+WC4aZ8iEdVqcpEiek4FrA4+bc2+UVD74egaRe9JABLu604nlgYYcGX5+zwuR0
 pEw73uPLmnSZ8Dnd1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jun 2020 20:20:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jun 2020 20:20:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking software behaviour according to selected SmPL
 code variants
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

Pj4gSWYgSSBvbWl0IHRoZSBzcGVjaWZpY2F0aW9uIOKAnCwgLi4u4oCdIGZyb20gdGhlIGZ1bmN0
aW9uIGNhbGwgcGFyYW1ldGVycwo+PiBiZWNhdXNlIEkgY291bGQgYmUgdW5zdXJlIGFib3V0IHRo
ZSBudW1iZXIgb2YgYXJndW1lbnRzIGluIG90aGVyCj4+IHNvZnR3YXJlIHNpdHVhdGlvbnMsIEkg
ZG8gbm90IGdldCB0aGUgZGVzaXJlZCB0ZXN0IG91dHB1dCBhcyBiZWZvcmUuCj4KPiBUaGlzIGhh
cyBiZWVuIGRpc2N1c3NlZCBiZWZvcmUuCgpJIHdhcyBqdXN0IGxvb2tpbmcgZm9yIGEgcmVsYXRl
ZCB1cGRhdGUgaW4gdGhpcyBhcmVhLgoKCj4gV2hlbiB5b3UgcHV0IDwrLi4uIC4uLis+IGluIGFu
IGFyZ3VtZW50IGxpc3QsIGl0IGRvZXNuJ3QgbWVhbiBhbiB1bmtub3duIG51bWJlcgo+IG9mIGFy
Z3VtZW50cywgaXQgbWVhbnMgb25lIGFyZ3VlbW50IHRoYXQgaGFzIHNvbWV0aGluZyBhcyBhIHN1
YmV4cHJlc3Npb24uCgpBbm90aGVyIFNtUEwgY29kZSB2YXJpYW50IGNhbiBldmVudHVhbGx5IGJl
Y29tZSBpbnRlcmVzdGluZyB0aGVuLgoKKnkgPSB4KC4uLiwgPCsuLi4gZSAuLi4rPiwgLi4uKQoK
Cj4+IElmIEkgb21pdCBldmVuIHRoZSBzZW1pY29sb24gZnJvbSB0aGUgYXNzaWdubWVudCBzdGF0
ZW1lbnQgaW4gdGhlCj4+IHNlYXJjaCBwYXR0ZXJuLCBJIGdldCBhbiBlcnJvciBtZXNzYWdlLgo+
Pgo+PiBlbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS9qYW5pdG9yPiBzcGF0Y2gg
LS1wYXJzZS1jb2NjaSBzaG93X3F1ZXN0aW9uYWJsZV9icmVsc2VfdXNhZ2U2LmNvY2NpCj4+IOKA
pgo+PiBtaW51czogcGFyc2UgZXJyb3I6Cj4+ICAgRmlsZSAic2hvd19xdWVzdGlvbmFibGVfYnJl
bHNlX3VzYWdlNi5jb2NjaSIsIGxpbmUgNiwgY29sdW1uIDAsIGNoYXJwb3MgPSA2Nwo+PiAgIGFy
b3VuZCA9ICcnLAo+PiAgIHdob2xlIGNvbnRlbnQgPQo+Cj4gVGhhdCBpcyBxdWl0ZSBub3JtYWwu
ICBPbmUgc3RhdGVtZW50IHNob3VsZCBiZSBmb2xsb3dlZCBieSBhbm90aGVyIHN0YXRlbWVudC4K
CkkgaG9wZSB0aGF0IHRoZSBzdXBwb3J0IHdpbGwgYmVjb21lIGJldHRlciBhbHNvIGZvciBhc3Np
Z25tZW50IGV4cHJlc3Npb25zLgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0
ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2Nj
aQo=
