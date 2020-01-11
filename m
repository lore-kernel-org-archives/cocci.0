Return-Path: <SRS0=Fhwl=3A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62516C33C9E
	for <cocci@archiver.kernel.org>; Sat, 11 Jan 2020 09:18:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1782072E
	for <cocci@archiver.kernel.org>; Sat, 11 Jan 2020 09:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="f61Pm+p7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1782072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00B9I8YW006216;
	Sat, 11 Jan 2020 10:18:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2348F77DF;
	Sat, 11 Jan 2020 10:18:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5C9B37718
 for <cocci@systeme.lip6.fr>; Sat, 11 Jan 2020 10:18:06 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00B9I5sa026529
 for <cocci@systeme.lip6.fr>; Sat, 11 Jan 2020 10:18:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1578734283;
 bh=q3r/WJbhHUErMOhoKEoTjxDLusGdgqDbRsas63ok8oM=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=f61Pm+p7SZg39Mdrfu5bSzlB/cqDCfeSI9XtRg/SDSRroyT0WkNAlgwFuRVcvu7s6
 e6E/CjlznA4DkP8sLgkMaL0TwMCDv7YXq7Ef6tHKKhYPL2kV/fPIRXUzsHLhS4MUK6
 ymyQQWmbRURfGYCXORvTln+nAySq7pFrLVM6H51k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.100.149]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8zSL-1ixgEI2aZp-00CUyZ; Sat, 11
 Jan 2020 10:18:03 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
References: <20200110171150.14695-3-jaskaransingh7654321@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <24fd0119-e78d-ef08-e3e6-ae88cdb63f37@web.de>
Date: Sat, 11 Jan 2020 10:18:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110171150.14695-3-jaskaransingh7654321@gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:3Fc7D3nkPwe+l3xrmiTD2ClE3gP0TtiV07nsKY/WvuKcHHwXhMf
 ghD3VWl7Z+qkHXFFJ04Ts7tssDpaGM5yWP9TKICYVShg8tF9vrcrKmR0LiFUsneJfLV3OV4
 opKFEy56LYoQu0XUekk2JVncq0BMz8Lc1HzV/vjjtkpqZs0vmx6GeDXkS6n3+vzM0ZFTGe3
 ZNO7bd/mF0rxV5ybfaqPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2q0P948OleA=:vMn4+qbljR4RcPxTSXjz+N
 ZHUSdvhBYQbJsEfUPkdsHWbytrz+wrrxGCk4fZ2rOuJm/TlpbKGnkAHBpNdX1D6lugYE4q4om
 iig+f2+uBHOmcCbStTsHSiqNmhgfb+yvJOdN8BWGIyVpD74wlnagad+FqCuXrrJ9C79vp/0CZ
 DOifPChlMq4tHEQ33UOKVaMzLo+sQGg8qSPDYdRxAaegPXzHFZvTMFQXUThQ8Ud4HUCRhGayS
 DBDCQRWveuYeBjn3pl81izwzT+M2B7A0mS/X+DOKYHF74gy/jTAUdbZZUyBeSyJ2D2JRUIAkg
 rofZyFPmMWH+OFXjkKuWgga52vC+6IVA7w+nYZEDgP6eFUsp9EC3+nshU+JpfjNKSm5jKUyk0
 ISSEOTOwIPGho4M5Xa+jlhxJ5ho2ir2bDwvqKaG5jrcKxPzPv4CefyO+dtv5iXjgepYTfz/n6
 XaoHiKX+LBd37Udszv/VpFNWDzjznue7IrUJQSKIMn44jSuuhzO+Iep9FqrSqh2lspMiiw/jd
 m8TtE+R7cp4+U8DVUADeS0kFI4UTtptTkGsyXZlYTyBC0t05ZazRXusL2VTam+PBuVhjLDaet
 51gEBZAdOyefuIaR0xsSxBZnHIkrMB/qXMP7scj5sQrmLMaW1zwQ52dYvX7yF68ErvPeA7L1S
 lvMfY4hmN/XG/f96Yu2USDIa3ouf03VQE7oiwOwhzLD8auq4UajnoxUu+XGC9ioDebqAcgw84
 5fgTBz3NSHkaKlFl6MyRUia8Wg+4pWMh8hO0Fv37C1BkFOlg9kFkM4Xf2dIgCRplpty3I3ilH
 ZshVt8LL5BSiRtM/aqrdDRGxzIs9vD4aht2sjkHKaZSpWmlLEys3dfLENNLPlQrXCebyV2phk
 C0umPDguNLaHLN5sqVbXa8Zz03Kp9kqITi3P9lTWPfTMI05Y+QSToFxRQQelF+f1vP5B3zeUL
 lu2XVDGSDMrFZ59H8fgWSoxA+xeee0ZOrn0QVby3lXXVtKE+d/177EoFtcx2cKylulZHtKapd
 Qa21FbZmp8mbaQGA58G3vmUCwRfcnMEzjgTNGJu+tJiVcrnxN4N6xiCvx5tsI3/MPgaxBdGxs
 L0iZx68xYJH+vkS5VGvNNbn1bnCJ9IVKv7VyzIq6vOZ0HnAtlvLOE+sNL/npwCSEMDlne9bMu
 GCA/r2JAFHWavLZW/YcIVsVT1Ixkp1IZ7v8S9o3SyYY1NzuU4PdJNw7QQ5rSkBP/q1ksID6bV
 RhBkbgU+vruWtP16MSLenVNyrEVRvSyEhV3kTn/yaIcdtUCiTDw8wKK+couE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 11 Jan 2020 10:18:08 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 11 Jan 2020 10:18:05 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [Cocci] [2/2] tests: Add test case for user comments attached
 to identifiers
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

PiArQCBzY3JpcHQ6cHl0aG9uIHIxIEAKPiAraWQ7Cj4gK0BACj4gK2NvY2NpbmVsbGUuaWQgPSAi
aWQvKiB1c2VyIGNvbW1lbnQgKi8iCgpJIGFtIHN0aWxsIGxvb2tpbmcgZm9yIGZ1cnRoZXIgY2xh
cmlmaWNhdGlvbiBhcm91bmQgdGhpcyBwcm9ncmFtbWluZyBpbnRlcmZhY2UuCgpTZWUgYWxzbyB0
b3BpY3MgbGlrZSB0aGUgZm9sbG93aW5nOgoqIFByb3BhZ2F0aW5nIHZhbHVlcyBiYWNrIGZyb20g
UHl0aG9uIHNjcmlwdCB0byBTbVBMIHJ1bGUgd2l0aCBvdGhlciBtZXRhdmFyaWFibGUKICB0eXBl
IHRoYW4g4oCcaWRlbnRpZmllcuKAnQogIGh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2Nv
Y2NpbmVsbGUvaXNzdWVzLzg2CgoqIFJlY29uc2lkZXIgcHJvZ3JhbW1pbmcgaW50ZXJmYWNlcyBm
b3Igc2NyaXB0LWNvbnN0cnVjdGVkIG1ldGF2YXJpYWJsZXMKICBodHRwczovL2dpdGh1Yi5jb20v
Y29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vlcy8xMzIKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
