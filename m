Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666D7C021BC
	for <cocci@archiver.kernel.org>; Wed, 26 Feb 2025 08:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CDOnVbuHRa5TlckniZ+QbcxrKwAHtppPzAjAscxNHSY=;
  b=PpGvNemlRybVB5FMgP0hcF7PG001RvEwAddDfFgsGJwAE5SMbHrqqDxa
   8FvjldfKWeaVnjx4VetkGuIjJVZ9hx5+78E/1+g8ccEh91apYkU+p4g4g
   v+9UsNRDAHOY8kzQol6Tfg+Q+WGom1qbUSsMMDyttK0HeygjtkWC2PqKs
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@wanadoo.fr
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="210104093"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2025 09:59:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9415EE0D1D; Wed, 26 Feb 2025 09:59:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2EA55E0260
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 22:26:16 +0100 (CET)
IronPort-SDR: 67be3566_LSBdmqHDv/DQmGiuDUy4gDw15SR8zg3hrDwrWElB+hK0wWD
 By1rhm3xtr04ZitgJ50PUhXJMoVRO+aRINleMRw==
X-IPAS-Result: =?us-ascii?q?A0ENAADuNL5nj0fyDFBaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQn1aMwcISIRWiB1fiHQDhDuHKJIxgUA+DwEDAQ07CQQBAQMEh?=
 =?us-ascii?q?QACixMgBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEBAQE5BQ47hXsNSQEQAYIHAYEkZQk4AQEBAQEBAQEBAQEBAQEbAggFXgEBH?=
 =?us-ascii?q?gEBAQIBIwQLAQUIAQE3AQ8LDgwCJgICIDYGEwIBAYJ+AYIwAw4jBw2wIn8zg?=
 =?us-ascii?q?QGCDAEBBtsnDWyBZQMGgRouAYVrgkUeAYVrRIQzNoFVRIE8gwM+gh+CJINbg?=
 =?us-ascii?q?mmCM4FAg2yOZYghkGFSexwDWSwBVRMXCwcFgSlIA4EPI4EjBTQKNzqCC2lJO?=
 =?us-ascii?q?gINAjWCHnyCK2oEBYEqgjeEQ1wvAwMDA4MqhVKCEYFgAwMWEIMfdxyEf4NpH?=
 =?us-ascii?q?UACAQttPTcJCxsGPaEeATyENQeBDyt7CHqTOx0RgyKQNYo+lCA9NAcrgXOCA?=
 =?us-ascii?q?IFjDIopjziFfQYTL4QDk0EUMpJLLodlkGqMDIF5hAeXJIFnOoFcdIMzTwMZD?=
 =?us-ascii?q?4gAhiEZhR+DVcYtQjUCOgIHAQoBAQMJjimBc4FLAQE?=
IronPort-PHdr: A9a23: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
 AqLlzxEPmYWBaJCnw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HvzWDK3qhYNkeqgUs7i2EgqjBHEkLtp133Aq2lEZdPWaSL3+qy
 ncpoVj6faSskdtZJhAo6H7BEDkexnhHPFOgbX5UY3SJDUO/VHYV72KjrGSoAEIeReeygc178
 4JGJSWSueAa2SS5vyKhTVQfexQpOVvvJrY59v2/jNIYUVDd7xghj0UNi+rVmlbACRPGJZRLv
 Whz/sCgxblWHgTaK2Aa0Utbqzmi5nqrfvdDyI7Ow==
X-Talos-CUID: 9a23:h8v5Ym+ue35vYQUhI7SVv2kqFZABVXeD8FKKDXCIFDpqaueuUFDFrQ==
X-Talos-MUID: 9a23:5KWp3AoWMyPV7FNqmNcezyNpFd5Gu7mjMkcirq4qv9iGGg5oBjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="110055898"
X-MGA-submission: =?us-ascii?q?MDEnoN+MsqvDiQAbzGH6goeahsIP/47kbSQHUe?=
 =?us-ascii?q?B5ajPgM8BNJkXqbZ8K9bzWPz6gvbc0ArxZ3Bt5nXpQojyK3ReRPmw+K0?=
 =?us-ascii?q?8f0uu9eTZg7XZIYB/3pqGobBhEScZP9SREKFE6LmqS+mFLh0Adv8Rty9?=
 =?us-ascii?q?f+iyQ/nu9JQUT1/N3tLXGiCg=3D=3D?=
Received: from smtp-71.smtpout.orange.fr (HELO smtp.smtpout.orange.fr) ([80.12.242.71])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:25:59 +0100
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id n2R0tkeFQ4iG7n2R3t60Fm; Tue, 25 Feb 2025 22:25:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740518758;
	bh=CDOnVbuHRa5TlckniZ+QbcxrKwAHtppPzAjAscxNHSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=siYU52+wZ9L1fww+iQDN9rtYX6/aPczL9atUE2l26+nq1Ri8dh3TYGdKOZSOl8FUk
	 XrbU+P2TpuXPZmylEcNVhm7IGsserFCZYBNjOT562ZUYjLqKjMa1SJH893MOHidh6R
	 OQATR7VDki3fiHZfHEF2JqtwL04PZvB0Oj0pypFUs2f2NaghtKWNKg5zY+oKMy9gx3
	 hJDV0lXDGXzAw1PjH65vHLOKoP3lFuSvJzAbZkaII3cDH1jfDHrdCDL8+lHftSY/+S
	 CY90Fz3FaFYxcLZzbR4khlsrjLfgaLUxO0uOmAn+6ltyDhAKQJ99yzzK2ZVeFXSo2U
	 OrHC+r+ja1CFQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 25 Feb 2025 22:25:58 +0100
X-ME-IP: 90.11.132.44
Message-ID: <44dd2b5b-d91c-4daf-ab75-ed4030180028@wanadoo.fr>
Date: Tue, 25 Feb 2025 22:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Frank.Li@nxp.com, James.Bottomley@HansenPartnership.com,
 Julia.Lawall@inria.fr, Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org,
 axboe@kernel.dk, broonie@kernel.org, cassel@kernel.org, cem@kernel.org,
 ceph-devel@vger.kernel.org, clm@fb.com, cocci@inria.fr,
 dick.kennedy@broadcom.com, djwong@kernel.org, dlemoal@kernel.org,
 dongsheng.yang@easystack.cn, dri-devel@lists.freedesktop.org,
 dsterba@suse.com, festevam@gmail.com, hch@lst.de, hdegoede@redhat.com,
 hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, idryomov@gmail.com,
 ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev,
 james.smart@broadcom.com, jgg@ziepe.ca, josef@toxicpanda.com,
 kalesh-anakkur.purayil@broadcom.com, kbusch@kernel.org,
 kernel@pengutronix.de, leon@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 martin.petersen@oracle.com, nicolas.palix@imag.fr, ogabbay@kernel.org,
 perex@perex.cz, platform-driver-x86@vger.kernel.org, s.hauer@pengutronix.de,
 sagi@grimberg.me, selvin.xavier@broadcom.com, shawnguo@kernel.org,
 sre@kernel.org, tiwai@suse.com, xiubli@redhat.com, yaron.avizrat@intel.com
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-7-a43967e36c88@linux.microsoft.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-7-a43967e36c88@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 07/16] libceph: convert timeouts to
 secs_to_jiffies()
Reply-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2456
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/44dd2b5b-d91c-4daf-ab75-ed4030180028%40wanadoo.fr>

Le 25/02/2025 à 21:17, Easwar Hariharan a écrit :
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@ expression E; @@
> 
> -msecs_to_jiffies(E * 1000)
> +secs_to_jiffies(E)
> 
> @depends on patch@ expression E; @@
> 
> -msecs_to_jiffies(E * MSEC_PER_SEC)
> +secs_to_jiffies(E)
> 
> While here, remove the no-longer necessary checks for range since there's
> no multiplication involved.

No sure it is correct.

Same comment as on patch 06/16, available at [1].

CJ

[1]: 
https://lore.kernel.org/linux-kernel/e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr/

> 
> Acked-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>   include/linux/ceph/libceph.h | 12 ++++++------
>   net/ceph/ceph_common.c       | 18 ++++++------------
>   net/ceph/osd_client.c        |  3 +--
>   3 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 733e7f93db66a7a29a4a8eba97e9ebf2c49da1f9..5f57128ef0c7d018341c15cc59288aa47edec646 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -72,15 +72,15 @@ struct ceph_options {
>   /*
>    * defaults
>    */
> -#define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
> -#define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
> -#define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
> +#define CEPH_MOUNT_TIMEOUT_DEFAULT	secs_to_jiffies(60)
> +#define CEPH_OSD_KEEPALIVE_DEFAULT	secs_to_jiffies(5)
> +#define CEPH_OSD_IDLE_TTL_DEFAULT	secs_to_jiffies(60)
>   #define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
>   #define CEPH_READ_FROM_REPLICA_DEFAULT	0  /* read from primary */
>   
> -#define CEPH_MONC_HUNT_INTERVAL		msecs_to_jiffies(3 * 1000)
> -#define CEPH_MONC_PING_INTERVAL		msecs_to_jiffies(10 * 1000)
> -#define CEPH_MONC_PING_TIMEOUT		msecs_to_jiffies(30 * 1000)
> +#define CEPH_MONC_HUNT_INTERVAL		secs_to_jiffies(3)
> +#define CEPH_MONC_PING_INTERVAL		secs_to_jiffies(10)
> +#define CEPH_MONC_PING_TIMEOUT		secs_to_jiffies(30)
>   #define CEPH_MONC_HUNT_BACKOFF		2
>   #define CEPH_MONC_HUNT_MAX_MULT		10
>   
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 4c6441536d55b6323f4b9d93b5d4837cd4ec880c..c2a2c3bcc4e91a628c99bd1cef1211d54389efa2 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -527,29 +527,23 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
>   
>   	case Opt_osdkeepalivetimeout:
>   		/* 0 isn't well defined right now, reject it */
> -		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
> +		if (result.uint_32 < 1)
>   			goto out_of_range;
> -		opt->osd_keepalive_timeout =
> -		    msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_keepalive_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_osd_idle_ttl:
>   		/* 0 isn't well defined right now, reject it */
> -		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
> +		if (result.uint_32 < 1)
>   			goto out_of_range;
> -		opt->osd_idle_ttl = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_idle_ttl = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_mount_timeout:
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> -			goto out_of_range;
> -		opt->mount_timeout = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->mount_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_osd_request_timeout:
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> -			goto out_of_range;
> -		opt->osd_request_timeout =
> -		    msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_request_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   
>   	case Opt_share:
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index b24afec241382b60d775dd12a6561fa23a7eca45..ba61a48b4388c2eceb5b7a299906e7f90191dd5d 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4989,8 +4989,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
>   	linger_submit(lreq);
>   	ret = linger_reg_commit_wait(lreq);
>   	if (!ret)
> -		ret = linger_notify_finish_wait(lreq,
> -				 msecs_to_jiffies(2 * timeout * MSEC_PER_SEC));
> +		ret = linger_notify_finish_wait(lreq, secs_to_jiffies(2 * timeout));
>   	else
>   		dout("lreq %p failed to initiate notify %d\n", lreq, ret);
>   
> 

