Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BB8C35FFB
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 12:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=798O5IFaGWOrWWRbwFLXR22CjZxenmAkJTVAejyDsNY=;
  b=WW9NWqy+CFUuMSzI2xG8zySg4cmPQvs0Akp2ghyZIGtg9gTDvL1rKUV+
   5X1JZ6aJrEkGegZUqKt5zNlhYJvpnu7YevcQKheHT9illNMfh3wnB7hEM
   dqjd5Ha2wZ0NhzWoJpyMsGo7tcw2SGg++F9IfE47OCYrN1i0dItbalsdu
   s=;
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
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213693222"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 13:07:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0DBB4E0D1E; Wed, 19 Mar 2025 13:07:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B3024E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 13:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=798O5IFaGWOrWWRbwFLXR22CjZxenmAkJTVAejyDsNY=;
  b=SoutKb4XTUPlMCRoWpxsskUJOxxFDEPpz/YKokOmGATmpu9omrHQ/zbP
   QzioS4sK1XBE2dwoCIeghz617VuA/dZoVyF/iUguEEOWMgFE/PO9oz8WY
   fdbEKa5t+imQQs3ClZsBQWTkGjOnedbZ2PWhkPNCqYlXCigbIbl3e02/F
   U=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112023201"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 13:07:50 +0100
Message-ID: <17ce3c64-40c0-476f-b8d2-f75f4f167370@inria.fr>
Date: Wed, 19 Mar 2025 13:07:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20250319083504.4499-1-olaf@aepfle.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <20250319083504.4499-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH v1] adjust URL in vim README file
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2646
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/17ce3c64-40c0-476f-b8d2-f75f4f167370%40inria.fr>

Merged to master, thanks for the patch!

On 19/03/2025 09:34, Olaf Hering wrote:
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>
> https://github.com/ahf/cocci-syntax/pull/11
>
>   editors/vim/README | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/editors/vim/README b/editors/vim/README
> index 749b5ab2b..44d2437c1 100644
> --- a/editors/vim/README
> +++ b/editors/vim/README
> @@ -3,8 +3,7 @@ README for cocci-syntax
>   
>   Syntax highlighting for Coccinelle's cocci files for vim.
>   
> -Releases are available from http://dev.exherbo.org/~ahf/pub/software/releases/cocci-syntax/
> -and a Git repository is available at git://github.com/ahf/cocci-syntax.git
> +Releases are available from https://github.com/ahf/cocci-syntax
>   
>   Feel free to submit patches :)
>   
