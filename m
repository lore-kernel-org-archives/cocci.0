Return-Path: <SRS0=4B11=3Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EEFC2D0B1
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 14:08:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEA920661
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 14:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="BiTaSoYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEA920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 014E8Xke026485;
	Tue, 4 Feb 2020 15:08:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C8C8877EC;
	Tue,  4 Feb 2020 15:08:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D6E0777E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Feb 2020 15:08:31 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 014E8VMW001549
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 4 Feb 2020 15:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580825309;
 bh=zb6ZKbv4Mt/TPpKoOKgNvOWqAEdy3tDFTte0WKCFQXQ=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=BiTaSoYZH4/h+i5aKpQ6sQlm9s5CakB7OdiaFNUebcolNfAsFUfDRONVq8ZNyMiS2
 fohVf2vxQ8MO4LLAQfg8CYycAmaPVfEvY4lT9Otutx4kQ684CGNgZpgGr7LNEs2EsB
 SVDX4yri1Z31gTyFUkhB3KmuaSRwE5eBXYD2hnD4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.133.16]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgK3g-1jMAY52k8S-00niYO; Tue, 04
 Feb 2020 15:08:29 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
 <CAAJnyheEpd44ShTijdOAq6QZ9dyjJ387dcJDHg5qcd4aN90PYw@mail.gmail.com>
 <5fe198eb-2e43-4ae3-f82a-e7bcfc394623@web.de>
 <alpine.DEB.2.21.2002041418420.3345@hadrien>
 <6debc5f9-839a-1b7f-7d11-cd7a7c6b3866@web.de>
 <alpine.DEB.2.21.2002041446400.3456@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e2cbe977-8ffc-90a8-d115-e868d138e98f@web.de>
Date: Tue, 4 Feb 2020 15:08:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002041446400.3456@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:1qftzy63gN8B6BbiwEmDgV3Pm/QCd0B44MTqS+67bT3yVF3oGrm
 zMvw0OgLO1Z7Buca6hdglKiEHFfzbAZ9vBtwng9QmAudAhlKwyecI8+wbnKiqx1Hd6IKRmV
 97OFyw47X5vtw2golO6geUiVyPQrMIHZLGUKwh2ClxMnIsCbXgoGPqAZJMLEI47+9MDwNg4
 ZXg4c6laRbHsZRtN/V8xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y+LsYdAzW0I=:TcjbbVauEnIZ53NwtWmQfO
 qb0/iMSK5xQWreHIAklJwqnqm7X48feMm0VuE1UmzoDyQTDRA9ZgDP7YIYjwrLkbJjS1TJhPt
 AhkPmficdYSS7uhfnjg4YD05cA6hjVsyvrK15gxcv50iq5avzdZVQ01HL9Evs0Khz/Qpss28/
 zOUrFh1sINe5+yOTTpTCwRnz6qIwaC/nvbIR/1awMsjkcBseTFfo6FXp3uJdyX1PE4nvlGAQ0
 P47IEqAliUh+bGpKBQhhgesfgXFLgwvJWUlibhkwoo3KpvdRbSZ3x1ScxXks3mFXsloqDeNfs
 OQ3XozxLN+YBZmo6Sur1sWjavJ1pgIDrecLriGHsnDxZlpAFabdgsCwHkQwGy6P+VGSyTVnFa
 Af0L4OB2R9N+w+hCgnerwfdRMRpMurdpH+cafJNspMte6eRYxMGad/gnVTeCodzOHTrK+Qslk
 36O5VDR+zVBPHggywT9QBXdOPvYV1CaA85nNtv5m1ynQfQSpqzmF+WUAEj1CrQZlb0hmSHBqI
 8dWUZuGyV3issWCZmK508vazU0I66doiaaQy0e1Fb2oo+wYcCp5833c+3aB8UD0UjkMjTjKRC
 SiIqf6Pc42oWTIVFIcgzY/Hl2TLlE7m75a0WfzndChDlkzJRu/xqm3vtQYIM5fa5GnHnkCWDp
 QoA9gx5UzBB2I4KdxLJq/zqYzegXsdhmythNnV8hDhCEdO1KMBJXqPdGz0rbzeDBkJkE1rugz
 X1CymfaiYhWPgJqJRooU27AQbTvCySzNG31SvB5XbJzLcsuG7S37OVyFqx/wqKijB3ju6STU+
 tKORyx0RjqRS76KSf4m9ydhuGKxJSDZQgQcVTZ0NRfG7AmVTyuSzyaRne8ERQBJVP3OYv9wZP
 XcCx7zZ9KrRCvkR28P/F0FFOT5hIkyfRQYcVM6LdGWXISeYXTbny8mgJJNbsB2jCj35p3x86v
 ABqQv6UZdWP5FXjPjHLbkJu647TOWolQYINjcFc/okbtMlr9kolzMFcunQzuWhrHshpnQEF+i
 4BMJkpXCjLHXRWqNa46EakoKW9tSq+qjbmVADjOmjwJHEnvz3F4tKXlJLzV08axOxWMdMJHS8
 1dyxSBHf00Nb8c2+PXjDB0Nj4PrPMrNAZSFCYWDQI60z7PjsMm81k8PFIWlViDnJB+hJbO75e
 NY2+fFwmZsw5JajRqgxti4WnQ8iO/H+NwwdCYo6leM17g/LyAFOJq//8Nbt+rMsfdiGb6FcYh
 syHvNH7/v24kisXiY
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 15:08:34 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 15:08:31 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wellington Wallace <wellingtonwallace@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a std::string check by strcmp() with SmPL
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

PiBQZXJoYXBzLCBidXQgaXQgd2lsbCB1bm5lY2Vzc2FyaWx5IHJhaXNlIHRoZSBydW5uaW5nIHRp
bWUgb2YgeW91ciBzZW1hbnRpYyBwYXRjaC4KCldlIGNvbWUgYWxvbmcgZGlmZmVyZW50IGV4cGVj
dGF0aW9ucyBhZ2FpbiBmb3IgdGhlIHBvc3NpYmxlIGFwcGxpY2F0aW9uCm9mIHRoZSBjb25zdHJ1
Y3Qg4oCcPCsuLi4g4oCmIC4uLis+4oCdIGZvciB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2Uu
ClNob3VsZCB0aGUgY29uY3JldGUgcnVuIHRpbWUgY2hhcmFjdGVyaXN0aWNzIGJlIGNsYXJpZmll
ZCBhbnkgbW9yZQpmb3IgY3VycmVudCB1cGRhdGUgY2FuZGlkYXRlcyBpbiBrbm93biBzb3VyY2Ug
ZmlsZXM/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpo
dHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
