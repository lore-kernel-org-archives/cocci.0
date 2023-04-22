Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956BDC6FD18
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 09:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=uBzcDm6Nqpy83X+RaP+6Rjd6YZho0o1J2dhIPwWqVfQ=;
  b=Ubh4J/0naNv3l70kB9LwXgH00hsOzSV1O/N8V8mkKGrlwEeBRMLq4jm3
   u8yWj1k7d+gmnS6JyBzQFsxDu6d6nQpLwZBxK6aehf6YLL3j59GSE15x9
   sD6RuP+z6URnK7oqzgn+VqKezWYndCjBj2phXpqcpZreoCxNh7aT7tXy7
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="104280348"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 11:09:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 78CF1E01D1; Sat, 22 Apr 2023 11:09:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BE218E019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 11:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uBzcDm6Nqpy83X+RaP+6Rjd6YZho0o1J2dhIPwWqVfQ=;
  b=Jzx1txc3fWdIdcwgtcVFl4y3IZYKtjcM+KJvjKlRvd4GlueGtgriXEzu
   voZOlImYP83C/jXCLx0ZtnVxYwCdi1Cz1Ki6h/n5XbyjU6ZaGYwkIgpdh
   ls8Y3MyWeI3UqkQyO6lGDapw/OfgESeXoFjgd8vVQji/MqHpFJSjM11KJ
   w=;
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="54029844"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 11:09:39 +0200
Date: Sat, 22 Apr 2023 11:09:38 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, 
    Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
In-Reply-To: <1f0089f3-3c8f-60e3-5520-f7813093076a@web.de>
Message-ID: <alpine.DEB.2.22.394.2304221104340.2766@hadrien>
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de> <alpine.DEB.2.22.394.2304221031370.2766@hadrien> <1f0089f3-3c8f-60e3-5520-f7813093076a@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1167888919-1682154578=:2766"
Subject: Re: [cocci] Checking data processing for capturing groups in
 regular expressions (with SmPL)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1112
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/alpine.DEB.2.22.394.2304221104340.2766%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1167888919-1682154578=:2766
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 22 Apr 2023, Markus Elfring wrote:

> >> I tried script variants out again for the semantic patch language.
> >> Software combination: Coccinelle 1.1.1-00448-g8e007c83 (OCaml 5.0)
> >>
> >>
> >> @initialize:python@
> >> @@
> >> import re, sys
> >>
> >> @script:python selection1@
> >> @@
> >> text = '"]"'
> >> sys.stderr.write('text: ' + text + '\n')
> >> match = re.match('"([^"]+)"', text)
> >> if match:
> >>    content = match.group(1)
> >>    sys.stderr.write('content: ' + content + '\n')
> >>    if (len(content) == 1) or ((len(content) == 2) and (content[0] == '\\')):
> >>       sys.stderr.write('Result: c\n')
> >>    else:
> >>       sys.stderr.write('Result: s\n')
> >> else:
> >>    sys.stderr.write('no match\n')
> >>
> >>
> >> Expected test result:
> >> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch match-20230422-debug.cocci seq_printf1.c
> >> …
> >> text: "]"
> >> content: ]
> >> Result: c
> >>
> >>
> >> A corresponding source file example:
> >> int main(void)
> >> {
> >> 	seq_printf(seq, "]");
> >> 	seq_printf(seq, "<>");
> >> 	seq_printf(seq, "%s", "Test");
> >> 	return 0;
> >> }
> >>
> >>
> >> @initialize:python@
> >> @@
> >> import re, sys
> >>
> >> @find_update_candidate@
> >> constant char[] input_string;
> >> expression input_context;
> >> position pos;
> >> @@
> >>  seq_printf@pos(input_context, input_string);
> >>
> >> @script:python selection2@
> >> call;
> >> param << find_update_candidate.input_string;
> >> pos << find_update_candidate.pos;
> >> text;
> >> @@
> >> sys.stderr.write('param: ' + param + '\n')
> >> match = re.match('"([^"]+)"', param)
> >> if match:
> >>    content = match.group(1)
> >>    sys.stderr.write('content: ' + content + '\n')
> >>    if (len(content) == 1) or ((len(content) == 2) and (content[0] == '\\')):
> >>       x = "c"
> >>       mark = ["'", content, "'"]
> >>       t = ''.join(mark)
> >>    else:
> >>       x = "s"
> >>       t = param
> >>
> >>    coccinelle.call = "seq_put" + x
> >>    sys.stderr.write('call: ' + coccinelle.call + '\n')
> >>    coccinelle.text = cocci.make_expr(t)
> >> else:
> >>    cocci.include_match(False)
> >>    sys.stderr.write('include_match(False)\n')
> >>
> >>
> >> Unexpected test result:
> >> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch use_seq_putc_or_seq_puts-20230422-debug2.cocci seq_printf1.c
> >> …
> >> param:   "<>"
> >> include_match(False)
> >> param:   "]"
> >> include_match(False)
> >>
> >>
> >> Why do I observe an undesirable difference for the evaluation of regular expressions here?
> >
> > I know almost nothing about either python or regular expressions.
>
> You probably know more about such software areas than you express here.
>
>
> > Furthermore your semantic patch is very complicated and you have not
> > provided the .c file.
>
> Please take another look at the provided source file example.

OK, it was strange to put the expected results before the .c file input.

>
>
> > If you want a response, greatly simplify your semantic patch
> > to the minimum necessary to show the problem,
>
> I did that for this bug report.

This is clearly not the case.  As a trivial example, your semantic patches
don't contain any rules after the python code.  But the python code
contains cocci.include_match(False).  What is the point of that? For
another example, is your concern what is printed with text in the first
rule and with param in the second rule?  Those prints are on or near the
first lines of the python scripts.  What do you need the rest for?  Or if
those are not your concern, then why are they there at all.  If you have
multiple concerns, please just don't do that.  Ask about only one thing at
a time.

julia


>
> > and provide the .c file, which should also be the minimum necessary to show the problem.
>
> Have you accidentally overlooked any available information?
>
> Do we need to compare the desired data processing by the means of OCaml code?
>
> Regards,
> Markus
>
--8323329-1167888919-1682154578=:2766--
