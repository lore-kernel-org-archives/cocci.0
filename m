Return-Path: <SRS0=7QDM=YB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0720CC4360C
	for <cocci@archiver.kernel.org>; Tue,  8 Oct 2019 11:57:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11AB20679
	for <cocci@archiver.kernel.org>; Tue,  8 Oct 2019 11:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="je4QObzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11AB20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x98BvSN0010101;
	Tue, 8 Oct 2019 13:57:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6261577BA;
	Tue,  8 Oct 2019 13:57:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BB82B77AE
 for <cocci@systeme.lip6.fr>; Tue,  8 Oct 2019 13:57:26 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x98BulAr017783;
 Tue, 8 Oct 2019 13:56:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570535806;
 bh=cr0Df24+334crWmoIA17j+ArPJ/uIqFPstFDdV2tTbw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=je4QObzXLSuZT0dyDyWDB8JGBcYrVDQqV+nnbHbVt0oNWqpC9UKbLgfJTlKz3FAe3
 OHfeLDopEhemYiOyM1D+Gal5gwfO/5ZcIsWfpn5tVVYHabzZYtsYZtyjTUUqwDkwVe
 wsDn9VhgHbYl8zSQLNTxEhSIkIMDBwEp1JWs39jA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.6.73]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LshSX-1i76jn1SAL-012KrO; Tue, 08
 Oct 2019 13:56:46 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <f4d2b005-5d5f-5d5b-430e-9921eba80b6e@web.de>
 <alpine.DEB.2.21.1910072244150.2578@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f7713a17-43e4-04f3-58f9-6bbc2b95c21a@web.de>
Date: Tue, 8 Oct 2019 13:56:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910072244150.2578@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:5QWJDEwHbYuz5kLWnMQY3evWM+7jICTvGQjiwB8SZXm/r+Y6UL8
 +PvmVICmqGCYZ/RPrlHAV8o7cBIOREifJ31DkfW0TMEMX1lMyiEEzjUXF8i8Zur62n+kjGL
 9JYAlE/mOGNS8RTrmsg5V6pdif+vBU3w2oVfxv8gwsIZue+jSp4O07/r3KUecFmHlwU9fUZ
 jbKDu3sv2DpTniOfCQC7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ti3axlnKRA0=:YU7rsilOiSd7h25IUcJNg8
 CYj3UO8oN8RftTE0HS1i+VMKqd+q8r4RtFe1s6yE8/rpWmeJFlg2gYy5fVGbq8JmQR3MfLqsC
 PI8ThqWwJPnzmNavv/NvGuQHibchYL564SM1isQH5nSFMGKXcQGHFlA1hMay2WJmLje8Ewt1c
 8WstuLp+2ykB5NLxt66ueQ1ir2vBj8DS1N3Ttuo1IOzehQVNtTFRtk+aCvzMqpQbRcQQxXNqH
 LH24wmkt/0YhAAQMaGFUJqAlPasHJxlk3t8CzLlsGN0wPfiCs+IYNYfeBOYgzAWE9u033mXMZ
 qIXx0ziL3hnFB0ll0jHM2TgSFDBG/hvRFTQQCkBLl9vwE2/cmT7M+usGmPvQPJkLxqAKmm95g
 UEoFRszFCpwJ6z4eTsPtJZCg89GULNvNjR8TfheVoTZkIcsyA8iNIanX+0zanUWQxvsa/9kz+
 w+eOQRpWh3Xc4dfRrj9x2DFIsTELiQq28Io1lRsXPNQ0IEk2dEqoy+HqsMaK7KpP/Bv+fn1U/
 8IKBYwbVA120XOSRP6bPdh4KXPkdX72Q7mQDn/BGajov/D2kcQScdtPikoiQpYkWZDdPjFH8e
 BXtTG6Pshdwy43wEiDhXhirUVXRvIGiNN5x3BvyWstZLD8Aqiu44vUnzB703ae3hi8jiK0y2B
 yCZaGdo9B5Jl41j9ZlNR1AkJt8bEsRaFPPW16PsIvg2V5gkjiKzVTdOaV6eIr2iz4rPCpBIVE
 37LmPxSnZZ40veLLEacaVkBdwRwf6eprObX/xDOWMu5us6AoTRDc9b+b3fa53L1ywCaXPVbRi
 ezdteW6IOeuHIiED2XgCd/uuwmU4fsjG+yoTuvwr8DXtA1dN+3rE4XCe/MyyvppLno53PWLPl
 nmI/m8QWZLMQcyC05UvBUQVVT5xVQ7FcGT2JD6yXh6pUc5puEStOKrZJgpNMxQF4QgJtr/zu3
 9ap0FNlPPtLpoCo++I2+nsotE1o5JqOcBONLaZBD5+YmOcxfjongo0hxKwYBNfx5HqBRF1zyp
 DqbQEGWYygTB27IBw2MEwRfl04fA7DL0AnO6r+s0wT8SMcnntx9Se2InxMAvmBB1fWT66GqUU
 rqcl9ryXJo8VY8Wpxhmh6ChXU6+amuBGd2mam9LzT8QbHsh4IEqUFWytynfUbyoyeSl1aCkTB
 dd6lTjM7X+lU5oK29XGqqkfRNgPuMRRNO6XvhL4ZYo7gPEC3eUw51jpYC/U6Pt54ABoA7bXQ9
 raYiERQcp/ytaCSgYZKvhrQxfSn9FnRg0bxZNgwz52W2R1Wt3MRhdRscn3CQ=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 08 Oct 2019 13:57:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 08 Oct 2019 13:56:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Adding code after function return types with SmPL
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

Pj4gV2lsbCB0aGUgYWRkaXRpb24gb2Ygc3VjaCBhbiBhbm5vdGF0aW9uIGluIGEgZnVuY3Rpb24g
ZGVjbGFyYXRpb24KPj4gYmVjb21lIHN1cHBvcnRlZCBmb3IgdGhlIHNlbWFudGljIHBhdGNoIGxh
bmd1YWdlPwo+Cj4gUGVyaGFwcyBzb21lIGRheS4KClRoZSBkZXNpcmVkIG1vZGlmaWNhdGlvbiBm
b3IgYSBrbm93biBwcmVwcm9jZXNzb3Igc3ltYm9sIGxpa2Ug4oCcX19tdXN0X2NoZWNr4oCdCnBv
aW50cyBzb2Z0d2FyZSBkZXZlbG9wbWVudCBjaGFsbGVuZ2VzIG91dC4KCkJ1dCB0aGUgZm9sbG93
aW5nIFNtUEwgc2NyaXB0IHZhcmlhbnQgZ2V0cyBhY2NlcHRlZC4KCkBhZGRpdGlvbkAKaWRlbnRp
ZmllciBmOwp0eXBlIHJ0ICE9IHZvaWQ7CkBACiBydAorX19hdHRyaWJ1dGVfXyAoKHdhcm5fdW51
c2VkX3Jlc3VsdCkpCiBmKC4uLik7CgoKQ2FuIGZ1cnRoZXIgaW1wcm92ZW1lbnRzIGJlY29tZSBl
YXNpZXIgYWxzbyBmb3IgYW5vdGhlciB0cmFuc2Zvcm1hdGlvbiBhcHByb2FjaD8KCkByZXBsYWNl
bWVudEAKQEAKLV9fYXR0cmlidXRlX18gKCh3YXJuX3VudXNlZF9yZXN1bHQpKQorX19tdXN0X2No
ZWNrCgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvcj4gc3BhdGNo
IC0tcGFyc2UtY29jY2kgdXNlX211c3RfY2hlY2s1LmNvY2NpCmluaXRfZGVmc19idWlsdGluczog
L3Vzci9sb2NhbC9iaW4vLi4vbGliL2NvY2NpbmVsbGUvc3RhbmRhcmQuaApGaWxlICJ1c2VfbXVz
dF9jaGVjazUuY29jY2kiLCBsaW5lIDMsIGNvbHVtbiAxLCBjaGFycG9zID0gMTgKICBhcm91bmQg
PSAnX19hdHRyaWJ1dGVfXycsCiAgd2hvbGUgY29udGVudCA9IC1fX2F0dHJpYnV0ZV9fICgod2Fy
bl91bnVzZWRfcmVzdWx0KSkKCgpXb3VsZCBhbnkgYWRkaXRpb25hbCBlcnJvciBpbmZvcm1hdGlv
biBiZSBoZWxwZnVsIGhlcmU/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3Rl
bWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2Np
Cg==
