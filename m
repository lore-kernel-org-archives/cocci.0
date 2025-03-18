Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A607C28B2F
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jI22lD3fbX7NUxwVE7G3shGCmzg16hLkIyYlar9tKnQ=;
  b=Hxe9rSKa1AMu+MgDoQvno5xZsaVhC0Ffbi0y5opY4na9Dqhxm0aSIfjs
   rjarjL5UfiDrsW4iKaiaUlT836+nlj0pLZqG91zpvDHF4n3YSovYuVFT8
   L1VnMUcj2vBKdwcka2hTF4fRmAINyX51G0b8TCOcxXlkILtZAoUsH0N5Z
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
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213489437"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 14:15:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 94488E0D1F; Tue, 18 Mar 2025 14:15:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 24801E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 14:15:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=jI22lD3fbX7NUxwVE7G3shGCmzg16hLkIyYlar9tKnQ=;
  b=HhFSkNtxJ+NXOgtGSspPmenlhjrB3KA7CytJmQXSUT5MTfXyqbs654H9
   R6fgQcu5fdrj8x53u/y7lzYdFWOLxhdbGmZfdmXhQUaj81I8Ib6GK+jJI
   gW2B+ESWBJ/h0R8K+JuhLRKpJH8pYaNW5dhNNxB2apHtavrJJ2pq+Vr9V
   Q=;
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="111907401"
Received: from lfbn-idf2-1-133-189.w83-202.abo.wanadoo.fr (HELO [192.168.1.23]) ([83.202.217.189])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 14:15:42 +0100
Message-ID: <f5bd8460-844f-43cd-8c74-308db2c93c16@inria.fr>
Date: Tue, 18 Mar 2025 14:15:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <20250317075809.27150-1-olaf@aepfle.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <20250317075809.27150-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH v1] Adjust configure warning for systems without
 hevea
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2617
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/f5bd8460-844f-43cd-8c74-308db2c93c16%40inria.fr>

Merged to master. Thanks for the patch.

On 17/03/2025 08:58, Olaf Hering wrote:
> Fixes 07e224f35 ("small fixes in configure and man pages")
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>   configure.ac | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index 489ca91c7..38381a323 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -65,7 +65,7 @@ AS_IF([test "`$ECHO --version`" =  "--version"],
>    
>   dnl  hevea is necessary to make docs
>   AC_PATH_PROG([HEVEA],[hevea])
> -AS_IF([test -z "$ac_cv_path_HEVEA"], [AC_MSG_WARN([hevea not detected -- you will be able to rebuild the documentation])])
> +AS_IF([test -z "$ac_cv_path_HEVEA"], [AC_MSG_WARN([hevea not detected -- you will not be able to rebuild the documentation])])
>   
>   dnl  patchelf is an optional dependency and in principle not used for building Coccinelle
>   AC_PATH_PROG([PATCHELF],[patchelf])
