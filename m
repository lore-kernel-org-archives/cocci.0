Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF11EC433EF
	for <cocci@archiver.kernel.org>; Fri, 11 Mar 2022 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HOnMraGU1K+tmkH2MGHv9MmqxpiJ9f4Ngm2rTVEP3s0=;
  b=OusulvYCC5sTVUFJUD+Y2zYvrAcd+fXCIZSSW90aG4F58a0H/M/fSMtY
   GiFo9Gw0xHHB3m0rit5HVqDJjYaytE4exFWmEfRIkP3XTTgiD9w1AuEC3
   BphQjc+0zN3noq+3K7+LJrzuC4U65lq5iXYKnxrVYzhSq5soqVXxmLMtI
   0=;
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
X-IronPort-AV: E=Sophos;i="5.90,173,1643670000"; 
   d="scan'208";a="25653766"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2022 13:39:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0640EE02A3; Fri, 11 Mar 2022 13:39:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F32A7E0045
	for <cocci@sympa.inria.fr>; Fri, 11 Mar 2022 13:39:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HOnMraGU1K+tmkH2MGHv9MmqxpiJ9f4Ngm2rTVEP3s0=;
  b=VMh318j6WIXVZYGPM7H/rcJMvTrCjnzxmdbz9A+GjSFnEeDzAoVt0l4P
   uTY9mvukP4Q79etWUV7/nMQTdQW1dL9DSUa0dP5ffTpvigX4KSV6BTcgn
   T9JFrJ68rSjSvFOsnKfDsLEy2uQtAVTKttJMLf8L3qAiVvADTAhyU8Rm1
   8=;
X-IronPort-AV: E=Sophos;i="5.90,173,1643670000"; 
   d="scan'208";a="8284871"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 13:39:17 +0100
Date: Fri, 11 Mar 2022 13:39:16 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
In-Reply-To: <af50234b-f84c-72ed-df93-acc7bc41bb82@univ-grenoble-alpes.fr>
Message-ID: <alpine.DEB.2.22.394.2203111331520.3172@hadrien>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net> <alpine.DEB.2.22.394.2203090654100.4094@hadrien> <a32a6aea-bc17-2e56-947a-99325ab91265@ewheeler.net> <alpine.DEB.2.22.394.2203092218430.35182@hadrien> <ce6ae8a0-9976-4177-bce7-446d54bdc4f1@ewheeler.net>
 <trinity-819ef152-a230-487d-a730-fa70e5275ce3-1646903810019@3c-app-webde-bap20> <e683d80-5764-7550-d729-273e61b607c@ewheeler.net> <af50234b-f84c-72ed-df93-acc7bc41bb82@univ-grenoble-alpes.fr>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 205
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203111331520.3172%40hadrien>



On Fri, 11 Mar 2022, Nicolas Palix wrote:

> Hi,
>
> If there is not too much extensions, maybe you can enumerate them in the SmPL,
> or generate a SmPL script per-extension after a collecting phase.
>
>
> The Regexp are the ones from the Ocaml Str module, or PCRE according to the
> configuration.
> https://github.com/coccinelle/coccinelle/blob/master/globals/regexp_pcre.ml
>
> So, the group definition are legal for the matching, but maybe depends of the
> underlying Regexp used.
>
> Moreover, but because we have Python and OCaml escapes with more power to
> generate thing, using group seems hard to use from a SmPL syntax perspective.
>
> I like the C@1 notation to get the group, but how would you say
> to concatenate it with a prefix/suffix either static or variable (from another
> metavariable) ?
>
> As your example suggests, maybe keeping only the first group if any is defined
> in the + part would be great, and all the bind string otherwise.
>
> I retrieve the matching phase here
> https://github.com/coccinelle/coccinelle/blob/master/engine/cocci_vs_c.ml
>
> Julia, where can I find the + part that where the bind string
> is used ? Can we still have the Regexp at that point ?

The actual use of the + code is in parsing_c/unparse_cocci.ml.  For the
regexp to be available, it would have to be stored in the matavars_binding
type that is defined in parsing_c/ast_c.ml

References to grouping only makes sense in + code.

References to grouping would be ok for metavariables of type constant.
But they could lead to problems for other kinds of metavariables.  For
example, a expression metavariable could end up bound to something that is
not an expression.  So Coccinelle would have to reparse the extracted
string like one does in python or ocaml scripts (pythontococci.ml or
ocamltococci.ml).

julia

>
>
> On 10/03/2022 23:03, Eric Wheeler wrote:
> > On Thu, 10 Mar 2022, Markus Elfring wrote:
> > > > Anyway, my needs for this are already met with a combination of SmPL
> > > > cleverness and a bit of manual intervention,
> > >
> > > Would you like to share a bit more information about a (temporary)
> > > solution
> > > which you find good enough at the moment?
> >
> > This was the resulting diff from git after doing the complete refactor to
> > remove "untitled" from default filenames:
> >
> > 	@@ -991,6 +1019,7 @@ on_freqplots_save_as_activate(
> > 	     GtkMenuItem     *menuitem,
> > 	     gpointer         user_data)
> > 	 {
> > 	+  char newfn[PATH_MAX];
> > 	   saveas_drawingarea = freqplots_drawingarea;
> > 	   saveas_width  = freqplots_width;
> > 	   saveas_height = freqplots_height;
> > 	@@ -998,7 +1027,8 @@ on_freqplots_save_as_activate(
> > 	   /* Open file chooser to save frequency plots */
> > 	   SetFlag( IMAGE_SAVE );
> > 	   file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
> > 	-      "*.png", NULL, _("untitled.png"), rc_config.working_dir );
> > 	+      "*.png", NULL, get_nec_filename_stem(newfn, ".png", PATH_MAX),
> > 	+      rc_config.working_dir );
> > 	 }
> >
> > This was the Coccinelle SmPL:
> >
> > 	@ replace_untitled @
> > 	identifier F != {on_nec2_save_as_clicked};
> > 	parameter list PL;
> > 	expression list EL1, EL2;
> > 	expression EXT, arg, E =~ "untitled\.(.*)";
> > 	@@
> >
> > 	F(PL)
> > 	{
> > 	+	char newfn[PATH_MAX];
> > 		...
> > 		file_chooser = Open_Filechooser(GTK_FILE_CHOOSER_ACTION_SAVE,
> > EXT, arg,
> > 	-		_(E),
> > 	+		get_nec_filename_stem(newfn, EXT, PATH_MAX),
> > 			EL2);
> > 		...
> > 	}
> >
> > but that just moved the existing "*.png" in the metavariable EXT into EXT
> > within get_nec_filename_stem(), which wasn't quite enough, because
> > get_nec_filename_stem() wants ".png" not "*.png": so I manually deleted
> > the *'s.
> >
> > It seems that I use Coccinelle daily: there is always something that is
> > easier solved with SmPL than manual editing, even if there is some minor
> > intervention after SmPL does the heavy lifting.
> >
> >
> > --
> > Eric Wheeler
> >
> >
> >
> > >
> > >
> > > > so no need to rush about trying to implement this on my behalf
> > >
> > > Thanks for your nice feedback.
> > >
> > >
> > > > unless it would benefit others.
> > >
> > > I guess that further demonstrations for the application of (advanced)
> > > regular expressions in combination with the semantic patch language can
> > > help
> > > to clarify corresponding use cases.
> > >
> > > Regards,
> > > Markus
> > >
>
>
> --
> Nicolas Palix
>
