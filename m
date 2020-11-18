Return-Path: <SRS0=W2IF=EY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05E7C5519F
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2020 13:12:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B912064C
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2020 13:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ghL7NRQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B912064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AIDCF60026197;
	Wed, 18 Nov 2020 14:12:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B5A187789;
	Wed, 18 Nov 2020 14:12:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 68B0F5C34
 for <cocci@systeme.lip6.fr>; Wed, 18 Nov 2020 13:51:14 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AICpAVJ017068;
 Wed, 18 Nov 2020 13:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1605703869;
 bh=kummH/HLGEYd6qqTfUQNY6hVDvlGO1e5sYH967oUJ6w=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=ghL7NRQSI7NFtykzaURCRjiulf5YI9JmDtrCCyXEOelxYRcuNK2W65pbS5uKH6rox
 WsaE5jrfce9wvBnMbM9rdmTBPEqtKaPJsXSflyiNqHJI61djlRXssJceZ14pzATd9p
 w3dL4mRTMLQYt387+takkFOnjutmvgMFQGqKPJas=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.125.234]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MI5ze-1kh15H2cV4-003yrf; Wed, 18
 Nov 2020 13:51:09 +0100
To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <20201118080242.t6u6lchj5ww2fac4@adolin>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <62af4a93-dbc3-8aa0-6924-4dc479001d34@web.de>
Date: Wed, 18 Nov 2020 13:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201118080242.t6u6lchj5ww2fac4@adolin>
Content-Language: en-GB
X-Provags-ID: V03:K1:yXNLxTLEnGieqn7e794brATK84HM8XwkanbB6/wfpAFqlQlr0Yq
 D6WUlvTdlQWNw/ejxAaiBzE65X+fupv47Bq6RC0vKtlgVx3fOmrYdsQu9n5r+vlskhxmGAf
 oa+j2TueYfohk6lV9MwqYZGn/viQk2R1IQxwEuBodEwkHoIwr/TQoJr+JJgittEa1fXhynn
 O/khvgTJXP6vaAknIgBfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aF72oodsEtI=:FRak7u0rlrZAUuGoIKRmBt
 DOTBcS8X0QHuITBDb9jA2dU43lE8iV9siKFpcyYF0PfVsmdO6J3b7L/ntePZAdfgzGXbsh5hc
 q2zreg+nQkt1im20G53DbCQ+fUOpw9c4Bzwf8tidBh+jMesEqNHAHCLJUOGKq+/vwSf+XGfcA
 cLprtih23NCRT0+Sis5iHu+kcL+qos3aCgsWzSXNom/mon7ePRHvY1/BGpkW+0EfZNFUDwr6w
 7rQUbxpqCxBS7jqWn193wVWP9nWRCdUicEj9QyT0gonMIcwlY234uWp6u5N3LnCnCvbl17IoT
 vKWuDmDe3bHHs/puNt6VfT4lMbJPAXEo3KC6iqG/bP0CNkUAiV/pahoufT9A4QncMtg+5+0JC
 YqTGuDLxxHDuntk11BzdS7KWMHw6R2F15+BTGRA22okU2OdypeecONPy3a1mMcjw5RKpPVB24
 RB7Pf9cz031aYw0eMaNxuGuOkX5yUgbM1Skt157lB4poVuLyBJjDskByv5o0NGjxqr6wETFCJ
 5Exd+XFIIsG/79enyz4GsQdDvOKKNxe8dEFbmfTi9n0yWQ1a2VgKsNKFLJTn2wAGLnuTB5kqz
 P0dYgWNtA0LPkQO6Seu7pes9HNaVZWXDHL7xI0wv7zOUtco/NZRlA1KP27ZuuqOOWCmZrrmYi
 1J3BYFbRZ+xQPOm/wMUSTioUTI9O2asKlVOHuaucL2dJeJTVSE2GzQOo++pHxFAY2MhQqtmOO
 KuJT2rwqzGZ9z/wD1EJmEk2hGEZd2d98jkSeUllYqDvhfRbiE88PfSk3M1eS+Ok6riRKD6oqT
 ALylJ2JXRi4xRcAWI/gZ+UBSM2LRKpg+rknykSBgScbTwmZD7LcaagR8dkkRZBhhVKA9o5OoA
 hv6vuq2EWWR2rsBderVQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 18 Nov 2020 14:12:16 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 18 Nov 2020 13:51:10 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 18 Nov 2020 14:12:13 +0100
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [Cocci] [PATCH v2] coccinelle: locks: Add balancedlock.cocci
	script
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

PiBDaGFuZ2VzIGluIHYyKGFzIHN1Z2dlc3RlZCBieSBNYXJrdXMpOgoKVGhhbmtzIHlvdSBwaWNr
ZWQgYSBmZXcgc3VnZ2VzdGlvbnMgdXAuCgoKSSB3b3VsZCBhcHByZWNpYXRlIGZ1cnRoZXIgY29u
c3RydWN0aXZlIGNsYXJpZmljYXRpb25zLgoKCuKApgo+ICsrKyBiL3NjcmlwdHMvY29jY2luZWxs
ZS9sb2Nrcy9iYWxhbmNlZGxvY2suY29jY2kK4oCmCj4gKy8vIyBGYWxzZSBwb3NpdGl2ZXMgbWF5
IGJlIGdlbmVyYXRlZCBkdWUgdG8gbG9ja3MgcmVsZWFzZWQgd2l0aGluIGEgbmVzdGVkCj4gKy8v
IyBmdW5jdGlvbiBjYWxsIG9yIGEgZ290byBibG9jay4KPiArLy8vCj4gKy8vIENvbmZpZGVuY2U6
IE1vZGVyYXRlCgpIb3cgZ29vZCBkb2VzIHN1Y2ggaW5mb3JtYXRpb24gZml0IHRvZ2V0aGVyPwoK
Cj4gKy8vIENvcHlyaWdodDogKEMpIDIwMjAgSnVsaWEgTGF3YWxsIElOUklBL0xJUDYKPiArLy8g
Q29weXJpZ2h0OiAoQykgMjAyMCBTdW1lcmEgUHJpeWFkYXJzaW5pCgpEb2VzIHRoaXMgaW5mb3Jt
YXRpb24gaW5kaWNhdGUgdGhhdCB0aGUgc2hvd24gc2NyaXB0IGZvciB0aGUgc2VtYW50aWMgcGF0
Y2ggbGFuZ3VhZ2UKd2FzIGEgZGV2ZWxvcG1lbnQgcmVzdWx0IGZyb20gYW5vdGhlciBjb2xsYWJv
cmF0aW9uPwoKCuKApgo+KyAoCj4gK211dGV4X2xvY2tAcChFKTsKPiArfAo+ICtyZWFkX2xvY2tA
cChFKTsKPiArfArigKYKCldoeSBkaWQgeW91IG5vdCByZW9yZGVyIHRoZSBlbGVtZW50cyBvZiBz
dWNoIGEgU21QTCBkaXNqdW5jdGlvbnMgYWNjb3JkaW5nIHRvCmFuIHVzYWdlIGluY2lkZW5jZSAo
d2hpY2ggY2FuIGJlIGRldGVybWluZWQgYnkgYW5vdGhlciBTbVBMIHNjcmlwdCBsaWtlCuKAnHJl
cG9ydF9sb2NrX2NhbGxzLmNvY2Np4oCdKT8KCgrigKYKPiArQGJhbGFuY2VkMiBkZXBlbmRzIG9u
IGNvbnRleHQgfHwgb3JnIHx8IHJlcG9ydEAKPiAraWRlbnRpZmllciBsb2NrLCB1bmxvY2sgPSB7
bXV0ZXhfdW5sb2NrLArigKYKCkFyZSB0aGVyZSBhbnkgY2hhbmNlcyB0byBhdm9pZCB0aGUgcmVw
ZXRpdGlvbiBvZiB0aGUgZnVuY3Rpb24gbmFtZSBsaXN0CmZvciB0aGlzIFNtUEwgY29uc3RyYWlu
dD8KCgrigKYKPiArbXNnID0gIlRoaXMgY29kZSBzZWdtZW50IG1pZ2h0IGhhdmUgYW4gdW5iYWxh
bmNlZCBsb2NrLiIKPiArY29jY2lsaWIub3JnLnByaW50X3RvZG8oajBbMF0sIG1zZykKClBsZWFz
ZSBwYXNzIHRoZSBzdHJpbmcgbGl0ZXJhbCBkaXJlY3RseS4KCitjb2NjaWxpYi5vcmcucHJpbnRf
dG9kbyhqMFswXSwgIlRoaXMgY29kZSBzZWdtZW50IG1pZ2h0IGhhdmUgYW4gdW5iYWxhbmNlZCBs
b2NrLiIpCgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIK
aHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
