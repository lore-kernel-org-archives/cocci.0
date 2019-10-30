Return-Path: <SRS0=bhL7=YX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36540CA9EC5
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 18:16:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B38120862
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 18:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hi6T4f0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B38120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9UIG4GV011163;
	Wed, 30 Oct 2019 19:16:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 99B0E76F8;
	Wed, 30 Oct 2019 19:16:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 41CD974CD
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 19:16:03 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9UIG2ZW007967
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 19:16:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572459362;
 bh=/Y5bv+ibkNl/4xz3/ZIhSBsAxYNp690QyYwQD9nlApI=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=hi6T4f0pxEK7HscJI8FvX+EoHIOzVnG8z21Ipd3jEYRN6OvJ5pYKPAkJ7zoEtndaF
 eWs+KcvLSfNokHJRIW9k0WqYSLMPTbUSiidEuyuqGrtv9ph3qZX5nzBMHz5eK2p9EQ
 0W8ZIdx7Qt6K6RlUqQWHARRfVueTvqdUu4dO+z+w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.104.79]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWNHW-1iSaBU1Yb4-00XcnW for
 <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 19:16:02 +0100
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <fe6868a4-01f5-2832-9081-7643be0ab4a1@web.de>
 <3e3f40db-2422-c64d-3825-35f8c2471eb7@web.de>
 <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <bd082d16-3038-1c8f-0a8a-bef8e6498aae@web.de>
Date: Wed, 30 Oct 2019 19:15:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:glnPWtRcHFFf5UDQLgw8tJ3moXkW+2obSBBRIHfK9wBTqMwT4fu
 Vc+12rbcIRWmwVN+lka4evygD6FNYdPLukrDEYDKnmXF9ZB6Mr3L6XcGwyTZ/3e0HaTSgsH
 0V/wQVjZiIAw+PSWFPcfA/XHDj3F5sQbGMEADV5VuI4l2koQ6zCyrblL0imRdtm6hRzxCJ6
 eSz+tAxy339meRayrZZzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/60ndF9D+8Y=:IeL+NN5NOP3XmggIqub77d
 PjMgRrUtBWu8tc5AUFZyMNJm1QPYYmqIzBM1EJZe8fm/BfqfmRbckP29ihBZqS70M8OQuGX6s
 o7wSU3dtsA1BVRyxcXL3pbKtlMVKUqXBj5Ptz9jw1T8HOo6r4uf12BEUwejiqaBjF0jskWygI
 /1vHDE5OZaVSS7JQMSwKgbSYxuKM4cvnhoBTq4IIxj99bqQMv9hwL+RUMlwiLRC385on8grS+
 iXBNrfV7WY+5NhT6PZCxCg+bmkV/cHuUMghi00XqOLJUqJijl+EZqMjz16AyqrFXaZAH1/dgm
 b+evQy2xQkuY8W6f6SHyiOP2Xh/Sij6c/5GRGGPstUxjYorGMxqE3gUrzQugNOklkgr2cgDz+
 C8YyFlG2N3pcBm5tUADbTXfXqSPBn8nXHFkBAD93vo5w2RU3upKbCdy4usI6E8+WjBNXjHQDd
 xRITpgwPoCS3nD2bSTJRAO5W3ESOXK6zUaBfKuvhzXZT4IlrF/AsW6741Lwp+XHAvOqxlsxkw
 DVvA7fSnQmMwSXCysYuIv01ewOFpWSTPN67sjb4keBD3NrNy7sa0VJDtOBioAW0V8G+W3pDf9
 X4FAvvCF7lK57YLE0wXWBPrvB0sH+N1KIHc5AzBns3SyFnNBWlwuSjJGvL04tNgi2H6JSnKm2
 yrqmlTHRJLItWHRDbSDzgvuNoTaO8xF60/rPCWPhSpGSt8mr0MWZId0NS18w13LZo2LGt09nY
 /7CW7/oyzGkiCq8pJF9C41lzJyWvZv1jhKD1h1Yxc7T+m3gA+Xa1LewGAKj9ss0iLeok5AlL3
 eDDSWMXUhhOiaQDc62v2QL/2BJ9UfJgoPWwi0wKOyolYrtQsuHYfaidIMkaYekl1SeU48Om/t
 Fa5ZFzIPocCRhHA2Ux2VVemQlop1QqkU63YQ9h7k0zpcJ4rJ7XJGxisifEAfBotxPJzk1ykl+
 fITLio6L0l1mOVpmi9Ytr+O5FWF9yI1D5VjEYK0l+MhG6Ouv2SfHgN8nihTdtJ8iJrZ1a4jwm
 tjPZhlmQR4KCbiFbDq4pjZH1NT06bDgq22+fY6/9DfsoLPLVcsXo6wlP2r+60l3MMCD6wbAN0
 c84I0ZxU5BsIt3F7H+O8jDni9qSK+I/FedQiLpK97oNVQEFSW2m0cMYGpmi0JebbURa4l64Xq
 /nfpPB+Ve+Phvfh1SOi2d+J9v8279iY/lUrmxJ2abUqKK5QD2LuAKItatOM0XHLIYx/ZG0N7z
 FXMtCSDYeipriexCfFlpa97ae/PJ0KvB8G7DE76DKhi3RDCeR1wMDAH3VSks=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 19:16:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 19:16:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] xusb-tegra186: Adding a function call behind a label
	with SmPL?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

> But I stumble on another unexpected test result.

I would like point out that the following simple (?) transformation approach
does not generate the expected diff hunk at the moment.

@addition@
expression object;
@@
 object = kzalloc(...)
 ... when any
 device_unregister(...);
 out:
+kfree(object);
 return ERR_PTR(...);


elfring@Sonne:~/Projekte/Linux/next-patched> spatch drivers/phy/tegra/xusb-tegra186.c ~/Projekte/Coccinelle/janitor/add_kfree_call1.cocci


Will further collateral evolution happen then also for the Coccinelle software?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
