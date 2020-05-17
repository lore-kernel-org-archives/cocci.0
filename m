Return-Path: <SRS0=PP4e=67=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FCDC433DF
	for <cocci@archiver.kernel.org>; Sun, 17 May 2020 09:22:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B216206D5
	for <cocci@archiver.kernel.org>; Sun, 17 May 2020 09:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="g/KqBx6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B216206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04H9MNXA010584;
	Sun, 17 May 2020 11:22:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 03B337740;
	Sun, 17 May 2020 11:22:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 72E713DC8
 for <cocci@systeme.lip6.fr>; Sun, 17 May 2020 11:22:21 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04H9MKER007265
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 17 May 2020 11:22:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589707340;
 bh=EIiuqteoxVoOV3EryqWuRmSDX2/G7wE4ViUXplp9CFE=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=g/KqBx6Qh0/CniauQtK5/obV3g1CghFeGvlhniKPFfKkwS//zegIUmdLBf4vVfSwk
 1aHVx+/QlecyGcV9zE1mHxX08YJEkUjB+Gn94N1E/4E7nPCkpUi/Nz8w3Gzg6r2S5j
 WzApIw7MYOADQqOHmrnfKw6bxe6cf4LpdHJ0+8CI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.172.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MW9rM-1jYj3e05gw-00XYl3; Sun, 17
 May 2020 11:22:20 +0200
To: Thomas Adam <thomas@xteddy.org>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <24b3f013-21e4-99e8-5366-cfc944077cc2@web.de>
Date: Sun, 17 May 2020 11:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:tpkTs6SfM4tL8V2vVAxiTcuYkU0/QYck524KvxYB7WfvKX0BfWC
 QS2WyyZLlwtgXWQ0mfJzr8ioAq0e10FLxCc05JnmnQzf5jw1M1jPZhebzr5AYWlbS+ZIPCG
 NQpB7hbfqEk8KLdXK0uFXciG2Fk37XL5A1LLLE00cvbfJUogjjXf9D9s6Q4Qf9Y/Lxm/tVy
 4V2QLWw0GBnA8aKR1pubA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y8lvv5ZscJM=:a1vIzMAOmJeBVvQiX2XOjJ
 cohzeoEpgICx8o7cOeQc/gRaxT+vW0gSfWmUXNu4bR1RTohWsh+vEJj3p3POVYdDOOBIalc0A
 m7I5moei4YkNz6kxk088YIF9I0QIbgKunb7M0KHUwY+R7C1kA2iFJJ82eY3GfrR26g8i0S/hi
 BA1D9pmHdPPs6xcJ14yiN7XzsxvBXfvGSix7xqedTQYB665P8IViZnDzPPHXKTF2d0nWlsWHm
 Gc+EgSXYWyxy5CjXTNdJMeXH3Rz8oFOEq3TIarG8gllp/HijZg0bUpWrM4bsBE8SkHA9NE914
 INuP4V03pp7Y5ampeqpTRE6i0pWZeLCU/bvd6nPGDI6ExwKDhiSkilEqrXh93EaWh/hpbI9JC
 JY+pYxlSD6JFVH94oQVOc30pA5QRul/tCBMxi/bC4Bnpiug4L6vlzo7wOOgH2wRy+wAGbZavq
 lEBd2enHesNSiO1oGK6fk34kV1o6Xe7TPr1seHVQo+iT9c4XKvJ7VIedNdsKtce1lcZpJ+OdC
 wUmTzmVaU3ybXUletHFnu5rE0efgmu4xufs+IhgtTu2xkOEDo56uk0RpJbMYFPZ+vRGA+5+Ax
 ciyagGhJH4UrqC7f43a+yETB+O7t3Wxp51jNA+G86LcMOn3Mi2bmV87LPGeR5Pq26ScHTbr1C
 uWhpVTL8nEEGASP+LJraaAeCWUp93TSqTaZrmwtYwFjZDifKq/n+plCZXrv+dqqXhimSsWClI
 6z0ggQJ++APhyUQyBmGY2oZIZR/rR0Tg8KlzEEorSS/AEKyDdKp79o8H/TBK5iMg79SnaDjc4
 E/5tLa+4tc/XdochqGye3vNSUZxeYvMSKibgL5mCU4hfdzyKC862AW1Ge0nDIGeWQkYRuLw2/
 3RQFXzcOWJIJyiRkZVhM6umT71juwk+QiurjmdvY6uUHkZ/TwAb/fKRanmIUtTH6mIV3OvhYj
 JnOtbvwBN9SN7KHgyC5hoaeqSwJhEbS8FT/B5n+fhoqwRs5BHzUeg6y+J0rs+IIAZ6p9xe3Kp
 e+ETwB6Bdo1nT+r5jly2TIPN1u3dAMmx1z5VufytdWDb6PnJ78MML3L+gLn8xxZgMBCW55np9
 JSqMpfkPE93yjOa/1aZKEl2yGXY1D+bE7DvmOw/PYukwkgH9bVcIHZAo0Zsqb/0fj/pRLtFrv
 2wg7bZ1WaIZMDoopIp7V5hP4O2Fr8GjEDxe/m/Ya8E7wlcd8Fjgxjrhx8lR7kE3Ru2BAfKJ+S
 fIf7zwRJ/tPma1NJI
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 17 May 2020 11:22:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 17 May 2020 11:22:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Using SmPL scripts to mangle function arguments
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

PiBIZW5jZSwgZnVuY19uZXcoKSByZWR1Y2VzIHRoZSBudW1iZXIgb2YgYXJndW1lbnRzIHRvIGp1
c3Qgb25lCj4gLS0gYSBmb3JtYXQgc3RyaW5nLCBhbmQgdmFyaWFkaWMgYXJndW1lbnRzLgoKKiBE
b2VzIHRoaXMgd29yZGluZyBjb250YWluIGEgY29udHJhZGljdGlvbj8KCiogV291bGQgeW91IGxp
a2UgdG8gZmlkZGxlIHdpdGggYW55IG1vcmUgdmFyaWFkaWMgZnVuY3Rpb25zPwoKCj4gTXkgcXVl
c3Rpb24gaXMgaG93IHdvdWxkIEkgZ28gYWJvdXQgdHJ5aW5nIHRvIGdldCBjb2NjaW5lbGxlIHRv
IGhlbHAgbWUKPiB0cmFuc2xhdGUgdGhpcz8gIElzIHRoaXMgZXZlbiBwb3NzaWJsZT8KCkdlbmVy
YWxseSwgeWVzLgoKQSBtb3JlIGNvbXBsZXRlIHNvdXJjZSBjb2RlIHRyYW5zZm9ybWF0aW9uIGFw
cHJvYWNoIGNhbiBiZWNvbWUgY2hhbGxlbmdpbmcuCgoKPiBAQAo+IGV4cHJlc3Npb24gTzEsIE8y
LCBPMwo+IEBACj4KPiAtIGZ1bmNfb2xkKE8xLCBPMiwgTzMsIC4uLik7CgpDYW4gaXQgYmUgdGhh
dCB0aGUgaXRlbSDigJxjaGFyc3RyaW5n4oCdIHdvdWxkIGNvbnRhaW4gbXVsdGlwbGUgZXhwcmVz
c2lvbnM/CgpJZiB5b3Ugd291bGQgbGlrZSB0byByZXVzZSB0aGUgbGFzdCBmdW5jdGlvbiBwYXJh
bWV0ZXJzLAp0aGUgcGFzc2VkIGNvZGUgc2hvdWxkIGJlIHN0b3JlZCBpbnRvIGNvcnJlc3BvbmRp
bmcgbWV0YXZhcmlhYmxlcwpvZiBhIHR5cGUgbGlrZSDigJxjb25zdGFudOKAnSBvciDigJxleHBy
ZXNzaW9uIGxpc3TigJ0uCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUv
YmxvYi83Y2YyYzIzZTY0MDY2ZDUyNDlhNjRhMzE2Y2M1MzQ3ODMxZjdhNjNmL2RvY3MvbWFudWFs
L2NvY2NpX3N5bnRheC50ZXgjTDE5OQoKCj4gKyBmdW5jX25ldygiJXM6IC4uLiIsIF9fZnVuY19f
LCBPMyk7Cj4KPiBJIHN1c3BlY3QgSSBtaWdodCBiZSBzdHJldGNoaW5nIGNvY2NpbmVsbGUncyBh
YmlsaXRpZXMgaW4gdHJ5aW5nIHRvIGNyYWZ0Cj4gbmV3IHBhcmFtZXRlcnMsIGJ1dCBJIHRob3Vn
aHQgSSdkIGFzay4KCkkgaW1hZ2luZSB0aGF0IHRoZSBjbGFyaWZpY2F0aW9uIG9mIGNvcnJlc3Bv
bmRpbmcgYXBwbGljYXRpb24gZGV0YWlscwpjYW4gYmVjb21lIG1vcmUgaW50ZXJlc3RpbmcuCgpS
ZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
