Return-Path: <SRS0=g0NP=CG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFDAC433E2
	for <cocci@archiver.kernel.org>; Fri, 28 Aug 2020 19:43:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07AA12087D
	for <cocci@archiver.kernel.org>; Fri, 28 Aug 2020 19:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="D3g2jXKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AA12087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07SJhOkC019343;
	Fri, 28 Aug 2020 21:43:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 86D1D777D;
	Fri, 28 Aug 2020 21:43:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2A0C64316
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 21:32:32 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07SJWVu2024774
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 21:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598643150;
 bh=SLXe9pJBCWmemCe9vIGCHFcgImaEzucv7msD3qJFoFM=;
 h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
 b=D3g2jXKySEOvVaZ23CdhvbxeUOlFtzNmq2LSusbgmhSnT6TuNN0EX6tsX4Wqe9PCi
 AkQak6MPAyRtq1PX5kpG+2XyMKOsyL6gPpuG7WmCj9Tw+UMmf0RCX9KsaabVmSc3gn
 zqrd67/NCshhSPHPmgWVLtIWnRXUuGohLL7aSbOU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.21.78]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lcge3-1kvHsP2cH1-00k5JK; Fri, 28
 Aug 2020 21:32:30 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <11814b2f-1923-1227-e68f-7f806c11f59d@web.de>
Date: Fri, 28 Aug 2020 21:32:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:gUySosbAt4I024UBV2DuoZAgqtdk4YqQ5U+3Ywq36dvwcBuK07z
 pKp/uwIkmEz5SnUTB/wpKsWUBC1+AiuRcxH55/0IbdfZ76/OPZ5SfD9esiWT6zRoVovy1ye
 r/MhHFpyofaV0anY3j83QzhgcM25CwpTkRTp2qWmxbcdxpHRxBOfX2wSpZrrjpfSsb6tYpQ
 d0ySU3A0DCkvSgT7fVHJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jLw7rmNtzvs=:Ant225i0TOhBVDlLgnDjtr
 U2zHoJYSUvYYVyt3mIwNfPYeFnwy4lHnrebzwfYHA0wnH9sBRRhMMCRcRDbqI5iicnvZHxkjM
 uTsvvbZhPTbG9mZXpQThIee+dcESkDwMCK/SyckufW/bdEVyvbxXTEObVquO2HFmB+X6mHOJw
 fw28Nr/USjvaFPUcb26E+XmjtAqDQdhHA5/MpkW3X+bRhkbfGdw9uUaguDvsAMlLt6qNLhp68
 Iw6Sj/wdY+ybzl836Rc8LFmccpncTCILjfe4j1xyF0FY5qeoT0yR1rqWUKiBk25PCvUUm634c
 qV2l+EOJOdQKNo7rgpQvOYc4ox/hxr7CMYnUQgjJliUvUDWz1RsDWjEnc4Da8DSxkKU+MmJpU
 9FZAke1w21pEhdfhdrNeb7/xYyaONbw0ciLOtnWPLQ5JeaJi3Auov46CBK99TS5lvbrElK1Qg
 aFgnTPPg3iu/9vDV3aBXBN0BIB+yCvORiZb1yftSqtsiPEDmyBFcdz2nQRsi3uj3vgmEwmaau
 VJxMp+ULP5wnuPA3DmcxajojM/55JiMOBI0sQQk8xSWfPTspQR0/xutz2d4Ifp8WFb4JovTZa
 oz0lzbZ4AO+SvTmOcTW9q2njNzqHEOb+pQMn+3N09w/VllYHb6et/xYU3vxBKuEbcO+4pO2Ni
 7FFjSau9ua629CXjn+3LAAHLBPksoIFrtIThKy6Yk4J4NjGfFnYT8x0HGrGrOsYji7CeDngGl
 OdaPLrV9fIeHrXhMzxYT7TJ0+7ldUWG3yTd5Rh7BNK1XgVq+j4NcaTnU9uw4htN6w4kw4ZRII
 4q6S8ZDCvzWcjAyq3jahAIWX56qAiZxApkRMlgtFHVGaXNVfm8VW+9cXwFVA2vJu+FLbDQt80
 6H/vjqR5GOkq9qMa5SMbwrQUgswhHUyEdFq/A4stmByyXrDj3LIlHKKwX4mxe9+ak0TlfEzUJ
 LnL0L6w+dQfimO3K1TnDzaSHhrirC3QdYjVauAWYLPUJUcv7tnq0MDFFKVIZEP7Cj2viDtaCY
 pRZHnLUK/HUsonJlurIO9FAZ5POjsfuOrHNv7tUO1IuZuZFieeNOQFnEh/CxI9Cze8kz03nwv
 ZUfS8toFwFmNWh+p7ZfJGG5npprx1ResWM70tuUziu74Zg6NpxxBL2deayQ+LyMSaglHV4u55
 VvWAbaEvPfGiGvH3nRMW9cdVe8bppoxD/ZPnQqDeF3MbumfXuPgMu5bHlABUeJiTmT8P6cu8Y
 fjzeZuzYgjfCzWp8dzCONS8JE3s77piQnue3gYw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 28 Aug 2020 21:43:24 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 28 Aug 2020 21:32:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 28 Aug 2020 21:43:22 +0200
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [Cocci] Checking the usage of a SmPL disjunction within a sizeof()
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciB0aW55IHNjcmlwdCB2YXJpYW50IG91dCBmb3Ig
dGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlCihhY2NvcmRpbmcgdG8gdGhlIHNvZnR3YXJlIGNv
bWJpbmF0aW9uIOKAnENvY2NpbmVsbGUgMS4wLjgtMDAxNTktZzczMGRiYjAz4oCdKS4KCkBkaXNw
bGF5QAppZGVudGlmaWVyIGFycmF5LCBpbnN0YW5jZTsKdHlwZSBUOwpAQAoqc2l6ZW9mKCBcKCBU
IFx8ICooaW5zdGFuY2UtPmFycmF5KSBcKSApCgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0Nv
Y2NpbmVsbGUvUHJvYmU+IHNwYXRjaCAtLXBhcnNlLWNvY2NpIHNpemVvZi10ZXN0LTIwMjAwODI4
LmNvY2NpCuKApgptaW51czogcGFyc2UgZXJyb3I6CiAgRmlsZSAic2l6ZW9mLXRlc3QtMjAyMDA4
MjguY29jY2kiLCBsaW5lIDUsIGNvbHVtbiAxNywgY2hhcnBvcyA9IDY2CiAgYXJvdW5kID0gJyon
LAogIHdob2xlIGNvbnRlbnQgPSAqc2l6ZW9mKCBcKCBUIFx8ICooaW5zdGFuY2UtPmFycmF5KSBc
KSApCgoKTWF5IEkgZXhwZWN0IHRoYXQgc3VjaCBhIFNtUEwgZGlzanVuY3Rpb24gc2hvdWxkIGFs
c28gd29yaz8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZy
Cmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
