Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946A9C433E0
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 18:32:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3463206D5
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 18:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cuS5Uer4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3463206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058IWFIa002546;
	Mon, 8 Jun 2020 20:32:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B3E9C7783;
	Mon,  8 Jun 2020 20:32:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2C2E044A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 20:32:14 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058IWDC7005027
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 8 Jun 2020 20:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591641129;
 bh=IBDqx493tt1wkXPpzA/7XTXyPaT674q56+B8I9R8/Mc=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=cuS5Uer4odfzpa9bmbQtXv5wZ0gEHR4K/J4HmJ+9DFSKTILGPpjWZ+lIIZze/kz19
 iLratHInx5wnGFThue81BGIC5EL/fI+M6IJnyl8hh473wm/ZtF6jiO2q0vfRaxpki3
 PIxN+clmW0rdLr8elQwezyqinTKMhxks8d0D8Tfc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LnSGg-1j0nod1O9O-00hdVB; Mon, 08
 Jun 2020 20:32:09 +0200
To: Denis Efremov <efremov@linux.com>, Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6c9c6a4c-c305-ddab-8a1b-e4dc448d643f@web.de>
Date: Mon, 8 Jun 2020 20:32:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:iLwj2vJ0brvPvZKas/bjtr4Ytr7QXduKpi1DO9Ef38xrMnv2qkl
 Oclt+grMGWcZC+wYpEqApO6uJ3a3gpavFR0PkZxMsPxgLR++MUrpz+484gwhwAtDN9W2Jhq
 2Vb26ufFZ8y0KGXfFTe5baW4KQeTBoqBMiyX2p2VFtf2EV0oZLB4ymAzXLa++m1/8UIHiCK
 0ukmNHy+Qao51iivo2A1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VwCSdTMk4/c=:9UKXcnQ3ZtQlFAIgWoIzPi
 fsCnHyP+zCJMvr68eP93e48dM//1a0qPSTE1q0KrUtM5vicxZVKJ8mlsMhXC33I6XOuZJNFTK
 feYUoWGc/dmQc0KtM7Pde/EzC1P2q9HfV/zUlB1fXdwhBkKRR02qxzEAWIcQf7DkgaM6/fzAf
 uxKyKraTQ4mYdVb4wvg6a3lgLqLX8Fi1WkfJz49xfVjfx4cEjKAqWWfEB04wRGemR7jABmKbh
 UxQN3PdRD42Tv78AhlLgPftA7gXotTyXLpJ1XBFZLjuuRAK+l8S8XbTEko776WZ4mrizwbzAe
 UtZxpNt2J+LrwlkFSmhmPunZZFlp45D/USUi9XDZ21LtTs2L54tpvdZ4+jMjpQ9bEi52J94G1
 FQOwRZXhZEic0v3RpxHs9974Nw2lc8WQP/vRfuzvxB3kFhuu7ek45Yy06O4RDpRYUsciasGhZ
 CLkcZtduTcww+GvF6GgsUFfEymzmKOqmhwOP2HhBTb1SlYoLpaYeGQJKpB/i8aqpBlji0wDmh
 M6R8Whe8FffluD9cCM2eFULGhAq4l1N/PCzrlhoEOxk3ve4ePgOXVUA9q2zZ+G2VyEn9Qy5SS
 eDzdZM9bhpP8rGbFr0HStQAO3USrXvkFn3MDzZkEbRfxr47mqvgljtGnQYZJoG72ozD+04JB4
 ZB0ShNssYhYTB7InvxVQZxeYCcI0l2ld72h0CZ7CQsFukGNG/W3gMMJGylfn5s7EiBDc87uJU
 KcuHu64+7JnzhOGTlF/t8PGHh7hL3DPuOVSb4/sdbbC/tKfDGPokjaKgygCRg5EATB9NNpkYI
 MANKB9jbQeOS45Ij6ZtYbu3c0alxhZM21Aw3jQF7LEe2tgJvAA6zkGvfNKketFL6+JxyFjzB3
 oMRN33Hou0B+0BAysDsSeiPoKjVwIPCQ4s5IeuL2qGa8R9gBVcN+eTMfDqZ8evUcxlRYl3OZR
 6Fh1T77dnc9XchVL67GJnPlOcpibTC1jXuU02UTASRD17jFrxTJmTfKa2BjR58Tn2rULOvksS
 5AnvxKET3VsaVR7OkgBVyXn5a5MJNCj/niuZlLaqJhQQRSOmXaLWDvk87sWJEyIs1yLK/QS0e
 Y139L5G7BIhWs8ZzBFkoeeB4PvxgPTinRuDknVYaggp0ytMFDNBZvGdExMKTARJIhu5YDIGDc
 Vh+Lp3Zmfnlo7f2PGlcDr42cwgAhPXCDKX6Jw0MXOkxcFvx/Boh6HttsVHtkEwHJIOAgEKQsb
 MvBIkkk7t2/gCXfXk
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 20:32:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 20:32:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2 2/4] coccinelle: api: extend memdup_user rule
 with vmemdup_user()
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

4oCmCisrKyBiL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvbWVtZHVwX3VzZXIuY29jY2kKQEAgLTM5
LDYgKzM5LDI4IEBAIOKApgrigKYKPiArQGRlcGVuZHMgb24gcGF0Y2hACj4gK2V4cHJlc3Npb24g
ZnJvbSx0byxzaXplOwo+ICtpZGVudGlmaWVyIGwxLGwyOwo+ICtAQAo+ICsKPiArLSAgdG8gPSBc
KGt2bWFsbG9jXHxrdnphbGxvY1wpKHNpemUsXChHRlBfS0VSTkVMXHxHRlBfVVNFUlwpKTsKPiAr
KyAgdG8gPSB2bWVtZHVwX3VzZXIoZnJvbSxzaXplKTsKCkkgc3VnZ2VzdCB0byBjb21iaW5lIHRo
ZSBkZXNpcmVkIGFkanVzdG1lbnQgd2l0aCB0aGUgcHJldmlvdXMgU21QTCBydWxlCmJ5IHVzaW5n
IGFub3RoZXIgZGlzanVuY3Rpb24uCgoKPiArQHJ2IGRlcGVuZHMgb24gIXBhdGNoQAo+ICtleHBy
ZXNzaW9uIGZyb20sdG8sc2l6ZTsKPiArcG9zaXRpb24gcDsKPiArc3RhdGVtZW50IFMxLFMyOwo+
ICtAQAo+ICsKPiArKiAgdG8gPSBcKGt2bWFsbG9jQHBcfGt2emFsbG9jQHBcKShzaXplLFwoR0ZQ
X0tFUk5FTFx8R0ZQX1VTRVJcKSk7Cj4gKyAgIGlmICh0bz09TlVMTCB8fCAuLi4pIFMxCj4gKyAg
IGlmIChjb3B5X2Zyb21fdXNlcih0bywgZnJvbSwgc2l6ZSkgIT0gMCkKPiArICAgUzIKCkhvdyBk
b2VzIHRoZSBTbVBMIGFzdGVyaXNrIGZ1bmN0aW9uYWxpdHkgZml0IHRvIHRoZSBvcGVyYXRpb24K
bW9kZXMg4oCcb3Jn4oCdIGFuZCDigJxyZXBvcnTigJ0/CgpSZWdhcmRzLApNYXJrdXMKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBs
aXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFu
L2xpc3RpbmZvL2NvY2NpCg==
