Return-Path: <SRS0=mmt7=VG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E62CC73C42
	for <cocci@archiver.kernel.org>; Tue,  9 Jul 2019 12:16:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244FC20861
	for <cocci@archiver.kernel.org>; Tue,  9 Jul 2019 12:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cLZe3Oqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244FC20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x69CFa04027318;
	Tue, 9 Jul 2019 14:15:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8F6AE7772;
	Tue,  9 Jul 2019 14:15:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 00A7C76B5
 for <cocci@systeme.lip6.fr>; Tue,  9 Jul 2019 14:15:29 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x69CFMLe009648;
 Tue, 9 Jul 2019 14:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1562674493;
 bh=J1W6SrxrLl8yeccTu58UEmdLYAzUxbW3tx7ueplROWQ=;
 h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
 b=cLZe3Oqc3JxrQJ8lxiY+SYBEMBF/Esrre87QLFEjGwaQLKOW2vE5tEblwR/TgUUm0
 PCeMYfBaYsdl4ZhLEHcNsmfrWhVFZH4phoMAwLA8qaTTfJ0uGBunPxy89EIs6illOt
 wNQT/ITDvC4WJfmiWqQ4nJX+86p5N/A7Q4wtaqbY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.179.96]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9XQB-1hdzFa2GGV-00CyKK; Tue, 09
 Jul 2019 14:14:53 +0200
References: <1562566745-7447-2-git-send-email-wen.yang99@zte.com.cn>
To: Wen Yang <wen.yang99@zte.com.cn>, Julia Lawall <julia.lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1c215500-b599-8b2f-61ea-a6f418ab4905@web.de>
Date: Tue, 9 Jul 2019 14:14:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562566745-7447-2-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
X-Provags-ID: V03:K1:mjZt4du5a81zOteXo1CzYRKx+ufI90+1ifPjvzr5kQ7nnfAcAhC
 UOidXa/z250xX3Cwny3DW50JEtVFhLqcBcKjX6kjTUnpoE26n9y8DErmNoXxS0P6xcTfTxk
 fceKP/nN8ZcuGSrR8PuCJ8TUOf/TEp2iRkmxznpeSHJ39KJc71R4ow+/crYpe4bVOYqZCC8
 TO9IIWQTnXoovi/WujowQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pgijroxvakk=:QbuqYPIs7U1TD4HvEGqqai
 QdsYZxniU8iHAv388G1qO23NnZp+BDzdkWXMtxM2xgpPXI2/snb2QRi7sxTdYdBsOEFKkuNSt
 +JAwsnbAWt9NCTEWWPLrUsjdxeT0TO6tff2Vfu66t2SERC31HaZkDaYTXAQ1nxIjTszO8ePc8
 5WO1OxwrRXRXfCZvjVTu1k2D5vh4xJBq1sT6ZpoRZXnMBNnezqeuhdJtK2X6/od0pArSoKiIX
 gtiUGRsvmtM51JpfhmS87ihhZJtNdtSJdWCU7FV0m9XNLQ5XVgNjhIdLKmk4A5g5r8Axfw8P9
 wbPvD4pXaMFBlC4T8/S8X8d7GysVsrpt7MfsRfFBEXMPYRbnsAuJOvn6Np+a08OsK3UvrWfGV
 WBv3IDX/oLWrPZQVmj3Mp7sb/h5moSEqFs3KJyhe0WQQpqh0veqIcQxquX/CW28xdy8JB66Mh
 ECpqabbqdJxEOPw/KLxpm/SwQOm/HiX+F8RU3jKPlIMyldkKmfW+MuRwpClqxoxh2V1CHu+rH
 IgiLtmPXDpy58Onzwtu0YrldJ5HekOdNcvaOWMGKx0nGUSmyCjY2Up1UZuANZ7U+LlvF1FPMr
 DMpXtmxNtZUF+eJCFKm/Zfv1iX+pGeE8DpOBo8EFmDtILD4lnUviz9+ri9Q2JkxXhpvY7a3Jp
 JgUvsc2sisOdp45oTWa67D1i3Yqh3ZoqK6cRV3cgevT4ZNrrFOacvDUkVdFbzZZGH/mcWuAv+
 PhCwFXiuGkbiWrclofT4LulsBk0eJGVNyZIJgjYHjr4l2G//MO4KiMADqLLp+TlQUHQ+jQrP5
 mtd2p7DvZb4QMrSzl8ZUH71BA+hDE5kIDvMNMDBVmp7l3ZJKFRLN0+hZa+Tu/ycVOGb/ByMIH
 jpfPp6bRw63wMFUZlpy1Gn8WhKBhpwq1RfPTEFHhq+lvanO30EzVMYraHzW4n3K5lVesakGtP
 tYB+6eZM4iP+f0r4mnq7LX1w9udb+j2Ti3Z+sGPH7CcjifVSAiArubkCpUf4Yg30fomH9WAVZ
 WZP42BIf7ZR46qg8y/XJlvyGOMuti0FDZePxCzU9tuidTHJAA3QhEcofJvM8FZJqDtb+5cXgY
 C/ODOtS5TDS575xPD/ge4m4OrVGJF3lHVVA
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jul 2019 14:15:38 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jul 2019 14:15:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Armijn Hemel <armijn@tjaldur.nl>,
        linux-crypto@vger.kernel.org, Xue Zhihong <xue.zhihong@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [Cocci] Coccinelle: Checking the deletion of duplicate
 of_node_put() calls with SmPL
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

PiAxMTA6CWllcnJfb3V0OgoKPiAxMTE6CQlvZl9ub2RlX3B1dCh0cm5nKTsgIC0tLT4gZG91Ymxl
IHJlbGVhc2VkIGhlcmUKCj4gLi4uCgoKPgo+IFRoaXMgaXNzdWUgd2FzIGRldGVjdGVkIGJ5IHVz
aW5nIHRoZSBDb2NjaW5lbGxlIHNvZnR3YXJlLgoKU3VjaCBhIGRldGVjdGlvbiBvZiBhIHF1ZXN0
aW9uYWJsZSBzb3VyY2UgY29kZSBwbGFjZSBjYW4gYmUgbmljZSBhbmQgaGVscGZ1bC4KCkkgY29u
c3RydWN0ZWQgYW5vdGhlciBzY3JpcHQgdmFyaWFudCBmb3IgdGhlIHNlbWFudGljIHBhdGNoIGxh
bmd1YWdlLgoKQGRlbGV0aW9uQApleHByZXNzaW9uIHg7CmlkZW50aWZpZXIgdGFyZ2V0OwpAQAog
b2Zfbm9kZV9wdXQoeCk7CiBpZiAoLi4uKQogICAgZ290byB0YXJnZXQ7CiAuLi4gd2hlbiBhbnkK
IHRhcmdldDoKLW9mX25vZGVfcHV0KHgpOwoKCkkgb2JzZXJ2ZSB0aGVuIHRoYXQgdGhpcyBhZGp1
c3RtZW50IGFwcHJvYWNoIGNhbiBnZW5lcmF0ZSB0aGUgZGVzaXJlZCBwYXRjaApmb3IgYSBzb3Vy
Y2UgY29kZSBleHRyYWN0LgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUvUHJv
YmU+IHNwYXRjaCAuLi9qYW5pdG9yL2RlbGV0ZV9kdXBsaWNhdGVfb2Zfbm9kZV9wdXQxLmNvY2Np
IGNyeXB0bzR4eF90cm5nLWV4Y2VycHQxLmMKCuKApgotCW9mX25vZGVfcHV0KHRybmcpOwoK4oCm
CgoKQnV0IEkgd29uZGVyIGF0IHRoZSBtb21lbnQgd2h5IGl0IGRvZXMgbm90IHdvcmsgKGFzIGV4
cGVjdGVkKSBmb3IgdGhlIG9yaWdpbmFsCmNvbXBsZXRlIHNvdXJjZSBmaWxlLgpodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
dHJlZS9kcml2ZXJzL2NyeXB0by9hbWNjL2NyeXB0bzR4eF90cm5nLmM/aWQ9NWFkMThiMmU2MGI3
NWM3Mjk3YTk5OGRlYTcwMjQ1MWQzM2EwNTJlZCNuNzEKaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjUuMi9zb3VyY2UvZHJpdmVycy9jcnlwdG8vYW1jYy9jcnlwdG80eHhfdHJuZy5j
I0w3MQoKSSBhbSBjdXJpb3VzIG9uIGZ1cnRoZXIgc29mdHdhcmUgZGV2ZWxvcG1lbnQgaWRlYXMu
CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczov
L3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
