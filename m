Return-Path: <SRS0=71lr=7A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A7FC433DF
	for <cocci@archiver.kernel.org>; Mon, 18 May 2020 10:31:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30C2207ED
	for <cocci@archiver.kernel.org>; Mon, 18 May 2020 10:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="niat+Lhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30C2207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04IAV0eI024850;
	Mon, 18 May 2020 12:31:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E04C87559;
	Mon, 18 May 2020 12:30:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7FEBA3D0F
 for <cocci@systeme.lip6.fr>; Mon, 18 May 2020 12:30:58 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04IAUvLQ021468
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 18 May 2020 12:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589797856;
 bh=+Y6iTYO1IWbCpgsSmPGgEXzTAsZIAMWJr/nxO+Yq6Gk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=niat+Lhp9QLu9++OK1XJth+7WFNS4IiNAllQmpJR3GfGi/ZxX/J6dRGCyUMsx0+2h
 tJFKb1qnUzhJUcbFjNCWOGnMNfsT2acAQE+wG7fgzp7H5slfNRDmP+4d+9hX/VgJpp
 ZqoVdfapLeWSUWy/v7qAPQbIvhPht/s5PfIBk3Lg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.105.123]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc3F-1jpBll390f-00EfbN; Mon, 18
 May 2020 12:30:56 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <4a677190-b494-138c-4782-eec033a77377@web.de>
 <alpine.DEB.2.21.2005181118540.2467@hadrien>
 <0a93e321-42de-3534-9c4a-d67132a1289e@web.de>
 <alpine.DEB.2.21.2005181217580.2467@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8f3cbbd1-653e-ab2d-5a41-18eec00ae828@web.de>
Date: Mon, 18 May 2020 12:30:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005181217580.2467@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:5/eWNDIae7d4V6bk3vKRSop1GFjQGhV7FxfX9Gj9Z22cGKowocN
 1JlzlWnAf0m/6ZDst3jj2mRIIHX6ofWh+0NCGcqW/ORSrWII3NMaaYnpr5UCNurP4ptDXiA
 yRwwQfMOO/jarcS5sDr+pUHPz5OqcyC5sb7EXJfy4AGiEzZ/Vhr/CR2wqL3V9FnOEQACMyX
 zyZalCznr60ItGGBKKO6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:baGtrZVG+mk=:g2IW6GxilYjC1lTaysoW5W
 hxl6aKNTlH3m/cI/Pduuuc1QKnqh2xrY9KOrBXfcSKVkVf6BpuGdauoU7iijiRjpQygLV35jy
 yFDitj+CGBYz9/LOdbhDcXrUUJv9j2Hjqtyi7LAtAW1rbFGxRJY8MazyF3l4THjPS5NxEmBYk
 1iwNIvi1HmvFCPwEwQJkNsKEcVavXzsR2us14MZcJEzqKg4tNOMN17ri62WiKQwn0YrGvBoCu
 oKzmnrO05zGe93Yf0b/huiq08H1y0dq69KvbUy+6KxMfaQwD93gKiCl1t5GyaFBFllUnToYVW
 GyEENoVFflxf0oElRVv6t8p1+hBj5tuav5Rs9N7OXKXlZPgFBQJyn+fGzO7wuDEK52l2B6LUs
 yTAc4CDfjYAH/1dpYakY0VDr753YOkOPMRkIO3X4lSzweGx72Q7vm4BeYsI+xN24h21kRBTl3
 6h6xdb+nEAfUHRPZZZQktGX24XXh0dth5jtIREfy0Rckn7OT44zZtqJbDLs0d+aygHnrlccHW
 r2lmDvd42qYstBWT0tB+SJ5HjiA1BNmRQkFTlssIEeHO10BIgVj7dtqGGosxG/7/hCTwEq73u
 gZJtHy0W2OfUu2i0ycJiUah+2QgLp0yJ3o6TOC0otOEuWMlhCmD6jnlx87rOJwkh/L0kfqmNe
 ny7lcpzSoCx8+6dsropOpWX+8AWqT30gtJV7WeOVURID+lpMOseMv0+aqz3mtU/o2LnHzv/VW
 QchL5FIG1VS62Y+qkFu2k079Q+ENEs5X2fJSnMsH+5BMdWapeck6S35Og0xmWKXqdRA6F0685
 Yuh6TaRzZEFrDEFI5us/ogS59JBf9VUE0rKbntaHnKGWdNEqimjJkywhuQ1RhX46X0lWG/B4T
 qLS9jcZk65Ocx7btCvB8aqbFhkHohyF20MtTujv0ZK91j1XFhTZGmZp9xYwnCFRHn6flkQzbn
 raV8knsGPSn/ZE+37SHWJDBe6+iDvvUi67jkagjb2qvV/1yhXyn/MDbXxgFLk1PP+FpE2/UWa
 6dLj5iIxZKxdrJX9hwnbSzCL3z6MR2USE49qyu0T1SOQGV0tLawZoSJAWqUx54eheDD/r9YVP
 OPhu95szFbsSjxqTGYNQ73ZCf2ViS32b87yAu/Q2h65B+azNsqdwOHmrIQKsYKR2U+Vtq09ie
 A1fz+cUCKX9YTabf2+mnz02d4BANWAuB86hh1PPsYfHt8IsJL1hOM6KXxr3RA2coi5Ywy3OHO
 O1qozVRbY+Ypg4IFc
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 18 May 2020 12:31:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 18 May 2020 12:30:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Chuhong Yuan <hslester96@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to match function calls in macros?
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

>> How would (or should) the Coccinelle software handle the mentioned search pattern
>> if such a line continuation indication was omitted between a macro declaration
>> and subsequent source code?
>
> The macro ends at the first line that doesn't end with a \

This is fine.


> If the developer forgets the \ there would likely be a parsing problem.

I find it helpful to clarify parsing challenges around such an use case.
It might occasionally be relevant if a line continuation indication
was accidentally forgotten or was intentionally omitted.

* Source code review should point such questionable places out, shouldn't it?

* How much does this implementation detail matter for the safe application
  of the semantic patch language?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
