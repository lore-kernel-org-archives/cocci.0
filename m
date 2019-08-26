Return-Path: <SRS0=MHZk=WW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5973DC3A59F
	for <cocci@archiver.kernel.org>; Mon, 26 Aug 2019 17:26:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B7D20874
	for <cocci@archiver.kernel.org>; Mon, 26 Aug 2019 17:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="p/NwXHV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B7D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7QHQiiU003269;
	Mon, 26 Aug 2019 19:26:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2D83A7788;
	Mon, 26 Aug 2019 19:26:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5F50674B3
 for <cocci@systeme.lip6.fr>; Mon, 26 Aug 2019 19:26:42 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7QHQejE005262;
 Mon, 26 Aug 2019 19:26:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1566840399;
 bh=n57XebSm9/MGU1Uz0mDj/rJFImdyoY6Nq9LBBViFFt4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=p/NwXHV3PwtM6xcEh6f67igQ7aOIPYA5QUW7MevxYxp5/bONxHh2P3bYmObZLrW6u
 gG/+jk9nFr92oPNuBbzZU4Vbn4NSqmoP8h+n0ec/A2yKXuVqAwdBDomPL4k5MbI8oK
 ovisKCkjP/dqvc+95XEb+QcwHNqr5SjdDk12NE2o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.136.115]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7scS-1iOUPu3ePw-00vQBM; Mon, 26
 Aug 2019 19:26:38 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <a7f12c28-0f96-d388-f1f4-57db4d3d880d@web.de>
 <2AE15A09-F219-43DC-81A9-73C13CFC0753@lip6.fr>
 <661aa3dc-3514-3d75-eb3a-9e46843fd02d@web.de>
 <alpine.DEB.2.21.1908251547420.2283@hadrien>
 <c6f15b8d-561e-fda4-1531-191334f1142c@web.de>
 <alpine.DEB.2.21.1908251741460.2366@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <17be79c5-00b6-33b0-730b-6b4b1d21f03b@web.de>
Date: Mon, 26 Aug 2019 19:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908251741460.2366@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:qFACfq/t/JQSF2wcinQA1CZtcVt1lSvx3Ll6hAYxS12S82Gu9F2
 1K7K14c5uwtagCmV/LkAbFkkfdAlgHMuTuYzNt7YGiP4ZAhwb89VYa4zvEnx2sKGeXlGzgb
 Gjp3UV+JwuY1EsT5nfs9DQbUCohMiJdtolFcolD0GoPUf0Dtse4N6r1x0DYch8Co9SKMN9T
 vg+imojxvAPoVMq2RTLNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ISAD3KGAo+w=:dzms34Yi2ref+J1grZ0Fxj
 tSxnZxgxWHjSO73usBwgMOEaYisWZaxVVDHU9XKn8bh2pJHB3uEMNBAY/Dboy6pc17qgfZNiN
 0dn2pu/EUcHFH0AASAjdOotkp8FzprLka6NFrfDY0bv2Ft0K/rJYGlvYJFfu4kKQlwnZPYqPl
 p/7zfPV1wu71gYmwK3M744Vnosr7BvkJa5MBs5FIFJAnDmniKvDc5hgLGRlUXLkJ2JDpVWi+B
 LQarwcuSo4zsEmXvIfsbuwpWFNyCELjQe1Zc3xrrDB5TM4o6PnoLOZVXNK1KKuthAVYgnLnnt
 I4ZlbE1P6E5wNRVvxNZwo39Ixr3TVW0KCst5USN15FFid3rPFkLwlJaEAUCydCkILoWGmPdgg
 /HBdnUHUtgce5qGlTZ6euxvJ51aTK86AaMQzr9T5MHO/HJIKmE/gO+1DGx+iyXDnr0uSD02jM
 hPrmkalAqHOA999XLHRhZR8ci7Bar25D3czsEs59e1H/M12CuPTbIA+WmhkHersAOnuUUEvZ2
 eKECzcJbOx1CiZCgpMhTgFYbC993Il2QvgecCLXVSwti26KR1TGX+ZK9o4k21c/zoMJ4jS/PU
 +n1UAXa1B/s98InMsgwSEKpgmbhuQX6Hs6gpUnXhqcel4YW1Gx7GIgg/S0PkxAVSqEJjXUbIl
 yr2CtLx6irUUdVXBLHBMhWjUgSrG5KFJB7Wzkei8rDDUFFiIqEOE98W/A7ZXu6xb52eB3DZ58
 M2alFqfKUSwdRTYk4yvR4cfDcFWLfPugcp3YExnLaO3x2yRSzY/gV9CbVT6qv663C3bcfkEiv
 CpDPAHBaO4fd1ufRj+F//Jurd8UKot80cioH7AHq+w62cpTiVfh3GxJqxz5GsQxT5fxoU42T0
 PmWvj0CFZbUEsvF/8WzJZna1+CEGhNbZ5B37oSNfqckost4TZoGxuWnWSEbNi1t79/vPu9UE2
 hHkpqT4B+OhQMgbStZiVoV9ZzuFa4NCOdoDbr81FfzW8QTm75gScS7FgRMYk5py28LMWTF84c
 NO0tf9W/mopKOLAQp98h8RrkPEb+u06PxktuSWZ4SdLV10EnKZFoKpoV+k1mXnE6LKYY/n8rJ
 n4lpeL0B74pNQp0PAWd8pjdshXwFMvqdw0+pIhURgBmMFT0uI4/jxF4mYdMDm+eJOtlU0eR19
 sX5O8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 26 Aug 2019 19:26:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 26 Aug 2019 19:26:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking null pointer handling with SmPL
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

PiBJIGRvbid0IGtub3cgd2hhdCB5b3UgYXJlIHRyeWluZyB0byBkby4KCkkgYW0gdHJ5aW5nIGFu
b3RoZXIgc29mdHdhcmUgYW5hbHlzaXMgYXBwcm9hY2ggb3V0IGZvciB0aGUgcHJlc2VudGF0aW9u
Cm9mIG51bGwgcG9pbnRlciB1c2FnZS4KCkppYS1KdSBCYWkgY29udHJpYnV0ZWQgcGF0Y2hlcyBi
YXNlZCBvbiBhbmFseXNpcyByZXN1bHRzIGZyb20KdGhlIHRvb2wg4oCcU1RDaGVja+KAnSBieSB0
aGUgT1NMQUIgZ3JvdXAgb2YgdGhlIFRzaW5naHVhIFVuaXZlcnNpdHkuClNvbWUgY29ycmVzcG9u
ZGluZyBpbXByb3ZlbWVudHMgYXJlIGluIHRoZSByZXZpZXcgcXVldWUuCgpBIHNwZWNpZmljIHNj
cmlwdCBpcyBhdmFpbGFibGUgYWxzbyBmb3IgdGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlLgpo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9s
aW51eC5naXQvdHJlZS9zY3JpcHRzL2NvY2NpbmVsbGUvbnVsbC9kZXJlZl9udWxsLmNvY2NpP2lk
PWE1NWFhODlhYWI5MGZhZTdjODE1YjA1NTFiMDdiZTM3ZGIzNTlkNzYKCkNhbiB0aGlzIFNtUEwg
c2NyaXB0IGJlY29tZSBhYmxlIHRvIHBvaW50IHJlbWFpbmluZyB1cGRhdGUgY2FuZGlkYXRlcyBv
dXQKaW4gc2ltaWxhciB3YXlzPwoKRXhhbXBsZXMgZm9yIGZ1cnRoZXIgY29uc2lkZXJhdGlvbnM6
CiogZnM6IHhmczogRml4IHBvc3NpYmxlIG51bGwtcG9pbnRlciBkZXJlZmVyZW5jZXMgaW4geGNo
a19kYV9idHJlZV9ibG9ja19jaGVja19zaWJsaW5nKCkKICBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0L2ZzL3hm
cy9zY3J1Yi9kYWJ0cmVlLmM/aWQ9YWZhMWQ5NmQxNDMwYzIxMzhjNTQ1ZmI3NmU2ZGNiMjEyMjIw
OThkNAogIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxOTA3MjkwMzI0MDEuMjgwODEt
MS1iYWlqaWFqdTE5OTBAZ21haWwuY29tLwogIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNo
d29yay9wYXRjaC8xMTA2NjI4LwogIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzcvMjgvMzQ0
CgoqIHNjc2k6IGxpYmlzY3NpOiBGaXggcG9zc2libGUgbnVsbC1wb2ludGVyIGRlcmVmZXJlbmNl
cyBpbiBpc2NzaV9jb25uX2dldF9hZGRyX3BhcmFtKCkKICBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJz
L3Njc2kvbGliaXNjc2kuYz9pZD1hNTVhYTg5YWFiOTBmYWU3YzgxNWIwNTUxYjA3YmUzN2RiMzU5
ZDc2I24zNDU1CiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MDcyOTA5MTMzOS4z
MDgxNS0xLWJhaWppYWp1MTk5MEBnbWFpbC5jb20vCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cGF0Y2h3b3JrL3BhdGNoLzExMDY3MjUvCiAgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvNy8y
OS8yMjgKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0
dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
