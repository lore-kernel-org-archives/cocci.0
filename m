Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D558ECE579
	for <cocci@archiver.kernel.org>; Mon,  9 Sep 2024 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lonUSnqdTD88ZPU2zJHgdmx3mLDJED+oxqZbrLmNd+Y=;
  b=hM4XECOfKF58v8kry3Q+9Ey9CRRg/Fk4Oos3SHZzn5cHHdSlRBdZaaSQ
   0PiaozPYswzMYpQca8wZ0q0YZ/tfJucYtn8T3PkDnlWo6pgX2T9QtcMxv
   RPapu8o9jcKLf9BkXW46vrYVAFZXBCYflYQYBogm7y4ihRPibk7ZFTyxc
   U=;
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
X-IronPort-AV: E=Sophos;i="6.10,214,1719871200"; 
   d="scan'208";a="182230801"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Sep 2024 18:00:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8FD68E0CD4; Mon,  9 Sep 2024 18:00:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 64080E00B6
	for <cocci@sympa.inria.fr>; Mon,  9 Sep 2024 18:00:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lonUSnqdTD88ZPU2zJHgdmx3mLDJED+oxqZbrLmNd+Y=;
  b=Wg8i0E6jOTB6ngFAFJG8yuBBCUBrra+5M0ZoQcn72ZiNlfUg/LcMEbkL
   u8mGtjoF1/QdpKlnIyAMqNWT4fdpwrlmH56sZOWbxpVqgR7ktl5pXml+0
   pBc4m0+ur5L/rEW0kbjlg1iS2pP7Jh1nlLr/dpSiiUcs5j1MUsrkcyfQz
   U=;
X-IronPort-AV: E=Sophos;i="6.10,214,1719871200"; 
   d="scan'208";a="95838497"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 18:00:31 +0200
Date: Mon, 9 Sep 2024 18:00:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Hongbo Li <lihongbo22@huawei.com>
cc: kees@kernel.org, andy@kernel.org, nicolas.palix@imag.fr, 
    linux-hardening@vger.kernel.org, cocci@inria.fr
In-Reply-To: <20240904091451.3328272-2-lihongbo22@huawei.com>
Message-ID: <71436945-5386-ff6e-8e8c-b513d4509241@inria.fr>
References: <20240904091451.3328272-1-lihongbo22@huawei.com> <20240904091451.3328272-2-lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH -next v2 1/9] coccinelle: Add rules to find
 str_true_false() replacements
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1866
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/71436945-5386-ff6e-8e8c-b513d4509241%40inria.fr>



On Wed, 4 Sep 2024, Hongbo Li wrote:

> After str_true_false() has been introduced in the tree,
> we can add rules for finding places where str_true_false()
> can be used. A simple test can find over 10 locations.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
> index 5e729f187f22..50329c4c8acd 100644
> --- a/scripts/coccinelle/api/string_choices.cocci
> +++ b/scripts/coccinelle/api/string_choices.cocci
> @@ -85,3 +85,26 @@ e << str_down_up_r.E;
>  @@
>
>  coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
> +
> +@str_true_false depends on patch@
> +expression E;
> +@@
> +(

There is no need for the above.  That is only needed if there is a
disjunction, ie a set of possible changes.  Likewise no need for the ),
and the same in the next rule.

julia

> +-      ((E) ? "true" : "false")
> ++      str_true_false(E)
> +)
> +
> +@str_true_false_r depends on !patch exists@
> +expression E;
> +position P;
> +@@
> +(
> +*      ((E@P) ? "true" : "false")
> +)
> +
> +@script:python depends on report@
> +p << str_true_false_r.P;
> +e << str_true_false_r.E;
> +@@
> +
> +coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
> --
> 2.34.1
>
>
