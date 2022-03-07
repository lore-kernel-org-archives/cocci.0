Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55C1C433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Mar 2022 20:48:38 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24872504"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 21:48:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 034DDE00D3; Mon,  7 Mar 2022 21:48:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B8413E00BB
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 21:48:31 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="7863675"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:48:32 +0100
Date: Mon, 7 Mar 2022 21:48:31 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <ed1d7d30-461-8822-7fd2-e1701534c29b@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203072147580.3091@hadrien>
References: <ed1d7d30-461-8822-7fd2-e1701534c29b@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Does SmPL for functions with prototype disjunctions
 need to be complete?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 181
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203072147580.3091%40hadrien>



On Sun, 6 Mar 2022, Eric Wheeler wrote:

> This seems to work when the body of the funciton is defined in each disjunction:
>
> 	@ prefix_nec_arg @
> 	type T;
> 	identifier F, j;
> 	typedef nec_t;
> 	parameter list PL;
> 	@@
> 	(
> 	T F(
> 	-void
> 	+nec_t *nec
> 	 )
> 	{
> 	... when exists
> 	    when any
> 	nec->j
> 	... when exists
> 	    when any
> 	}
> 	|
> 	T F(
> 	+nec_t *nec
> 	 )
> 	{
> 	... when exists
> 	    when any
> 	nec->j
> 	... when exists
> 	    when any
> 	}
> 	|
> 	T F(
> 	+nec_t *nec,
> 	PL
> 	 )
> 	{
> 	... when exists
> 	    when any
> 	nec->j
> 	... when exists
> 	    when any
> 	}
> 	)
>
> But placing the function body after the disjunction block did not, even
> though it is easier to read and does not duplicate content:
>
> 	@ prefix_nec_arg @
> 	type T;
> 	identifier F, j;
> 	typedef nec_t;
> 	parameter list PL;
> 	@@
> 	(
> 	T F(
> 	-void
> 	+nec_t *nec
> 	 )
> 	|
> 	T F(
> 	+nec_t *nec
> 	 )
> 	|
> 	T F(
> 	+nec_t *nec,
> 	PL
> 	 )
> 	)
> 	{
> 	... when exists
> 	    when any
> 	nec->j
> 	... when exists
> 	    when any
> 	}
>
> Is that expected?
>
> It means there must be a longer SmPL, which is ok, but for my own
> curiosity: is there a shorter form?

It might be possible to put a disjunction around only the parameter list,
ie inside the parentheses.

julia
