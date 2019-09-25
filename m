Return-Path: <SRS0=ojky=XU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB51BC432C1
	for <cocci@archiver.kernel.org>; Wed, 25 Sep 2019 08:22:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1982720673
	for <cocci@archiver.kernel.org>; Wed, 25 Sep 2019 08:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gY1gBAf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1982720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8P8M6kP028892;
	Wed, 25 Sep 2019 10:22:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 40067779A;
	Wed, 25 Sep 2019 10:22:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 02A7B76D9
 for <cocci@systeme.lip6.fr>; Wed, 25 Sep 2019 10:22:04 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8P8M3bX024180;
 Wed, 25 Sep 2019 10:22:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569399723;
 bh=oirZw6L/JoJYQzIbFHlb7via7ysq7vcCDvDAufmxrho=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=gY1gBAf7OE+rw95x7WIWp6JsLstVCKBFTdLB7LRYa95q/ohfqUx3WWNKi8l0KuaGm
 WrnPsJxmwS/vf1amcr8sVFX7M+PiJJv6ByjiwMht2C90DNvZsUwi4o61kfhY8SEDw3
 1I3MMoSuGdXslKUBlU4S0INzkN6vhwDWBsQC+dnM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.110.103]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LudP2-1i4Pco3tL6-00zruK; Wed, 25
 Sep 2019 10:22:03 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <e3e922ef-fab2-ee5c-57f1-0f36ccc682fd@web.de>
 <alpine.DEB.2.21.1909242219450.2589@hadrien>
 <3628f3d4-b9c2-d42a-b1a9-d5e7fe32f171@web.de>
 <alpine.DEB.2.21.1909242249540.2589@hadrien>
 <d77d6c40-d148-540b-3071-dd2bce76c158@web.de>
 <alpine.DEB.2.21.1909242303310.2589@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8bcbe200-ff91-5897-502e-25a441aa388c@web.de>
Date: Wed, 25 Sep 2019 10:22:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909242303310.2589@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:RF6olX/YhoZolG6+jbuGx+IziuMAQmebmd5XJlBU17uqpWs2Fl7
 OHiKApuNK7uKzMsjcls4El5vePJ0ER0slnbaKwxdMxx0K11CxgAPcWzavNs234YcM/ue06p
 GktXrqu4SP98QmfJVYpvKTp92SnpsSxtmlssFUuj2Y6x88AC7FuMMxyVTXvQRSeKXOM5XZZ
 jMDaL5m/5Urxy0E9OMvTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Cw4yFpkp3g=:tGInQEZYI5O/FnnXnw1K+t
 3K0kqWw/BnQAzGZ/GU4kC4cOah4suDqOX3CldH1j5oYhWf6VJTmA0+9tOKGGF21b0SjeOJFW6
 dnu7yPD1bEsVH1Sy7qixCJMnsp+v3GQRFEhgNE3fMjipEn8sZmQ8Ixd2NCtNlQzDt4dCOTi/X
 cTPiklDHYQDcfsI71Cy4Blbm5swVDLMxWhd2pW4qoJntJOxB2aFWl3ZYvlGGhueFWMg34VgO1
 hc2M141Vmtgs5erK2FL0khUZOO3HQElrgIuenYcw0sSvcWJFX3/CL0twPcvNsi5osesru95+g
 5EVbyyJ5OeY1+HfMv2z5K8aisDhXeOSrhHFXaV48uGIGP4+Pyi5iDJlSaSldcSfhOXzhXcFIk
 LBWzAwswCHGYjcIILKAJU3anpFJyifpO6vOEV8VbSr02Yc9mbVBYH4ddmpHlVS2Lw40WPGUIo
 M21hbtyti1bKiZUM9XEOKjAt3rgQjG49ZkG8B97u6HhNWM2cSznrrl7IMxRcXkKYtGN1EWcvp
 H/DOTARiu77ywykAsbPuq+9acZRwZoW+H5Jq9h71yVjyeN0vHLNnOaMTguyHfEluzTVODI2wm
 HHAWLL+04BWjHUESACbXxYbmBMUmWZiV80MfxuUl5JJdgVpueUhG10pSjhf2IhhNjKmyFEtwe
 aBjWXEGSD09eiTsFy5QQm3yE+qJnEeM0G5VzsbYAjfnhUe04lVbfdlZlaLNkRcxCEqmlSAlPk
 8caqKz1xPLXMyS+D2PLbhIU0ps36FesgS5oNEu0yp+77cWPgvEKJY3FCcQaUL48SJqmZ3OIrz
 zRcs9IMCM8vlLIrTJl9L0M1U8Egau5HePL5zRXH58gQ9DHYBSB4THb4shJqkrjFTWf8urI6Xa
 ryR55il3AOTVgKELD9EunFyiS1PakO0E/h0HZ4sGxglch34sceyXVi36WDnXk33yZl6Vc/QvQ
 ZxCcICD5pMzHHWw4/23GoJ4PlOKDiNEpF+6621yefzsLs7C6oEsXU6mMlvhyHS2GCh4Dgiiju
 vZ/dDUqBKuRXp2fr9VdFNKCSHtzmSwzCbUDl5iN930QoMxKmJwoW/z0c9feWPKUk/DX6I9rzv
 e5SWFN3HbtHiJH2qqfDtMXfkNO6oQU2G9qQyl/x/HMpO/wiVXw5gkNJlgTgQk6weL5Ptgs1GA
 jyV+vMRjhFT8INUo/HptMR/1MVR8L+HJlopdEFJCbYmdlO505Ri6OAjV8vZqptKErqvj4KtYz
 ULtRYxTMNy/LB15R0a4fK/j6eXXhN00R/GZq94GHauqT4ySOkT9GRyOUjEX4=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 25 Sep 2019 10:22:06 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 25 Sep 2019 10:22:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
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

PiBPbmx5IHBvc2l0aW9ucyBhcmUgdW5pcXVlLgoKSSBzdWdnZXN0IHRvIHRha2UgaW5mb3JtYXRp
b24gYXJvdW5kIGFuIGVycm9yIG1lc3NhZ2UgbGlrZQrigJxtZXRhOiBzZW1hbnRpYyBlcnJvcjog
cG9zaXRpb24gY2Fubm90IGJlIGluaGVyaXRlZCBvdmVyIG1vZGlmaWNhdGlvbnM6IOKApuKAnQph
bHNvIGJldHRlciBpbnRvIGFjY291bnQuCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2Nv
Y2NpbmVsbGUvYmxvYi9mMjg0YmYzNjYzYjM2MjQ3NmYxNGMwYzkwZGU3ZmY3Y2UzZmFmOWI3L3Bh
cnNpbmdfY29jY2kvcGFyc2VfYXV4Lm1sI0wzMjMKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QK
Q29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlz
dGluZm8vY29jY2kK
