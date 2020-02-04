Return-Path: <SRS0=4B11=3Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA12BC3524A
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 08:19:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564262087E
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 08:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="FIhUJqwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564262087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0148JMTf013653;
	Tue, 4 Feb 2020 09:19:22 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 95A0877EC;
	Tue,  4 Feb 2020 09:19:22 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8EA8D77E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Feb 2020 09:19:21 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0148JL05025349
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 4 Feb 2020 09:19:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580804359;
 bh=1mREekBkXk1Mcl3a0AcXH1e2DkqAwWSI2gizgBHpTMg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=FIhUJqwEf5Q0T4K9eKhnfR2sAFfTAy5cVunOO4BDBbySXpspBMXWyWdMD9+ODKGlC
 ePHX9uLafWi8ZiRNiPP6LSQBL5TdIqFjaW0FQADzbgLdVKA6ALA0dPNWDXPwxQNmTp
 U2ISarupI0W6EL2rttN71ZSOF4H8LpReWQy7Qp08=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.133.16]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaZQd-1jOZD61IMR-00mLxu; Tue, 04
 Feb 2020 09:19:19 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
 <alpine.DEB.2.21.2002032151520.3356@hadrien>
 <b318a372-2f31-f57f-4684-62ac2b82bff3@web.de>
 <alpine.DEB.2.21.2002032230210.3356@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <496e8fba-5fa1-acdb-df07-10b316904613@web.de>
Date: Tue, 4 Feb 2020 09:19:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002032230210.3356@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Hg/KCS88spIXD4CVfj384F2tVg+QvwtSVyvGYqiE1NC5Btoj1/F
 2OlJ2M3Qjnph7c9AU9o9//MsaBE32Jr2Iy5d4eYJSVUgDPYd0s65cHWKJLu+gx/VdUaaDQu
 Y/TR0gnDKtQBXrdbonWEXNkS95+cbH7MMoiK8/Fzt3y3U0DZ/FFoBXwiMnBI61CLQLwTrVD
 EN8LWi1049Ib1DFwfxkXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8B2yn71xFek=:pG8Xfl8q5S2r1VVCZG5LVB
 BYU9r3BB/az9bn/Dxq1Buxl46zQslGjNAR3Dcr6CHhmKQQ79YaCucW3eTP/ult4zQ51BevshZ
 1a/Mv2a553+5aDP16CSdI5ANHUSunTq2wyT4cqS+IBe9nvMDHXZqWA77mxpuc8VY0orZ7aP6a
 J1Jh5Bf273CdtOxEZvhmMN4dvCMDwc8lKD9xeyu3P7x9XOGqj0ycmdG/vKNkpw3I2kItZpY4u
 h7mkx/SPC2teFIfLuBw3ha84TPpFuTnrALoAbsLRfO6jenxa9NdFCMnMMk87OTSs0gkIEym5m
 lEt0y61wGZRNu63zEsXp7wNnE3DrFc+oMDwiDrtGnDDn7Athlx1ppWGfctbLJrifGsA6oHtjx
 O85pkt1JcHfYrbTyC/EEOgS0yW/Ywhgvk4aM0OzFYTekDm2UoNs1iAZmBP+KANf/GHjHU+jnv
 z1q+5mvsnyUj/TgFksPT4HfEB9erIE4RkA4sZqAD/ZPAot/A9AfRzVuzshpBuXxCoI0gS/23P
 jOufAL+S5H4b5GRaBu+iN0bJC868x0sGK2KfTk/qqtXjjE7iPWeGoAhSFsr0YgV17Hbw97Lr8
 eTkj0mK4sYvzWJLQq8K8GQv67k5r7m/XdgZ7a4qbJZwx5nevdMMWAu1Ll5reGWdfN3/IHBhXF
 NALa960kgSwnL9Na8q9KKHlkWfRax3ePhiRspam4VFL5H7fzvoUhWA7Fhm600r3jXAMo0Ll4b
 hNOpeBqulqP67V2ApIr1p5iQTrhdfVWXt+qRgBBuYRhQUXZwyPjnIYQXDrrmWsgBf2oILG2Ea
 zKrCVjThMsI6puZVxhB8bfe1JRpHBcaZckjlpeD7AaYh4z/qop2c+RZ/jrkf62NRqW/nh8EVi
 RyPzliu1f3AZrxuTozcNZ15hYyPuiAsJPnYNzOOt+QhdkO0fiH8URFlzs972j0J+V3mK+KOlB
 YQhU7VraUx1GoT9zD3C9255+nmP4jxTSuScoinWsNTE9rUrbgvm8Llxszuvs1xcB1pAEDrRQF
 dnjeL8T8vpPGGlS5LG9xStMUQK+dhC7KOisROaLaJMFsYjz7ynPHkKY5XabodFBsKI3LQHqRS
 qTzZ7ygcxGGFcukjTdyTlBIYLi7H8X6Mihb1DAatetsY9FL5wdl9I3lRPlcMx4WwY/8sqylRe
 HebRTmiHqM5kaF16EAV+0KRs/din4cSpk2VGlIgrP6/+Zjg2tfemR8D+kBqmUA7rnvsuohpqV
 fH9Fux45h6Ve04uFE
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 09:19:22 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 09:19:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wellington Wallace <wellingtonwallace@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a std::string check by strcmp() with SmPL
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

PiBJZiB5b3UgYXJlIHNob3dpbmcgYSBwYXRjaCwgdGhlbiB0aGUgZmlyc3QgY29sdW1uIGlzIGVt
cHR5LAo+IGV4Y2VwdCBmb3IgdGhlIC0gYW5kICsgY2hhcmFjdGVycy4KCllvdSBhcmUgcmlnaHQu
CgpJIGFtIHNvcnJ5IGZvciBteSBtaXNpbnRlcnByZXRhdGlvbiBvZiB0aGUg4oCcaW5kZW50YXRp
b27igJ0gYXQgdGhpcyBwbGFjZS4KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lz
dGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29j
Y2kK
