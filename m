Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A550FC02198
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2025 20:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HDo14UWXJJhikq+DLyV4VOaNI1GvjMImjjxkh0rzydg=;
  b=rq3dL6Pn9MswSRAcXwpl2+SC4+oJFzobMNo7ARcfrG/0sd/1HnNQ7fd0
   EjRJLaLUdoSEwDTaoNvcy/8Jroh7T2EyZX63GHv461uPBs4+oGEdDTvjT
   GUTa/9m5jrvfIF4RjMRzMNQRY54gA1uAA7mbp4bo+3QDg4DB5zbW0fJQH
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.13,259,1732575600"; 
   d="scan'208";a="206605035"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 21:16:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 63D44E0D1F; Tue,  4 Feb 2025 21:16:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 11104E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 21:16:09 +0100 (CET)
IronPort-SDR: 67a2757f_V+I0mK0k8U8SU2WgPPc1Di6pAg7f1LoBVNZUzt9ySDKBd8h
 0JS71NahW3t9mzBZLsk9+9nPMCB3JudcIsIOTxQ==
X-IPAS-Result: =?us-ascii?q?A0EPAAAPdaJnfC/YVdFaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQAUBAQELAYJDgVY0BAtIhFaPT4IhA4t2kiCBQD4PAQMBDUQEAQEDB?=
 =?us-ascii?q?DiESAKKfgIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABASIZBw4SKYV7DYJiAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEFAixfAQEBAxIRBBkBGx0BAwwGBQsDCgICJgICIAEBE?=
 =?us-ascii?q?QEFARwGEyKCYIIwAQMxA6cWgQVCiz5/FgUCFoEBgg0G2lwKGSgNbAOBYgIHF?=
 =?us-ascii?q?IEGLgGEcylcgjceAYFsg38bKYM5eicbgUlEgUqBBoFvPoIfgiQVg0aCaQSCL?=
 =?us-ascii?q?0qBJ4NAok0mCAEGFwMHBwkFBAkTBgUFAkIJBgUKEgMEAwQEAQILEwkDAwIOA?=
 =?us-ascii?q?ggDAggGGQE/EgQTCg0LBwUfCggMEQooAyIEDisPAQIBVwU0AQgGAgIEBAIEA?=
 =?us-ascii?q?goCCQICCAcCFAMCBAQCAQUSAwsBBQYFAQEEDA4CAgMDAgIBCAICAQECFAEEA?=
 =?us-ascii?q?wEHAgEEAwUDCgEBAQIBBBQGAwUDAwcDBAIDAgYCBAUFAgIDAwIDAQMDAgECA?=
 =?us-ascii?q?wkQDxYCAgMEAgYCAgEEJgIBFQUCAwQCAgcCAgMBAgECAgIEAgQCAgYDCQgBA?=
 =?us-ascii?q?gIHAQICAgMVAgUBBAkDAwUSDCADAgICAgMHCgMFAgEBAgQDAwMDDA0HAgMBA?=
 =?us-ascii?q?gEDBQMBAgECCQMGAgIDAwQSGQUDAg8DAgEFBAIIEAsHAQEPFAUECQUVAwYCA?=
 =?us-ascii?q?wMWCwQFAwMDAQwPDgICCwMXBQEBBwEDDQgDBAQCAwMJAgEQAQMEAgkCBAECC?=
 =?us-ascii?q?gICAgICBAEBBQQCBAMCBQICAQgEAwMDDQQDCAgDBQMMEgICAgkCAwECAwMDB?=
 =?us-ascii?q?A0IHQUJEQsCCQMEDQIEAgIBBgMGCgYVAQIYAgIGDAQDAwgDAgMCAgECAgIBE?=
 =?us-ascii?q?QICCQgNBQkFBgICFQMCAwgBCQMPAwIUAQYCCAMHAQEEAgIKEwoBAQICAQYmA?=
 =?us-ascii?q?wEBAhQTBwMIAgICAgYWDAEFBwMHDwUFBAICFgMDEgQEEAICAwMCAQEUBhUBB?=
 =?us-ascii?q?QIDBgsBBgECBQQCAwQCEgIDDhMDAwQGAwECChACBAIJCgEFBAMHBQIfAwMCA?=
 =?us-ascii?q?gULAggCAgUCBQcDCQ4BAgUDBAkCFAIQAgICAggWAgICBQUYAyYCBAMDAwMLA?=
 =?us-ascii?q?QICDgkDBDgGEQQCAwMCDgECAgsBAgIEAgMBBAcJAwMJCgcBCg0HAgIKCAkQA?=
 =?us-ascii?q?QICDwcDAgICAgYHDgMCEw8FBgYCCgcNCgQCAQICFQIDCQYDBQ0DBwQKDQIVA?=
 =?us-ascii?q?hYFAyACCAkLAgcRAgUSAw4FAwICEQQCAwYFAwEHARcDBwgCAgwCAgICBQIFA?=
 =?us-ascii?q?gUXEQENBAMDAwIIAQQVBgMJCCobEgEBAQUBCQIDAgMECAMDAwIDBAwLAgEHC?=
 =?us-ascii?q?AMDBgsICQYDAgcIGQMFBAMHBQshAgYDAgQFBAEFAhMNAgMZAgYDBhQJDAIGC?=
 =?us-ascii?q?AcJAwcBAQECAgIIAQUFDAkCAwQCBQQEAQEIAwMEBgIBAwICAgEECgEBAQIKA?=
 =?us-ascii?q?ggKAQkTBAMIAwMDAwMFAQICCAQTBQUCAQUMEwwBCgYDBgMEAgICCgEHAgMDA?=
 =?us-ascii?q?wIHAQsjAgEDAgIFAgIBBQMCAgYEAwIBAQkCAwIIAQICAQECAgIEAQcBBAcGA?=
 =?us-ascii?q?QECBAICNAIBAwkCBQEBAQ4CAgQCAgECAgIEAgQBAgYLBAUNAQECAQICAQEBB?=
 =?us-ascii?q?AEIAwEBAQICAwMFAwUIDw0BARcLHQUEBQICAQEBAQECEwICAQsBAgEBAxsCA?=
 =?us-ascii?q?QMDBAELAgEBBB8EFgICAgICAgQCAwICAwICAgsUFR0CCQMjDwMLCQgTPQELB?=
 =?us-ascii?q?zIENgEUFAcrIV+dWTyDchkHAYENgSeBAnqSQYNRrxFxaIM9m0+GETOqUy6HZ?=
 =?us-ascii?q?JBqkgqXExEjEoE0AjaBXDMaCBsVbII2TwMZD4gAhiEMFoNYyDZFMjwCBwEKA?=
 =?us-ascii?q?QEDCZA2gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RH0i0UD6I+5xIy9FVFYJcjlO368b57UMwz0sQ==
IronPort-HdrOrdr: A9a23:B26WIKORszXaNcBcTjGjsMiBIKoaSvp037Dk7TEKdfUzSL3lqy
 nOpoVn6faQslwssR4b6Le90cW7MBfhHNtOkOws1NSZLWrbUQmTXfhfBOLZqlWKJ8S9zJ8+6U
 4KSdkHNDSfNykAse/KpCa/CMgp29SK/eSFgu3E325xQQwCUc1dxjY8JALePUF/WRVcCYBRLu
 v72uN34xSlPVoYB/7UOpDHZYf+Th/w+a4OrSRmO/fv0mmzsQ8=
X-Talos-CUID: =?us-ascii?q?9a23=3AaxTcl2o/GTtVk+rHXFN7snfmUf4hTVrQy3LOGh6?=
 =?us-ascii?q?5Vz9zVYeZdWSX85oxxg=3D=3D?=
X-Talos-MUID: 9a23:TrmTrQn5OkFA8lqxdsVfdnoyLN5a8or3EnwQy5cplNCabxx9Z2mC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,259,1732575600"; 
   d="scan'208";a="108211338"
X-MGA-submission: =?us-ascii?q?MDEDNrG4nHHXP6f6KKdsqD+gSkg6XgxW7dDLGy?=
 =?us-ascii?q?VLX8fMJYqC7nKX9xHe2G/0klyIIs+rWUes/u+VjFY0MhkPtOEVXmR2Nt?=
 =?us-ascii?q?zwNxw70NzPMaHOzcyenKfMhkYmS3xGte+6im/+0mrDkupZTv+rwSX+Td?=
 =?us-ascii?q?z4glqxkDRaoUlZa4msmzy3/w=3D=3D?=
Received: from mail-pj1-f47.google.com ([209.85.216.47])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 21:15:59 +0100
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f9bac7699aso1992972a91.1;
        Tue, 04 Feb 2025 12:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738700157; x=1739304957; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDo14UWXJJhikq+DLyV4VOaNI1GvjMImjjxkh0rzydg=;
        b=NEcTYe1leYWN8bjQN3mFcKYdrWfUAlhJiNBzlx+MwvWe3sEXrSG3uCgmefzQcpD6QN
         2Hu2HgJJ6jW5e0g295ZGH3TXnEiHaIzRwug6GFdIGKAufOM76RwfDf6au4THpGsj9Z6Z
         4uo0Jb9OIEJmpNqDJn2OyoqUgj3hGeiOEnAdyrSXzESDJxHflhlwjuCEZZOvwpmyp/Gz
         7c7z/4YDWwyOIaiLyEZB/p4s2vi1KX1PPsPshedKg0IMlIQz8tGCb+JZFa9mZhSubMPb
         +2h8Q42/5LMdZa7IdOooAVRTygc5WrqWklvuhMCWqWPM/zYNJM6zdW3Z7D3uvJfpF2mH
         3j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738700157; x=1739304957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDo14UWXJJhikq+DLyV4VOaNI1GvjMImjjxkh0rzydg=;
        b=PaylogedD2LO/D/WVpvB7gz6AcjhDwHB6NIbPf4MOdBadLah0kT3hG/PAkFI3qbM/s
         k3R84vDKZ0BOHw1d6oZVeVbmJHGRRKuAMjmKjrej2jVusLZQHoqJFdsLJIrcYumKJWlL
         Sd+OiVbvQm35Z/Ntp6R/Oc2/nX64MQ/0VlOQuCit3Vj8ZorXvtq/5KRfNY5FXbt0fFW+
         dp8UljZEV7qpKHKNtDrWQ4JPcG/OANgdmzVM7XrJAQPVI3vQvE3hyUcF9D34inFNMXCC
         XcKnoUqmE5xbXKs2eN+Uj+9E2OW7vTqAaX4L6ZnqppiVCBYWTxsp6n82baoGgml2VelC
         YPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkzSZnxgS6mlOTSGdLVSrgqZg/Yy8Lsn8CzaaqKqukXPE6+AdMweu8Z51Mb55drkSP0TJz4QEwUObIMw8=@inria.fr, AJvYcCVnG07RBFlw/r6hQDFBH7X2C015kFAs+Q9cgXCJ6/aHYyN0azTaf6gaA6UTRxpC4G2DSrOIIq8=@inria.fr
X-Gm-Message-State: AOJu0YzXicC/h4bL8nqXkUYVtX5luvH6sD9OMxlBeCqIUtav/NadwUFg
	9lr7CJVp43EpZQQ6/bsukrDWj9djqVkqF0vFPNQp7PtpZOMQgMqH46oWZGtaAe2mIv5mA0pQPaZ
	lEWeSRDK8IfvjozfOQmdHsJzni8Y=
X-Gm-Gg: ASbGncvGRbLeO+9LLsDEHKaIUjCvsy3tdqGPbex6ph0wXYk+sGAH1toVUgXxvVVW7r9
	q7J5H0m4G7w8bg9kWB65bZX5ca1YcZbJ0LWbeZ3xAfRfAKSBCeB6PtptAGHfgb3GF0ce5270M
X-Google-Smtp-Source: AGHT+IFpUn4ty+hTBTAscWBy/P6n51/jgfEImKVtStudLd6LSKIl/9ac2I1XNzbeRalZoB0WUHUyHWRLIpYi1FKnBlE=
X-Received: by 2002:a17:90b:5289:b0:2ee:8008:b583 with SMTP id
 98e67ed59e1d1-2f9e0792e11mr153173a91.16.1738700156925; Tue, 04 Feb 2025
 12:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com>
 <20250203-converge-secs-to-jiffies-part-two-v2-2-d7058a01fd0e@linux.microsoft.com>
In-Reply-To: <20250203-converge-secs-to-jiffies-part-two-v2-2-d7058a01fd0e@linux.microsoft.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 4 Feb 2025 21:15:45 +0100
X-Gm-Features: AWEUYZmez9Mpz0-SYRI0bR38UXb1Ekbuss658D4anHnBb41KwIIcd5IfJG1eviU
Message-ID: <CAOi1vP8djn-cpTMv+qVO4-cK9GD7vousoNEg8hOQ2fTU5t+NOg@mail.gmail.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Dongsheng Yang <dongsheng.yang@easystack.cn>, 
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, cocci@inria.fr, 
	linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH v2 2/3] rbd: convert timeouts to
 secs_to_jiffies()
Reply-To: Ilya Dryomov <idryomov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2343
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/CAOi1vP8djn-cpTMv%2BqVO4-cK9GD7vousoNEg8hOQ2fTU5t%2BNOg%40mail.gmail.com>

On Tue, Feb 4, 2025 at 12:50=E2=80=AFAM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication=
.
>
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci wit=
h
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
>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/block/rbd.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index faafd7ff43d6ef53110ab3663cc7ac322214cc8c..41207133e21e9203192adf3b9=
2390818e8fa5a58 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -108,7 +108,7 @@ static int atomic_dec_return_safe(atomic_t *v)
>  #define RBD_OBJ_PREFIX_LEN_MAX 64
>
>  #define RBD_NOTIFY_TIMEOUT     5       /* seconds */
> -#define RBD_RETRY_DELAY                msecs_to_jiffies(1000)
> +#define RBD_RETRY_DELAY                secs_to_jiffies(1)
>
>  /* Feature bits */
>
> @@ -4162,7 +4162,7 @@ static void rbd_acquire_lock(struct work_struct *wo=
rk)
>                 dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
>                      rbd_dev);
>                 mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
> -                   msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SE=
C));
> +                   secs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT));
>         }
>  }
>
> @@ -6283,9 +6283,7 @@ static int rbd_parse_param(struct fs_parameter *par=
am,
>                 break;
>         case Opt_lock_timeout:
>                 /* 0 is "wait forever" (i.e. infinite timeout) */
> -               if (result.uint_32 > INT_MAX / 1000)
> -                       goto out_of_range;
> -               opt->lock_timeout =3D msecs_to_jiffies(result.uint_32 * 1=
000);
> +               opt->lock_timeout =3D secs_to_jiffies(result.uint_32);
>                 break;
>         case Opt_pool_ns:
>                 kfree(pctx->spec->pool_ns);
>
> --
> 2.43.0
>

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
