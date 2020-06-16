Return-Path: <SRS0=twh3=75=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07E1C433E3
	for <cocci@archiver.kernel.org>; Tue, 16 Jun 2020 16:51:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FD4214F1
	for <cocci@archiver.kernel.org>; Tue, 16 Jun 2020 16:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hCY9ibqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FD4214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05GGpCsg026015;
	Tue, 16 Jun 2020 18:51:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C70177577;
	Tue, 16 Jun 2020 18:51:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6885B438E
 for <cocci@systeme.lip6.fr>; Tue, 16 Jun 2020 18:51:11 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05GGp952000247
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 16 Jun 2020 18:51:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592326268;
 bh=831msw+Y1tYmXC8l5tfZEeJE2mry2T/hUOANbCe65o0=;
 h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
 b=hCY9ibqGxzE2NfXIqPN3o6/pLk4AEVlWEnzYvWzQ07ylqh3wN7a/J3OrRt+crC18p
 lQhAx+4XbVImObaJ9P9cdAnx0UOhUyT7Ncw7dz3XgWbcsjbfYUIlS+qQEHHhwZeCaU
 jWwHA7ZoIP+80fB+42501ij0vWWumviiqiWQ7bNc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.138.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGWc-1jcxKQ1DOc-009R9i; Tue, 16
 Jun 2020 18:51:08 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <37e4e561-8d88-263a-0037-f58cb8c1861e@web.de>
Date: Tue, 16 Jun 2020 18:51:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:WSIAK6Lgte7uIodayERNr0LeaAYYM7d7kGVFw+pVFvcyjGsx0K3
 /ibSVhVM78shUNEEZNoy4ekeY5ljUEutzmIilVUGWFzlaoe0n/1v5f7gZG7BnGCK193YtgD
 GqH5OnIFWsWKqvM1TzwqW8wWPNknhB5SElrplB+meWzzL/3oU7upRIOIPCXuiwVWsx9v0BS
 9Vr9n6/nU4R2Qu2mVJyZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:emy5cdk3g30=:7Tw0hUH5+rO/3Opnj9c6UB
 Tr3c/3Zah8By3hofhXa6pxlbm8xw02QYzKUyY4jND5TR9FY0M1akPqn3jaQp4oCTjouyoWgmb
 L5yycngErl7UnwrqzhGjQFimYi+XSxH/Iiq918AlxTCj14ag8jSVlLQxZkZo9r4Ob0wGzUgnR
 uoeBip6Quz84ABjt5MvBCughhrxLsJU0LCnWAtIi7K9jTb18MWPiU8n7Mgh1fczQDR88Q6qFa
 HwP8CC+uXdYYvu1tLSNv3HJISH09JEGeC8ohBUqvCfghItMnLCyeTEYrTGylco+nwa/oxD+2q
 lq/XlC82FgXt7Lqs5JC811L3DhBbrz2nz1c+3jexb/S38dQUgGQ7yJroSvQF7LV0pmSCeZ+IW
 41j2Ta47Gb+5pyoRhP+yf3ttW3X62X8UJK7gG/QHypkr47jz/cgAgu7yg/KDfmAacXMtxEaQ/
 Zh4TTDirNYBCzi4TY33wSCOHSe9NoqwNI2G3uf+wqCF3UXx9mkOvQYb+IUqvdDoI/viy7vDmr
 aE+zVFBU67yffLZR9OYqS81EnLPlBnfx6/RQD4BbEXbFTkh9GQvsj4IQk0w3ZwpAy7OXeD5db
 1bLOFxgvm7r0BQDreo3j2EHXaO2rhD7NVQp6ZJh6+FnvCvE8VQLDeVWwkwkmE9SlxQXj8maXu
 XO0gExSwkVNoMSohsZEIOL34yGhyuc3uI64psvYTUzEvmjqGc925YDDOZp5YR93YoL9qD51Nz
 cAWIeagtsEx7HrEG+ArwGmKMVhbgPw9eHYue2JZ2ZXuwegbtYDdwEkEcEaW7oJM2sY1sjdZZd
 Wagfc0fYywAwm7FuIy5CZ5PTy52a8M1xFrCHFssu0ZKkPDTFlOXDMnI6UY1OlcBWI9FwbUsie
 lGlUmAY5z3gS3nD9TvihbdyLwDlQknvGYdNnCja/ZLsOSTzIAm3oUTcESoW0frjTA4/WX+sVH
 razaEDmOTA9oKJGodDCKy/CfCKzHJItN1OTjVA95OopapfPMFgyymG5PHMWsS9/4UBWN12GD3
 FBoDjtmQzUpH599wNY742bW5aulottLDjsNpx2HqTFdxm4Qq4bge04OMGPUj2d7WaHIWpNy88
 6dRy6kjaXgY3nxvjW3jhNyD7HXdtCUF0qppX1Izgslr9qlTjHLUThgfbBcIiPmWhHl0qmZRQW
 TzB1Cq7hGfdbG0w2/1cHnt2PgoOfxb1qTWp9OItpTRIiWn0+AQEZAJN+bpeJucw18IUND3WOJ
 CU0QG8nurHxy9IWQj
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 16 Jun 2020 18:51:13 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 16 Jun 2020 18:51:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Software analysis around data type annotations
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

SGVsbG8sCgpUaGUgc3VwcG9ydCBmb3IgZGF0YSBwcm9jZXNzaW5nIHdpdGggYXR0cmlidXRlcyB3
YXMgZXh0ZW5kZWQgcmVjZW50bHkuCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2Np
bmVsbGUvY29tbWl0cz9xPWNvbW1pdHRlci1kYXRlJTNBJTNDMjAyMC0wNi0xNgoKVW5kZXIgd2hp
Y2ggY2lyY3Vtc3RhbmNlcyB3aWxsIGEgc291cmNlIGNvZGUgYW5hbHlzaXMgYXBwcm9hY2ggYmVj
b21lIHN1cHBvcnRlZApieSBhIHNjcmlwdCAobGlrZSB0aGUgZm9sbG93aW5nKSBmb3IgdGhlIHNl
bWFudGljIHBhdGNoIGxhbmd1YWdlPwoKCkBkaXNwbGF5QAppZGVudGlmaWVyIGFjdGlvbjsKQEAK
KnZvaWQgX19pb21lbSAqIGFjdGlvbiguLi4pCiB7IC4uLiB9CgoKZWxmcmluZ0BTb25uZTp+L1By
b2pla3RlL0NvY2NpbmVsbGUvamFuaXRvcj4gc3BhdGNoIC0tcGFyc2UtY29jY2kgc2hvd19pb21l
bV9mdW5jdGlvbnMuY29jY2kK4oCmCm1pbnVzOiBwYXJzZSBlcnJvcjoKICBGaWxlICJzaG93X2lv
bWVtX2Z1bmN0aW9ucy5jb2NjaSIsIGxpbmUgNCwgY29sdW1uIDE0LCBjaGFycG9zID0gNDYKICBh
cm91bmQgPSAnKicsCiAgd2hvbGUgY29udGVudCA9ICp2b2lkIF9faW9tZW0gKiBhY3Rpb24oLi4u
KQoKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBz
Oi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
