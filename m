Return-Path: <SRS0=ltHb=6B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17247C2BB1D
	for <cocci@archiver.kernel.org>; Fri, 17 Apr 2020 06:09:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323DE21D82
	for <cocci@archiver.kernel.org>; Fri, 17 Apr 2020 06:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="nzdnJRr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323DE21D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03H68nj9008253;
	Fri, 17 Apr 2020 08:08:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BF74D781A;
	Fri, 17 Apr 2020 08:08:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 273B03B93
 for <cocci@systeme.lip6.fr>; Fri, 17 Apr 2020 08:08:48 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03H68lwZ023646
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 17 Apr 2020 08:08:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587103725;
 bh=352+rFYrKrG48G2DiseaE6b/xzU6Oi8gITjRAQVEARk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=nzdnJRr3HDIjQuGmsETTMHQfsOcmD9W3aRqwMjh0JhayErfo9Oar0VXmhmgmwmkU0
 9l58bzPyIJMONTQno3e9w4jj0bvM4UIFbB6gQbBykUAt5y/KccmxUouQ2tRt5xrwXh
 7pe9hGQT0witTVrVv0B1CATrvLU2U8teSm9qYtg4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.97.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwqBg-1jA3NN3FzE-016KnP; Fri, 17
 Apr 2020 08:08:45 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <alpine.DEB.2.21.2004151949230.2381@hadrien>
 <5702b553-d054-33a4-8544-f68ed5457acc@web.de>
 <alpine.DEB.2.21.2004161052210.2447@hadrien>
 <0365dceb-3b66-48cd-c273-4bf7fceb4688@web.de>
 <alpine.DEB.2.21.2004161444300.8125@hadrien>
 <735a3c61-695b-a857-b0ce-8999b04644b1@web.de>
 <alpine.DEB.2.21.2004161627300.8125@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6aa255a7-5fa1-fef6-a5b7-c0e9d5e3f441@web.de>
Date: Fri, 17 Apr 2020 08:08:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004161627300.8125@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:tZBCCyWI/3p9uVRRpszMTgk+qFt5LcUEzFaVp1Xkn4Rh0bIf6sz
 /2Ho7ZgljYK9ITbfgsd7QnM5A+scNLwSTLYl7xw04u129d5yp84bbUHvxb/wOxT5DPSBXV+
 IbVxTHrtEBYbzJs7PW/VNU5MUuVE62Chu/Doi1OwAwiReuBlqRgrx0dgX1jgRnpopHGZ8gt
 mWFKE8dZTuRQTrl/TcpIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WVxSrFIZ3Rs=:8/RMLUxlHmCAIEW32fl8WN
 +7Xa9t/ucHSGWs8Q+nnjpqRO7LzQrQ/x1Dxxn7JjVju0wcmrPjbxwZsxfWjve69GzgHAROfJ3
 Ct8KKl+uvbQPQgkmgsHGVVIC2op3C6GI7bW8nRUxVkM1fy2tja0t/sgwEkyDUocEF9KTavDbF
 BPMXTdFtyLHd+ChVfxM1AsxUGigQcnNIZ5XC3W6lP5EwBsDjaI0OQwoWzNbuasZSPMwzcvPkg
 2MRRkjcfdER7e1FFQF523R8Faiyvpu29sUcL956f+jbWX2iiWfUcyWEp7hx/myMB+FC+8q1MA
 0wuFgyAMo7qoFEEn2iuLDC9uagg2lven0iOJOnlWvDY8FM/A8V+E+kkYB0QcJcqmvwRrAxKRI
 yCPzKyIkTvhv4QlvuDXMRVRzCUQHnhrbx9kDSkB2qWRFMXMJq1F/oFtrzZWliPPpZElLTy/C7
 gwybRfBIK/p2yqDqGQsJFoclyEMW+RP3zaGDee3CzBpuKqfa7LQ1bZjdUlPIzRRAV2U06j4eg
 XCQJr6UmHUFuNtZotF6R371cs+EQ3KitNlnFAwPUSpnufyMsftK1oyNCDtD474EPsZgGP50vA
 zRW+v7BDlLfFGAjItYeshEMQrHAE8jlEqQ+0qYU1BlXkRI51s2GDrC//lUcyR/DP1O+IlbL+H
 jAyzi1ZOR3QfAiw34UIP4tjo5tsAgkvHEEqfLJJnc+W7c+URoNNDZ9Xa6ZDoQkekpXwKNQrNc
 zO2wjVCGAOeNe/hM84cluhImU6orhphop0aa0JTO4A6dxijFFg8gEJUznQtJI4DXsbuVOZVsb
 YT4+jTm/uMOym508h6OfxKLwdVBM15aOu1KLpSEpS37fCAcOKFcRivDVzHiA5r+fz47p9AWik
 6T//5H3z99PeAMpvoNifDtF1lB4VwibHb0KcQiDlm1i+IWQa0VT8tFJm3Y2fLXUK7pWUFGaOc
 q5ho4pM9k2YS2QY5FavNVk0wZHuDaTlGb9RM5m+bUv9hNX6UIg68PD86xmJwzhHrDV26FI/Wz
 fKcgG6TojApDqakDrKLWmc8kisHKFe/88YRJLT6YUVX2pxtuj6Bv4USUDKYmV6cVWThM6oxr1
 5DQxJB2LfKGjwR9HerMeKD2VlluJmCW9Bi+8T/KwLwWNzSO4d4XW4l+bFfA0jBDw4Pofigj7G
 A0+gCgHWFWjCTJ5zjexoAnh8CigNFak0rANuSppdZiJTAAAailIG7lWnhPe2co/3aXzZ8wHtI
 1KgpMS2iNPdeFKT4Y
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 17 Apr 2020 08:08:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 17 Apr 2020 08:08:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Dejin Zheng <zhengdejin5@gmail.com>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the replacement of two specific function calls
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

PiBPSywgaXQgc2VlbXMgdGhhdCB0aGUgc3RydWN0dXJlIGlzIGRlZmluZWQgaW4gdGhlIHNhbWUg
ZmlsZSBzbyBubyBpbmNsdWRlCj4gb3B0aW9ucyBzaG91bGQgYmUgbmVlZGVkLiAgQnV0IEkgaGF2
ZSBub3cgbG9zdCB0cmFjayBvZiB3aGF0IHRoZQo+IHNlbWFudGljIHBhdGNoIGFjdHVhbGx5IGlz
LCBzbyBJIGRvbid0IGtub3cgd2hhdCBpcyB0aGUgcHJvYmxlbS4KCjEuIFVuZm9ydHVuYXRlbHks
IEkgbmVlZGVkIGEgYml0IGxvbmdlciB0byBiZWNvbWUgbW9yZSBhd2FyZSBvZiByZWxldmFudAog
ICBkaWZmZXJlbmNlcyBpbiBzb3VyY2UgY29kZSB2YXJpYXRpb25zLgogICBBbm90aGVyIGNhc2Ug
ZGlzdGluY3Rpb24gd291bGQgYmUgbmVlZGVkLiBUaHVzIGEgY29ycmVzcG9uZGluZwogICBTbVBM
IGRpc2p1bmN0aW9uIGlzIHByb2JhYmx5IHJlcXVpcmVkLgogICBJIGhhdmUgdHJpZWQgb3V0IHRv
IGV4cHJlc3MgdGhlIGRlc2lyZWQgY2hhbmdlIGJ5IGEgU21QTCBzcGVjaWZpY2F0aW9uCiAgIHdo
aWNoIGNhbiBiZSBhIGJpdCBtb3JlIHByZWNpc2UuCgpAcmVwbGFjZW1lbnRACmV4cHJlc3Npb24g
YmFzZSwgZGV2aWNlLCBwcml2YXRlLCByZXNvdXJjZTsKQEAKLXJlc291cmNlID0gcGxhdGZvcm1f
Z2V0X3Jlc291cmNlKGRldmljZSwgSU9SRVNPVVJDRV9NRU0sIDApOwogYmFzZSA9Ci0gICAgICAg
ZGV2bV9pb3JlbWFwX3Jlc291cmNlCisgICAgICAgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVt
YXBfcmVzb3VyY2UKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoCigKLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2aWNl
Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtPmRldgogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsICYKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzb3VyY2UKfAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBkZXZpY2UsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MCwgJgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaXZhdGUtPnJlcwop
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKTsKCgplbGZyaW5nQFNvbm5lOn4vUHJvamVr
dGUvQ29jY2luZWxsZS9qYW5pdG9yPiBzcGF0Y2ggLS1wYXJzZS1jb2NjaSB1c2VfZGV2bV9wbGF0
Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2U2LmNvY2NpCuKApgp3YXJuaW5nOiBpc28gcHRy
X3RvX2FycmF5IGRvZXMgbm90IG1hdGNoIHRoZSBjb2RlIGJlbG93IG9uIGxpbmUgMTEKZGV2aWNl
LT5kZXYKCnRoZSBmb2xsb3dpbmcgY29kZSBtYXRjaGVkIGlzIG5vdCB1bmlmb3JtbHkgbWludXMg
b3IgY29udGV4dCwKb3IgY29udGFpbnMgYSBkaXNqdW5jdGlvbjoKRXhwOgpkZXZpY2UtPmRldgri
gKYKCgoyLiBXb3VsZCBpdCBiZSBvY2Nhc2lvbmFsbHkgbmljZSB0byBpbnRlbnRpb25hbGx5IGV4
cHJlc3MgcmVzdHJpY3Rpb25zIG9uCiAgIHBvaW50ZXIgZGF0YSB0eXBlcyBieSB1c2luZyB0aGUg
YXN0ZXJpc2sgaW4gbWV0YXZhcmlhYmxlIGRlY2xhcmF0aW9ucz8KCgozLiBJZiB3ZSB3b3VsZCBy
ZXF1aXJlIGluZm9ybWF0aW9uIGZyb20gaGVhZGVyIGZpbGVzOgogICBJcyBhIGZpbGUgaW5jbHVz
aW9uIGZhaWx1cmUgdHJlYXRlZCBhcyBhbiBpbW1lZGlhdGUgU21QTCBzY3JpcHQKICAgZXhlY3V0
aW9uIGVycm9yPwoKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2
LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
