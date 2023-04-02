Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F66C76196
	for <cocci@archiver.kernel.org>; Sun,  2 Apr 2023 08:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/2u7HyxHU3Fi7ItlP+bUr4viZqO6z025nL3RDAjVKR0=;
  b=OerjL2318Yph5SY56hf5mA0R79yNgnGv75Ts2MeSLd3DZLzmCK39sSJI
   sf3a6D2NwBOJrHibRsM/IUasUdATuZR68cjmvsJ5C/0FwtmjHZTeXv7mh
   UEwa3S/csnQ5svuAoIYf06eoIKeJmqZPpYkPQgplrQhZrSZOFfcJuakVw
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
X-IronPort-AV: E=Sophos;i="5.98,312,1673910000"; 
   d="scan'208";a="100273954"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2023 10:03:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0D015E019E; Sun,  2 Apr 2023 10:03:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2095BE00CE
	for <cocci@sympa.inria.fr>; Sun,  2 Apr 2023 10:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/2u7HyxHU3Fi7ItlP+bUr4viZqO6z025nL3RDAjVKR0=;
  b=jkAjai2R+srZnyisVbUpC1/9av2mA+ohTK2HqJwNll8gux4QgpA4BUhW
   S9Z9XeASYBgnOKQQGY82NXCR2LqJ1hFh8AtUSoC7NAlCp/wnMFI100ZrH
   hdfw/3V/PXDjhYB8G1GAebcXRN11wmcwod8wvvKOCL7ZgBO+CDslKi15b
   8=;
X-IronPort-AV: E=Sophos;i="5.98,312,1673910000"; 
   d="scan'208";a="100273951"
Received: from ip-185-104-137-32.ptr.icomera.net (HELO hadrien) ([185.104.137.32])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 10:03:19 +0200
Date: Sun, 2 Apr 2023 10:03:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Matti Niemenmaa <git-matti@maon.fi>
cc: cocci@inria.fr
In-Reply-To: <20230402074041.2032175-1-git-matti@maon.fi>
Message-ID: <2cc1a5c5-728c-fb6d-1968-bb71f24d36b4@inria.fr>
References: <20230402074041.2032175-1-git-matti@maon.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] Silence Emacs warning on loading cocci.el
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 995
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/2cc1a5c5-728c-fb6d-1968-bb71f24d36b4%40inria.fr>



On Sun, 2 Apr 2023, Matti Niemenmaa wrote:

> Unescaped quote character literals (?") have produced an "unescaped
> character literals" warning on load ever since Emacs 26 (Emacs commit
> c2bbdc3316487 and bug#20852). As far as I can tell the escaped syntax
> has been supported since at least the early 90s, so there are no
> backwards compat issues with this change.

Thanks!  Applied.

julia

>
> Signed-off-by: Matti Niemenmaa <git-matti@maon.fi>
> ---
>  editors/emacs/cocci.el | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git editors/emacs/cocci.el editors/emacs/cocci.el
> index 072e4a9d..12e384f3 100644
> --- editors/emacs/cocci.el
> +++ editors/emacs/cocci.el
> @@ -394,7 +394,7 @@ Turning on cocci-mode runs the hook `cocci-mode-hook'."
>  ; put cursor before a parse error coccinelle message and it will
>  ; open the corresponding file and go to corresponding line.
>  (fset 'cocci-goto-next-error
> -   [?\C-s ?F ?i ?l ?e right right ?\C-  ?\C-s ?" left ?\M-w ?\C-x ?\C-f S-insert return ?\C-\M-l C-right right C-S-right C-insert ?\C-\M-l ?\M-g S-insert return])
> +   [?\C-s ?F ?i ?l ?e right right ?\C-  ?\C-s ?\" left ?\M-w ?\C-x ?\C-f S-insert return ?\C-\M-l C-right right C-S-right C-insert ?\C-\M-l ?\M-g S-insert return])
>  ;"
>
>  ;; Provide
> --
> 2.40.0
>
>
