Return-Path: <SRS0=mkCy=TA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A22C04AA6
	for <cocci@archiver.kernel.org>; Tue, 30 Apr 2019 10:46:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E9720675
	for <cocci@archiver.kernel.org>; Tue, 30 Apr 2019 10:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YHbxCpzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E9720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3UAje0R008098
          ; Tue, 30 Apr 2019 12:45:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BA6837735;
	Tue, 30 Apr 2019 12:45:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E0CE7767F
 for <cocci@systeme.lip6.fr>; Tue, 30 Apr 2019 12:45:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3U8tNLX018425
 for <cocci@systeme.lip6.fr>; Tue, 30 Apr 2019 10:55:23 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1556614522;
 bh=Qfn6Sk7plsmM5muxRnBVN0AGRkqyMvsLz//QPygRjO0=;
 h=X-UI-Sender-Class:Subject:From:References:To:Date:In-Reply-To;
 b=YHbxCpztldnKRz52gtM6GOHSoLHm58Mvj8JMT7SVEiSA2gBOaVJGxl8+ACTpnrEJl
 i8tZICIeO3OlyYHdYHQsrg0iOoOfstN75+pxTD7Q6kO3Iqvi8ZpS2QiTk071KO7a4b
 F3o/X6LTmocX2wpBGBSzY92iVRnXyXebyYJhLHoE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.1.213]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGlGr-1hYv3j188f-00DXF7 for
 <cocci@systeme.lip6.fr>; Tue, 30 Apr 2019 10:55:22 +0200
From: Markus Elfring <Markus.Elfring@web.de>
References: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
 <30df39b4-6f45-45c7-1c37-1f8991f3f6e2@web.de>
 <alpine.DEB.2.21.1904251039000.2550@hadrien>
 <2f138dc8-74cd-3766-cc78-c4bace8579c0@web.de>
 <6ec5b70f-39c3-79e5-608f-446a870f02f3@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <470160aa-f577-bbe6-58cf-0957e8810415@web.de>
Date: Tue, 30 Apr 2019 10:55:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6ec5b70f-39c3-79e5-608f-446a870f02f3@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:8M4PfoK0fQqu/+y9G4Fc/F9tmNwqvqIBs9zS0cjKKCq3ONIVwU3
 gGowCKhMM/D8WkhC4Msfxfgg9gJBccctR84+joltFxT7VgC8HlT7q9JQckk2hA4Z3RnUxU1
 bSh+DWmOawSTUEyUs1+paQiHKXSZL4i3nUqOXJ1fFYDgoE+7JCZmt3t/ACdihiZkZ0Dwate
 GlnhTnMXrN979qdFDqkEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lQWbNck+UYQ=:AVcrqzRrPdrwbWeOvPchBL
 Hubea96GzNIdlMmHAaM3bQewZZyUbe3QcLjkCAE75rn1QlGWfWRqrd676ZnmNlV2Ep0IPhxbZ
 gPeOTbc/PKjcVPH5AkS783bI7HNuKB/1+iY9py1U+BkFT5XL9D7sq4CfuCLIu74K+y4WdLsyE
 /6t2b3auw7bRnA5pF8kJTE5VJpghHIqJGUFW7wknXxl5EscaFcrgHCzK9c4iVrJ9LzjbeNNMk
 cOPmTntXyTfCKtoNdPkJaS2pkP6SAcKX7iAJ/CdaV7nl55yfJGDJxq7N2go0YDWbGysYPMmUt
 t+w27pBUM+55PS1vl6tLH570rBF3pbV/R9qm4QeRYh1qg7zwFz+rWMiFJLf0L9pmlt7gumvxK
 RNfdMf3zkwErkLLiCV7kv1GckLA05JA03UqtFc9rQ5Kx7ZWPklIBteoByej2cN+DJeFNTgQyL
 Y4URyLWxrFfYt5BxRcBwbeRMYK4kRg1HzQv35bBLGuN/7xIGEUUr/dFWZEoMWIj8U67tmt1IU
 8/7cTsdqZ02bQ/S92z7CWMObvOUWLGe6wVosuDx7Rr+BL5c9Bfk2aXZO3FxUXfd+sid3a1CyB
 Q3ImK4QMAc64x76dgKItvhsnvlG8b9bxg4S0peE+H5DYe2ZOnAHkOI9HfFH9mWCVQKM0V4tS8
 4gza3X2cu3474Fa88f+tNJQ1wIo6NWNtl3mS+HX4mhJpjstIr7vVN04yDYv/85I/pLT8CpQEN
 TPymM++UvMD6I1nwQRjf9Wq6k9Ab064M+lHMJB3fZynT2+uVsNfqW/FfOw/pwcgdfM/kyyGYF
 hMl3R4482K9JwSeKA9DX4TCWN0JhaTQ+pcIGRNZ92CPMTENW1M2WBztzMcpT3kxpNdowZXBe1
 hfi0aSsRCIoJSm3jV2yOVWsTA0ush+3nh4kOngCg2gSRrmQgbd5ip3eSCnR+dkcUXFCOgEzpl
 F+B+LC7YaDw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 30 Apr 2019 12:45:41 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 30 Apr 2019 10:55:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Data exchange over network interfaces by SmPL scripts
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

PiBVbmZvcnR1bmF0ZWx5LCBJIG9ic2VydmVkIGR1cmluZyBhIGZldyBydW5zIG9uIG15IHRlc3Qg
c3lzdGVtCj4gdGhhdCB0aGUgZGlzcGxheWVkIHJlY29yZCBzZXRzIGNhbiB2YXJ5LiBUaHVzIEkg
Z3Vlc3MgdGhhdCB0aGlzIGFwcHJvYWNoCj4gKHdoaWNoIHdvcmtzIHRvZ2V0aGVyIHdpdGggUHl0
aG9uIG11bHRpLXRocmVhZGluZyBmdW5jdGlvbmFsaXR5KSB3aWxsIG5lZWQKPiBmdXJ0aGVyIHNv
ZnR3YXJlIGFkanVzdG1lbnRzLgoKSSBhbSBjdXJpb3VzIGhvdyB0aGUgY2xhcmlmaWNhdGlvbiBv
ZiBzdWNoIHNvZnR3YXJlIGJlaGF2aW91ciB3aWxsIGV2b2x2ZQpmdXJ0aGVyIGFsc28gd2l0aCB0
aGUgaGVscCBmcm9tIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gYXJvdW5kIHRoZSB0b3BpYwrigJxD
aGVja2luZyBuZXR3b3JrIGlucHV0IHByb2Nlc3NpbmcgYnkgUHl0aG9uIGZvciBhIG11bHRpLXRo
cmVhZGVkIHNlcnZlcuKAnS4KaHR0cHM6Ly9tYWlsLnB5dGhvbi5vcmcvcGlwZXJtYWlsL3B5dGhv
bi1saXN0LzIwMTktQXByaWwvNzQwNjQ1Lmh0bWwKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QK
Q29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlz
dGluZm8vY29jY2kK
