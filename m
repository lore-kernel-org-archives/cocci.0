Return-Path: <SRS0=peAA=EA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901ACC388F7
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 20:55:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D1022284
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 20:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hPAQndtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D1022284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PKtCPb026715;
	Sun, 25 Oct 2020 21:55:12 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0DE745C18;
	Sun, 25 Oct 2020 21:55:12 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BA9965C16
 for <cocci@systeme.lip6.fr>; Sun, 25 Oct 2020 19:45:09 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PIj9sO004252;
 Sun, 25 Oct 2020 19:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603651507;
 bh=Xbhtqs5M7Cryz2cvgmoDINx1VuWhO665VZTWgmiog4M=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=hPAQndtVWXI/wgmSdXd8h9haTc1S0mjiKz0Zc0q9qCHDleiL1NI0GrjKS2O8JHA9z
 Pzr1zdANf1AFlCDwcNRjXvRCqmyvBWJw45913fjyFO8a+tT2b633V0TmsBTMnVrMNJ
 f8tz1Yr5Axg83MEkS8W7+5ytVYzzCgmEg1QUepyo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.86.219]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LecRm-1k3Waj2S1W-00qV1Z; Sun, 25
 Oct 2020 19:45:07 +0100
To: Julia Lawall <julia.lawall@inria.fr>, Coccinelle <cocci@systeme.lip6.fr>
References: <0d1575b0-ab37-663e-2464-278fd76280b5@web.de>
 <alpine.DEB.2.22.394.2010251924290.2714@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <8f58a94e-b093-a587-c56a-a0ea0fc1f3ea@web.de>
Date: Sun, 25 Oct 2020 19:45:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2010251924290.2714@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:SsEE1YWIFkORWgeKVKWjG1CzYN7TYLHJNBmFNkkrt/gJD9LGNXw
 EF8+joTBU5CgQGj9PMseDnKSCjZiSukzMZPp9JyQ1n2SXUG34PQ6zbwlzB3zAyI5TZ/xUVi
 cZJ+AX8OIZS9KRebAZbsnejsKogKAW9OvY6tmi/B7+jG94i7Ni5qYQM1dtlPqvi91tzIarf
 1fW2AlRmYWMDGNLxUIJfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OWHbsbTtwjk=:tRXwzzv1+tWpxuJ9hi3irg
 ZEdU9a6lHr1/l4xZ2p0ohTD07ZyW1h/k7JgmUeRvbOgWvg8tHUl0c7/JjOAgZhh7Ca03oYyJn
 YirnlQFCxCn+K2U3Xxzwb2uHilyqGxaoKXeGVTDlX/0B6tAuoVA4JaFhX8guJfOD3uZuLbxOJ
 /O3eEYNzKQoj3WojYP1lIN9rA5ufEw5BmD/NT4NfyDJI3lNExKd7t36p16IoO8YZAymCz/TTw
 dPoqTrGfRxiIRlKu/hyUbQwvDD33gaeb6JAATB0uh7w3sbNIzD5XjlqKdm5FJluefDTg7eDI+
 BY7sNmZjU5MxDCndlx9AMCgCra8wh4PxHFMKs6CCkyReGldXu/cHjqDx1qC1eGgpMxPL7x3zY
 +a/NFYtG3qXEN3MzkTn86dnvY1nxZEIotVaeVc34lkSCOxjbis4tvRABkErVxwfK9Qsexvb8z
 SoU41OtkVXBL4dsNfIek5dW0EGngHulcVSNC//Vkrh1dVdW/K8kgpltou28UvQg3NgN5GuPDK
 viBFeKybFdg1CogNu5A3XgplebrvMUEge34OUfKvRgkpXZlzeoQd959AzAfVxQhZU1WypibQv
 jAjmkCR6A8nydUzc4pw5sYSnmPPB4aPoCaN8f9NAhfOG1OCIsDulaK7beXYrUbe13CQChg8zs
 7S0xS4KmsDfx1bN2D2+lcwGdwjydGNfhO5qdErudJ4EI0FZBGgLY31IGVDqr9XbCebcUWuP1Z
 +bp3GDlIcDcFbRFDpVdoLxeK42g7IfjBRBGbJgntl8waJnvRTUzeOuXSNREGdaTaik8MoTP4v
 M0+Fpdy7o+1PIn/b5kMWq0daGn7Zh7SDWOGpzXoAsJW5zqGd0I4vA3OxesakxvdCG2P6Zs1El
 EetUaDsPkPCXW9QC0T7g==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 21:55:12 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 19:45:09 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 25 Oct 2020 21:55:10 +0100
Cc: kernel-janitors@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Coccinelle=3A_null=3A_Optimise_disjunctions_in_?=
 =?utf-8?b?U21QTCBzY3JpcHQg4oCcZW5vLmNvY2Np4oCd?=
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

>> This analysis result indicates a clear ranking for such function calls.
>> Thus reorder the SmPL disjunction items according to their usage incidence.
>
> Did you actually test this before and after the change and see a
> difference in performance?

Would you become interested to configure a representative test environment
for safe comparisons of corresponding run time characteristics
of the affected software?


> On my laptop, I see absolutely no difference,
> for the patch mode and for the context mode.

Does such information trigger a desire to clarify involved aspects in more detail?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
