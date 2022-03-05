Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E595C433F5
	for <cocci@archiver.kernel.org>; Sat,  5 Mar 2022 21:47:20 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,158,1643670000"; 
   d="scan'208";a="24580520"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Mar 2022 22:47:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1BA98E00CB; Sat,  5 Mar 2022 22:47:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A8BA0E004B
	for <cocci@sympa.inria.fr>; Sat,  5 Mar 2022 22:47:13 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.90,158,1643670000"; 
   d="scan'208";a="24580519"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2022 22:47:13 +0100
Date: Sat, 5 Mar 2022 22:47:13 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <15f59e89-64e8-ba91-d71b-322e6905763@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203052240451.3180@hadrien>
References: <15f59e89-64e8-ba91-d71b-322e6905763@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How do you add a function argument when an identifier
 exists in the function?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 167
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203052240451.3180%40hadrien>



On Sat, 5 Mar 2022, Eric Wheeler wrote:

> Hello,
>
> I'm trying to convert an existing global typedef struct to be the first
> function parameter whenever it is used so we can move away from global
> varaiables and make the code more flexible and thread-safe.
>
> If I have functions like this:
>
> 	void f(int i) {
> 		nec->x = i;
> 	}
>
> 	int g(int i) {
> 		return i+1;
> 	}
>
> Then I want to prepend an argument only if the existing global
> `nec_t *nec` is used in the function.  Thus `g` is unmodified and `f`
> would become:
>
> 	void f(nec_t *nec, int i) {
> 		nec->x = i;
> 	}
>
> This is the patch I'm trying and it doesn't seem to be matching nec->j:
> 	@ rule1 @
> 	type T;
> 	identifier F, j;
> 	typedef nec_t;
> 	parameter list PL;
> 	@@
>
> 	T F(
> 	-PL
> 	+nec_t *nec, PL
> 	 )
> 	{
> 	...
> 	nec->j
> 	...
> 	}

This doesn't work because it requires that nec->j appears exactly once (ie
not in the part matched by ...) along every control-flow path of the
function.  You can do the following:

       T F(
       -PL
       +nec_t *nec, PL
        )
       {
       ... when exists
           when any
       nec->j
       ... when exists
           when any
       }

The when exists requires that only (ie at least) one path have the
property and the when allows other occurrences of nec->j

julia

>
> If I remove `nec->j` from the patch so it is just this:
> 	T F(
> 	-PL
> 	+nec_t *nec, PL
> 	 )
> 	{
> 	...
> 	}
>
> then the parameter list is correctly modified (in all functions), but how
> do I properly check and only add the parameter when `nec` is used in the
> function?
>
> A couple notes:
>     *  `nec` is currently global, it is already used in the function.
>        I'm trying to change it to a parameter so I can drop the globals.
>
>     * The acutal use of `nec` can be quite complex.  For example:
>         curd= CCJ * v/(( log(2.0 * nec->dataj.s/ nec->data.bi[is])-1.0)) ...
>       so we want to match if `nec` is used in any form.
>
> Thanks for your help!
>
>
> --
> Eric Wheeler
>
