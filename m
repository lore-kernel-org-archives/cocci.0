Return-Path: <SRS0=VaV3=27=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A0C282DD
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 18:40:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073682072E
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 18:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="j05jR1v5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073682072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AIdfWx018658;
	Fri, 10 Jan 2020 19:39:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 17A1E77EA;
	Fri, 10 Jan 2020 19:39:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E2AFC77E3
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 19:39:38 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AIdb1f024044
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 19:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1578681576;
 bh=4W9fFsDU3CcwOzVLNfh9BJkQAOirbWBVxZMyhkZW3C8=;
 h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
 b=j05jR1v5zEtdV1YwaAJUaE4fU4zwzka1fPt0hE0ySBpyBq4bJid8gG9qLE81q4Z6B
 ISho5OLiWTg20Nq4bWeVt+jWBi99uv//qx0DYWEug9PTZDhIRXmf30NBBagLPstN6m
 ik+W3yKkB/Z/XUayQVLFzz8JsCG7rdy88taQNGyA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.170.191]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfRyz-1jRa7t1e8n-00p89j; Fri, 10
 Jan 2020 19:39:36 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
References: <20200110171150.14695-3-jaskaransingh7654321@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fd51f110-63eb-cd34-3624-a2647f1f877a@web.de>
Date: Fri, 10 Jan 2020 19:39:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110171150.14695-3-jaskaransingh7654321@gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:KU+RG1NljqGmO8uEWjX3SrHk8w1C8HljXGvXF6PZneZiCHYCar8
 qHhFyBrFelFH9oPo12FOriCoVmHR8+rpk6K7jkzh8V3Jo+HuCjNmjarg1JRJHFTbFYJUYRA
 TOyLx1hiDSM7b+JavhBlCNoDFM2KPr1ARzzaFVLdstpCXGfyxE5z2rnVPNF4jBQq6pMQWkf
 8ymFrFw7l7zmioIvc+n1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VLxiFegmZwc=:wM4ObfTqxxNPnAvztupfb2
 XNh5MoYdYodo91re/ruV33EP3IFcaewdRWk7xDdXMv61yLEF2RSDh/TxngT+JBOGBSJ6+WPhP
 ofB8dMYA3O1b1hv0/Rz/LKwGfEvbCT7fSEB1/Tn6bXgir0QF3UJojS4cvCBSamdMonCvqMIqh
 H5Jz5q8/PG4lYgu4EnCxvuHs3Ic4QhY8Zi0RHNMDg0t38F1RV0x7NvRaWQLFXBtnUvNziPoMU
 WIivEtL1IGmD3TPee0STRoPc8e7ectXbN7cnrkh8vLPOJRyXXVmw+U3qOur4l1Q1iGBQgfF9Z
 ny0u8eDYYxuTeFEKzhaMO0NlTQHh1LCl7vNgzdNjsRb0UJa44k0L/OB7GM3cYNfke9cyjYeF4
 ntrYUNdTw3Frm/5pGsDTaiIxlIAVNd+/YUJXqZZZx0WLupT/4+/J843Uf2E7FySbqpgrwJeCJ
 6razVOOH/6dr2rzKPA6zYyZ1H27KQLb4I9vhWZ9KAoxnmRfgDh8vMZPl8+EKPN0x9RpCIMVbu
 1ycym3cqWjY8foGDh8XDlICGz6X9KmCdRDtpN964sj2xkzhdXaNU1cOPW+Cdgcsf0scQDJ5d9
 r0AUgBZDhzLKcsCBqodCqULOPJhvGZRmZwqjL1dCeeXATsKzs0gP+H2cjFMDLM4nSd1LzUeRu
 aiJPpDSzJz25mNYngufYkNQqoIIqpJwfmQtWfUpcaoz24IDtyTS0zCJzonRzs0ggG1EVvoieu
 wX1JKSW0e0Uth7CNSdnlwVwAQY2VA/QTltFJzASIvx7ZGunJg6jTaaA6lgd9v9LXc/tMidjgu
 xTMaSB2zNKo+mc18W7jJKyGV4OuhAeVJKwICeUsqP2J7sUV3mD85lQCW4T2/vV4ChYd2MIBps
 uW1pQpx8m+SruP4hbM/+iynbPn0XyTw9eX0q6GCG20UQ9KSb9kAjd+1fQvB8QFknPinRX+Snx
 tXeJkIcgLwYfwOi7jYWgGgTRMo479Tjej+cUKXiZEcac+IrIBtIJl9FHUrnbYlMGeQ2BgD1as
 qbxLo9Gb5BmuMkbHIPTAEUMxO2CffLJuOjYvi8/NtR89oGUSREIDsmJDcKnAtpZfBfw9zFWIE
 SpUq5ZoMJRxhFX2P4uYlONxEjNqjyHFz13h9ILg61OPoXd/yOCPDboMUa7Zm/KcIYakVcr843
 7HeFk9h9b4iZRn3TeqqZ++7Zkl0vyqNUEO36DF5v67NRu6B7+oqPTKEdHJqs7gA5JqDUDZ4LP
 PQouDSZP5k9QG4Zk5YZLA7l3Ww+zj1yIPkG+OLQOrea0dWemu13A6f17oTcI=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 19:39:41 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 19:39:37 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [Cocci] [PATCH 2/2] tests: Add test case for user comments
 attached to identifiers
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

> Add a test case for both of the erroneous cases.

Thanks for your contribution.

Will a slightly different subject be more appropriate for this patch?


> +@ r0 @
> +type t;
> +position p;

I suggest to omit this variable for the shown simple SmPL script.


> +@ script:python r1 @
> +id;
> +@@
> +coccinelle.id = "id/* user comment */"
> +
> +@ r2 @
> +identifier r1.id;
> +type r0.t;
> +@@
> +foo() {
> +...
> +++ t id;
> +}

This variable assignment and the addition of commented variable declarations
looks interesting.

* Can such a change be achieved also directly without using an extra
  Python (or OCaml) script?

* I would usually prefer to avoid the generation of duplicate source code.
  The corresponding example might demonstrate other test goals.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
