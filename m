Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C67EC76195
	for <cocci@archiver.kernel.org>; Mon, 27 Mar 2023 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7JE7QdvKaZYNiC+EHD6Zp12m/upgFyEAxrLdJhc4mQQ=;
  b=azdVnA62xYzfTxkByJAlNqNRTsnyez9CqK8MDvkE+IGSi4o9YIMdTu2S
   vOhD0vqx3fj/DYqlB1F9iB0A6/YzFsxRIHjztVLVVlHKLwnWvvGbog7wJ
   rQ8tqRsUlWnkpahHbSHwQTL19Ddn2QgCV+EjvVnNDHj3qQabVRPYmm707
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linbit-com.20210112.gappssmtp.com
X-IronPort-AV: E=Sophos;i="5.98,294,1673910000"; 
   d="scan'208";a="99299405"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2023 14:28:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B0350E0D45; Mon, 27 Mar 2023 14:28:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C6130E0D40
	for <cocci@sympa.inria.fr>; Mon, 27 Mar 2023 14:28:40 +0200 (CEST)
IronPort-SDR: 64218bf8_hDlUAvlshydx5Sxa1b0zvDR4KZtVmPUOmc3P8FeQFWvOPRt
 RnWw1dFRUPo21J7Jlln8tghWcpGfiI7O5yyl15A==
X-IPAS-Result: =?us-ascii?q?A0FiAACViiFkfzHdVdFQCh0BAQEBCQESAQUFAUCBPQYBC?=
 =?us-ascii?q?wGCLYFLLwRRhFORAS4DhC+TTYVYgSUDVg8BAwEMAUQEAQEDBIILgnMChTkCH?=
 =?us-ascii?q?QcBBDIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBGQkZB?=
 =?us-ascii?q?w4OBSSFaA2CNykBdYEIAQEBAQEBAQEBAQEBAQEBAQEBARYCeF8CAQMSEQQLA?=
 =?us-ascii?q?Q0BATcBDwsUBgImAgI0AQUBHAYNBgIBAR6CXIJdAwShDYEEQosyfzOBAYIIA?=
 =?us-ascii?q?QEGngqBHgkJAQiBAi0BkDp6J4IogTwMgnc+hBcXK4NDgmeCKodOhxSILwqBN?=
 =?us-ascii?q?HaBIA6BPYEEAgkCEWuBEghngXxAAg1jCw5vgUoCgkElBA4DGSsdQAIBCzs6P?=
 =?us-ascii?q?zUJCyAGWGsCLBETBQMLFSpHBAg5Bho0EQIIDxIPBiZEDkI3NBMGXAEpCw4RA?=
 =?us-ascii?q?0+BRwQvgVwGASYknSAgATwWBDdMJoIEkliSQJ5CB4N9oHEGDwQulwgUkiMuh?=
 =?us-ascii?q?y2QD6dxAgoHBhAjgUcOJYFccIM3TwMZD44gg3KPez80AjkCBwEKAQEDCYI5h?=
 =?us-ascii?q?jKCWAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NBeCQ6HfAu1kJ5oSpLqEMceALOsnbusQ8zAXPo5KOGVom7+j5r
 uTdZMgpGDJYVcqKQ0dcLW7UpVoLkmsl6KdjbNhR4tKGTOWxVdAT7sSiLcKoQeQeBEWn9Q1vc
 wBT0E9MqyJMbETt6fHCWKDYrEdKbe8gcaVbKvlvhNQpMJRB52ILT0VNu9WKCJLrcB9a6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,294,1673910000"; 
   d="scan'208";a="99299397"
X-MGA-submission: =?us-ascii?q?MDFbJi1F7bHXjYuDduF7NawATTk9L9Z91BWrvj?=
 =?us-ascii?q?MK0ZORqQSvMAIanCBrrG6/wQOGzcnuJYUE2+YpzGvvf+fAVzY3MpktUG?=
 =?us-ascii?q?pIag1bgUsVox9baYAHZKA5yoit22X5Q5uCiUu7csNM1llCrxqu1vL9dJ?=
 =?us-ascii?q?VTZvGdnrWhdEv1b+IVULoptg=3D=3D?=
Received: from mail-wr1-f49.google.com ([209.85.221.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:28:40 +0200
Received: by mail-wr1-f49.google.com with SMTP id y14so8607487wrq.4
        for <cocci@inria.fr>; Mon, 27 Mar 2023 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1679920120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JE7QdvKaZYNiC+EHD6Zp12m/upgFyEAxrLdJhc4mQQ=;
        b=2L0cR5VE2NFhVPykwsr4iw3GlHlZuOz/yTvn7XLSW0BbgbuceoOqdTYO3ba2irsviG
         tqODrs0635EEPHYkxxMW6IP5tFr+qNcFFuZsCaEN5jSFRvtzh4aodQEruC0iH7w8RGPf
         w4v4HSAzC4/lTVdvhrdGUAHvQLybaEoXo0jQSluLK4+n8sBIGulmpBtWxlhiETyPS6+9
         FDxT8anFyaMOG+pEsCtl34lHodYnMqdtqWKoNYT4DA+1PTHED3jOL4KcEavojhBrKQDM
         3RkwnlBekLln7xj7/MPlqU+ZeUa//7ckmCFfRFueD1q8Opy3xng9vUWcSqI/5Jq09eFX
         xBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679920120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JE7QdvKaZYNiC+EHD6Zp12m/upgFyEAxrLdJhc4mQQ=;
        b=530ni2N3waeh/24PvpbeC37zfc195oOxG6ors+QP1t+74bT5bJR3e2wRMnfROdua04
         ulfIuByQHLUS28x1VWkmDxv3XYRfAXAiCBXmgoR1gHbgbJ5mg9ys0m0IxjLPLEA6wNPu
         Ql8CHZLLPnzQwyS9uJsMNRzAF8aYbFNYJJ/i3u1w137HdBSVMHdVqBUiqt8N6eipNmca
         vT5iBybPwGaxWXNR0m//kodPAQvhhPopRfMaGEzrhI8an1E59XDvBwk0VR2k/yS5AlqV
         UO4nc/O4Ay7u8M1+5g4wvgPQjGOPLLkpb8ijrzukczG8qqErqbTrRrw/lF+hOtl7/RDL
         57/w==
X-Gm-Message-State: AAQBX9esIObGPDjKWcqFLghZnSZzs4nZsb/M2/v6/NwVfCQJgfhNsRtu
	s8jMdsuVJ8b/JM0MnxglDWQpOg==
X-Google-Smtp-Source: AKy350aYLU0BuXDE6SXKbUGRw51RJogCMJNwzIn8Anvk+Et3prniahCnvNWUrpjPpBnsQ7XeEp0+nQ==
X-Received: by 2002:a5d:6a87:0:b0:2d0:c73d:ef2a with SMTP id s7-20020a5d6a87000000b002d0c73def2amr9184389wru.24.1679920119730;
        Mon, 27 Mar 2023 05:28:39 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe10d000000b002db1b66ea8fsm11525226wrz.57.2023.03.27.05.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 05:28:38 -0700 (PDT)
Message-ID: <a989f01e-79a9-44a4-3603-ba4eeeb86dea@linbit.com>
Date: Mon, 27 Mar 2023 14:28:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8d193937-532f-959f-9b84-d911984508aa@web.de>
 <941709b5-d940-42c9-5f31-7ed56e3e6151@web.de>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <941709b5-d940-42c9-5f31-7ed56e3e6151@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] [PATCH resent] drbd: Fix exception handling in
 nla_put_drbd_cfg_context()
Reply-To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
X-Loop: cocci@inria.fr
X-Sequence: 964
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/a989f01e-79a9-44a4-3603-ba4eeeb86dea%40linbit.com>

Am 25.03.23 um 15:07 schrieb Markus Elfring:
> Date: Fri, 17 Mar 2023 18:32:05 +0100
> 
> The label “nla_put_failure” was used to jump to another pointer check
> despite of the detail in the implementation of the function
> “nla_put_drbd_cfg_context” that it was determined already that
> the corresponding variable contained a null pointer.
> 
> * Thus return directly after a call of the function
>   “nla_nest_start_noflag” failed.
> 
> * Delete an extra pointer check which became unnecessary
>   with this refactoring.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 543cc10b4cc5c60aa9fcc62705ccfb9998bf4697 ("drbd: drbd_adm_get_status needs to show some more detail")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/block/drbd/drbd_nl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index f49f2a5282e1..9cb947127472 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -3187,7 +3187,7 @@ static int nla_put_drbd_cfg_context(struct sk_buff *skb,
>  	struct nlattr *nla;
>  	nla = nla_nest_start_noflag(skb, DRBD_NLA_CFG_CONTEXT);
>  	if (!nla)
> -		goto nla_put_failure;
> +		return -EMSGSIZE;
>  	if (device &&
>  	    nla_put_u32(skb, T_ctx_volume, device->vnr))
>  		goto nla_put_failure;
> @@ -3205,8 +3205,7 @@ static int nla_put_drbd_cfg_context(struct sk_buff *skb,
>  	return 0;
> 
>  nla_put_failure:
> -	if (nla)
> -		nla_nest_cancel(skb, nla);
> +	nla_nest_cancel(skb, nla);
>  	return -EMSGSIZE;
>  }
> 
> --
> 2.40.0
> 

Sorry, I fail to see how this is an improvement over the status quo,
much less a "fix".

Can you identify the issue with the current code and can you explain how
your patch makes it better?

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
