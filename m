Return-Path: <SRS0=VzTg=C6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C20C4363A
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 17:51:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F5120BED
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 17:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="K/MF8aWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F5120BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LHpMIe016521;
	Mon, 21 Sep 2020 19:51:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 260E6778D;
	Mon, 21 Sep 2020 19:51:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7A9975F8F
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 17:34:54 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LFYrI1024897
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 17:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1600702493;
 bh=yB2hVcLVG6wC6OviTfaq5SCjX4bzL9/Mcs9oZh252oI=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=K/MF8aWtsiXqx76ilc+fEKjZSO0gebwDb1veahGXXvYgw8VoorKG9p4MO+SHCrm5f
 KvkiOBBBuudrpFxii4ixnNrdDVehQO+smNdnDPoVHFnSXSoItEoyvbkTpfoRVzXNib
 xpmmnL2MDHBklG5xnBGqWo2vLcu2l627Ba+DX0yA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.186]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWRzK-1jwiBj2LPe-00XbVE for
 <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 17:34:53 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <17fe1cf3-c85c-971d-8e59-65b666e91071@web.de>
Date: Mon, 21 Sep 2020 17:34:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:VCz6ttpzrlAlO7bjGPKF7stN1A+1dA6rEkgNVTJoaK5bIiVaIPp
 u7tEy62f4+Z6/+10dI6R4EWGeei2LfCYQDqha+DS/C1puACw692zf6VYl9fgAaQzaEasErX
 qqjJy8AvRHJnp7plIrXFLO6Z4Bd+R8csRzN8a5OedkpJMoVDSDLpBO3Pu/HupP8+/xLrONx
 PK5HHo5HUIm7JVZBjB5SQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oqj5RcY++2g=:rdAHThfXc81zMEfNgCp2pq
 JVzxcbIIlFy5fmDDPLBabZn5npEeokQTPvLzED9sZ0WX3unLFA+MPuio+NcwlX/JcDcba8c/O
 xv80c/f5Gw/2TL5UMI7fsHFDXKfQgiz8iNDfX4Ij9d7VNZZvQyKobyOC38Gq0cD1tFey6LYN9
 OT4ack8+UaXN1xfsV04Yc1Ls/h6866ww76ntBsoqn5LCFdH/2j2kBOuD+m7EMydAJeJGEhb4e
 VTFY7VcR8DtLjd4PqM/WNiTm48Q4ZKF+J5xF9XpdBdEQEtqX4wzzFm97TQQJtir3Ft9/l6cZg
 MkjM5rzylje5K6u4bTkYvoPXuz6FyVeLx2MflHgvqCOA3fukp58+pC3VJsbSSIr20ZCTq7fW5
 Shk0c1/gBjnh0sOu2yDKqZ/ldoVALrwhTe/8aUja1/6Mgh2MsgN5s2WvFGIHChsbNbT2BqZSk
 N9ztvRlDjaVAqNvE73HSxyC0jyPIF+zsktdmwcvV42psrhUQekmbx6Uc/Jplnrrme0vPlrvMn
 15WgrTy9udX/WsT2G8tNf1WbAfw0aYccN9pl5MHCMySblVzuMm+XoIRBTzVrGQ8JO4fKTvljP
 ucEHNC5W2BWl9Zb3M3e+G/X0f+McWmTd/DVJf8eIG/Wf/mzQSRoLNI+mYHHI0RCNxGr4LiQex
 dTGh+E42EECCYz9vebHXztejByLXw9ZMnulAGGZlocpy82OEx72MnBjAp/rjKro48cXYV61E0
 9cC8BPRBzHl7LQtKIs1D7y9ZEOZ2UzUjizd9yxvZjLJbztIqgNay6o2LWywEADY6p5vkq2aCX
 YEd3pZdPPKf0P4q1m38zuOjthpaJWiGg5Q6VpW/o8Pcj9Vjsnz1kIODGEEabpMvhXuZOwFGvV
 oJLU/SiHTuEDYBhsBpCFIU7jr9Dg/bsX+veq+4IgLrFpo5gyUpyabk7jzIBzAWtDvfwu9e8my
 saRBlmoJoXyYTU/Y1nXmQ0lAgxzZc8WJBY2UWwRZN6nL8erNsHHGftRFGpGqJBSL3a8qkl5i/
 VwOfMZlioU4PXa7gyTjN1mzur+ruI9oTN++XTVBM/0PzGV/0ilVOdzNw8sYA29hiRONiGFEts
 ptSBmiHp5S7heU6gGwksJX1A/S1kyebZZoLkoit7cwf+O/lNq119YFYRbSEs+ObgG9mvH0Eoy
 wWVPBA7TPED7vlwVumsYwHHjycamLiMUU8wTZBMPzt2RGmwBbWf84BkXu/qYS/wtXPGvO1SCx
 V1oUChZxnYaTS2nstAM9rZFL9VfHCCLgCT7u1Ig==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 19:51:22 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 17:34:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 21 Sep 2020 19:51:20 +0200
Subject: [Cocci] Checking adjustments for pointer resets with SmPL
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

SGVsbG8sCgpJIGhhdmUgbm90aWNlZCB0aGUgdXBkYXRlIHN1Z2dlc3Rpb24g4oCcVVNCOiBxdWly
a3M6IHNpbXBsaWZ5IHF1aXJrIGhhbmRsaW5n4oCdLgpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC11c2IvMjAyMDA5MjExMTMwMzkuR0ExOTg2MkBkdW8udWN3LmN6LwpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTMwODk5MS8KClRodXMgSSBjb252ZXJ0ZWQgYSBw
YXRjaCBodW5rIGludG8gdGhlIGZvbGxvd2luZyBzY3JpcHQgdmFyaWFudCBmb3IKdGhlIHNlbWFu
dGljIHBhdGNoIGxhbmd1YWdlIChhY2NvcmRpbmcgdG8gdGhlIHNvZnR3YXJlIOKAnENvY2NpbmVs
bGUgMS4wLjgtMDAxNzctZzI4NzM3NDE54oCdKS4KCkBhZGp1c3RtZW50QAppZGVudGlmaWVyIGFs
bG9jYXRlLCBvYmplY3QsIHJlbGVhc2U7CkBACi1pZiAob2JqZWN0KQotewotcmVsZWFzZShvYmpl
Y3QpOwotb2JqZWN0ID0gTlVMTDsKLX0KK3JlbGVhc2Uob2JqZWN0KTsKIG9iamVjdCA9IGFsbG9j
YXRlKC4uLiwgc2l6ZW9mKC4uLiksIC4uLik7CgoKTm93IEkgd29uZGVyIGF0IHRoZSBtb21lbnQg
d2h5IGEga25vd24gcGF0Y2ggaXMgbm90IGdlbmVyYXRlZC4KKEFuIGVycm9yIG1lc3NhZ2UgaXMg
bm90IGRpc3BsYXllZC4pCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvTGludXgvbmV4dC1wYXRj
aGVkPiBzcGF0Y2ggZHJpdmVycy91c2IvY29yZS9xdWlya3MuYyB+L1Byb2pla3RlL0NvY2NpbmVs
bGUvamFuaXRvci9zaW1wbGlmeV9wb2ludGVyX3Jlc2V0Mi5jb2NjaQoKClJlZ2FyZHMsCk1hcmt1
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBt
YWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZy
L21haWxtYW4vbGlzdGluZm8vY29jY2kK
