Return-Path: <SRS0=bJuE=ZI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA2C432C3
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2019 08:30:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2F72072D
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2019 08:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="C9DeRTi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2F72072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAG8U4Hq024653;
	Sat, 16 Nov 2019 09:30:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D35EB77CA;
	Sat, 16 Nov 2019 09:30:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9ACDC77C6
 for <cocci@systeme.lip6.fr>; Sat, 16 Nov 2019 09:30:03 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAG8U2Vb004704;
 Sat, 16 Nov 2019 09:30:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573892996;
 bh=qYjTsqm/jZgnkR5Swi+zPm8c4+lS5Hzr7rnDd+DmsfA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=C9DeRTi5Wg6VjReU8sFgbTYQ5cPh8zMvMIMmxmdWIYyWchcZZGLsahK3cH5lVAnvt
 l8Sn4vC8e1Q0uIMW0+dMOOfUfske4+LcdEXwWQIgNfwRyP2qJRligBQOz7JMOxQ5Gi
 MUa4wed8Z9fmzlLDzU+x4fLCV7HW9bXYOUtFJuZ4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.152.34]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LetUp-1i5ag703mJ-00qhT1; Sat, 16
 Nov 2019 09:29:56 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
 <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
 <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
 <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
 <53346d52-e096-c651-f70a-ce6ca4d82ff9@web.de>
 <6c4ef61f-5fef-ffc8-82d6-ee42006756b4@web.de>
 <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de>
 <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
 <94301b9c-a397-ae04-c617-92679f4bb018@web.de>
 <alpine.DEB.2.21.1911152000170.8961@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <22a03cac-160b-51be-b015-54ac600d3e92@web.de>
Date: Sat, 16 Nov 2019 09:29:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911152000170.8961@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:csgwpmRM3I/du8yLGJZ6gKQfXvaDQ+9wwnHDEeOyuUvOGUd6NuF
 N/my9nNqlKN4oG8uAGtSklWS0XdMhI/pDK2tYauS9L41sx/XYcfq9/rM/nYcjPZDddytgiF
 zn4ZUkQd9+eb4O4IUkVBmEirgYEWuPcQv1dOOeabtYswGCtUM6grJpsfVUNevTeE45O+GIW
 3At2A+nX3tuh9yz+HjhGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/lCmsZuzCTA=:6+kaiS6vuC0pJc//+pomj1
 TXfBfXNlMa1Qs2rPIt4xMpZofc44cPUzKSzACEw5ypoL2bLkyQctqfsQ8RhTF4FlHuo6Pbop7
 4vh3P90s6FdShsUZ1jV67WttBHeQcCw6WsAAbB6dGhKLTcrh2YOlSXGLCNqOsQlqTJAH1NyVX
 RDOYYmU1i1C6j7tgDL4aw1DehEJxu3m+HCL2AXRCf7MDr15IEAq4JbGeo1/L08jf2kNvJS84G
 uJ9bqKZ0atD3PAKLEO0J1pZV3fPQxfiz7NBC2LWiA2I5QD64lFw1hjY1YGJjiie+umILkM1zB
 6aTOH1+B3jjsdooz9WTW8BHZtUgoNleSuGB0ZYe/CgYIXUbPq/k4SMqIDqdGTrNwnNmaJ/fDb
 X4aybele5utaztaHKRU7t/Gs9wtx+DeSQspKr2DHcYGWl2y+ETvI2UX6qc4q5zmiGp7SyeiDs
 Vbw4mtrsmL9T9U66BMS0C+1/qSFnDgC9B11/vCyasujuuvGyM16cZYRp2LDiEJCh24xwPmZeB
 rL8ICN/m28UQT7fg4uzYtt6CGqgIHkqKwnLINRqFnQfuGXAQl2k+XxAL8BGLRkR4jzes13ZIA
 x+g+j9BqwY6vHs+unllkwhBJ6RmvU/+3vFZBwOcGhAJsFeIE7ErAsKyT6hDgUQ9ZPeK5OgjaI
 n7+4teXmUIEqshltz1lTSovajdUwkuC5TnAwGwOyhDbAqQA0qR/+Ds+7P3v4f0Zhuh8hvNJ+D
 z7sr+XpzWY1irsEC7CK2eJ5Vf5QdzVjLx/0J83JUA5TxuudNmcsURtPDVrqXhdRTLU8jHNLk8
 grbwQKCGXhd5okWaUTzQE8mddz2skkudpSSnojUXv4RYvVAohYSUTTH4ZBVyeZUyaNANMDgxU
 v02Wq+b/SP3BCLUfL9zH9pChVJ34cPLDwiEPnNqYl1Kj0MzULOG2umJjwDFZDS/xMaADVVljv
 RV0PV35jQD0NF1OpYJ5tyMt3Qi9yL9b8iyw+eqZ5YruoHduzLcGKWdvN4HOdof3IBEn0AwpF9
 HhiwXiMMxdjk806C7ZSyC1A3xM7sxumYCw8kyhgyfCu8NZ3a3VuHoQfW+pK6S/lg1Ft7NN7rm
 AuDfmlrIrR3sk6iMcvJ6L5pDQO4kHcSyPeOfzPWCDgLaUyaSqy0lQRYpScuXfikleZB+m4roL
 eXdygpume8YlaO3JfViVPulk4HmXRmZ4S1DR5jIGRkTXVjCsNPsSuh9YQZtcKZQViJ2DA0Psu
 IFE71QRgDA3cu94j1SGc9JnV7T57nCbRTj7PUf5YtywOd73+Bs+xUFlfYIW0=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 Nov 2019 09:30:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 16 Nov 2019 09:30:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>, Coccinelle <cocci@systeme.lip6.fr>,
        git@vger.kernel.org
Subject: Re: [Cocci] git-coccinelle: adjustments for array.cocci?
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

PiBJdCBjYW4gZGV0ZXJtaW5lIHRoZSB0eXBlIG9mIHQtPmVudHJpZXMgaWYgaXQgaGFzIGFjY2Vz
cyB0byB0aGUgZGVmaW5pdGlvbgo+IG9mIHRoZSB0eXBlIG9mIHQuCgpJIHdvdWxkIGxpa2UgdG8g
cG9pbnQgYW5vdGhlciBpbXBsZW1lbnRhdGlvbiBkZXRhaWwgb3V0LgoKQW5vdGhlciBrbm93biBm
dW5jdGlvbiB3YXMgYWxzbyBhbiB1cGRhdGUgY2FuZGlkYXRlLgpodHRwczovL2dpdGh1Yi5jb20v
Z2l0L2dpdC9ibG9iLzlhMTE4MGZjMzA0YWQ5ODMxNjQxZTU3ODhlOWM4ZDNkZmMxMGNjZGQvcHJl
dHR5LmMjTDkwCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvZ2l0L2xva2FsPiBzcGF0Y2ggY29u
dHJpYi9jb2NjaW5lbGxlL2FycmF5LmNvY2NpIHByZXR0eS5jCuKApgpAQCAtMTA2LDggKzEwNiw4
IEBAIHN0YXRpYyB2b2lkIHNldHVwX2NvbW1pdF9mb3JtYXRzKHZvaWQpCiAgICAgICAgY29tbWl0
X2Zvcm1hdHNfbGVuID0gQVJSQVlfU0laRShidWlsdGluX2Zvcm1hdHMpOwogICAgICAgIGJ1aWx0
aW5fZm9ybWF0c19sZW4gPSBjb21taXRfZm9ybWF0c19sZW47CiAgICAgICAgQUxMT0NfR1JPVyhj
b21taXRfZm9ybWF0cywgY29tbWl0X2Zvcm1hdHNfbGVuLCBjb21taXRfZm9ybWF0c19hbGxvYyk7
Ci0gICAgICAgbWVtY3B5KGNvbW1pdF9mb3JtYXRzLCBidWlsdGluX2Zvcm1hdHMsCi0gICAgICAg
ICAgICAgIHNpemVvZigqYnVpbHRpbl9mb3JtYXRzKSpBUlJBWV9TSVpFKGJ1aWx0aW5fZm9ybWF0
cykpOworICAgICAgIENPUFlfQVJSQVkoY29tbWl0X2Zvcm1hdHMsIGJ1aWx0aW5fZm9ybWF0cywK
KyAgICAgICAgICAgICAgICAgIEFSUkFZX1NJWkUoYnVpbHRpbl9mb3JtYXRzKSk7CgogICAgICAg
IGdpdF9jb25maWcoZ2l0X3ByZXR0eV9mb3JtYXRzX2NvbmZpZywgTlVMTCk7CiB9CgoKVGhpcyBw
YXRjaCBnZW5lcmF0aW9uIGNhbiB3b3JrIGJhc2VkIG9uIHRoZSBmb2xsb3dpbmcgU21QTCBjb2Rl
IGNvbWJpbmF0aW9uLgoK4oCc4oCmCmV4cHJlc3Npb24gbiwgeDsK4oCmCi0gICAgICAsIChuKSAq
IFwoIHNpemVvZihUKSBcfCBzaXplb2YoKih4KSkgXCkK4oCm4oCdCgpUaGUgYXN0ZXJpc2sgc2hv
dWxkIHJlZmVyIHRvIGEgcG9pbnRlciBleHByZXNzaW9uIHdpdGhpbiBhIHNpemVvZiBvcGVyYXRv
ci4KSSBnb3QgaW5mb3JtZWQgdGhhdCB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2Ugd291bGQg
c3VwcG9ydCBzdWNoIGEgcmVzdHJpY3Rpb24uCgpUaHVzIEkgaGF2ZSB0cmllZCBvdXQgdG8gc3Bl
Y2lmeSB0aGUgY29ycmVzcG9uZGluZyBtZXRhdmFyaWFibGVzIGluIHRoaXMgd2F5LgoK4oCc4oCm
CmV4cHJlc3Npb24gbjsKZXhwcmVzc2lvbiogeDsK4oCm4oCdCgpCdXQgdGhlIHNob3duIGRpZmYg
aHVuayBpcyBub3QgcmVnZW5lcmF0ZWQgYnkgdGhpcyBTbVBMIHNjcmlwdCB2YXJpYW50LgpIb3cg
c2hvdWxkIGFuIGFycmF5IGxpa2Ug4oCcYnVpbHRpbl9mb3JtYXRz4oCdICh3aGljaCBpcyBldmVu
IGRlZmluZWQgaW4gdGhlIHNhbWUgZnVuY3Rpb24pCmJlIHRyZWF0ZWQgYnkgdGhlIENvY2NpbmVs
bGUgc29mdHdhcmUgaW4gc3VjaCB1c2UgY2FzZXM/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0
CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xp
c3RpbmZvL2NvY2NpCg==
