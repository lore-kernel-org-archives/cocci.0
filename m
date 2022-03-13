Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F71FC433EF
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 07:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=aZSa0WOAvY5/OyNQGjiA/DzgwVAga0t2ZaBIqHW7f2U=;
  b=tN74B06xpStnk6tD8PIQtRCInzS534PPXfDf41eX5opvENQNyipaFegw
   6ECmszox91j49ZrLSndTojrfn8FB+AWlVX7hfJ7qPC7ziE270AuXU/Kd+
   RkyygWAQ2MBgErodjoibFnJM8HJ4sUY8qHWx+41gLuXJaJujFlw9oPqtX
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
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25837438"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 08:15:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9FDE7E02A3; Sun, 13 Mar 2022 08:15:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 41B92E0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 08:15:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aZSa0WOAvY5/OyNQGjiA/DzgwVAga0t2ZaBIqHW7f2U=;
  b=sA8CR4QW1SlQgoTrXyEiUBYCP2MVU8eUqvV6MxVTCefDYJ2yOrTity+s
   71ohJcm9O0P3K8rcGSbU2hcc9v8BokEZyLmxk5pK0rPe3TLaiHWwa14Td
   ZKs59NJkHvDrNcd8JGf544MYaw5JrpD8gdmn+ofnbQ3PcJ4Jp7nVcZbJ1
   k=;
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25837432"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 08:15:10 +0100
Date: Sun, 13 Mar 2022 08:15:09 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <44139568-4c27-7ae5-75b3-f9c9c2d88a73@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203130807300.18925@hadrien>
References: <44139568-4c27-7ae5-75b3-f9c9c2d88a73@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How can Coccinelle operate on a series of else-if
 statements?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 214
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203130807300.18925%40hadrien>



On Sat, 12 Mar 2022, Eric Wheeler wrote:

> Hello,
>
> I am trying to generate a patch like this for every if and else-if
> occurance in the function below:
>
> 	-    else if (strcmp(v->format, "%d") == 0)
> 	-        count = sscanf(line, v->format, (int*)v->vars[0]);
> 	+    else if (strcmp(v->format, "%d") == 0)
> 	+        count = sscanf(line, "%d%n", (int*)v->vars[0], &check);
>
>
> Side note: see the other email about string concatination for the "%n"
> part, but this email is about handling else-if's, so I let (for example)
> "%d%n" remain "%d" and just name it metavariable C in this example:
>
> 	@ verify_parsed_vars @
> 	identifier F = {parse_var};
> 	constant C;
> 	type T;
> 	parameter list PL;
> 	@@
> 	F(PL)
> 	{
> 	    ... when exists
> 	    when any
> 	    if (...) {...}
> 	-else if (strcmp(v->format, C) == 0) count = sscanf(line, v->format, (T)v->vars[0]);
> 	+else if (strcmp(v->format, C) == 0)
> 	+   count = sscanf(line, C, (T)v->vars[0], &check);
>
> 	    ... when exists
> 	    when any
> 	}

Putting the wholefunction definition is not a good idea.  It will be
expensive, because you have to trace throughthe whole function definition
to get to the change point.  You can just match the if pattern.

actually, I don't understand the purpose of the metavariable F.  Do you
only want to change a function called parse_var?  If so, there is no need
to use a metavariable, just put the name of the function in the place of
F.

@@
position p : script:python() { p[0].current_element == "parae_var" }; // adapt as needed - I don't know python
@@

if@p (...) S1 else S2

Then, for your nested ifs, the problem is that if you make changes in both
the then and else line, you may run into an "already tagged token"
problem, because the else of the outer if contains the then of the inner
if.

It may be convenient to make one rule that does

if (...)
- old_then_line
+ new_then_line
else S

Then if you need to clean up the final else, you can make a second rule
that takes case of that.

julia

>
> This works for the first occurance as you can see here (even though the
> formatting gets clobbered, which I can live with and call `indent` unless
> there is a cocci fix for that):
>
> 	--- t.c
> 	+++ /tmp/cocci-output-12307-187abf-t.c
> 	@@ -16,8 +16,9 @@ int parse_var(rc_config_vars_t *v, char
>
> 	     if (strcmp(v->format, "%d") == 0)
> 		 count = sscanf(line, v->format, (int*)v->vars[0]);
> 	-    else if (strcmp(v->format, "%d") == 0)
> 	-        count = sscanf(line, v->format, (int*)v->vars[0]);
> 	+    else
> 	+        if (strcmp(v->format, "%d") == 0)
> 	+        count = sscanf(line, "%d", (int *)v->vars[0], &check);
>
> but there are several more else-if's in the series in the same format.  I
> would like to do the first 'if', too, but I can do that by hand if it is
> inconvenient to do in SmPL.  Once I understand how to do this I can write
> one for the "%d,%d" formats with multiple vars:
>
> Thanks for your help understanding SmPL+else-if's!
>
> -Eric
>
> Here is the simplified function:
>
> 	int parse_var(rc_config_vars_t *v, char *line)
> 	{
> 	    int count = 0;
> 	    int check = 0;
>
> 	    if (strcmp(v->format, "%d") == 0)
> 		count = sscanf(line, v->format, (int*)v->vars[0]);
> 	    else if (strcmp(v->format, "%s") == 0)
> 	    {
> 		strncpy((char*)v->vars[0], line, v->size - 1);
> 		count = 1;
> 	    }
> 	    else if (strcmp(v->format, "%f") == 0)
> 		count = sscanf(line, v->format, (double*)v->vars[0]);
> 	    else if (strcmp(v->format, "%lf") == 0)
> 		count = sscanf(line, v->format, (double*)v->vars[0]);
>
> 	    // These scanf's would use a slightly different SmPL patch (or disjunction):
> 	    else if (strcmp(v->format, "%d,%d") == 0)
> 		count = sscanf(line, v->format, (int*)v->vars[0], (int*)v->vars[1]);
> 	    else if (strcmp(v->format, "%f,%f") == 0)
> 		count = sscanf(line, v->format, (float*)v->vars[0], (float*)v->vars[1]);
> 	    else if (strcmp(v->format, "%lf,%lf") == 0)
> 		count = sscanf(line, v->format, (double*)v->vars[0], (double*)v->vars[1]);
> 	}
>
>
> --
> Eric Wheeler
>
