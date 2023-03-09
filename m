Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA93C64EC4
	for <cocci@archiver.kernel.org>; Thu,  9 Mar 2023 09:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=r2jZ5qXrE7xt6+Kpn72mdf8y4ye094SWdyzkqZeH5gQ=;
  b=lyyk7rPPPldlGHAeZPE7/d8jwKH6DuyN9+7x+WJzNuKIXlMQpZ2meDWC
   8DdBqbr3Ui72siFvnaftIoW9ZX4IJu3eTDfQcoS3q1fcTk6NHG/j4XK1N
   c2S9IXhSvYKKPXR1iycpY6BaJwDQKo53OAfU5U0yVrfTDpCt5lbw+LOD2
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.98,246,1673910000"; 
   d="scan'208";a="96241956"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2023 10:38:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 753A3E01A9; Thu,  9 Mar 2023 10:38:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E920BE00BE
	for <cocci@sympa.inria.fr>; Thu,  9 Mar 2023 10:38:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r2jZ5qXrE7xt6+Kpn72mdf8y4ye094SWdyzkqZeH5gQ=;
  b=mjI3sXJHH6O0jprMbsT07ltksGur2y/GxCW6+CcyjHouEUMB5bAw2I3G
   gRoZRqGuSiPRf1pnFgYlcXl8rYjoNkA/p6f+4dtbbNoq8ntOSlckHbY5c
   zGTT0UiFaqyyhAPYeO42siUl5obS3HMfXcMKo8LZeh8WyVdIS3f/XlJ+S
   I=;
X-IronPort-AV: E=Sophos;i="5.98,246,1673910000"; 
   d="scan'208";a="96241940"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 10:38:50 +0100
Date: Thu, 9 Mar 2023 10:38:50 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <20230309101001.78c0bc26@nbbrfq>
Message-ID: <95103e65-6f5a-ae64-8ab2-7c57e5ca9438@inria.fr>
References: <20230309092812.71b25d5c@nbbrfq> <89959f1e-b5ed-6b2c-2931-4fdd65428e89@inria.fr> <ad666bb2-3f4-47a2-13fd-8f7e29b8af79@inria.fr> <20230309101001.78c0bc26@nbbrfq>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] HELP: multiple inserts at one position
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 882
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/95103e65-6f5a-ae64-8ab2-7c57e5ca9438%40inria.fr>

> Now, mere cosmetics, but is there a way to retain the spaces before the
> braces in the replacement?
> That would spare me a sed to obey to the coding conventions in gcc.
> With the attached i get:

Try the argument --smpl-spacing.

julia

> $ spatch --sp-file /tmp/mpz_free.0.cocci.txt /tmp/inp.cc
> diff =
> --- /tmp/inp.cc
> +++ /tmp/cocci-output-1431557-e530f9-inp.cc
> @@ -54,6 +54,7 @@ CompileExpr::compile_integer_literal (co
>    if (mpz_init_set_str (ival, literal_value.as_string ().c_str (), 10) != 0)
>      {
>        rust_error_at (expr.get_locus (), "bad number in literal");
> +      mpz_clear(ival);
>        return error_mark_node;
>      }
>
> @@ -69,6 +70,8 @@ CompileExpr::compile_integer_literal (co
>  		     "integer overflows the respective type %<%s%>",
>  		     tyty->get_name ().c_str ());
>        mpz_clears (ival, expr, NULL); /* fake, just checking.. */
> +      mpz_clear(type_min);
> +      mpz_clear(type_max);
>        return error_mark_node;
>      }
>
> @@ -77,5 +80,6 @@ CompileExpr::compile_integer_literal (co
>    mpz_clear (type_min);
>    mpz_clear (type_max);
>
> +  mpz_clear(ival);
>    return result;
>  }
>
>
> Thanks again!
>
