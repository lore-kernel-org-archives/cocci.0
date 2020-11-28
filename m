Return-Path: <SRS0=SYYD=FC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B470BC63798
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 20:10:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B29221FF
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 20:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="OCetiUYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B29221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ASK9Tn7008230;
	Sat, 28 Nov 2020 21:09:29 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 19B9A5C34;
	Sat, 28 Nov 2020 21:09:29 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F3B72454B
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 21:04:16 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ASK4FwN001470
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 21:04:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1606593854;
 bh=QRVs2SNILPvF3VqOCQZ2qjxFMOp7CvxtofQRvrH797I=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=OCetiUYsS3Ei3B+p2MtTEoIz38WwVH2eVDSp0dt+Ck5nXA1P7LeXXhkXrjboSf+rl
 3Dblsb4crGXF+20y9bkgooAdmuIDknmav3y9YC5jwJV7drvGJkiQ1Jd5l8nCpeymYi
 vLez7fO/9HQsnZ4ZCtWcnZCfwgDuKyDBnp3DMmyQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Martm-1kTDUa2qAU-00KTWR; Sat, 28
 Nov 2020 21:04:14 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <13b38013-8d4f-55fa-3c0e-ead782031659@web.de>
 <alpine.DEB.2.22.394.2011281844070.2725@hadrien>
 <feb351dc-537f-0f83-d9ec-cf16796ac0ee@web.de>
 <alpine.DEB.2.22.394.2011281959330.2725@hadrien>
 <d78a46b3-7035-8300-6e8c-b9e823574ad9@web.de>
 <alpine.DEB.2.22.394.2011282048540.2725@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <8d2bfa68-c8e0-9c5a-b2f5-057e534f5976@web.de>
Date: Sat, 28 Nov 2020 21:04:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2011282048540.2725@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:VXQ453i7j1Dd20Xw7f41GaCKRehsuGxyVE65UTOYTo4vyqF4zDA
 v9o+4ANdvZo52vk0Df8FamH0F/hAEkvUgl8fBGR+mwcLIa3V22eunRWRiHNrtOdptpv1Ndh
 jHlXfkTCOYPe50rhZl0IQA1Q7P1HH/vIq/QR/Sa6YlfEdwPp2iJ/A9JLVuUwn+FiYqPjZ4z
 df9kr+nTpt5j9b+Fre6Jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5EELceT9eTA=:Z/FGGEkswH9f0o09cJAvxE
 iZmomgjja+Erq+jMOlUWKZZQXOrElEw6k4GI9r2+Bmi1K00NmKVP8Ah5FbW9XWHlLOd3m+6Yt
 bUCxzAPj+geAQjm/i8R1jw14WBDXIR/Rg4nZ1cZHt/1y70Ag3/X2iVfmzSheCfxeFyPnMzoPC
 BWebBEFeNUvUU+sbQJnYl5e1SaeANdCEJ1b8KxPuhoqofOrTSt6AN2gLzFKYHoJua7ylmNo75
 8+uu6J6F0LbbU4ugQEaKTNNvsKk+ObGFRftnGBPMD4Z56g00ljMDDWHQi4pDCYpAELRAHGVqv
 Cl3yNnoGnx/kk7zQQX/GoG6fI5ijcay1s3aZfTEV+ggpdKzJINJCDYgUXMUAFk5UZ7PPnivjZ
 +DHtskMgnZmmNPoVc49kisOgD1A2k2PDFVABVnRovLyLRWI5VQw23FNIxM6EkSt7dtxcsjWz1
 4CZRwsXgYhFAwDiLOeL8lo2X0Fa7iClZlq9eWWUkQQ7JeorsQZQaP09euDERHtJ+RkyhcjyBm
 GE7LvGwux6aIPDIzmJbG6+MyJDlaKFyOnEZEA7sEskI7+gDp4x906Dt19cHZgDvs7dwHlGx+Y
 585RjlKcmIsKcUm2DIeZGjHk20RWQMqVgwnZbBwJwKUTPqM6yRUQ9SCzqDvX02v9aPfF1pts1
 phFOcCrqjWTD7iZk5jWEWUEsyyUzqDbX0Fa85recOnrOZKv0lObiQw4rfkjww294PKvEh1qea
 Shp2k4ZzPDGICV5J8++ZgvM1eFW6KtgiE9rto7SmW/YubtfC8oV0cmQmkZx9nt18mrwInTZm1
 +WenenInOEobnmu5ooCIh9zdBXU1rHKmN2GNpE01Ln9BwAjqmvYfu6GYNwtKFZkmqQUN0/K9x
 Ae5bAZ+h56g+bPRYXeoQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 21:09:30 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 21:04:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 28 Nov 2020 21:09:27 +0100
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the influence of an omitted semicolon on a
 code adjustment
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

>>> You can't have an expression directly following a statement.
>>> Only statements follow other statements.
>>
>> This information is reasonable.
>>
>> Does the Coccinelle software insist on the specification of another semicolon
>> in the SmPL script for the identification of an adjustable statement?
>
> Yes

I imagine that another view can become applicable here.

* It is possible to move a function call with a known property into a parameter
  of a subsequent function/macro call.

* I care more for the implementation detail that a following function/macro
  call exists and less that this source code needs to be an complete statement
  (together with the usual semicolon at the end).


I stumble on further software challenges if I would like to make the simple
transformation approach a bit more variable on the number of surrounding parameters.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
