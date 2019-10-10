Return-Path: <SRS0=AiyZ=YD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A83C4360C
	for <cocci@archiver.kernel.org>; Thu, 10 Oct 2019 13:36:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFA92067B
	for <cocci@archiver.kernel.org>; Thu, 10 Oct 2019 13:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ZhlYb05x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFA92067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9ADZju4029722;
	Thu, 10 Oct 2019 15:35:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E201477AE;
	Thu, 10 Oct 2019 15:35:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ADFEC77AD
 for <cocci@systeme.lip6.fr>; Thu, 10 Oct 2019 15:35:43 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9ADZfTh013682;
 Thu, 10 Oct 2019 15:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570714541;
 bh=SsOAYOkMUxfHv9JCpaMhOMhVRLDtqfO+p2vT8VtBun8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=ZhlYb05xrxmqbySNJFK4NDYdxXWD/HU0lQGZt2pHF+CqBTzQZho0pA8S9FGZ7x8Et
 VMsySElhBZmr7U1jqSrFN6Qp2+igyy+gIKE+m5OeLZaC+9e4q9rFtg+7edjmdy2BqV
 Ra26UyAi6bA3A/E2etsMt0Nk1PpJBSbcPih3N37s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.64.254]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXHXF-1idCY40yZB-00WHsp; Thu, 10
 Oct 2019 15:35:41 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8df6513d-36d3-2049-8fb0-28d84c8f9c85@web.de>
Date: Thu, 10 Oct 2019 15:35:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910101509370.2305@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:ePyZE+gerNp5WdTbpUlG/i/Wcz4tjTLouEPu5z+tDg9jzreKXWp
 vsUzRWs0uV0WLEgFdINIMQjdToyuldxs6on7GspZ4iuoVSO30ZIwu6SrtwA9N10GbUc0ge8
 S9+0aXvFjHvYk4PZkyztM8n0sXalX4QytHpmNWknmxJfbZDKKBhX+8af6qrW9Qn2CMD0Pvb
 wnQjiR3hpCtFl/fVmvnzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zkROhgNtsVA=:RntrFk2OgUsZusfSIPMky1
 OFSlCDobk4E6r3Nn30x5Jd3XdH+ozjlDZm1WKM7BrjhsJjU2HWqdeLMZDBnUy0Xl2Da7ESyYI
 dQKuyP0D/JvO4UbPqwTCL1/vo8mJgtwjuEy8Z3bdozjhDr88Z7f9yepl0dZ+HWOcYIGNSOMzN
 NtYWcnYF+5iyMRuIgAhp4fw7Q5YfvG4xEjSBh6ghcTCoZ2VxJmfKjwiIVPA+M7Lm65/9prTfl
 VLCywVeCnSCiboAJ5jvWP6D9WlBq+SKg3ztgdJqxsn0Y8O8EeYcOmTXoYVjlEqEe/P9WeukX8
 o20J6WZFkBtoB/cnZFN4P+jl3g033ka4cHWNaIYQZzxI0i+cFcoIzcWjo4RqZ+ODIK180+TCB
 RZyP5DaEBhsja/0F36cMw0SMsqbItuHmqa7bi35/CchP/0wr6+EjbPggRA725DPODBpUM0feq
 i/jQxmrY4H4el6zjGVtdc88Keeaa/oDaWpQOvO/DjoRQiBOK1CcqDjzZOifSDrsLqaEKnXTJN
 gavNZoKlovdyczW45p3wdAiOfOYjo5/C1I1xQFwGLRhyhiUgNI+J792aRwiWM/Y77zb0q8aT7
 wH4RDtpd9/ltqPG4dvEqpYlbNHBBG+bu+YySVuVxv5oIh+JRnBjlm2qO+zH5VfAzg/40OSSmm
 cUbWtVmIn3RNsW/C1XyKUP6JukRg7eI4dAdpXivgY7tsVWF2vBgPlncctbMqbAireOU2zXvwo
 3m1g+iXfY+I4RqMKmAREyPdhHwXgcagzHjFtoA0E/MZQynqVv4H7YhrqiaAREppcUeMH8Gbwy
 8T0lc8cpWP2hOmfpjxfkJHj9n1sYeO4NLRIaDyiyFA9WJ1YMavxS+jW3zLoSs8vDcuK1kOuro
 pqzdLB46/8pSHQNUDzWS/AOVl+yhrK6K3za/Z4W0ZrP2jrDfX+jCFUoQu4891axTnlLYUmsDM
 ACd7/k0P0MzgLiLUOAHJkk43HbXMHnY9euvtdxgTxqb9sPKqlHjT+jZEOipOBPq0FuLHFbq31
 W8nZ9PErClrOrjf0MOcMSADYmwJXw4eUOEJnHlJ/ZYxO7G2N3zQOyIix2yekd3wu5UAKTVLRk
 eqgmXW4XvnhoqEydGbSi5hIHEwpGLL0LLuPVa5wM6BRrJFOJHHNPG6RFwUY9qldUoW4v9cBBx
 ggaJuU34063gU/rOVyVRJKYrAljvcJSMbkkIj+gNDZA6/UJME/t0yNdtjIjaqszyaQT3ymE7v
 LpEecLM9tqTSwzaDWsXX3d6YcB90R5RiAhFxqKJq1UPpPi6BF67nGZlsT8t0=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 10 Oct 2019 15:35:45 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 10 Oct 2019 15:35:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked function
 calls
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

> Why not just
>
> x = kmemdup(...);
> ... when != x

I find this SmPL code exclusion specification too generic for the use case.
I would like to detect that a corresponding null pointer check would be missing
(before the data can be used for further data processing).

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
