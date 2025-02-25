Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D50C021BE
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 21:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:references:from:to:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tARq/I59R/ifvYF0dCCLUoCvyYc1ZBk7Dm3FuvihB2s=;
  b=lvl4tMCDBHjFyb1Pww4yfGX9zkedb/npbxi4KUF3gwdcTpMUNQJ41+kf
   TsCcogjEXwtWVmkq0/5iWMSo6Qk2TFO8cA6osOKKdHi5wzLA6buZ3Gz6q
   qeiDqN6853SvrpvvnMYhvFTliuwnrCNCmcelafgqtkOKHOkgcA9c8uU1I
   o=;
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
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210047167"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 22:17:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79CA3E0264; Tue, 25 Feb 2025 22:17:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F101E0260
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 22:10:10 +0100 (CET)
IronPort-SDR: 67be31b1_95ZDR/0atCRfWSAGXvHVNJn3pNKsSQsLj9RTk/nb3MBTdBT
 GWOHhvhzrDG3vQ1NfM6PFiPZvYaXkhX5cotULmA==
X-IPAS-Result: =?us-ascii?q?A0EDAAAVMb5nj0/yDFBaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgVczBwhIhFaIHV+IdAOEO5lZgUA+DwEDAQ1EBAEBA?=
 =?us-ascii?q?wSFAAKLEyAGAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBAQEBATkFDjuFew2CYgGBJGUJOAEBAQEBAQEBAQEBAQEBGwIIYwEBHgEBA?=
 =?us-ascii?q?QIBIwQLAQUIAQE3AQ8LDgwCJgICVgYTAgEBgn6CQiMHsDl/M4EBggwBAQbcI?=
 =?us-ascii?q?IFlCYEaLgGFa4JjAYVrRIQzNoFVRIE8C4EJgW8+gmEEhTmCaYIzgUCDbIY/o?=
 =?us-ascii?q?ShSexwDWSwBVRMXCwcFgSlIA4EPI4EjBTQKNzqCC2lJOgINAjWCHnyCK2oEB?=
 =?us-ascii?q?YEqgjeEQ1wvAwMDA4MqhVKCEYFgAwMWEIMfdxyEf4NpHUACAQttPTcJCxsGP?=
 =?us-ascii?q?aEfPIQcGQcBgQ2BJ4ECepJBg1CvUDQHK4FzggCBYwyfXgYTL5dEFJJ9Lodlk?=
 =?us-ascii?q?GqpMIFnOoFcdIMzTwMZD4gAhiEMDQmFFsoNQjU8AgcBCgEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0CX7gqyNh3ksaUtBeoYDKrPw771zdoMgy1knxilNoNJuA7Slfr
 OV7ZMmPHjP+UsssRAb6Kq90cy7K080mqQU3WB8B8bFYOCighrSEGgA1/qA/9SDIUzDH4dmvM
 8KT0E9MqyVMbEQt7ee3ODXKadY/DDKytHLuc7ui1NACSl3dqAI1WtEIzfeNmEzaQFaCfMCe6
 a0145ii36AdXEQB/7XOlA1G8zu4/3z/aiJXSI7
X-Talos-CUID: =?us-ascii?q?9a23=3AO/lnuWgoGFfZXOk7i8JO2jKWlDJuMUCD4UXKP2a?=
 =?us-ascii?q?DUSVZRKylbniU/ZFkup87?=
X-Talos-MUID: 9a23:xio5uQksxjDCAv2dCP2mdnpyE9ZIuvmUCHwHiJQ6tMiBMx5IZzi02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210046571"
X-MGA-submission: =?us-ascii?q?MDEKrsJtR2Vvvm0FPqBvwR4k0kJnz1rh+L8+cJ?=
 =?us-ascii?q?SIGFGiefAtuJLpiizUTgzmVz/B5E+DzDLTucfhrt4KkNZPWIC3c7FNkY?=
 =?us-ascii?q?KCkGHR4Eb2cbnpscdoOA4rnSuvFJncm63F/mnjquDBB2l4Lg9EsWr6at?=
 =?us-ascii?q?WmJput7FPpRRS10RYL15ZlcQ=3D=3D?=
Received: from smtp-79.smtpout.orange.fr (HELO smtp.smtpout.orange.fr) ([80.12.242.79])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:10:10 +0100
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id n2BftCcRTqJDFn2BitbctU; Tue, 25 Feb 2025 22:10:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740517809;
	bh=tARq/I59R/ifvYF0dCCLUoCvyYc1ZBk7Dm3FuvihB2s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=Nt/l6W83BU5mDSrDQIQy8CZKAo0h68PJvcKps3BRoVn2m6bAUl1vWhK2es/BP8BFW
	 DN3RlPUQFqJK58J49zS8Iq+H8FIQKGC4aR3FLiDA6idBgn8tIg5Twr41t+eDK/0sPp
	 mg1FQKV8UkENBVw737LGxuMBZo+ZBM/oK6VglExOrG9+5UCmVjY6kqG7UnMc6VpiKZ
	 s5Dl6bX1iLuElode1uDwU8GHn7T6IquRWeHKn8Hf+NPHn6mqYOqdxW2q2i+4k7lkXn
	 e6Eo2vgp4trckiymDN9vhHfOlmyq2Gyk1kUlSKjSw+1pc9JkNq2cH1UTJN+cQ2XgrM
	 /ezXxEpZ+Rm3Q==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 25 Feb 2025 22:10:09 +0100
X-ME-IP: 90.11.132.44
Message-ID: <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
Date: Tue, 25 Feb 2025 22:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3 06/16] rbd: convert timeouts to
 secs_to_jiffies()
Reply-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2454
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/e53d7586-b278-4338-95a2-fa768d5d8b5e%40wanadoo.fr>

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
> While here, remove the no-longer necessary check for range since there's
> no multiplication involved.

I'm not sure this is correct.
Now you multiply by HZ and things can still overflow.


Hoping I got casting right:

#define MSEC_PER_SEC	1000L
#define HZ 100


#define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)

static inline unsigned long _msecs_to_jiffies(const unsigned int m)
{
	return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
}

int main() {

	int n = INT_MAX - 5;

	printf("res  = %ld\n", secs_to_jiffies(n));
	printf("res  = %ld\n", _msecs_to_jiffies(1000 * n));

	return 0;
}


gives :

res  = -600
res  = 429496130

with msec, the previous code would catch the overflow, now it overflows 
silently.

untested, but maybe:
	if (result.uint_32 > INT_MAX / HZ)
		goto out_of_range;

?

CJ


> 
> Acked-by: Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Easwar Hariharan <eahariha-1pm0nblsJy7Jp67UH1NAhkEOCMrvLtNR@public.gmane.org>
> ---
>   drivers/block/rbd.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index faafd7ff43d6ef53110ab3663cc7ac322214cc8c..41207133e21e9203192adf3b92390818e8fa5a58 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -108,7 +108,7 @@ static int atomic_dec_return_safe(atomic_t *v)
>   #define RBD_OBJ_PREFIX_LEN_MAX	64
>   
>   #define RBD_NOTIFY_TIMEOUT	5	/* seconds */
> -#define RBD_RETRY_DELAY		msecs_to_jiffies(1000)
> +#define RBD_RETRY_DELAY		secs_to_jiffies(1)
>   
>   /* Feature bits */
>   
> @@ -4162,7 +4162,7 @@ static void rbd_acquire_lock(struct work_struct *work)
>   		dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
>   		     rbd_dev);
>   		mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
> -		    msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SEC));
> +		    secs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT));
>   	}
>   }
>   
> @@ -6283,9 +6283,7 @@ static int rbd_parse_param(struct fs_parameter *param,
>   		break;
>   	case Opt_lock_timeout:
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> -			goto out_of_range;
> -		opt->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->lock_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_pool_ns:
>   		kfree(pctx->spec->pool_ns);
> 

