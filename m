Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A47C433F5
	for <cocci@archiver.kernel.org>; Wed,  2 Mar 2022 07:21:47 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,148,1643670000"; 
   d="scan'208";a="23927232"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2022 08:21:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6203FE00D9; Wed,  2 Mar 2022 08:21:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CA539E00BA
	for <cocci@sympa.inria.fr>; Wed,  2 Mar 2022 08:21:40 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.90,148,1643670000"; 
   d="scan'208";a="7353792"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 08:21:40 +0100
Date: Wed, 2 Mar 2022 08:21:40 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <9225d1eb-8211-53d7-9cec-bdbda52f743b@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203020820050.3162@hadrien>
References: <9225d1eb-8211-53d7-9cec-bdbda52f743b@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How can I find all static variable declarations?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 163
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203020820050.3162%40hadrien>



On Tue, 1 Mar 2022, Eric Wheeler wrote:

> Hello,
>
> I'm trying to find all static variable declarations (either global or
> within a function:
>
> 	static int global_x, y, z;
>
> 	void foo()
> 	{
> 		static int a, b, c;
> 	}
>
> with a patch like this:
>
> 	@ rule1 @
> 	identifier I;
> 	type T;
> 	@@
> 	static T I;
> 	+ // static ^^
>
> It gets single variable declarations:
> 	   static gint iv[4];
> 	+  // static ^^
>
> but not multiple variable declarations like the foo() example above
> because 'I' only matches a single variable in the rule.
>
> It also matches functions, but I really only want variables (if possible):
> 	 static void subph( int nx, int ny );
> 	+// static ^^
>
> I tried an identfier list:
> 	@ rule1 @
> 	identifier list IL;
> 	type T;
> 	@@
> 	static T IL;
> 	+ // static ^^
>
> but gives the error:
>
> 	init_defs_builtins: /usr/lib64/coccinelle/standard.h
> 	minus: parse error:
> 	  File "nec-static.cocci", line 5, column 9, charpos = 50
> 	  around = 'IL',
> 	  whole content = static T IL;
>
> What is the right way to do this?

What you tried should have worked.  And it should not have matched
function definitions.  I will check on it.

>
> I'm just printing the diffs so I can inspect the code, sort of using
> `spatch` like a semantic grep.  Is there an official way to do "semantic
> greps"?

Use * instead of - or + for the things you are interested in.  You will
still get a diff, but the - lines are the ones that match what you wanted
to see.

julia
