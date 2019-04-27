Return-Path: <SRS0=Dpxx=S5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA88C43218
	for <cocci@archiver.kernel.org>; Sat, 27 Apr 2019 17:20:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD4D20693
	for <cocci@archiver.kernel.org>; Sat, 27 Apr 2019 17:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="daHlf7g9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD4D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3RHKE1X010227
          ; Sat, 27 Apr 2019 19:20:14 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E4120773D;
	Sat, 27 Apr 2019 19:20:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0583E7734
 for <cocci@systeme.lip6.fr>; Sat, 27 Apr 2019 19:20:12 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3RHKBPS029079
 for <cocci@systeme.lip6.fr>; Sat, 27 Apr 2019 19:20:11 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1556385610;
 bh=6vbNS3XmhpTBi9uujFWYC0sCvwyM2m3ku15DmGuj2i8=;
 h=X-UI-Sender-Class:Subject:From:References:To:Date:In-Reply-To;
 b=daHlf7g9S68KJYLV3jZWHbLKBnN0ynP7tuD7kc7C9OFD4bdi2vbGsNrT4GeCRnMvs
 KevoQ/e0kUWI8bZXtanhSo9iisB+luIJNIeYAp9jhy4Au26/bjQZLIReAdMoAtyk6f
 JK6TQzwJve7B0FLtcBxPne5BzeSWTjYWQhdMwk/k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.163.217]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwHkw-1giSH635na-018544 for
 <cocci@systeme.lip6.fr>; Sat, 27 Apr 2019 19:20:10 +0200
From: Markus Elfring <Markus.Elfring@web.de>
References: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
 <30df39b4-6f45-45c7-1c37-1f8991f3f6e2@web.de>
 <alpine.DEB.2.21.1904251039000.2550@hadrien>
 <2f138dc8-74cd-3766-cc78-c4bace8579c0@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <55731402-7a70-c579-fc33-2c5cb5be5a70@web.de>
Date: Sat, 27 Apr 2019 19:20:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2f138dc8-74cd-3766-cc78-c4bace8579c0@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:KLDF3/vjYDfvHbYwefyb1AGRvnxF0iYxfteUhdtg83TUZRJyymq
 KsOTzOVR0di2+5aytv2MVU9HQIfD06NMPToj3arY3TJ585LJ5K+ZBVqR7dpnblFMOldJawu
 C4J502vggI0x7X5FTcaIUHofvtmK3DPxwxA5jhyOG2XtecINSEIYQoxuOD26lbP7KgTPLJb
 fYxXJ9zhYWYUAbo0ECGXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FnF3UnqUDRk=:xxWwj8eSotaqbIjruYmU2F
 K2Il0lBHJYxjgeflDS38AIQFQGZnFKiXGWlOeFMTPwnCsJzppwmkTMasGmSlJ+d655VoqGLhh
 i7qJErDSd/I8iEqljkl9e1e/+Yt/h8/FN12gvt3oRaGyfjI3AKhnGMEFlGhC8czBqqlbJoO7t
 emW/VEu0CeorMBMKNenGmyRk3310pJnjbMGurb3dDPPJptNAm2fuatFMcmycQqhsIFrYQ8r+O
 X2VztFEaJOUzqyH+q9IOW6GxQkcV8VS9FBunRLxlM5KaCetCR88HTnEUV0Al13JTifcWrc+3I
 6EiMXWrCA4U+3V9udQB3whM9eDyZblZUQl8aX95kySCpqx8bKeTUYhlrFxXuoEiaxjRTHYHvp
 SZSJbRwQH47ol1Y3B1BozE2bkz32HnbjVWQACqY6bZUv8U7/Mes6yF8cdvt5vbXv6apZo4/Bg
 XKX3/xYFkRGAPTTre1ot80qAH2oFetJ/ORFkP+X6adW/rtekxl62YvyYrcSzFTNey1oR9IgYd
 Oh1B6XXefJowf0LycOV/aDdjGHqs9BixBPG9vJqDY47dWHJdkI38bIMb2lwwJ2iwORE8vhtiO
 Dt28Ll4muFMpMqJjwwFtZnIeBSG2vocXcgtCQGX90s90VbWn34YrzrSKsZru3g2tJaTEDwgL1
 qkDPMPI9Fzs6Z9Tfj7nSNs/4G6olCkPITi82G7KTaJysZjMUGDlsMCfqVUGv0vItFEFYmN836
 J3ZNCtFzfNJEn/jm1VHbG+o63mu269NieA+5ueFJ3RfXLCrU3WkyuiPbn7OOqOUpWMaMSkwmI
 bvhtFtXkMsR3kbRTtCDOxlQ05CqNjCA1qFmSqLY+vDp65xG8tt4JlGke43ph6xAKvhaaBjoE5
 KO/Uu7rLvKsTWeqVRjP06VoIRkjlf2MeMVZfXFpQlqrcna2snYNAg2FjbVRu/Ji1IXcxeKZbR
 /sTDwKDsSLw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 27 Apr 2019 19:20:14 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 27 Apr 2019 19:20:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Data exchange over network interfaces by SmPL scripts
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

PiAgIEZpbGUgIjxzdHJpbmc+IiwgbGluZSAzNSwgaW4gc3RvcmVfc3RhdGVtZW50cwo+IHNvY2tl
dC5nYWllcnJvcjogW0Vycm5vIC0yXSBOYW1lIG9yIHNlcnZpY2Ugbm90IGtub3duCj4gRXJyb3Ig
aW4gUHl0aG9uIHNjcmlwdCwgbGluZSA1NiwgZmlsZSDigKYKCkl0IHNlZW1zIHRoYXQgdGhlIGF0
dGFjaGVkIGFkanVzdGVkIGRhdGEgcHJvY2Vzc2luZyBhcHByb2FjaCBjYW4gcHJvZHVjZQphbiB1
c2FibGUgYW5hbHlzaXMgcmVzdWx0LgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVs
bGUvamFuaXRvcj4gdGltZSAvdXNyL2Jpbi9weXRob24zIGxpc3RfZHVwbGljYXRlX3N0YXRlbWVu
dF9wYWlyc19mcm9tX2lmX2JyYW5jaGVzLXNlcnZlcjQucHkKc3RhdGVtZW50MXxzdGF0ZW1lbnQy
fCJmdW5jdGlvbiBuYW1lInwic291cmNlIGZpbGUifGluY2lkZW5jZQpkcHJpbnRrICggIiVzOiBy
ZWFkcmVnIGVycm9yIChyZWcgPT0gMHglMDJ4LCByZXQgPT0gJWkpXG4iICwgX19mdW5jX18gLCBy
ZWcgLCByZXQgKSA7fHJldHVybiAtIDEgO3xzdHYwMjk3X3JlYWRyZWd8L2hvbWUvZWxmcmluZy9Q
cm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQvZHJpdmVycy9tZWRpYS9kdmItZnJvbnRlbmRzL3N0
djAyOTcuY3wzCmRwcmludGsgKCAiJXM6IHJlYWRyZWcgZXJyb3IgKHJlZyA9PSAweCUwMngsIHJl
dCA9PSAlaSlcbiIgLCBfX2Z1bmNfXyAsIHJlZzEgLCByZXQgKSA7fHJldHVybiAtIDEgO3xzdHYw
Mjk3X3JlYWRyZWdzfC9ob21lL2VsZnJpbmcvUHJvamVrdGUvTGludXgvbmV4dC1wYXRjaGVkL2Ry
aXZlcnMvbWVkaWEvZHZiLWZyb250ZW5kcy9zdHYwMjk3LmN8MwoKcmVhbAkwbTEsMDQ0cwp1c2Vy
CTBtMCwzODlzCnN5cwkwbTAsMDU1cwoKClVuZm9ydHVuYXRlbHksIEkgb2JzZXJ2ZWQgZHVyaW5n
IGEgZmV3IHJ1bnMgb24gbXkgdGVzdCBzeXN0ZW0KdGhhdCB0aGUgZGlzcGxheWVkIHJlY29yZCBz
ZXRzIGNhbiB2YXJ5LiBUaHVzIEkgZ3Vlc3MgdGhhdCB0aGlzIGFwcHJvYWNoCih3aGljaCB3b3Jr
cyB0b2dldGhlciB3aXRoIFB5dGhvbiBtdWx0aS10aHJlYWRpbmcgZnVuY3Rpb25hbGl0eSkgd2ls
bCBuZWVkCmZ1cnRoZXIgc29mdHdhcmUgYWRqdXN0bWVudHMuCldvdWxkIHlvdSBsaWtlIHRvIGFk
ZCBhbnkgYWR2aWNlcyBoZXJlPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0
ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2Nj
aQo=
