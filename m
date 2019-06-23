Return-Path: <SRS0=b71c=UW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2F0C43613
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 07:49:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C4420840
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 07:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="h5fWX5J8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C4420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5N7nJ6f008953;
	Sun, 23 Jun 2019 09:49:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C5890776C;
	Sun, 23 Jun 2019 09:49:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AEB857761
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 09:49:18 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5N7nGo1010469;
 Sun, 23 Jun 2019 09:49:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561276156;
 bh=wfSOE0BPLH5c85FY4Cxf8W7bt2qQ4uRJEG5jwCNUvjQ=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=h5fWX5J8zMb4nsHI/6HbkTMss4yVzv80tCb9nKsmmKWy7e8g0LID/t3OXMZ3qvVRD
 h2xlU8r7OfQfxoo/Ty1a0tQRcaA0QRzAMEKnnVAP0kcAkKfIJmYwbRGfpseBm0UWJU
 2vtQ8m/26YSmKXOQbZz9Pt7HkMKzIIvAPgvh5ihM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.32.213]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mbhen-1hvFBG3i6v-00J2rQ; Sun, 23
 Jun 2019 09:49:15 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <f1bb347b-7318-f69f-ad86-bd633c72b375@web.de>
 <alpine.DEB.2.21.1906212251430.2538@hadrien>
 <9d2ef926-62b9-d182-d6d6-cd82ca13173f@web.de>
 <alpine.DEB.2.21.1906221517080.3253@hadrien>
 <4dfb9359-ab09-d206-3110-0fd177ba34b3@web.de>
 <alpine.DEB.2.21.1906221555220.3253@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <574e4f63-4991-b74a-562b-ff3293d56dd2@web.de>
Date: Sun, 23 Jun 2019 09:48:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906221555220.3253@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:qJtHKQ3Nn/tsF+lp1hZMrjY+cPG9APmMoL5rUKxaF6StnaJA8lh
 Kcv7zwv/9xbM4/nTO1NufKRiAV8kOMlYZp4+e6qQDnd7n1Dj/De8lHv4qQvzIfjgMKRch+w
 E6Y5+0u3/rM4LyDk/kEDCfUSXjjRKnIx50UiOcLV4n3PCsqqCsesF49zic4fFNiT9704oqK
 N26Q4u85ltFtYWIdLu3og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yO+QLN/v/PM=:Y6vhVaUf9e3l33gWs+XVAo
 HwOji2TGdUZHGUMMAA4VNkAiDf+vAzE4XoGDBdKFzdnZ8zx87ncqGa+gNt4A9nnyOgqfSUo33
 ulNRyUffUncPoEp6aipvuXr5LDb35hefJVaGx7PCZ4umH7H8rbr2pHZ3GhL5h6yM7UXS9n4Yj
 7bt1MuIHH0DrZYxQDEx4QW59rbz6N2M8W5NLpMiwk58sPRGT7F4RHzq8KkpCQG2z/6vc3nd4/
 qgJ5P+fCINcs8fqJ1gU+wpliLwsDc0IM0O0e7XXk4JtVZJNZk/44bgvxkpZ/oy/BKlndGzrGx
 UmMJVzTTNgDANdthuTlymxVdn9IWF7CoQnhHqtmi5WALn5gH86qdSgmb8AkiMTP16g/ibxW0L
 e2OiE/1booMPbSoXw72CbX5zPYQbs5iQFe5mjAf0O0eYtSl7KSWWcebsvw+G3FjJCE7jI+XP+
 BdM/oYqWQocP/Z1FeBMDHQ4EpZYLxeg5EpWTizfFmeO/OP+dd8wPWxgdEjjzG7WscmrUMU92i
 HN9XXoyGyAjd285aqH/gKS8CGaewRcyXgBavs3sDAfBevk+80hUWiPHTgraRthbctK2Nd0Eep
 NnSF2nTUt9bzPzxtWRCNWO6gRRX4kJ+HZ+EVyhuI706pqxMFXiwahlPKogPK51lev/wkfYT2i
 oQ2ZP5bjN1QeUqx9b2mFgx0Dyt55EE6LFGDrxnalzqgN7E/liJLgNQiKUocEWrIZKXDqB6IyZ
 nB9dQVtQvBtNa7hPjB0g3392uTe6lnr9Rw1stlhFUDiswPNzqXyGjOyzt4g0rIfmTy5Xqd6Aw
 r9z4NICY0T17eVgm+/JY8O5HgaR/3NZXveReFwq2BGJJZGqSIOdtopVOf9vwEJuIH8fUCwea5
 gQGe71YTN5Nh3AWaL6CkE89sS/YwQjKaa7EAgn4poYfvZtVUAMAY3f9irb1PbvreNd6pXDMoL
 ZGYCgkec2gBAQXp9InkFk5K5R3cIkK9a+x2WX/kxckfqw9+MdxEut
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 09:49:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 09:49:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking redundant variable initialisations with SmPL?
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

Pj4+IEl0IGNvdWxkIGJlIGhlbHBmdWwgdG8gcmVwbGFjZSB0aGUgbGFzdCBsaW5lIGJ5Ogo+Pj4K
Pj4+ICgKPj4+ICAgZTMgPSA8Ky4uLnZhci4uLis+Cj4+Cj4+IENhbiB0aGlzIFNtUEwgc3BlY2lm
aWNhdGlvbiBtYWtlIHNlbnNlIGFzIGFub3RoZXIgd2hlbiBjb25zdHJhaW50Pwo+Cj4gTm8uCgpJ
IGltYWdpbmUgdGhhdCBhIGZldyBleHRlbnNpb25zIGxpa2UgdGhlIGZvbGxvd2luZyBjYW4gYmVj
b21lIHNhZmVyLgoKICAgICB3aGVuICE9IGRvIGRzIHdoaWxlKCBcKCB2YXIgYm8gZTMgXHwgdmFy
IFwpICk7CiAgICAgd2hlbiAhPSBzd2l0Y2godmFyKSB7IC4uLiBkZWZhdWx0OiAuLi4gfQoKClVu
Zm9ydHVuYXRlbHksIHRoZSBzb2Z0d2FyZSBjb21iaW5hdGlvbiDigJxDb2NjaW5lbGxlIDEuMC43
LTAwMjExLWdlYWExM2Q1OSAoT0NhbWwgNC4wNy4xKeKAnQpkb2VzIG5vdCBsaWtlIHN1Y2ggYW4g
YXBwcm9hY2ggYXQgdGhlIG1vbWVudC4KCuKApgptaW51czogcGFyc2UgZXJyb3I6CiAgRmlsZSAi
L2hvbWUvZWxmcmluZy9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0b3Ivc2hvd19xdWVzdGlvbmFi
bGVfdmFyaWFibGVfaW5pdGlhbGlzYXRpb24zLmNvY2NpIiwgbGluZSAxMiwgY29sdW1uIDI3LCBj
aGFycG9zID0gMjk1CiAgYXJvdW5kID0gJy4uLicsCuKApgoKCklmIEkgdHJ5IHRoZSBzcGVjaWZp
Y2F0aW9uIOKAnHdoZW4gIT0gc3dpdGNoKHZhcikgeyBkZWZhdWx0OiAuLi4gfeKAnSBvdXQsCnRo
ZSBpbmZvcm1hdGlvbiDigJxub3Qgc3VwcG9ydGVk4oCdIGlzIHByb3ZpZGVkLgoKCj4gV2hlbiBp
cyBhYm91dCB0aGUgY29kZSBiZXR3ZWVuIHRoZSBjb2RlIHRoYXQgbWF0Y2hlcyB3aGF0IGlzIGJl
Zm9yZQo+IG9yIGFmdGVyLiAgSWYgeW91IHB1dCB3aGVuLCB5b3Ugd2lsbCBnZXQgYSBmYWxzZSBw
b3NpdGl2ZXMgZm9yIHZhciA9IHZhciArIDEuCgpJdCBzZWVtcyB0aGF0IG1vcmUgYW5hbHlzaXMg
Y29uc3RyYWludHMgc2hvdWxkIGJlIHRha2VuIGludG8gYWNjb3VudCBmaW5hbGx5LgpJIGZpbmQg
YWxzbyB0aGF0IGl0IHNob3VsZCBiZSBlbnN1cmVkIHRoZW4gdGhhdCBtZXRhdmFyaWFibGVzIGxp
a2Ug4oCcZTPigJ0gYW5kIOKAnHZhcuKAnQp3aWxsIHJlZmVyIHRvIGRpZmZlcmVudCBzb3VyY2Ug
Y29kZS4KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0
dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
