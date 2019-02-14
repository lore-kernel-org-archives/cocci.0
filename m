Return-Path: <SRS0=eKzF=QV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EE1C43381
	for <cocci@archiver.kernel.org>; Thu, 14 Feb 2019 08:16:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6521E2229F
	for <cocci@archiver.kernel.org>; Thu, 14 Feb 2019 08:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VUTkfX/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6521E2229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1E8G2cA025050
          ; Thu, 14 Feb 2019 09:16:02 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 567F276FA;
	Thu, 14 Feb 2019 09:16:02 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EC1DC76F4
 for <cocci@systeme.lip6.fr>; Thu, 14 Feb 2019 09:16:00 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1E8G0l3020860
 ; Thu, 14 Feb 2019 09:16:00 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550132146;
 bh=UUWT3QIcq7Tyh6AmRuRQ95tRrljYuqbBIDcYH2Mv6OM=;
 h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
 b=VUTkfX/4p3NhqyiICj/9VFNi3+vHuOse/SVFWLnEo4FBFp/y1FonA8EpaFFdTpoti
 dOoaj1mOtySdG8AJLEhUMbm22Q0Y4FoVYU95mGK6f4rTFThvCin0MdFFp7lB0Feat/
 OVxW5YIB3PDr91/+KMPYnuWDGo6QbfeQWTQdS5fU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.97.110]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MIvPJ-1gw7zc3JJx-002ZCg; Thu, 14
 Feb 2019 09:15:45 +0100
References: <201902141122485708549@zte.com.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Wen Yang <wen.yang99@zte.com.cn>
Message-ID: <97493e5b-a7a9-a437-7503-4617b5131901@web.de>
Date: Thu, 14 Feb 2019 09:15:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <201902141122485708549@zte.com.cn>
Content-Language: en-US
X-Provags-ID: V03:K1:Nel2ZL0O5yoXmtcUglqeBonN1Nbjk7jIgQ3wyy7ZM0JD3dW4fFC
 EkAGL0If1UDXGhDI40ZSOmvYPzA6xzqCV5u6EygcF7Er71MIHoHFseoQWyWIDEN0qOqfPWT
 nuk5RgfTxV6s1vTqw0wbtJm6b+eOfXrpknd57aw5Xd1rBGKlfx5Cx671Lb5iG0UhFYXrO/v
 Mk5bh7ZKQwaYbTRSDlaVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:efWYYc5WN6o=:E5Qz5S2i2L8OU6Dihe3Sq+
 PoNazT6YqlXaf1AYy068fbe1Y6FQ1LF875+bxSVtZH7ser5E6TnUayywqygk3uG/eyUIPRQJu
 kfUA/yfXuXhfPEezMrL6s+1JJ2HrMsopy5WiI6O6dF3l5rzvhwe+rJKecoL8La7EErmzwD+42
 fMVImAs/tnO2XQy2zhV4E9+PBF7yes/bzpoy7cSg1aus1dAl7d0sgqjlhCjQ2deNFq45pyipL
 TkSSI20TKTPEcrrR+3KPINE0zgUtG4MOFNsL2OuE+XlVO3dGRySRlG4V7b/cpTh4SyyupH31b
 oqRtmit4wUnJvmFAMC0bY5ZvdCXoAr6GbQ4O/QAFWe3Q84UK0+h7WEJIjo4ZY6P3tUG2L2poK
 JfFLR7cgdGEGwUvTTnm73xXhw6jo/PPOkeILpvw5l+Od4okwmaln2YpL0RES3PF7T2cVTp+NW
 QtL9O5bX3EARaNvTOo9e5EPRWBjp1CrZpRU+G4Qd+hy00K/IzFFnTQco/8BD62igX+b4Y4R/W
 yk0rXjuZwEoMW/m5OZ/L9fZI2XeuvGCOX08wwWBYBJVYQ3oj33y9/ExWd0WMgw89m2BQ22jbj
 hGT8jfQu3hIvexwWhYFm8n3s7g29Xvu/Qrt4v2gd9EUgE6p0Eek6bvmm3fK/tZUk0rmjEvQ4U
 Xk+MuFZ46wv/AKmxRUHypHtpgpfWcRNSGl4FU6ZQ006a2gIvusEqPvqN1Bb8jsPvswsiQvtlE
 09IRUlBI0yqssp2MVMSw9wErKRTEBXyMO5Xd2cBH/Q4zsCEH24VLjdncGyUXHkKmaNyiI4CPk
 O8gUYUWYAgol4hCEH+nPrQxbIeh+Vi3xmrSN/8XHSRbULKs8GktPqxxWKnvPwYvoE28RNxHgj
 k6BEWAOXy2/WEUEDlMdRw04kM292zh6I/eoiJx6GFlw4I+4wz/gT+5FvGqQ78VMtP4OlfAzW2
 jra4I4IkmlQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 14 Feb 2019 09:16:02 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 14 Feb 2019 09:16:00 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xue Zhihong <xue.zhihong@zte.com.cn>,
        Wen Yang <yellowriver2010@hotmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [v3] coccinelle: semantic patch for missing put_device()
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

PiBIb3dldmVyLCB3aGVuIHdlIHRyaWVkIHRoZSBmb2xsb3dpbmcgc3R5bGUsIHdlIGVuY291bnRl
cmVkIGEgcGFyc2UgZXJyb3IuCgpJIGFtIHNvcnJ5IHRoYXQgbXkgcmVmYWN0b3JpbmcgcHJvcG9z
YWwgZGlkIG5vdCBjb21wbGV0ZWx5IGZpdCB0byB0aGUgYXBwbGllZApzb2Z0d2FyZSB2ZXJzaW9u
LgpJIGFtIHN0aWxsIGN1cmlvdXMgaWYgYSBkZXZlbG9wbWVudCB0b3BpYyBsaWtlIOKAnFN1cHBv
cnQgZm9yIFNtUEwgZGlzanVuY3Rpb25zCm9uIGV2ZXJ5IHRva2Vu4oCdIHdpbGwgZXZvbHZlIGZ1
cnRoZXIuCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvaXNzdWVzLzQw
CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczov
L3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
