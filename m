Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F620C678D5
	for <cocci@archiver.kernel.org>; Tue,  7 Mar 2023 11:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=vay/SCQKms9T9h+4pA2BOeDyY+atTpL41fb64eB4ZVw=;
  b=oICWOfTGKBGWB/koygR/1Cn3AAekWMvHRY7lGsqBP3sFuGo0OMmHhie1
   GunXRmQoZVLTtghHWeGsaRgevl86iY9dvyKxKRJ/jDRx5DY+fhpQsFP/s
   z9H3zHJIMKGdlF4pydWcp2NKiPSKQQr5xF0mEB/cDIEsbupU7u5cYHIyy
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.98,240,1673910000"; 
   d="scan'208";a="95846341"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2023 12:14:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8F61CE0AC3; Tue,  7 Mar 2023 12:14:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CFA17E0247
	for <cocci@sympa.inria.fr>; Tue,  7 Mar 2023 12:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vay/SCQKms9T9h+4pA2BOeDyY+atTpL41fb64eB4ZVw=;
  b=Y6PH4M/WCAYxoUtTSaOlitSy7k9Q74qCpBZyAuF5RMhgWClxSNWB37zg
   8CyaHAQlCnAd2NlOxae2/T6Mfx/ByrP0/scomnayggvwA/yYibLHDEczv
   /Ac8W25lLwqz3Rb638xl66xgee3GRBUEb39UXoLdX0S3jOSfmRPgVx6Mi
   k=;
X-IronPort-AV: E=Sophos;i="5.98,240,1673910000"; 
   d="scan'208";a="95846334"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 12:14:13 +0100
Date: Tue, 7 Mar 2023 12:14:13 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Tommi Rantala <tt.rantala@gmail.com>
cc: cocci@inria.fr, Tommi Rantala <tommi.rantala@cujo.com>
In-Reply-To: <20230307104945.3125611-1-tt.rantala@gmail.com>
Message-ID: <ec7c6da4-6e56-60d1-ba61-dbc72db8a662@inria.fr>
References: <20230307104945.3125611-1-tt.rantala@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] Fix find -name flag when combining --c++ and
 --include-headers
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 877
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/ec7c6da4-6e56-60d1-ba61-dbc72db8a662%40inria.fr>



On Tue, 7 Mar 2023, Tommi Rantala wrote:

> From: Tommi Rantala <tommi.rantala@cujo.com>
>
> Should be "-name" not "name".
>
> Signed-off-by: Tommi Rantala <tommi.rantala@cujo.com>

The change is available on github.

julia

> ---
>  parsing_c/test_parsing_c.ml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parsing_c/test_parsing_c.ml b/parsing_c/test_parsing_c.ml
> index 97842072..2d30eda4 100644
> --- a/parsing_c/test_parsing_c.ml
> +++ b/parsing_c/test_parsing_c.ml
> @@ -35,7 +35,7 @@ let get_files path =
>        (if !Flag.include_headers
>        then
>          "find "^ path ^" -name \"*.cpp\" -o -name \"*.cxx\" -o -name \"*.cc\""
> -        ^"-o name \"*.h\" -o -name \"*.hpp\" -o -name \"*.hxx\""
> +        ^"-o -name \"*.h\" -o -name \"*.hpp\" -o -name \"*.hxx\""
>        else
>          "find "^ path ^" -name \"*.cpp\" -o -name \"*.cxx\" -o -name \"*.cc\"")
>    else
> --
> 2.39.2
>
>
