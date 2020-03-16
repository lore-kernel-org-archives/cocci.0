Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8A5C18E5B
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 17:49:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752CF2051A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 17:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hV9AL+i3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752CF2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GHmgkt016572;
	Mon, 16 Mar 2020 18:48:42 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BD666781A;
	Mon, 16 Mar 2020 18:48:42 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9DE4A7809
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 18:48:41 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GHmfJd013448
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 18:48:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1584380919;
 bh=JA9+H5JyNtFdr1l68KMje+k3uyES+FpBFeecn1Ub6SM=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=hV9AL+i3BXh+RG1+Xok44JeFOPJw5jDa9/riEUI1J6GinY7utZeIv5rvWicHxc14L
 f8RMQybNzevc87YSP1l4wFSB+9cW+Ckjg+GvIqJvUHDXs2o/Fpd8JbP2DdAkjMv5Gf
 1G+lhsOIqclwc1uNmdXKv8mwiz07cEYHNHD+uM7w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.93.189]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwHkw-1jN7ay3MBK-01863E; Mon, 16
 Mar 2020 18:48:38 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <924a20d8-6567-488f-1f98-a0c8e556e3d4@web.de>
Date: Mon, 16 Mar 2020 18:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:qaUg+tk858Y+78Jn4ebkQCiAOCaWwUWgJKD+UiLWSiT2+BR413H
 e9oQe9HSf/+fqcXokHHjgmrIIW5r9NV/b/E/bobmg3QqJSRythx4bn1i4kw0XKEXUDhdmAl
 JXs6L8F9wYpp/S49SKSiMCgA60ZE/cGC/Hrq0Vd5/nsvCp9w477/JXWIiP5M+J5aKw1kwJX
 TxoOlmPrWakGF+nPs8+dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5XAzoAVhKsk=:Lu9DODdmWkAjwH7lOJ5GfJ
 IuPOnLFwgnZrQ4/gcU8RM0rIHsliUTvsWAH7UcDyjNyZolXnzjp8G5ycj85R4zFb6wjXCIlEf
 sFw4f8iSN2q+ZPP1eKGwWTwGUTjtWZ219j6oZIgkgEr+tLc7tXwErwbbqFeIyO9tKYVaNWGzO
 ze7HJLM1HsJhnhSLujgEmUmFLgM79fPoZ/cghtw8IFpO82wm0PmAQ/p+Q5iIMlBfXNJ+WCaVr
 sfxRnCuWGjq6OrN49c9p/wg3OpYxLLe/IrjGWZDSj2TIZBQy0mtiHcAReVOGAvac4vSYKKvLu
 mkKyoR8RyeSES53nABStTaFXP65xS0FkkB9f/K3xX8Df1yxr6Qh5GUYNG/1MduDsM/QUOkzwi
 9tj4vsI6yU7j2ufzXUM4gwPyn/GzHECyjcj2CNfc1Wtb0WNVjJ4RYnAtomwa/6bJzJK5sTAmq
 46tqhd1dKMmLaeiyOJv/6O27wZpS4fPAUhinObW8uIUwLSoFGHz/1F6b3t/ky1QJsA7o3WylX
 2yAP5F14bTmxF41q+dhtodh2hcTwE9LxwaZdVbgfOm/s1hLOvJR1g6UPIBO1Vja59xChijXvS
 1PgxavFC8nAEjCYXH3scesjM+LBCHgvfFr1jIlEIBWOdgNjTMJnk4eCCcNxZ4ZjvR59WzM4sx
 LrvDBr15mCBRt3IuGE0sDb0j62QDBGpwsGha7BYXcyYY23ZIk46GyQSF5eQBXj9yhhvWKDOga
 mgUvwYVGuTd3tV2EtUcJBuC4Vmtdc8zt8eJwR3qsKHSWfEdottrgKIdD6hEvhj25GYQcYiy/v
 CWNbWDW2HKH2TyXX0oY45134DWS6H8EmmdU3sl3XV4RTKRfQGgCmsGBZfYzmYlwSNYV6ZQowm
 gaghZ4AdohZcNgUe7Ik+rkeXwiuLJ8xL6+LomEDz5TOTY3n3tS+Np8VmF5LPd9gVc7i5SNbjR
 5Zf0gRKz9FGodg/SPIngyDNzm365nQt0HPxKN7G2ZiSWjO/8kS7gAbU+KpvYD1D9M4A4W1Cg/
 DTjLZLBveDkLQrnXYin+5Tf1XRdAUR39hE+BY+/i8cn/Ks6qdAYqCDmvbsS0qqQSy3WqMbDbU
 ZUPLufqgO/zRdqdD5jblh8OFKHnioQd8SJD6anTRetc1siG8NxzVmmD30/z+q6H0N9wbhJKsx
 KEBmiQAKNM+IodTDhhro5LhzcG3d0qRHLAVFw21awAuHeoB4Zk06dcQvDF67K/Rifk86F589q
 oqflGBjOJNC/FRPxV
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 18:48:43 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 18:48:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 01/26] parsing_cocci: Add Function Prototype
	token
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

> Thus, a slightly hacky approach is taken to determine a function
> prototype with not the best certainty but what works for most cases
> in SmPL. If the identifier is preceded by any token that does not
> seem to be part of a type, then it is not identified as a function
> prototype. Else, it is.

Would you like to extend this explanation?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
