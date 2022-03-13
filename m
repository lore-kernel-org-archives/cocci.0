Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFE3C433F5
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 09:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=gYNZBMWwkqufZ5NsRBddylUHeyWrVvDMdpnaOXkwUbI=;
  b=HWpvtcT9zjKytcfG180Q2X3Au8K2X8wzEdosnEV4sSS3HCe/L8hBTZQM
   Wtqh7FZmserHH/i+FM+n1H8iOcqaSEaL5ncWqWou9IhwD70ed0sjH17jV
   jZcedstCeg3h9w8ydnM35XhcE/hZryEljJV6oTXOrfudqxNfLaSpR9Y6v
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
   d="scan'208";a="25847164"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 10:57:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1326DE004A; Sun, 13 Mar 2022 10:57:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 36D8FE0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 10:57:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gYNZBMWwkqufZ5NsRBddylUHeyWrVvDMdpnaOXkwUbI=;
  b=dD04vGt/564egk11jN44FSwriC2m/VzIDOCKbFvmq5e8bB3m1fRk69vi
   DBy0+hYFw5AxDJjwBU/SfxMc3pJw+Ia3xVIMZPfXoESX+Tap1GvgNAwVX
   Gg/iKZg8CmEo+CQzfI3ym33z0cS2wuJ6wh51yW9Jxbf9yOHcyXPdYnvr5
   w=;
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="8390964"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 10:57:41 +0100
Date: Sun, 13 Mar 2022 10:57:40 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
In-Reply-To: <caf9ec38-c627-711d-885d-b975cc914fca@web.de>
Message-ID: <alpine.DEB.2.22.394.2203131056330.18925@hadrien>
References: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net> <caf9ec38-c627-711d-885d-b975cc914fca@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-107973517-1647165460=:18925"
Subject: Re: [cocci] Can Coccinelle concatenate or append to existing string
 literals?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 216
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203131056330.18925%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-107973517-1647165460=:18925
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 13 Mar 2022, Markus Elfring wrote:

>
> > to produce this:
> >
> > 	void f()
> > 	{
> > 	-	foo("foo");
> > 	+	foo("foo_bar");
> > 	}
> >
> > It looks like `fresh identifier` can do something like this,
> > but I can't get it to work with strings.
>
>
> I suggest to increase the distinction which data parts you would like to modify
> for such a transformation attempt.
>
>
>
> > Is there a way?
>
>
> Will another test result for a SmPL script like the following trigger any further
> collateral evolution?
>
> @addition@
> @@
>  void f()
>  {
>  foo("foo"
> +    "_bar"
>     );
>  }

Maybe this would be a good thing in principle, but I don't think it would
be the desirable solution in Eric's case.  He should just use python to
construct the string he wants.  In that way, the user will better be able
to connect the output to the string that is found in the code.

julia


>
>
> Markus_Elfring@Sonne:…Projekte/Coccinelle/Probe> spatch --parse-cocci append_to_string_literal1.cocci
> …
> plus: parse error:
>   File "append_to_string_literal1.cocci", line 6, column 10, charpos = 48
>   around = '"',
>   whole content = +    "_bar"
>
>
> How will the chances evolve to support string literal concatenations better here
> (by the means of the semantic patch language)?
> https://en.cppreference.com/w/c/language/string_literal#Explanation
>
>
> @initialize:python@
> @@
> import re
>
> @find_update_candidate@
> constant input_string;
> position pos;
> @@
>  void f()
>  {
>  foo@pos(input_string);
>  }
>
> @script:python selection@
> param << find_update_candidate.input_string;
> text;
> @@
> if param == '"foo"':
>    coccinelle.text = cocci.make_expr('"foo_bar"')
> else:
>    cocci.include_match(False)
>
> @replacement@
> constant find_update_candidate.input_string, selection.text;
> position find_update_candidate.pos;
> @@
>  void f()
>  {
>  foo@pos(
> -        input_string
> +        text
>         );
>  }
>
>
> Markus_Elfring@Sonne:…Projekte/Coccinelle/Probe> spatch append_to_string_literal2.cocci string_literal_usage1.c
> …
> @@ -1,4 +1,4 @@
>  void f()
>  {
> -foo("foo");
> +foo("foo_bar");
>  }
>
>
> Regards,
> Markus
>
>
--8323329-107973517-1647165460=:18925--
