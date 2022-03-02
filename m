Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82600C433EF
	for <cocci@archiver.kernel.org>; Wed,  2 Mar 2022 07:28:54 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,148,1643670000"; 
   d="scan'208";a="23928252"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2022 08:28:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A83A6E00D3; Wed,  2 Mar 2022 08:28:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 12B97E00BA
	for <cocci@sympa.inria.fr>; Wed,  2 Mar 2022 08:28:49 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.90,148,1643670000"; 
   d="scan'208";a="23928233"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 08:28:49 +0100
Date: Wed, 2 Mar 2022 08:28:48 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <5d406855-8b98-e621-b972-b7953a49f049@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203020828170.3162@hadrien>
References: <b6b8a7b6-1472-a6f0-1336-95d53ee82bd@ewheeler.net> <alpine.DEB.2.22.394.2202280705080.3112@hadrien> <9b8e4283-90ff-2299-2a5e-ca12e65fe3fc@ewheeler.net> <ff76e0b6-d7cd-de3a-ec2d-b1b1492e2e69@ewheeler.net> <alpine.DEB.2.22.394.2203010710230.3160@hadrien>
 <5d406855-8b98-e621-b972-b7953a49f049@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can you match identifiers of a specific type?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 164
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203020828170.3162%40hadrien>



On Tue, 1 Mar 2022, Eric Wheeler wrote:

> On Tue, 1 Mar 2022, Julia Lawall wrote:
> > On Mon, 28 Feb 2022, Eric Wheeler wrote:
> > > On Mon, 28 Feb 2022, Eric Wheeler wrote:
> > > > On Mon, 28 Feb 2022, Julia Lawall wrote:
> > > > > On Sun, 27 Feb 2022, Eric Wheeler wrote:
> > > > >
> > > > > > Hello,
> > > > > >
> > > > > > Can I match only specific identifier types and names where the type is a
> > > > > > typedef? I've been reading as much as I can about Coccinelle but I've not
> > > > > > found a way to do it.
> > > > > >
> > > > > > I'm trying to move global calculation structures into its own typedef
> > > > > > structure to create a thread-safe environment where multiple threads can
> > > > > > work on different struct instances.  Right now the code works only on
> > > > > > static global values so parallelism is not possible without fork()ing.
> > > > > > (This is for the www.xnec2c.org project.)
> > > > > >
> > > > > > The code that looks pretty close to the following:
> > > > > >
> > > > > > 	// Globals
> > > > > > 	typedef struct {
> > > > > > 		int a;
> > > > > > 	} data_t
> > > > > >
> > > > > > 	data_t data;
> > > > > >
> > > > > > 	void f(char *data)
> > > > > > 	{
> > > > > > 		data[0] = 0; // parameter
> > > > > > 	}
> > > > > >
> > > > > > 	void g()
> > > > > > 	{
> > > > > > 		data.a = 0; // global
> > > > > > 	}
> > > > > >
> > > > > > I want to put all of the global 'data' variables of type 'data_t' into a
> > > > > > new structure as follows:
> > > > > >
> > > > > > 	typedef struct {
> > > > > > 		data_t data;
> > > > > > 		// and many others...
> > > > > > 	} nec_t;
> > > > > >
> > > > > > 	nec_t *nec;
> > > > > >
> > > > > > and replace the functions above as:
> > > > > >
> > > > > > 	void f(char *data)
> > > > > > 	{
> > > > > > 		data[0] = 0; // Does NOT change
> > > > > > 	}
> > > > > >
> > > > > > 	void g()
> > > > > > 	{
> > > > > > 		nec->data.a = 0; // This DOES change
> > > > > > 	}
> > > > > >
> > > > > > With a rule something like this:
> > > > > >
> > > > > > 	@ rule1 @
> > > > > > 	typedef data_t;
> > > > > > 	type T = {data_t};
> > > > > > 	identifier I = {data};
> > > > >
> > > > > This means that your variable I should always be called "data".  Is that
> > > > > what you intended?
> > > > >
> > > > > You should be able to do
> > > > >
> > > > > idexpression data_t I = {data};
> > > > >
> > > > > Then you want to use the name in a structure field.  Te problem is that a
> > > > > structure field is not an expression, it is an identifier.  So you have to
> > > > > make the match in two ways:
> > > > >
> > > > > @@
> > > > > idexpression data_t I = {data};
> > > > > identifier j;
> > > > > @@
> > > > >
> > > > > -I@j
> > > > > +nec->j
> > > >
> > > > Thanks Julia, that seems to work (I added `typedef data_t;` to the .cocci
> > > > file).
> > > >
> > >
> > >
> > > Ok so this worked in the simple example .c file:
> > > 	@ rule1 @
> > > 	typedef data_t;
> > > 	global idexpression data_t I = {data};
> > > 	identifier j;
> > > 	@@
> > > 	-I@j
> > > 	+nec->j
> > >
> > > But when I try it on the actual code base I get this:
> > > 	]# spatch --sp-file nec-refactor2.cocci src/xnec2c.c
> > > 	init_defs_builtins: /usr/local/coccinelle-git/bin/lib/coccinelle/standard.h
> > > 	(ONCE) Expected tokens data_t
> > > 	Skipping: src/xnec2c.c
> > >
> > > I have tried:
> > >   * adding `-I src/`
> > >   * adding `--include src/common.h --include src/shared.h` where data_t is defined.
> > >   * adding --include-headers-for-types
> > >   * adding --recursive-includes
> > >   * Removing the `global` specifier on the idexpression.
> > >
> > > None of these seem to work, they all skip with the "(ONCE) Expected tokens data_t" error.
> > >
> > > However, if I hack "data_t data;" into the top of xnec2c.c then it works.
> > >
> > > There seems to be a problem finding the `data_t data` definition through the headers.
> > >
> > > What should I do?  Here is the .c file if you want to take a look:
> >
> > I think that the file selection is done independent of includes.  A
> > solution is to just disable the file selection:
> >
> > --disable-worth-trying-opt
> >
> > You will still need the headers so that the type of data can be determined
> > and the matching can take place.  If the connection to the relevant file
> > is complex and involves lots of includes, then it is probably best to use
> > --include.
>
> --disable-worth-trying-opt option didn't seem to help, maybe I missed
> an include...but read on:

Thanks for the report. I will check on why it does not work.

julia

>
> > Another approach could be to just say global idexpression d = {data}.
> > If there is only one global variable called data in the entire system,
> > this should be fine.
>
> That worked!  I didn't realize idexpression can exclude the type.  All the
> variables I'm replacing are global and this time it didn't replace local
> versions of variables named "data".
>
> The EM simulation completed after variable replacement, so while I still
> need to validate that the output data is the same, I think this is
> working.
>
> Thanks again for your help!
>
> -Eric
>
> >
> > julia
> >
> >
> > > 	https://github.com/KJ7LNW/xnec2c/blob/master/src/xnec2c.c
> > >
> > > and the .h file with data_t:
> > > 	https://github.com/KJ7LNW/xnec2c/blob/master/src/shared.h#L219
> > >
> > > Here is the version:
> > >
> > > ]# spatch --version
> > > spatch version 1.1.1-00044-gb2a4b9b compiled with OCaml version 4.05.0
> > > Flags passed to the configure script: --prefix=/usr/local/coccinelle-git
> > > OCaml scripting support: yes
> > > Python scripting support: yes
> > > Syntax of regular expressions: PCRE
> > >
> > > > What does I@j mean?  Can you point me at documentation?
> > >
> > > -Eric
> > >
> >
>
