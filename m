Return-Path: <SRS0=NqNQ=55=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268D2C2BBFD
	for <cocci@archiver.kernel.org>; Mon, 13 Apr 2020 14:23:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A17820786
	for <cocci@archiver.kernel.org>; Mon, 13 Apr 2020 14:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="r8/0FpXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A17820786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03DENF6P015305;
	Mon, 13 Apr 2020 16:23:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 481177816;
	Mon, 13 Apr 2020 16:23:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 68BC27755
 for <cocci@systeme.lip6.fr>; Mon, 13 Apr 2020 16:23:13 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03DENCgQ003362
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 13 Apr 2020 16:23:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586787791;
 bh=sCeSEDiUo+uL1avVOHOAUKzoy8BNhqMUXyi1iZcQ4tI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=r8/0FpXa8tzzOoAFviHBmGgNv/MWEm5aXythUdPL3Un4+TLzm23uwcqllTih4NFFv
 wCF5S8iU3q/PScCGMhKW+tI+DiFFKknnawhNZx9/M9PzIKNW/Hva1aIr8iTeC4NgIl
 613PpZM6cwerMoG+OSdmJD+BXitTrTc4KVbVZyaw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.133.146.177]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDPEX-1jTj1u10sn-00Gr8w; Mon, 13
 Apr 2020 16:23:11 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
 <d878a25d-29fd-28b1-fa6f-2e0f44763d73@web.de>
 <alpine.DEB.2.21.2004121050210.2419@hadrien>
 <ab6d402e-3c12-25ab-162a-f200c382dd0a@web.de>
 <d68533a4-554a-fd38-a940-1c3fb15c4dae@web.de>
 <alpine.DEB.2.21.2004130957540.3035@hadrien>
 <7228efff-76bb-44c9-e2cd-ea19bbd49abf@web.de>
 <alpine.DEB.2.21.2004131553460.3035@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d4324b34-0040-0fb7-d24c-b738ed811c0c@web.de>
Date: Mon, 13 Apr 2020 16:23:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004131553460.3035@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:JZ/sdlLSynwWjpBTrImGEJxdljQbCCr2oc/Mx/RMkirJuNeRjPI
 XmNmEROX365I00yDETJoI8VfSgVuWW9dNA0QZlomoNY+kuVNZXU3mrMUC1kjmnS5zNfCFAP
 3Ix+HD2I4ye0AFzdzc4Ti5xbIP2+axzaF9n7HitYXBU9/cgL5NltXiHgnqtOmmKpgQwyVKS
 0+Z9L0xOwcgIZmBZ741Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z8/Qz+uiU+M=:RSEZCR0eCJ5mvkDOucd9HG
 k08PjFoyCbgKzw43t2ndACItRHCplVzQ8R+yhmYhvjz7BqmjdZOtPQUFewAPMpYdb3hWw9CEx
 /lZNxJb63HMmo8+lgrl/Le9VTOcXki2NvTEHT4YzQ68oDbB4+DfeEZSA+ux9g5/RXjPhxkngM
 yanCD9V50Dc1zTHhc/GBVvjLxQ/E3wExzp5MwJIuuGLQZaReRGT9JagqL2OqMaMXy8RmO/7f4
 0FiazwGWdOnwLG4akqc3gT7L4wZptL5u753h0rWD9l0N2DDLwe9zQJtGDS6MUv4rEZQGwnfkG
 2WlkUxtdHDTb84scybxIfV8Pqax/81NcAv3WnFqu05lU4pbqFRlAdTyfLX5cw0Vzn+EU1tofO
 ekm30HJNFx6W8c4glrKUiMKaBK48KMIdgpcfF/p4w5iUY1TZzv4upf7QKWNjEB9U1nHPTE1vN
 M5OdS1qF6f77bwE36ycRjNXMGEuQ5zBKacevnlkjcCXMv8AYvjNxles4Y2EQM+mOIHp9oo2n4
 C26QIkmlJQ/DNKzmZ/4rvzJ9ue74V17Z2MRhMIsHji1sa2initOXSiAmqy/jUaNejZzVlb42u
 IqT4ER+au6KkNxvxaQPEh9LLqelxRGKmejP12Z3BnU/4MQ4sX05k8YvLNu07X9U83ZxiXm7BC
 DyuasEEAKXIvc5ZjpJBmxVR7q2iXywv8f07NxSXj1mLk00MSXcrgX3kR1wlub/vF2kpdeKCh0
 QWGf6LVB5emwV3HMMRAIypuQCfG1nD7xbFYL4JTbkN9oOcuh5UC/9XynK3DRbOJdclouFAHw7
 bVT1PTUtOT5LaooKcRF2KL9RugmXPVvw57TzIkRKVoXr8uDmU0BT4AcLAFKJc4+eMasroCJTZ
 Zvw70iwYsRYGTqk03PLCADbzHKlLfl8h6BgD8kFjD5nlWT1+sOM/tLLEj05ttdM8cqSC5zAdW
 6PBABD5EBBVWL+xg+0bbUTox05Co/cWVvehtvi5yk8HJMAexD8yhPLecT4Etbgea84LO5gDZ/
 yx4FJjIkzhjzmbGbl7uHZX+VgO6bRJd7kbztbxFgRe3+9o/W1goSSPwphLWLvhx8GDTfzych6
 UhyUZX3XxpXuSZMKUEIf4I6/iXQg9xoRtMcY3uDFcG3cfbS4IBRJwzMJVNuPLMWL6hIvfOUN4
 yZpsc5bddGY+nqQZ1FUuhXNR0lTCkn6imqPbPcaiIkjNs/wZdWY+F/oFnZ+U/w96i9oW0p5I+
 DO3HEp0Iz/R4AKf1R
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 13 Apr 2020 16:23:15 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 13 Apr 2020 16:23:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] More support for SmPL data processing with databases?
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

> @script:ocaml@
> action << find.action;
> check << find.check;
> p << find.p;
> @@
> Printf.printf "%s %s %s\n" action check (Dumper.dump p)
>
> On the code you provided whichis unfortunately much too long to include in
> a message

I found my code examples short enough.


> and that you could have surely shortened to illustrate whatever
> is the problem.

Does such a feedback indicate that you are still struggling with the understanding
for the presented software situation?


> I get the same output from both semantic patches, except that the line
> numbers are different for the position variable p,

Does this information contain a contradiction?

Do you observe any repeated data sets?


> because you have put it in a different place.

Yes. - Thus I would expect that different column numbers will be displayed
while the line numbers should be (mostly?) identical.


> I don't see any reason why making the script code call a database would
> have any impact on this issue.

The database can provide ACID properties for parallel data processing,
can't it?

I would like to perform aggregate computations finally.
Would you become interested in counting record sets anyhow?


> If you do get different results for the above semantic patches,
> please make a small .c file that illustrates the problem.

I presented questionable differences once more a moment ago.
https://lore.kernel.org/cocci/7228efff-76bb-44c9-e2cd-ea19bbd49abf@web.de/
https://systeme.lip6.fr/pipermail/cocci/2020-April/007142.html

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
