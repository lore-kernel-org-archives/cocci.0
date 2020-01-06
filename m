Return-Path: <SRS0=FPmR=23=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBB4C33C8C
	for <cocci@archiver.kernel.org>; Mon,  6 Jan 2020 12:07:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118802072E
	for <cocci@archiver.kernel.org>; Mon,  6 Jan 2020 12:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TQ2HWmYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118802072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 006C7DLA016700;
	Mon, 6 Jan 2020 13:07:13 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B21F577DB;
	Mon,  6 Jan 2020 13:07:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9A4967718
 for <cocci@systeme.lip6.fr>; Mon,  6 Jan 2020 13:07:11 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 006C7BLC025135
 for <cocci@systeme.lip6.fr>; Mon, 6 Jan 2020 13:07:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1578312429;
 bh=Bfyf3Fg2fzRQJSxqfxXGNlnyHr2Z4EkOikN/L3kfBRg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=TQ2HWmYdJEuwDe/wzflK9U4LXyqM3pBNTi0z6KAJe4lvSrHuo8do95hl+JfdEqHuQ
 hSoywGa0VLA+cSfWTty3MlpVUKAB2WtXGwGV9Su987OXFJneQEmgx45t4Hp+YXnvYm
 vJwgqB+GHNkG2dfdwSVfjSfV525DULigO8cHGjaE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.154.111]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lm9T7-1jNUvk2PPV-00ZjEc; Mon, 06
 Jan 2020 13:07:09 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <20200103160304.GG17258@pobox.com>
 <08d3a32e-7adc-ff5b-52d0-9e67ed03ae42@web.de>
 <alpine.DEB.2.21.2001051100550.2579@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7ddf003e-956c-b146-55f5-7a68f263d5c8@web.de>
Date: Mon, 6 Jan 2020 13:07:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001051100550.2579@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:xPizyaAWBbXCOGV50WfGXa3q8nyl88fpVEaYokj7XUmsFNyTj70
 AFTYPKj9uz/i8GSMI+1xxi5LB5Ix9DPLnb/plRjSFMtAWWah8AMqAsrYLz4+h3okFPzA9FL
 LEcb6MRHBv2SWpbbezlwTenA6RIxBoVsE2khLu0DUXd9MQc1VqCwAfmZyK70JgB7VpW3WRj
 MZQG38XgorL2wqB8k+EVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2vOnBT4KMkU=:4T43A12WpMjoS4LHbPKXSX
 fMASlwchsrBrHB0ikOZTjQmkxTBujRTvl+HG3rVsf5hsV6WCxTROsRTKI0aNFCH0pLKbWMqo1
 /1amWyaetSzCR5MKVgZvgWvEkduPrDvR7cpfbR4EenbSqGrEBpJ2jHoW47rvlo3OdlDtTb2jL
 +pe6A2MyLlbpKXqMhvOLmpy76cdJc7p3ZIIcXl4GPbe9VIe2kkH33jmat3EsjpNKqbFHlaINE
 GdO6neqYR3meAbzQAKY/BdA1E1n3DPT3PzlyVBhlxczAvxqqhyRAUw0V/jlCYgmzaVC91mUMy
 6SBIGH3MFSJ2zYTuFEv5qVhhmN4QM5PWFweUwI9to42T9JGMwFiY+KRJR5JhKVKAIktiSXF2w
 vM1UDah7SoSwGhdwKioGbY/w0S+Uyu6uO+iwpIUmOlFpa2sCKTBL/RQXlzVFhtsMRFbE8Uazu
 U79gh2yB+pZnp94UHTL/KHxqS8DrGJK9nFbBQCcsoNRNj3FlFVvpiA0hqCeGNUVlhXl3gPOTF
 AdVe83VXl3I/5gPxSza3bWRpCcsxQgsYqHOmUG67QO0fR+elTEBtNb0yuaksfWPnGJ8QvxuBP
 dVAnu5O++oJYNa72GIr7z/a8eX8C53I0XUT9N2ZRo3KNG0u28Tq8Sz2FgHUpNvc/t0wW3cc0m
 kRlbzVz7G32w2ux6PTT5av4t/QnhYohqbzcfaERfLZ5W/LLDsT/8Mjr5wzbhlBeJPoXiMzr9u
 47s9Th2GcI3mJQk8kPTkCMvrdMYa8TipZmc5xq+3k+fUeLc6/ZBT/5uEJLnjpWDEhSIP5LO+V
 Q9HHJuRIO82z6EoiE5eX+wh6gSIueMV2Ur0QLw8MK6H1eHDfF9JKaS9wuSTlKtres1AhVIDZY
 LZPbEWVtrnQV7+p/VZBlOZqcnnClEEZdMwHaDlbQjzunf3Ciu+yRkmb0HD9XYT+BG5XwZBzYk
 g00ahyMmWP/trMLbMNu6GHz3awmbeHmVx1NdETvRQZ5luKjzQ+qv03cHWVU7GGcZ+TVFcyWc6
 qFNP0Bj7D1KqBDPghx/6gGWwgDwB+CfDrEXd61F+D/BLtdHNxNEBQNxl9nD7WZ6uJaTnkl8wn
 cKPQeRjzrNxENeskc5IC+q75L6q6rZj2vgkH7lDBOaFHYX94MZIIc1pohsTv5MFa31BOWgQd+
 AulLAlWqqEqJnq5gUPNXTr/PrFZd90OqZ6ycdenpd4YcxKP5S2+926Qxznl78K3NxjyT36NPE
 K+IJ6MxOiokKn9MpXAQJ+CYmIGZbUsbVNZHK+y8rijLO/dqh4AGjESEMwMWU=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 06 Jan 2020 13:07:14 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 06 Jan 2020 13:07:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Adding semicolons after macro calls
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

> The only short term suggestion I have is the following:

I wonder about the specification of two statement variables here.


Under which circumstances can a transformation approach (like the following)
work as desired?

@addition@
identifier action;
statement s;
@@
 <+...
 action(...)
+;
 s
 ...+>

elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch --parse-cocci add_semicolon_behind_call1.cocci
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
minus: parse error:
  File "add_semicolon_behind_call1.cocci", line 8, column 1, charpos = 70
  around = 's',
  whole content =  s


How will further improvements be achieved for data processing around macro calls?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
