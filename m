Return-Path: <SRS0=xb0b=AG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B21AC433E0
	for <cocci@archiver.kernel.org>; Thu, 25 Jun 2020 15:06:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B08206C0
	for <cocci@archiver.kernel.org>; Thu, 25 Jun 2020 15:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Z9JPmCbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B08206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05PF5kNV002214;
	Thu, 25 Jun 2020 17:05:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2318F7773;
	Thu, 25 Jun 2020 17:05:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 76298410A
 for <cocci@systeme.lip6.fr>; Thu, 25 Jun 2020 17:00:18 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05PF0H8l000658
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 25 Jun 2020 17:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1593097217;
 bh=zxyzxRt5ZZ/zLWScyYchcx0Ga9uVnG9Xx+Xe1VX9G4A=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=Z9JPmCbtvR3qp42SD1Cu5ZBxQNFrkUpRZiQGR1n5sEwpgFTPx6AEnpRbmqG+BomM3
 scHiI35v64KaZaK/8seAkFrrhgjuXLSm5AZ9TpYt2iDlb6MVQqzXkHAI6PeImLAOce
 6JZPFV6BvfzsHx0cQNWs3k2HV+foNZC5eJ8SJp3w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.34.93]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHGed-1jc3Aw1YJP-00E2xt for
 <cocci@systeme.lip6.fr>; Thu, 25 Jun 2020 17:00:17 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f49e80bf-5758-6762-3310-86fa3727a66f@web.de>
Date: Thu, 25 Jun 2020 17:00:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:SRf1u52J1E4TsvkKUn/2UccJ/h5TwjlI2f0vY60azT3S6J+JcX0
 ckAtLhqv47CVX6RxUYjxP26iaArt+04zz+3I1DlPAAUJ6CxAY/Fi6X2yFE52jwvzgQ/3239
 ZiVP2afDxKKHm7YayJV5fpISIBLZlKix83rD22inG4YXeXWAuGuZ0RfHnBDZcJvXZg/yolQ
 jDcjXAtXS2R6/g34ORJXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aIal+zs8go4=:Kq6Oo/+acymoPbAmcdJaIu
 nHT1Yu6JfNIxbfUnit2CEfxuyo5HhV/ndda0/z0s7n+W15aOToNjnpy0Xqpcr0U+BlKTEwJaE
 opi2nwaARXhunzpAi808ZAec9p4iuGRocLwICAoBACDBJYysDUfpb6pHmfDInAdLJ1DyX/TFc
 l26bwZr8zs9sZMuvbnqZz05cx97tS0q3HA+yW8oaivFxmMptJA1/idJIMPV8Cl0FAcFW1sgDH
 klqOfkMcjUbyitMgPKLyey1Dw7IDgV8pyYT67pURFIwvMl/GezNXjlH0fPZGHTuskelLyPy6g
 oGpia9ScLwz8b00PCG3WKeFj1MhOcCsRB6Z0NSTguxchKTzkXTFVIeintD01oGkGnV2ci4F5K
 OMraSjWJ7KQzSpZawKagdCnwYAxJIx53twnu1KQuXfW2BbA3NGwl2D6M4t5x8YN2KKsT4p4Ib
 1FMEI1fE9/ObZpfaoh3akycZ1GDTvxCU9rpKEwKx5Wg4pOzpnQrpfZc6yuXmKc3pvGkUbIPBQ
 KVqJbiNuffS9vT5iq6q9CHO6obkZdi2Ir6/wcP618SS9f/cZZydaHvTyRI/AmPTatwpwsPnoI
 H00ypp6O4RycQp/VCVzBbNTlSh4XmaMrup/3FctpY3Hw/IHNKIjmv4Xo3E+BrEUM3BpJPEERC
 H2/Icc8KDahX3ASW/BHPUmkjTQbTxLDR06S6eaiCzTzrfVWtEjTGjZe0oFm5fqlh8qb/5flwU
 zfbStRNHIguNp4qhHoXbFhC3RUNV//m6jsCg4Y+C7OF6vi8egivyclZlatt+aEFfuLfObdkpc
 /fNUMDbdDmxtybPSfYGBOIBIRoAtWWt6Ke6HV71xVc519iLK/ZojOrT0sXmS0tt3Yk7pqtuvq
 1phGOj1jOozE/8ZKQmfjW8wghSQCY5vzS26PtZng0L9oWqtQBQg9+57EOUmeHFeBclEsSrTUn
 2/loKHAX5ctIezWTb2hGjaF3eDALCPYZaNNUlSTpu/hv+27imSX8XUHeyWqw/dVdY7aevPD0F
 Myx2IY0YGST/M1zI6WfV8JvLtmJ2CBpSfkZV+tCGC5mfCD2zuQsKYH6U3tq0cBA2fxSH5XswT
 nE1LKu5IZSjX1GKbBvmNDhO8EEihytr8388FGics9aCo7XmCof84pnFYqigUVXAnwM56ZQMR6
 GE9pFTX7/iBIy/m2K+LwIeTMftSw/FHE2OF2319iJQS9EWYlJkU9q602VsogXp0/MngKSLO8+
 Robvb1BTR30xSCwfF
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 25 Jun 2020 17:05:46 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 25 Jun 2020 17:00:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 25 Jun 2020 17:05:44 +0200
Subject: [Cocci] Checking the parsing for a specific SmPL disjunction
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

SGVsbG8sCgpJIGtub3cgdGhhdCB0aGUgZm9sbG93aW5nIFNtUEwgc2NyaXB0IGV4YW1wbGUgZ2V0
cyBhY2NlcHRlZApieSB0aGUgQ29jY2luZWxsZSBzb2Z0d2FyZS4KCkBkaXNwbGF5QApleHByZXNz
aW9uIHgsIHk7CkBACip5ID0gLi4uICooeCkgLi4uCgoKSSBoYXZlIHRyaWVkIGFub3RoZXIgdGlu
eSBzY3JpcHQgdmFyaWFudCBvdXQgZm9yIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZQooYWNj
b3JkaW5nIHRvIHRoZSBzb2Z0d2FyZSBjb21iaW5hdGlvbiDigJxDb2NjaW5lbGxlIDEuMC44LTAw
MTMxLWc2NzViOTY3MOKAnSkuCgpAZGlzcGxheUAKZXhwcmVzc2lvbiBhY3Rpb24sIHgsIHk7CkBA
CigKKnkgPSAuLi4gKih4KSAuLi4KfAoqYWN0aW9uKC4uLiwgeCwgLi4uKQopCgoKZWxmcmluZ0BT
b25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvcj4gc3BhdGNoIC0tcGFyc2UtY29jY2kg
c2hvd19wb2ludGVyX2RlcmVmZXJlbmNlczMuY29jY2kKaW5pdF9kZWZzX2J1aWx0aW5zOiAvdXNy
L2xvY2FsL2Jpbi8uLi9saWIvY29jY2luZWxsZS9zdGFuZGFyZC5oCm1pbnVzOiBwYXJzZSBlcnJv
cjoKICBGaWxlICJzaG93X3BvaW50ZXJfZGVyZWZlcmVuY2VzMy5jb2NjaSIsIGxpbmUgNSwgY29s
dW1uIDE0LCBjaGFycG9zID0gNTQKICBhcm91bmQgPSAnLi4uJywKICB3aG9sZSBjb250ZW50ID0g
KnkgPSAuLi4gKih4KSAuLi4KCgpTaG91bGQgc3VjaCBTbVBMIGRpc2p1bmN0aW9ucyB3b3JrIGlu
IHRoZSBmdXR1cmU/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlw
Ni5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
