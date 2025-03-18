Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CF7C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JRMTi1X1lbGXg9V7wTy9dgxPKm+uxTYbfVQmvWhebR8=;
  b=huMXtz3Gd2odyIEb6s0PALv6XS1b5ZWy2cuUzjVJeSkTxJK5tZ4dUPKo
   44qQ9jLGaDzPzaDAL5GLWn0zRTfzqaduUxY+m931vwQYFIGsJNAZvVWtb
   aLTqvAIj9/U9EBLaaxsl0Qbo8PQZNJMrzlWleV/Hkgs8ZZOZmP48QG0DM
   0=;
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
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213497743"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 14:45:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 072ADE0D1D; Tue, 18 Mar 2025 14:45:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0966CE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 14:45:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=JRMTi1X1lbGXg9V7wTy9dgxPKm+uxTYbfVQmvWhebR8=;
  b=LHoCEKetnJcYG8JB5kKHGR73ETFw941mSOolDs4jT6ll+iyl74eEFybt
   ZsGjlrHxTOASQ/BP1cctTimjnetCc0+W5r+J4uQZzoTY9ShvuAKAse+8i
   jaRJtqnuAxCugCCPJ6AzQMud/amzCaMJy6nohycMPsPA0dRIw/DpF5iLs
   s=;
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="111911951"
Received: from lfbn-idf2-1-133-189.w83-202.abo.wanadoo.fr (HELO [192.168.1.23]) ([83.202.217.189])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 14:45:07 +0100
Message-ID: <048b980d-22cc-4792-8f1a-8949d5dced5c@inria.fr>
Date: Tue, 18 Mar 2025 14:45:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <20250317080053.27298-1-olaf@aepfle.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <20250317080053.27298-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH v1] Adjust help text for --with-metainfo
 configure option
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2618
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/048b980d-22cc-4792-8f1a-8949d5dced5c%40inria.fr>

Merged to master. Thanks for the patch!

On 17/03/2025 09:00, Olaf Hering wrote:
> Fixes 3c20ea6f8 ("Install AppStream metadata file")
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>   configure.ac | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index f0c585329..bc20724ea 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -554,7 +554,7 @@ dnl --without-metainfo disables metainfo installation.
>   
>   AC_ARG_WITH([metainfo],
>       AS_HELP_STRING([--with-metainfo[=PATH]],
> -        [Install the bash auto-completion script in this directory.\
> +        [Install metainfo into this directory.\
>            @<:@default=yes@:>@]),
>       [],
>       [AC_SUBST([with_metainfo], [yes])])
