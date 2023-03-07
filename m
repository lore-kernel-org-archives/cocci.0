Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122CEC678D5
	for <cocci@archiver.kernel.org>; Tue,  7 Mar 2023 11:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=q7cXvvYYp1PYT7jaBiaUuS+jHbakWUxwiNldjkwvgic=;
  b=KHO/96wrj1yHh9zMXVKz0btwSSq+NEHsEL7GlAJ7p/aYqY2oDH9ek38W
   qb3qjV7xy8TcidbuaNGg93Tik8ScLFIBP2nsoT0m90ONYl5qenJmJBQQH
   grt4Gox7ZXmRLxuJFQSkmCGpR7D4fkqspESYrwoi//YoO3M8cFKmRMVrT
   o=;
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
   d="scan'208";a="95845941"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2023 12:12:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5BE12E4374; Tue,  7 Mar 2023 12:12:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 30D0DE0247
	for <cocci@sympa.inria.fr>; Tue,  7 Mar 2023 12:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=q7cXvvYYp1PYT7jaBiaUuS+jHbakWUxwiNldjkwvgic=;
  b=DeWHwQ80HdXU2rTnC3Ew8M2d59N1zeIT3zgDxSRAHFLQuib9d6vTPUpD
   K6E4yr6tUPiczWJ47bZIowL1ewXUyadum0Ez6BCkULQXfusQIC+FjqrZV
   vGwXGa4HyhkOyTJAM8fJvZwpqcTXEkK5NDDsuL4B1yVYDPwNgnkUXxdaY
   g=;
X-IronPort-AV: E=Sophos;i="5.98,240,1673910000"; 
   d="scan'208";a="95845923"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 12:12:04 +0100
Date: Tue, 7 Mar 2023 12:12:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Tommi Rantala <tt.rantala@gmail.com>
cc: cocci@inria.fr, Tommi Rantala <tommi.rantala@cujo.com>
In-Reply-To: <20230307104945.3125611-1-tt.rantala@gmail.com>
Message-ID: <640ad-ccdc-df35-b3d4-beae6c55b629@inria.fr>
References: <20230307104945.3125611-1-tt.rantala@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] Fix find -name flag when combining --c++ and
 --include-headers
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 876
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/640ad-ccdc-df35-b3d4-beae6c55b629%40inria.fr>



On Tue, 7 Mar 2023, Tommi Rantala wrote:

> From: Tommi Rantala <tommi.rantala@cujo.com>
>
> Should be "-name" not "name".

Thanks very much!

julia

>
> Signed-off-by: Tommi Rantala <tommi.rantala@cujo.com>
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
