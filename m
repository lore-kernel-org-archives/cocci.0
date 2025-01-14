Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4761DE77188
	for <cocci@archiver.kernel.org>; Tue, 14 Jan 2025 22:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=aZ4QfPllvKleGLgiX8IDcmxzRQIxo3jzBXu+H/90lPw=;
  b=LVpxvlWczGn9fnJwfeNoS6aAYdZbM9LowirZlh6HpuZIqeBISAL3Qmid
   DUmEFRjI0FsuiW1uoNNszJeITDY8ghJwCzFt8dunvXE3kxf1brbatq5p+
   CefX3fiptmH4z3e7WeJujJfP9VbQJrEC4zucwtUKIASGfQELajgaqU3AL
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.12,315,1728943200"; 
   d="scan'208";a="203141415"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jan 2025 23:37:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7B999E0137; Tue, 14 Jan 2025 23:37:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6653FE0077
	for <cocci@sympa.inria.fr>; Tue, 14 Jan 2025 23:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aZ4QfPllvKleGLgiX8IDcmxzRQIxo3jzBXu+H/90lPw=;
  b=KNuRjq9dOKXsZgtVXcgY2tEx/QydOH7vz5/C7steUUfAq3OIFTk975Xy
   e1kOp1naXhcU6MrCQa/U49G+TFs7vvsi+bcUyP6LolP1Y8Gyii1XmTWLX
   xxLKYGBh8P6FprrYx55WIg64RLXdww7aI0TvG6giztYhoj8oN4czpQBX0
   c=;
X-IronPort-AV: E=Sophos;i="6.12,315,1728943200"; 
   d="scan'208";a="203141413"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 23:37:43 +0100
Date: Tue, 14 Jan 2025 23:37:43 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Anusha Srivatsa <asrivats@redhat.com>
cc: cocci@inria.fr, Maxime Ripard <mripard@redhat.com>
In-Reply-To: <CAN9Xe3Q99urpL68p8RxXta1xzHE6PCnfL7S3XktuLUK7KhMCXg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2501142337100.3510@hadrien>
References: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com> <dcaf63e4-78bf-3111-8494-6380e6118fd8@inria.fr> <CAN9Xe3TBb2GYNeqL1f1_GTPT2W5J78gniK0ZTZJyLwJL=KydoQ@mail.gmail.com> <fbdc13e1-d713-c4c0-35f0-f6a1de5a9e9@inria.fr>
 <CAN9Xe3Q99urpL68p8RxXta1xzHE6PCnfL7S3XktuLUK7KhMCXg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-314951505-1736894263=:3510"
Subject: Re: [cocci] Ellipses usage in line addition
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2208
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/alpine.DEB.2.22.394.2501142337100.3510%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-314951505-1736894263=:3510
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 14 Jan 2025, Anusha Srivatsa wrote:

>
>
> On Tue, Jan 14, 2025 at 1:39 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>       On Tue, 14 Jan 2025, Anusha Srivatsa wrote:
>
>       > Julai, Thanks for the response. More info inline.
>       >
>       > On Tue, Jan 14, 2025 at 12:50 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>       >
>       >
>       >       On Tue, 14 Jan 2025, Anusha Srivatsa wrote:
>       >
>       >       > Hi all,
>       >       > Wanted to know if ellipses usage is not allowed in the lines that we want to add in the code. To be more precise,I want to replace mipi_dsi_generic_write_seq() usage with
>       >       mipi_dsi_generic_write_seq_multi() .
>       >       > the coccinelle semantic patch that I am using is:
>       >       > //rule_1 ->s/mipi_dsi_generic_write_seq/mipi_dsi_generic_write_seq_multi
>       >       > @@
>       >       > identifier dsi_var,dsi_device;
>       >       > @@
>       >       > struct mipi_dsi_device *dsi_var = dsi_device;
>       >       > +struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
>       >       > ...
>       >       > -mipi_dsi_dcs_write_seq(dsi_var,...);
>       >       > +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
>       >       >
>       >       > this throws:
>       >       > init_defs_builtins: /usr/lib64/coccinelle/standard.h
>       >       > lexical error: invalid in a + context: ...
>       >       >   File "mipi.cocci", line 9, column 39, charpos = 298
>       >       >   around = '...',
>       >       >   whole content = +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
>       >       >
>       >       > Just commenting out the function replacing the snippet (i.e having only dsi_ctx being populated) works just fine. But the intended change is ofc the proper usage of the _multi API.
>       >       >
>       >       > Would be nice to know what is going wrong with this approach.
>       >
>       >       Add a metavariable declaration like:
>       >
>       >       expression list es;
>       >
>       >       And then your change can be:
>       >
>       >       -mipi_dsi_dcs_write_seq(dsi_var,es);
>       >       +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
>       >
>       > This doesnt find any match ....skips through all files.
>       >
>       >       Another approach is to write:
>       >
>       >       -mipi_dsi_dcs_write_seq(dsi_var,
>       >       +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,
>       >          ...);
>       >
>       >
>       > This again throws the error : init_defs_builtins: /usr/lib64/coccinelle/standard.h
>       > lexical error: invalid in a + context: ...
>       >   File "mipi_julia.cocci", line 8, column 39, charpos = 220
>       >   around = '...',
>       >   whole content = +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
>
>       I'll have to check on this.  It all looks fine to me.
>
>       >
>       >
>       >       Another issue is that you may have many calls to mipi_dsi_dcs_write_seq,
>       >       or taht some code paths might not contain such a call.  You probably just
>       >       want to make such a change whereever it occurs.  So you can write:
>       >
>       > Correct. Somehow the below approach : <...P...> ends up matching all mipi_dsi_device *dsi_var declaration and adds a mipi_dsi_multi_ctx declaration regardless of mipi_dsi_dcs_write_seq() being used ...
>
>       Ah, good point.  Just change <... ...> to <+... ...+>.
>
> Tried that. Results below.
>
> Code:
>
> @@
>
> identifier dsi_var,dsi_device;
>
> @@
>
> struct mipi_dsi_device *dsi_var = dsi_device;
>
> +struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
>
> <...
>
> -mipi_dsi_dcs_write_seq(dsi_var,...);
>
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
>
> ...>
>
>
> Output:
>
> spatch mipi_expt.cocci --dir ~/linux/drivers/gpu/drm/
>
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
>
> lexical error: invalid in a + context: ...
>
>   File "mipi_expt.cocci", line 8, column 39, charpos = 226
>
>   around = '...',
>
>   whole content = +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
>
>
> Code:
>
> @@
>
> identifier dsi_var,dsi_device;
>
> @@
>
> struct mipi_dsi_device *dsi_var = dsi_device;
>
> +struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
>
> <+...
>
> -mipi_dsi_dcs_write_seq(dsi_var,...);
>
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
>
> ...+>
>
>
> Output:
>
> spatch mipi_expt.cocci --dir ~/linux/drivers/gpu/drm/
>
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
>
> lexical error: invalid in a + context: ...
>
>   File "mipi_expt.cocci", line 8, column 39, charpos = 227
>
>   around = '...',
>
>   whole content = +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
>
>
> Code:
>
> @@
>
> identifier dsi_var,dsi_device;
>
> expression list es;
>
> @@
>
> struct mipi_dsi_device *dsi_var = dsi_device;
>
> +struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
>
> <+...
>
> -mipi_dsi_dcs_write_seq(dsi_var,es);
>
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
>
> ...+>

This one looks fine.  Do you have a C file on which you expect it to do
something?

julia

>
> Output:
>
> Skipping…..                                               
>
>  
> Feel like  I am missing something fundamental ...
>
> Regards,
> Anusha
>       >
>       > For the lexical error, should spatch be run with  some headers that I am notexplicitly adding? I wonder if I am running with wrong options instead of the semantic patch needing a tweak.
>
>       I don't think so. Spatch doesn't care much about header files.
>
>       julia
>
>       >       @@
>       >       identifier dsi_var,dsi_device;
>       >       @@
>       >       struct mipi_dsi_device *dsi_var = dsi_device;
>       >       +struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
>       >       <...
>       >       -mipi_dsi_dcs_write_seq(dsi_var,...);
>       >       +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
>       >       ...>
>       >
>       >       The <... P ...> notation is like ... but it makes the change whereever the
>       >       pattern P occurs.
>       >
>       > Yes. spatch however disregarding the pattern ....not sure why
>       >
>       > Regards,
>       > Anusha
>       >       julia
>       >
>       >
>       >
>
>
>
--8323329-314951505-1736894263=:3510--
