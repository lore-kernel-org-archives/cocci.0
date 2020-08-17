Return-Path: <SRS0=HTnY=B3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA47C433E1
	for <cocci@archiver.kernel.org>; Mon, 17 Aug 2020 08:02:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3412D20758
	for <cocci@archiver.kernel.org>; Mon, 17 Aug 2020 08:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VQXiXfdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3412D20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07H82SKa020597;
	Mon, 17 Aug 2020 10:02:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CBAA1758C;
	Mon, 17 Aug 2020 10:02:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 59B08428B
 for <cocci@systeme.lip6.fr>; Mon, 17 Aug 2020 09:58:01 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07H7w00m018880
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 17 Aug 2020 09:58:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1597651079;
 bh=PsLGqbV/ew+YnSX3rZq7CKQm64bq61zyk6UDRcC2o2U=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=VQXiXfdTyo8tYNYodwBa+uaJ/cDukw4FJ9JHmv3sGAPF1wGRHNd4C4BAvnZtcRWLz
 WT+7PMmpQQaWKyogtU3jkoqvYMu+AXVEIcH3K1PWfQwhr4YNT6qhM/w6/Qmth4MRIq
 iSQHfxhFPzk41Uo9qC4MmDNVqOWHDIb3O9vijx7U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.169.153]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOAnY-1k4Ge32vDQ-005Z1M; Mon, 17
 Aug 2020 09:57:59 +0200
To: Julia Lawall <julia.lawall@inria.fr>, Coccinelle <cocci@systeme.lip6.fr>
References: <ed9a8046-4c21-e849-f68b-9e08991b701d@web.de>
 <8e76e81f-970b-b1f7-840d-10506dc3311a@linux.com>
 <alpine.DEB.2.22.394.2008151229540.2446@hadrien>
 <34004dc6-e7a6-7557-4c64-2ec74872baea@web.de>
 <alpine.DEB.2.22.394.2008170941280.2526@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f8103248-4cbe-4c79-cdbf-d2fd758c83a4@web.de>
Date: Mon, 17 Aug 2020 09:57:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2008170941280.2526@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:Q1h0lC0hMSj6u6ERpPKGOTvYY2fsxLetrMPYXN05s+/5Dh9lfJ4
 rpLR4VUXYxqAyNbjcNFxAamAXqCg/tkkTrgU1Eny2eGmnKdpnny8fNvlTubg6dlrv8FoiJf
 OuLypshc1uOu278qMsQoeElikfJWFI5/eMkk5tOJqAa/J73mjb9Gf7PrZ2eCjPQtwuI2FsB
 yCzCuBkwAGpYEObpsK5dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gmbFn/vhcNE=:/RXbtydPw0K7uzODq6LUma
 60Gqd1ozljUae0WM0S0lxMXpYNRkEcoM1Q0S9FD8zQ2PcifK49HSME6B+QdRNa+YyNoyVsbJD
 8gK9y2iFkfhzvUZ4tmwVy/lugU0RepLYHJ+9TmMzgezYxgTgznHp/1XtxC0KCw79lwOw5sNtW
 rsLj3bDH+v5P7I9389XrMUs0Xq6yipp+lCyyCw+mXcn9OBLv7VEjLoeFCe9d5fHkkEz8yEZQp
 sXVNmn48FSWs1v0QDh86tQ/OIWRD2x2iaH6+Qddk37m9c/NSZBnTvpZ0g7s5tMHqhQS9M1rJd
 6DT0syvITF7saUsm8JFx8eKr7ODtz0KaKZfU+qvNkoci8jSclut+KjeEqZgppP6WVY2mq5+lP
 fy47uHuh6Ttr3eoBm9s3w8f0g7VuHsGhQGM5qrwZUGF3gMWFs0FSQo6g7DsJmZhGv0hRgJsBs
 shSNIK4VpnO3NtdY21412HCiosrlMGH6yLXt6No7rDIF4vJfD9F4+wkKGWHSrkuwyZ6hpqQg8
 OR4gyBtraxbBsW1gq0yapXlID3LEpgIAmoTxplY+dBmKDW9WvyGnKcW5GOmBAfRiB9asnCkAd
 MNJqNy5txBXUqGRUuSUVNyiDDleqJl3y8mJHwoDGNX1c02LzCt0Ue8Z/AoQGBpgzTFkrGQ/gm
 FVKrPS0lwwOFxcNTAXS8vWfAU3Yh49CezLBS1tKHhZF80qKwU3RVfdGHwhZlHuN1wqUYmTQ0G
 V5XfjePas99xHbUItLu80ioNHmz+ZUwM2TFyZOuRYQi2JsnFX9+xA4ryqQhFffpqYKN5sXibE
 NscHzO2MLbuOGl6ye6rRUQxKrNSFTg4eEV68EaWrjTXo2k/BO9oFthAqXt3u74Ci3L6PyQFcx
 12AGGLX1H91zM5OKhktjHigwknGlyT4obu/eMgRaDHddvRb47iQV+hzrRBBLZnb0i75NGDPZh
 eeIH3hSFFOfLXMF2r4/Cr42l9d4+Xs6b3KxWtFxoX+NvAZzTTGdXrxyqlKf6L49fHfCVvrksr
 CFsiHEwZlg+PZNFPY80soRCa6CJHHbVGT2BwxhmWoVrN5498rhgkfP/wur+rgDwESMmNyjmr5
 oQHUHuTIRlixQ/wIIWKI86zGYs0QS+eFFM9btUNGUbYQuPVighoaxN0+5CLsW6q6duCkNJdYj
 bCMx9RXoaPEhQfYG4J1Clllmbmh8FQHucuvndkTlfJC/Kc/5tQEyBO7CrdPN5NxafJLRmV8Y+
 Gn8Dd1KxXlyQ7Fr4SZ53BvQaHYmCzJWp0N8Hhvg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 17 Aug 2020 10:02:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 17 Aug 2020 09:58:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 17 Aug 2020 10:02:27 +0200
Subject: Re: [Cocci] coccinelle: api: add sprintf() support to
	device_attr_show
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

PiBUaGUgcHJvYmxlbSBoYXMgbm90aGluZyB0byBkbyB3aXRoIGRpc2p1bmN0aW9ucy4KCkNhbiBt
aXNzaW5nIHNvdXJjZSBjb2RlIG1hdGNoZXMgdHJpZ2dlciB0aGUgY29uc2VxdWVuY2UgdGhhdCBx
dWVzdGlvbmFibGUKYnJhbmNoZXMgd291bGQgYmUgYXBwbGllZCB0aGVyZT8KCldpbGwgdGhlIGNs
YXJpZmljYXRpb24gZm9yIHRoZSBpc3N1ZSDigJxmYWlsaW5nIHRlc3RzIC0gVE9ET+KAnSBiZSBj
b250aW51ZWQ/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5m
cgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
