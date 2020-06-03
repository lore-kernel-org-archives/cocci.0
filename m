Return-Path: <SRS0=21EQ=7Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FE2C433DF
	for <cocci@archiver.kernel.org>; Wed,  3 Jun 2020 08:24:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A169E20678
	for <cocci@archiver.kernel.org>; Wed,  3 Jun 2020 08:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="B+lgp4Lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A169E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0538OWg9010256;
	Wed, 3 Jun 2020 10:24:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A1CAB7567;
	Wed,  3 Jun 2020 10:24:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 438BE3BAB
 for <cocci@systeme.lip6.fr>; Wed,  3 Jun 2020 10:24:30 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0538O4Yd004133
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 3 Jun 2020 10:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591172641;
 bh=d23+srurHHCeCMViLDFai3IkV3OMWhZxZKQQdNVk3Zc=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=B+lgp4LvKwM/pTChpoVy7BzIXcxZjqtlf5ik42lsSSjbS4BsJvuZHdxUPOhlgxw9F
 pQ3cD7dSmDFarLtuE7+H8YLLklVYr0qEnndTr+h1ytS/NTpc6MI1jRFoNToDp6JZ0/
 8q+sk+fVdkL7BN25aPveeDp0FD+uFvooZf27PS5U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.231]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pYY-1jcW103Va2-008MzV; Wed, 03
 Jun 2020 10:24:00 +0200
To: Paul Chaignon <paul@cilium.io>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1a1600a7-faf3-00bc-d616-25281bf5039b@web.de>
Date: Wed, 3 Jun 2020 10:23:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:E0IgJ//1SmdIgk+vPjmcAX9hjPIMbW3Pg/Zf1RR+IIyG/G1IXmT
 O9s6FYqLmAzkf56jkPyG/STcDhWbAigMbba9/RJ3kEHzTKb0MYo3TLa4BWXjiVgud5wXlDN
 uwWwTnWImLmbx5YMfbyMmdzcpBqD3kW6CuWk5iwiY0AYHQK0CFkKfFq1szzOVgYPTOMydiF
 vUJDrCD4Hu/9y3sqjtAWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HwamsQeasaI=:R3whE/3ZfiKVL+Bc7XtERU
 mjoGx8nQpPh9PxmplOyMqfGh2nvnJVa78xPR+Zo27R1gWHD4gwjM9Trhu3Y+mKfUmUw/HWB/Z
 RUsbXsn+2/LKP1+NYzbSC4L2ZkhQEluphYox3dHoN2w/ZjFsPSecrSZXyme8yMtklt1P4HOa7
 rDhxQzlWVH6KNSA4061LuZG45XGb/YJrIow0XnOLdIsxxy/LMGw3gIFsEf8Is+H9erMsGxABI
 BG+iT95r+eDt9jaFuAn53B+VBLw/UQKX3hcXkPTQKsKr/6qmF7/OjgQn1kLIB/OZm3ETo50go
 P2JEiSb7vYL2jTPFKvx8EIzvJJubLEAeaGCLxfICJJzJRplk4dPl+5Relv+2OskSbYURSEuPL
 3UvYY/afdnLVQYYDOSHL/ICZnPvp7N4QKHAl08+nLihSc4ekQ7TK2Ov9MfOFRv0X6E8BolqFp
 DvXIx225cB382RodBmpl/7y90jKA6shniSB1zbjuFUIYI4a3/2tteSw9nKnC0NfHY1BfSzz8G
 Uf7H3gF6vtHvfripl29UjvPKtPE+uvLgHGr8Nxfs5zRLIHTgBaQ8M0zvWOeMKVnDPu2cJ3KWt
 vnvkOUMZGgtD5bih9FLSaxnRJcftBOc8EbAb30UGH5SCsZiQhu5gG2ViagdJlYDIIuOwYuSqs
 GHOoWbD8acfiNZiwPz5L9Yzo9Fa220pqQsElZtgWxV9uXmvJKJe4ab71bni6I7df2lLiewTgV
 b4xo2iHoOUHKI13UIVmZGoba/ZgplxeJvX4gCUaoDzpfzoaUBUEO4J3oxZ+oJ1WPlAvP77h1w
 Nf4T3q+iVFbJ2EIjUEgLxXNS1BvCGMUV/UXT9bpfcX34f9se0N6xHUaQNkj2Mo8EMfjBXHQPJ
 y7q7xBs3uEA9wRDI9t7z7/Ta3a+ehIm6MxcHKXjLChNd7xG9Sr3KlMC2LYTExdulyUgwJMB8R
 H8kRH52vvUOt3Wd+cap8sqJPzVjdj5k0Z8vIF5n+Pa0Oeg8o0UKO65qd6Nbh0f7Ah/DocFWcb
 DGSruKVGAItz4ruHTF1S9hCYXWR8z/L+X4dX1B6nlmgB87h4eaea8qX9nMo3B9ZDHIwvMSin2
 VT1w3nRYBrS+IC/i728mN2ag2AU/FB5Xqr3epsLqt/Own0bZqbw4TEsFk9QbX6Txn3VlQcFDN
 sLmhAW7FMREQ39JheBYBW3DYCHZQOKP5KjRcfev/gqyJsk1cpnzgMrB6ikVpjDUplaJalU6Ce
 jq/FZD+Ex9k3KKVYK
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 03 Jun 2020 10:24:33 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 03 Jun 2020 10:24:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Excluding function names in SmPL rules
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

> I couldn't find a way to do that from the first rule, so I whitelisted
> send_drop_notify() with a second rule (rule2 below). That seems rather
> cumbersome and I'm wondering if there's maybe a simpler approach?

Do you find the following source code search approach helpful for
your software development needs?

@display@
identifier fn != send_drop_notify;
type t;
@@
 t fn(...)
 {
 ... when any
(ep_tail_call(...);
 ... when forall
 return DROP_MISSED_TAIL_CALL;
|
*ep_tail_call(...);
)
 ... when any
 }


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
