Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33525C48BC3
	for <cocci@archiver.kernel.org>; Mon, 19 Feb 2024 21:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=vJJSg8kJbTTb4RoFiolKQvQ1v6GsQQQmflDFeZPcGBs=;
  b=bhQsmq8Wzd9CLybbF0SSaGoQbs+cvR7Hnda0CKUjk/zmJVA0HxYBU2zl
   vac9vmJJFfE+TWf3JuvuraNea7h9zBePjzSuzQaqMJ6FJB/kZco15nRqC
   iSlQ3oK6UQGmTIo3kbmQsxr3eJwgRMACQ5VAV4kUFVZ+pjkaN/laMYilF
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.06,171,1705359600"; 
   d="scan'208";a="152725319"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Feb 2024 22:31:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 466CEE0CD7; Mon, 19 Feb 2024 22:31:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 42C5CE008A
	for <cocci@sympa.inria.fr>; Mon, 19 Feb 2024 22:31:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vJJSg8kJbTTb4RoFiolKQvQ1v6GsQQQmflDFeZPcGBs=;
  b=OC/J+yeujzooUIcCu+MWwUejBOWrp1VV26OOTrgiobPkrLWDsRHWeVjI
   wEnrsWDtJuoGpgMDfxs3mzKMnQanF5sIjeYhGvE8SsNy4rHPR6TDyZDg7
   9viyeRAcxbwzFPY1adPskEv1eCZKMBrUi4ZgXhvzIjjNb4vNlkM9C3cWg
   M=;
X-IronPort-AV: E=Sophos;i="6.06,171,1705359600"; 
   d="scan'208";a="152725312"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:31:34 +0100
Date: Mon, 19 Feb 2024 22:31:33 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr, Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <202402191324.915AFFD6C2@keescook>
Message-ID: <alpine.DEB.2.22.394.2402192231180.3358@hadrien>
References: <202402191257.843BC9BC@keescook> <alpine.DEB.2.22.394.2402192208110.3358@hadrien> <202402191324.915AFFD6C2@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Excluding file paths
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1588
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402192231180.3358%40hadrien>



On Mon, 19 Feb 2024, Kees Cook wrote:

> On Mon, Feb 19, 2024 at 10:12:10PM +0100, Julia Lawall wrote:
> >
> >
> > On Mon, 19 Feb 2024, Kees Cook wrote:
> >
> > > Hi!
> > >
> > > I keep running into this, and figured I should just ask: how do I
> > > exclude certain directories (or files) when using "--dir"? For example,
> > > we've been working on removing the ambiguous/fragile C string APIs in
> > > the kernel and replacing them with alternatives, but we can't do this
> > > for userspace programs, since the alternatives only exist in the kernel
> > > code base itself. Mainly, this is about excluding tools/ but there are
> > > also parts of arch/um/ that are built against userspace libraries.
> > >
> > > I tried using "--ignore" but it doesn't seem to work. What's the right
> > > solution here? For example, this trivial replacement:
> >
> > You put the constraint in the initial @@ of the semantic patch.  Try
> >
> > depends on !file in tools && !file in samples
> >
> > Maybe parentheses would b needed, eg !(files in tools)
>
> Thanks! Yes, this works:
>
>
> @scnprintf depends on !(file in "tools") && !(file in "samples")@
> @@
>
> -snprintf
> +scnprintf
>  (...);
>
>
> Now that I know the syntax, I found the part in the docs that
> references "file in":
>
>   The declaration file in checks that the code being processed comes from
>   the mentioned file, or from a subdirectory of the directory to which
>   Coccinelle was applied. In the latter case, the string is matched
>   against the complete pathname. A trailing / is added to the specified
>   subdirectory name, to ensure that a complete subdirectory name is
>   matched.
>
> https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html

Nice that it's useful :)

julia
