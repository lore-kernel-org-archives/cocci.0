Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E3EC433EF
	for <cocci@archiver.kernel.org>; Wed, 23 Feb 2022 08:16:52 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,390,1635199200"; 
   d="scan'208";a="22777702"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Feb 2022 09:16:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 38F63E0358; Wed, 23 Feb 2022 09:16:50 +0100 (CET)
Received: from mail3-smtp-sop.national.inria.fr (mail3-smtp-sop.national.inria.fr [192.134.164.98])
	by sympa.inria.fr (Postfix) with ESMTPS id 2FA76E00A8
	for <cocci@sympa.inria.fr>; Wed, 23 Feb 2022 09:16:46 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.88,390,1635199200"; 
   d="scan'208";a="6724363"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 09:16:46 +0100
Date: Wed, 23 Feb 2022 09:16:45 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Morgan Green <morgangreen@hotmail.com>
cc: "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <DS7PR19MB5853BC1DDFC7F8D92CF26115AC3C9@DS7PR19MB5853.namprd19.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2202230914490.2977@hadrien>
References: <DS7PR19MB5853BC1DDFC7F8D92CF26115AC3C9@DS7PR19MB5853.namprd19.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch 1.1.1 hang
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 147
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/alpine.DEB.2.22.394.2202230914490.2977%40hadrien>



On Wed, 23 Feb 2022, Morgan Green wrote:

> In a message earlier today about C++ support I mentioned an unrelated spatch hang. I've now figured out how to reproduce it with a simple C test case:
>
> spatch --sp-file test.cocci test.c
>
> ---- test.cocci
> @@ @@
> {
> ...
> - if(1) {
> + {
> ...
> return ...;
> }
> - ...
> }
> ---- test.c
> void foo() {
>     if(1) {
>         return;
>     }
>
>     while(loop_test) {
>         if(junk) continue;
>     }
> }
> ----
>
> It seems to reproduce whenever there is a loop that contains a continue statement after an if(1) { return; }.

I suspect that the if(1) { return; } doesn't cause the loop.  It just
causes the function to be considered at all, because it is in your
pattern.  Thanks for the report.  I'll take a look.

julia
