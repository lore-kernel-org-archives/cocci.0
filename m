Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A737AC433EF
	for <cocci@archiver.kernel.org>; Wed,  9 Mar 2022 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=PwB0ud7bhx15b4+l2pI2nXzt/2ax9JuVFzhuBxVf3BA=;
  b=SX54lR4s/0keaMoUhMcJZCRcBvPc9YEWl3yEC2PHcdN4lpwM2XK2NU2D
   17xNsDc3EezgRY1LwrBT/ZBne9/73YNS1uzaIB9zVvCr7Qw75IjPOrMll
   AyWaTB5KbOMZIvAoyd67kSCgYVra7twkkLsetW557F7DT06SI7/RidU7O
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="25328029"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2022 22:20:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D5555E0362; Wed,  9 Mar 2022 22:20:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7E833E004D
	for <cocci@sympa.inria.fr>; Wed,  9 Mar 2022 22:20:21 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="8101613"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 22:20:21 +0100
Date: Wed, 9 Mar 2022 22:20:20 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <a32a6aea-bc17-2e56-947a-99325ab91265@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203092218430.35182@hadrien>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net> <alpine.DEB.2.22.394.2203090654100.4094@hadrien> <a32a6aea-bc17-2e56-947a-99325ab91265@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 198
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203092218430.35182%40hadrien>



On Wed, 9 Mar 2022, Eric Wheeler wrote:

> > Regex groups are not supported.  You can use python to do whatever you
> > want with the matched terms.  See demos/pythontococci.cocci
>
> Thanks Julia.  It seems the Coccinelle =~ matches do not support escaping.
> I was getting errors trying to match like so:
>
> expression E =~ "\.gplot";
>
> It works without the \ but errors with the .
> 	File "cocci/untitled-fix.cocci", line 5, column 35, charpos = 144
> 	  around = '\.',
> 	  whole content = expression EXT, arg, E =~ "untitled\.(.*)";
>
> It failed scaping \" as well but now I'm unable to reproduce the problem.
> Sounds like python is the way to go, built-in regex's are useful and might
> need a bit of cleanup.

I would imagine that you need to put "\\.gplot"

I would imagine that escaping is trivial to addres.  I have no idea what
one would even want from grouping.  That is, what notation do you expect
to use to refer to the groups.  And which group, if there are multiple
metavariables that use regular expressions?

julia

>
> +1 for group and escaping support if it might be a trivial patch.
>
>
> --
> Eric Wheeler
>
> On Wed, 9 Mar 2022, Julia Lawall wrote:
>
>
> >
> > julia
> >
> > On Tue, 8 Mar 2022, Eric Wheeler wrote:
> >
> > > Hi all,
> > >
> > > I would like to replace this:
> > >
> > > 	void on_struct_save_as_gnuplot_activate(
> > > 	    GtkMenuItem     *menuitem,
> > > 	    gpointer         user_data)
> > > 	{
> > > 	  file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
> > > 	      "*.gplot", NULL, "untitled.gplot", rc_config.working_dir );
> > > 	}
> > >
> > > And extract the extension ".gplot" as an identifier and pass it to the
> > > function get_nec_filename_stem, like so:
> > >
> > > 	void on_struct_save_as_gnuplot_activate(
> > > 	    GtkMenuItem     *menuitem,
> > > 	    gpointer         user_data)
> > > 	{
> > > 	  file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
> > > 	      "*.gplot", NULL, get_nec_filename_stem(newfn, ".gplot", PATH_MAX), rc_config.working_dir );
> > > 	}
> > >
> > > The SmPL patch below works for what I want statically, but notice the
> > > commented `expression E`:
> > >
> > > Is there a way to regex-group `expression E =~` with a parenthesis and then specify
> > > something like E[0] to pick up the grouped regex match?
> > >
> > > 	@ replace_untitled @
> > > 	identifier F;
> > > 	parameter list PL;
> > > 	expression list EL1, EL2;
> > > 	//expression E =~ "\"untitled\.(.*)\"";
> > > 	@@
> > >
> > > 	F(PL)
> > > 	{
> > > 	+   char newfn[PATH_MAX];
> > > 	    ...
> > > 	    file_chooser = Open_Filechooser(EL1,
> > > 	-       "untitled.gplot",
> > > 	+       get_nec_filename_stem(newfn, ".gplot", PATH_MAX),
> > > 		EL2);
> > > 	    ...
> > > 	}
> > >
> > >
> > > This doesn't work, but it explains what I'm trying to do:
> > >
> > > 	@ replace_untitled @
> > > 	identifier F;
> > > 	parameter list PL;
> > > 	expression list EL1, EL2;
> > > 	expression E =~ "untitled.(.*)";
> > > 	@@
> > >
> > > 	F(PL)
> > > 	{
> > > 	+   char newfn[PATH_MAX];
> > > 	    ...
> > > 	    file_chooser = Open_Filechooser(EL1,
> > > 	-       E,
> > > 	+       get_nec_filename_stem(newfn, E[0], PATH_MAX),
> > > 		EL2);
> > > 	    ...
> > > 	}
> > >
> > > It replaces as follows and does match "untitled.(.*)", but of course [0] is incorrect SmPL grammar:
> > >
> > > 	@@ -250,10 +253,13 @@ on_struct_save_as_gnuplot_activate(
> > > 	     GtkMenuItem     *menuitem,
> > > 	     gpointer         user_data)
> > > 	 {
> > > 	+  char newfn[PATH_MAX];
> > > 	   /* Open file chooser to save structure image */
> > > 	   SetFlag( STRUCT_GNUPLOT_SAVE );
> > > 	   file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
> > > 	-      "*.gplot", NULL, "untitled.gplot", rc_config.working_dir );
> > > 	+      "*.gplot", NULL,
> > > 	+      get_nec_filename_stem(newfn, "untitled.gplot"[0], PATH_MAX),
> > > 	+      rc_config.working_dir );
> > > 	 }
> > >
> > > I tried something like this:
> > > 	expression F =~ "\..*";
> > > 	expression E =~ "untitled" ##F;
> > > but that is invalid too.
> > >
> > > Ideas?
> > >
> > >
> > > --
> > > Eric Wheeler
> > >
> >
>
