Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3F0C433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Feb 2022 06:57:02 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="19984903"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2022 07:57:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E409BE037F; Mon,  7 Feb 2022 07:57:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 443C9E037F
	for <cocci@sympa.inria.fr>; Mon,  7 Feb 2022 07:56:59 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="5174772"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 07:57:00 +0100
Date: Mon, 7 Feb 2022 07:56:58 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
cc: cocci@inria.fr
In-Reply-To: <efdc5e18-fdc4-56d6-f78e-0e47fe24ef02@linux.com>
Message-ID: <alpine.DEB.2.22.394.2202070752260.3105@hadrien>
References: <cd9a37f0-9a90-1df5-cec7-853a783e5538@linux.com> <alpine.DEB.2.22.394.2202061941500.3126@hadrien> <f07ed61b-96e5-d99f-dc0f-d3f39b8291bf@linux.com> <alpine.DEB.2.22.394.2202062047220.3126@hadrien> <412f6138-c5de-38f4-553b-6b34a0650005@linux.com>
 <alpine.DEB.2.22.394.2202062158390.3126@hadrien> <efdc5e18-fdc4-56d6-f78e-0e47fe24ef02@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 131
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/alpine.DEB.2.22.394.2202070752260.3105%40hadrien>

> I checked that the problem persist on latest commit
> b2a4b9b77157 parsing_c: print correct attributes in pretty_print_c.ml
>
> and bisected the crash to commit
> 7b79a2415a8c6e8b1c39a8183bf732fdc6d00453 is the first bad commit
> commit 7b79a2415a8c6e8b1c39a8183bf732fdc6d00453
> Author: Corentin De Souza <corentin.de-souza@inria.fr>
> Date:   Tue May 25 19:21:51 2021 +0200
>
>     parsing_c: detect macro iterators from their bodies
>
>     This uses the same strategy as macro statements (see
>     https://gitlab.inria.fr/coccinelle/coccinelle/-/merge_requests/92).
>     The goal is to do fix https://gitlab.inria.fr/coccinelle/coccinelle/-/issues/24
>
>     The next commit will finally fix the assign_expr rule in the parser, removing
>     the conflicts it introduced while not breaking test
>     assign_deref_funcall_in_macro_it.
>
>  parsing_c/cpp_token_c.ml | 39 ++++++++++++++++++++++++++++++---------
>  parsing_c/parser_c.mly   |  3 ++-
>  2 files changed, 32 insertions(+), 10 deletions(-)

Thanks for all of the investigation.  I'll take a look at this commit, but
from the subject it seems hard to imagine how it would affect python...

Could you take a look at the core to see if indicates what function caused
the problem?

Do you have parmap installed on your machine or are you using the bundled
version?

Could use test with the bytecode version of Coccinelle?  I think that
would come without the --enable-opt option.

thanks,
julia

>
> I removed the @p variable and reduced the cocci file to
> @err@
> @@
>
> amd_energy_is_visible(...)
> {
> *       return 0444;
> }
>
> @script:python@
> @@
>
> and it still crashes.
> $ mkdir empty_dir
> $ spatch segfault.cocci empty_dir
> init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
> no inferred keywords
> [2]    240209 segmentation fault (core dumped)  spatch segfault.cocci empty_dir
>
> $ touch empty_dir/file
> $ spatch segfault.cocci empty_dir
> init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
> no inferred keywords
> [2]    240269 segmentation fault (core dumped)  spatch segfault.cocci empty_dir
>
> $ echo "void amd_energy_is_visible(void) { return 0444; }" > empty_dir/file
> $ spatch segfault.cocci empty_dir
> init_defs_builtins: /home/work/.opam/4.11.2/lib/coccinelle/standard.h
> no inferred keywords
> [2]    240363 segmentation fault (core dumped)  spatch segfault.cocci empty_dir
>
> Regards,
> Denis
>
