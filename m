Return-Path: <SRS0=cEHO=6O=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5064C47247
	for <cocci@archiver.kernel.org>; Thu, 30 Apr 2020 17:16:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525DE2082E
	for <cocci@archiver.kernel.org>; Thu, 30 Apr 2020 17:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525DE2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03UHGK6V015591;
	Thu, 30 Apr 2020 19:16:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AF6687816;
	Thu, 30 Apr 2020 19:16:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D1C727769
 for <cocci@systeme.lip6.fr>; Thu, 30 Apr 2020 19:16:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03UHGI0Q026085
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 30 Apr 2020 19:16:18 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,336,1583190000"; d="scan'208";a="447701483"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Apr 2020 19:16:18 +0200
Date: Thu, 30 Apr 2020 19:16:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3069d2ed-475d-d36f-526e-4b7a685577cb@web.de>
Message-ID: <alpine.DEB.2.21.2004301913110.13683@hadrien>
References: <3069d2ed-475d-d36f-526e-4b7a685577cb@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1354555777-1588266978=:13683"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 30 Apr 2020 19:16:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 30 Apr 2020 19:16:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking search results for two enumerations
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1354555777-1588266978=:13683
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 30 Apr 2020, Markus Elfring wrote:

> Hello,
>
> I have tried another tiny script out for the semantic patch language
> (according to the software combination “Coccinelle 1.0.8-00029-ga549b9f0”).
>
>
> @display@
> int i;
> @@
>  return
> *       -i
>  ;
>
>
> Are the following search results worth for further software development considerations?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/wireless/intersil/hostap/hostap_main.c
>
> elfring@Sonne:~/Projekte/Linux/next-patched> spatch ~/Projekte/Coccinelle/janitor/show_returns_of_negative_integers2.cocci drivers/net/wireless/intersil/hostap/hostap_main.c
> …
> @@ -328,7 +327,6 @@ int hostap_set_encryption(local_info_t *
>  	u16 val, old_val;
>  	int i, keylen, len, idx;
>  	char keybuf[WEP_KEY_LEN + 1];
> -	enum { NONE, WEP, OTHER } encrypt_type;
>
>  	idx = local->crypt_info.tx_keyidx;
>  	if (local->crypt_info.crypt[idx] == NULL ||
> …
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/sound/drivers/opl3/opl3_midi.c
>
> elfring@Sonne:~/Projekte/Linux/next-patched> spatch ~/Projekte/Coccinelle/janitor/show_returns_of_negative_integers2.cocci sound/drivers/opl3/opl3_midi.c
> …
> @@ -136,7 +136,6 @@ static int opl3_get_voice(struct snd_opl
>
>  	/* This is our "allocation cost" table */
>  	enum {
> -		FREE = 0, CHEAP, EXPENSIVE, END
>  	};
>
>  	/* Keeps track of what we are finding */
> …
>
>
> Why are source code places presented which do not contain a key word
> I was looking for this test approach?

I don't know.  With --debug you can see that there are only two matches.
So maybe it is a pretty printing problem.

julia
--8323329-1354555777-1588266978=:13683
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1354555777-1588266978=:13683--
