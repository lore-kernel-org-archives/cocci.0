Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA8DC433EF
	for <cocci@archiver.kernel.org>; Sun,  6 Mar 2022 14:02:01 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,159,1643670000"; 
   d="scan'208";a="24627562"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2022 15:01:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B6AC0E00D9; Sun,  6 Mar 2022 15:01:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 596AEE004B
	for <cocci@sympa.inria.fr>; Sun,  6 Mar 2022 15:01:52 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.90,159,1643670000"; 
   d="scan'208";a="7732398"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 15:01:53 +0100
Date: Sun, 6 Mar 2022 15:01:51 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
In-Reply-To: <f6b687d9-a87b-52a4-ed47-76d83c969f99@web.de>
Message-ID: <alpine.DEB.2.22.394.2203061501350.3079@hadrien>
References: <15f59e89-64e8-ba91-d71b-322e6905763@ewheeler.net> <alpine.DEB.2.22.394.2203052240451.3180@hadrien> <f6b687d9-a87b-52a4-ed47-76d83c969f99@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1758438845-1646575312=:3079"
Subject: Re: [cocci] How do you add a function argument when an identifier
 exists in the function?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 169
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203061501350.3079%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1758438845-1646575312=:3079
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 6 Mar 2022, Markus Elfring wrote:

>
> > You can do the following:
> >
> >         T F(
> >         -PL
> >         +nec_t *nec, PL
> >          )
> >         {
> >         ... when exists
> >             when any
> >         nec->j
> >         ... when exists
> >             when any
> >         }
> >
> > The when exists requires that only (ie at least) one path have the
> > property and the when allows other occurrences of nec->j
>
>
> How do you think about to work with the following SmPL script variant?
>
>
> @add_first_function_argument@
> type rt;
> identifier func, member;
> typedef td;
> parameter list pl;
> @@
>  rt func(
> +        td* nec,
>          pl
>         )
>  {
>  ... when exists
>      when any
>  nec->member
>  ... when exists
>      when any
>  }
>
>
> Would you eventually like to use another SmPL ellipsis instead of the
> explicit specification
> for the parameter list variable?

This should also work.

julia
--8323329-1758438845-1646575312=:3079--
