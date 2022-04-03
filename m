Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C68C433EF
	for <cocci@archiver.kernel.org>; Sun,  3 Apr 2022 16:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=f4amluIFrlGxxOXuQP2lgpEamNUaVxV75Dyx54/yhzM=;
  b=FaUWzPTYbejmwwNXHQUZ+xWzBs72OuIfRpUnGcvjWELg77oHti6hsbOu
   UojVsL99E1j8RhPvJays1nGuQyjvaPmELiDJ+SrCkkNKwv5bOIPTp0hzw
   gt+Tp7A9oDk8N2DYtyl17glzEHdOFkDpNgQXfirpGCRG0Jbn1DPlJh3St
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29754398"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 18:27:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9D58AE0297; Sun,  3 Apr 2022 18:27:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 381A8E00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 18:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f4amluIFrlGxxOXuQP2lgpEamNUaVxV75Dyx54/yhzM=;
  b=nvBlzDVKl9ME5KBSO/uzXw54SSqjfxvZC436LJ14c6Lg4Q/5STv7njg1
   +R9h5H4WgyMu086jvs2nflCP/Qiuvpvia0OA/yDHdm+zEa2Cx0ruoP89y
   LlBBs368AlYBlQE77VOoxZXwpYfjbDfXJZh/mHIFdxOuAv38EBALrf1qy
   s=;
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="10414589"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 18:27:42 +0200
Date: Sun, 3 Apr 2022 18:27:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
In-Reply-To: <220403.86bkxikuwy.gmgdl@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204031823000.3114@hadrien>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <220403.86bkxikuwy.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1172631434-1649003261=:3114"
Subject: Re: [cocci] using gcc & clang -MF to reduce spatch work (was: Using
 `parallel` [...])
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 350
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/alpine.DEB.2.22.394.2204031823000.3114%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1172631434-1649003261=:3114
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Sun, 3 Apr 2022, Ævar Arnfjörð Bjarmason wrote:

>
> On Sat, Mar 19 2022, Eric Wheeler wrote:
>
> > Hi All,
> >
> > Just a quick tip for others (like me) who are new to Coccinelle:
> >
> > You might already use this, but if not, here's a hint for doing lots of
> > replacements in parallel:
> >
> > 	parallel -j24 spatch --sp-file smpl.cocci {} --in-place ::: *.c
> >
> > If the SmPL depends on interactions between files then `parallel` won't
> > work, but if the changes work per-file then it runs much faster with lots
> > of big .c files.
> >
> > In cases where you do need to run over lots of files and they _do_
> > interact, you might get a Stack Overflow error.  In this case set
> > something like this for 1GB of stack space:
> > 	ulimit -s $((1024*1024))
> >
> > In my case spatch needed 1GB of stack and 2.4GB of RAM.  It took a few
> > minutes and finished thousands of replacements!
> >
> > Julia, you might add this to documentation if you think it would be
> > useful.
>
> To change the $subject to an alternate approach that may work for you,
> and that I've been experimenting with.
>
> If you use GCC or Clang to compile your C code you can use the -MF
> option to emit a dependency tree for your *.c files, i.e. your compiler
> is already doing all the work that spatch needs to re-do to find
> includes.
>
> But more importantly, if you have 100 files and change a *.h only used
> by 10 of them, you'll only need to invoke spatch on those 10 files.
>
> I had a question related to this here on-list in
> <211116.86h7ccox6b.gmgdl@evledraar.gmail.com>, i.e. you can use
> --no-includes and instead feed the list of files to be included to
> spatch. If those files come from your dependencies made with -MF you
> migth be able to assume they're correct.
>
> Well, not if your *.o file is newer than your *.c, as it might have
> grown new includes, but in this sub-example you'd make your *.c.cocci-ok
> (or whatever) generation depend on the corresponding *.o, or would
> otherwise compile first (which is much, much faster than spatch,
> especially with ccache).
>
> I don't have any stand-alone example for use, sorry, but basically in
> make syntax something like:
>
> 	# get dependencies from our last compilation
> 	-inlude $(wildcard *.mak)
> 	# next compilation
> 	%.o: %.c
> 		$(CC) ... -MF $@.mak -MT $@ -MT $@.cocci-ok $<
> 	%.o.cocci-ok: %.o
> 		spatch ...
>
> I just typed that up now, and there's sure to be syntax errors etc, but
> I think you get the idea, i.e. you'll save yourself spatch work by
> bootstrapping from your C compilation.
>
> Also note that you don't need to run GNU make, if you build with
> something else you can (with a tiny bit of munging) change the make
> syntax it emits to just a list of files to depend on (the easiest way to
> parse it being to invoke a make one-liner to spew it out for you).
>
> I think it would be really useful if spatch could spew out the list of
> headers it understood from a given file.

Maybe the --verbose-includes option will help.

There is also the option --use-patch-diff that will check only the
uncommitted changes in a given directory.

julia

>
> Depending on your compilation (e.g. ifdefs) the two may not 1=1 map, but
> you could also do this CC trick in reverse, i.e. if you ran spatch first
> you could feed the resulting dependency graph from spatch to your C
> compiler.
>
> In pracice I haven't found reason to worry about that lack of 1=1
> mapping.
>
--8323329-1172631434-1649003261=:3114--
