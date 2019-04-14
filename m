Return-Path: <SRS0=Ayxn=SQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7466C10F13
	for <cocci@archiver.kernel.org>; Sun, 14 Apr 2019 07:43:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE85E20850
	for <cocci@archiver.kernel.org>; Sun, 14 Apr 2019 07:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GN9nKkgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE85E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3E7gjCB016058
          ; Sun, 14 Apr 2019 09:42:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F1AB7771D;
	Sun, 14 Apr 2019 09:42:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D3C6C770C
 for <cocci@systeme.lip6.fr>; Sun, 14 Apr 2019 09:42:42 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3E7gfVX001262
 ; Sun, 14 Apr 2019 09:42:41 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555227761;
 bh=mjA8AROgSR+smUsBCv9SVihPhhrjyaQJLZUXen+4MDY=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=GN9nKkgjnQ5tXUGgYFiB9NJOmG1Pdxr/Q2RH9/ozEcRO8TyCvPJPBFx1v8huBUIdC
 UwpjbxJKFYQE4aQtnMu5uLhu01hxEx8KL6mXdiRuLr8ZqUH7FJoVBbh4icjv11N6zA
 wBXRWASCb+VLaYIW5ZWa8IWkdT+VequmgOFT3I7o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.103.133]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVLoc-1hMe6R1wJ4-00Yf0Z; Sun, 14
 Apr 2019 09:42:41 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <ce2b0c4c-bc85-0341-ca0a-9b158804943a@web.de>
 <alpine.DEB.2.20.1904111728380.3143@hadrien>
 <88620f8c-3762-ac4e-5e0f-6115a21635fc@web.de>
 <alpine.DEB.2.21.1904131737540.2536@hadrien>
 <ada8fea1-1b56-1c58-5a78-8fc95006d203@web.de>
 <alpine.DEB.2.21.1904131743330.2536@hadrien>
 <566b0019-021a-0415-4b98-b5d8c74beb83@web.de>
 <alpine.DEB.2.21.1904131802270.2536@hadrien>
 <bedc9f4a-4d02-6898-0226-6f9e67d5d870@web.de>
 <alpine.DEB.2.21.1904131816130.2536@hadrien>
 <b2fc8f6b-b89a-ee77-fdd7-0e219d5bea27@web.de>
 <alpine.DEB.2.21.1904131834510.2536@hadrien>
 <934077c2-a431-afb9-e7f5-0909d45abe2e@web.de>
 <alpine.DEB.2.21.1904131905320.2536@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f30d46a4-db37-7e97-6fb3-2cc2917fd432@web.de>
Date: Sun, 14 Apr 2019 09:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904131905320.2536@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:8m//ymEpq3QTMgxuQ+5AJhEJaNXtCI2u8lH+Skt6Oea8xFMMAVL
 9JopXPRTVPZiFZ0x4WiTWycu9zXpjmJAnHVyj+wuDXJAnUqTnueAHeCtG7gjzIns+NskGLS
 gqbuEA19IbcQKvcwCfEBD1dpqbsdZ9i6ZkXnWCuA6KmraA4cWg27QU82hc60+yH4H5FKRSI
 gT47+LmeIkijG7ELXtwnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sr1g52hHWew=:SA1KCWubSW78tDiZfA1Qph
 qxzeYLDI5MSJhdSVBvdoSuHewH+xQ67bJh3rBWcVZB47/iSBQxPGIGV+R6iIeLCP/bpsn/uR1
 mKEMfW+o8+sfdjpNj3goVAHWVFeZdstyUtc3HEmCW3urltlSDLN/9GSkQQjKrwsvby+r42yWJ
 W++iqgZlJd4mwQgyqR7h8vajuunm2t6go1c5Np8SuNU0czWJzO/9cOLMge85+NXDmNb5a4dwa
 BptVByZ+7U68QT38OjbtrtrM+w2EIoP1WmEHwDZFj/WOFvHfVGSGv1JL0U8F96WcE9Q3WKFPL
 FL0iStVgrnJc9e3wV0TlKvRHs+h3wX9gEiN6giZudrYM3IzA3CxLvcnDgXV2/v+TlW17L+cth
 Kuv3CtXBj96lu2V6aByBGPqFqfiGaNrtj10XkQLLtJL9Zy79W4oc3dJHhVQEdf/Ym7aLmgbvl
 X+CcvN6CzizDCTcT9cE10YXLNZZy/BBYZh6KUPsrMbAxJJnGQJZRcDvR9oBUBx6dYgZYyPbIK
 N0mFyUFnxAW6sj7h+qqqoid1FGI6R1+r2LtPZvz+pq2V1Ii+ZxkcipGgjsOF3IbiNz6BmNZSm
 12TsVp9a/knhB0DoiQNgHIKEadUpedTzoXYN+5851TUobN1UGmKfvuWE2nznLbZ+kHb99FQAs
 3pbXjD+GDlHyFYw7zQ0oFQrrRLjjIYNqwyCj5ehOVAskA2XMgepi/YcYmdGLCN5Jv/DyiYopo
 J1Fb4XsftfA7ldrbiqjSWWhjCUXKEzLaxuKMVOc51ZjIN+N+GIS6AMscseTqQtausiBhxSJ9z
 2tSLJT5tVobepHypc2U/wCtut7vyNwC/5M4ICEiReuvSY+jiPRNvfzSiPfVNlVqkRjmbJ7SeL
 Q2QYbugKrtIj7Rdt7ZK8XfoxQFolf6ZcD78OUj10c1Wh8YOf2Xug5b1gN4MpfUMkBJy6yakvf
 zZKvjEHysBw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Apr 2019 09:42:45 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 14 Apr 2019 09:42:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Clarification for SmPL functionality around position
 variables
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

PiBVc2UgcG9zaXRpb24gdmFyaWFibGVzIGFuZCB1c2UgYSBzZWNvbmQgcnVsZSB0aGF0IGZvcmNl
cyB0aGUgcG9zaXRpb25zIHRvCj4gYmUgZGlmZmVyZW50LiAgSSBhbHJlYWR5IGV4cGxhaW5lZCB0
aGlzLgoKSSBzdWdnZXN0IHRvIHRha2UgYW5vdGhlciBsb29rIGF0IHRoZSBwcm92aWRlZCBpbmZv
cm1hdGlvbi4KCkkgaGF2ZSBleHRlbmRlZCB0aGUgYW5hbHlzaXMgYXBwcm9hY2ggbGlrZSB0aGUg
Zm9sbG93aW5nLgoKCkBmaW5kQAppZGVudGlmaWVyIHdvcms7CnBvc2l0aW9uIHAxLCBwMjsKc3Rh
dGVtZW50IHMxLCBzMjsKdHlwZSBUOwpAQAogVCB3b3JrKC4uLikKIHsKIC4uLiB3aGVuIGFueQog
aWZAcDEgKC4uLikKIHsKICAgIC4uLiB3aGVuIGFueQogICAgczEKICAgIHMyCiB9CiAuLi4gd2hl
biBhbnkKIGlmQHAyICguLi4pCiB7CiAgICAuLi4gd2hlbiBhbnkKICAgIHMxCiAgICBzMgogfQog
Li4uIHdoZW4gYW55CiB9CgpAZHVwbGljYXRlZF9jb2RlQAppZGVudGlmaWVyIHdvcms7CnBvc2l0
aW9uIHBvcyAhPSBmaW5kLnAyLCBmaW5kLnAxLCBmaW5kLnAyOwpzdGF0ZW1lbnQgczEsIHMyOwp0
eXBlIFQ7CkBACiBUIHdvcmsoLi4uKQogewogLi4uIHdoZW4gYW55CippZkBwMUBwb3MgKC4uLikK
KnsKICAgIC4uLiB3aGVuIGFueQoqICAgczEKKiAgIHMyCip9CiAuLi4gd2hlbiBhbnkKKmlmQHAy
ICguLi4pCip7CiAgICAuLi4gd2hlbiBhbnkKKiAgIHMxCiogICBzMgoqfQogLi4uIHdoZW4gYW55
CiB9CgoKPiBZb3Ugc3VyZWx5IGRvbid0IGxpa2UgaXQsIGJ1dCBub3RoaW5nIGlzIGdvaW5nIHRv
IGNoYW5nZSBpbiB0aGlzIGRpcmVjdGlvbiwKPiBzbyB0aGUgZGlzY3Vzc2lvbiAoYXQgbGVhc3Qg
b24gbXkgc2lkZSkgZW5kcyBoZXJlLgoKTm93IEkgc3R1bWJsZSBvbiBhbm90aGVyIGVycm9yIG1l
c3NhZ2UuCgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvcj4gc3Bh
dGNoIC0tcGFyc2UtY29jY2kgc2hvd19zYW1lX3N0YXRlbWVudHM3LmNvY2NpCuKApgpWYXJpYWJs
ZSBmaW5kLnAyIGluIGR1cGxpY2F0ZWRfY29kZSBjYW5ub3QgYmUgdXNlZCBhcyBib3RoIGEgcG9z
aXRpb24gYW5kIGEgY29uc3RyYWludAoKCgpCeSB0aGUgd2F5OgpXaWxsIGl0IG1hdHRlciB0aGF0
IHRoZSBkZXRlcm1pbmVkIHNvdXJjZSBjb2RlIHBvc2l0aW9ucyBhcmUgbm90IG9ubHkgZGlmZmVy
ZW50CmJ1dCBhbHNvIHRoYXQgb25lIHBsYWNlIHNob3VsZCBiZSBiZWZvcmUgdGhlIG90aGVyPwoK
UmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9z
eXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
