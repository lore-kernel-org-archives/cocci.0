Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF86C02193
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2025 20:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KR/DuzPu4L6UmQMWZ9c+c7Q6VILPpItJGIL+ba1HmaQ=;
  b=AwNjItCkHNhjbmhAAfeRXp9T0RAi2OAGsTbsaEQZ9S/KymJv2VM7eFzE
   Ix2XcD7Qg6H2IxH6KB1F6Rf/iVpuIDQT4CowO9q9Y//fEjAxxZKi7JeC1
   7lKE6PMQXIXI3Hb1x4KxNhx3r1drzt3k7SUt6WUvCnJIUGaBDYflkOi72
   A=;
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
   d="scan'208";a="206605080"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 21:16:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1C5EDE0D1D; Tue,  4 Feb 2025 21:16:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3E913E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 21:16:29 +0100 (CET)
IronPort-SDR: 67a2759c_Pxar4FBYDml5yGHR9iyb2soOfs8qW5UNDyj0R3U3jv1C6Hz
 XGpq9peqltTXg14KM4XEahIGoAKuSFoLyEzKISg==
X-IPAS-Result: =?us-ascii?q?A0EIAACQdKJnfLPWVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAYJDgVY0BAtIhFaPT4IhA4t2kiCBQD4PAQMBD?=
 =?us-ascii?q?UQEAQEDBDiESAKKfgIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABASIZBw4SKYV7DYJiAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEFAixfAQEBAxIRBBkBGx0BAwwGBQsDCgICJ?=
 =?us-ascii?q?gICIAEBEQEFARwGEyKFEAEDMQOnFoEFQos+fxYFAhaBAYINBtpcChkoDWwDg?=
 =?us-ascii?q?WICBxSBBi4BhHMpXII3HgGBbIN/GymDOXonG4FJRIFKgnU+gh+CJBWDRoJpB?=
 =?us-ascii?q?IIvSoEng0CiTSYIAQYXAwcHCQUECRMGBQUCQgkGBQoSAwQDBAQBAgsTCQMDA?=
 =?us-ascii?q?g4CCAMCCAYZAT8SBBMKDQsHBR8KCAwRCigDIgQOKw8BAgFXBTQBCAYCAgQEA?=
 =?us-ascii?q?gQCCgIJAgIIBwIUAwIEBAIBBRIDCwEFBgUBAQQMDgICAwMCAgEIAgIBAQIUA?=
 =?us-ascii?q?QQDAQcCAQQDBQMKAQEBAgEEFAYDBQMDBwMEAgMCBgIEBQUCAgMDAgMBAwMCA?=
 =?us-ascii?q?QIDCRAPFgICAwQCBgICAQQmAgEVBQIDBAICBwICAwECAQICAgQCBAICBgMJC?=
 =?us-ascii?q?AECAgcBAgICAxUCBQEECQMDBRIMIAMCAgICAwcKAwUCAQECBAMDAwMMDQcCA?=
 =?us-ascii?q?wECAQMFAwECAQIJAwYCAgMDBBIZBQMCDwMCAQUEAggQCwcBAQ8UBQQJBRUDB?=
 =?us-ascii?q?gIDAxYLBAUDAwMBDA8OAgILAxcFAQEHAQMNCAMEBAIDAwkCARABAwQCCQIEA?=
 =?us-ascii?q?QIKAgICAgIEAQEFBAIEAwIFAgIBCAQDAwMNBAMICAMFAwwSAgICCQIDAQIDA?=
 =?us-ascii?q?wMEDQgdBQkRCwIJAwQNAgQCAgEGAwYKBhUBAhgCAgYMBAMDCAMCAwICAQICA?=
 =?us-ascii?q?gERAgIJCA0FCQUGAgIVAwIDCAEJAw8DAhQBBgIIAwcBAQQCAgoTCgEBAgIBB?=
 =?us-ascii?q?iYDAQECFBMHAwgCAgICBhYMAQUHAwcPBQUEAgIWAwMSBAQQAgIDAwIBARQGF?=
 =?us-ascii?q?QEFAgMGCwEGAQIFBAIDBAISAgMOEwMDBAYDAQIKEAIEAgkKAQUEAwcFAh8DA?=
 =?us-ascii?q?wICBQsCCAICBQIFBwMJDgECBQMECQIUAhACAgICCBYCAgIFBRgDJgIEAwMDA?=
 =?us-ascii?q?wsBAgIOCQMEOAYRBAIDAwIOAQICCwECAgQCAwEEBwkDAwkKBwEKDQcCAgoIC?=
 =?us-ascii?q?RABAgIPBwMCAgICBgcOAwITDwUGBgIKBw0KBAIBAgIVAgMJBgMFDQMHBAoNA?=
 =?us-ascii?q?hUCFgUDIAIICQsCBxECBRIDDgUDAgIRBAIDBgUDAQcBFwMHCAICDAICAgIFA?=
 =?us-ascii?q?gUCBRcRAQ0EAwMDAggBBBUGAwkIKhsSAQEBBQEJAgMCAwQIAwMDAgMEDAsCA?=
 =?us-ascii?q?QcIAwMGCwgJBgMCBwgZAwUEAwcFCyECBgMCBAUEAQUCEw0CAxkCBgMGFAkMA?=
 =?us-ascii?q?gYIBwkDBwEBAQICAggBBQUMCQIDBAIFBAQBAQgDAwQGAgEDAgICAQQKAQEBA?=
 =?us-ascii?q?goCCAoBCRMEAwgDAwMDAwUBAgIIBBMFBQIBBQwTDAEKBgMGAwQCAgIKAQcCA?=
 =?us-ascii?q?wMDAgcBCyMCAQMCAgUCAgEFAwICBgQDAgEBCQIDAggBAgIBAQICAgQBBwEEB?=
 =?us-ascii?q?wYBAQIEAgI0AgEDCQIFAQEBDgICBAICAQICAgQCBAECBgsEBQ0BAQIBAgIBA?=
 =?us-ascii?q?QEEAQgDAQEBAgIDAwUDBQgPDQEBFwsdBQQFAgIBAQEBAQITAgIBCwECAQEDG?=
 =?us-ascii?q?wIBAwMEAQsCAQEEHwQWAgICAgICBAIDAgIDAgICCxQVHQIJAyMPAwsJCBM9A?=
 =?us-ascii?q?QsHMgQ2ARQUByshX51ZPIQLB4EPgSYIepM7HRGDI5Aznl5xaIM9m0+GETOEB?=
 =?us-ascii?q?JQGkkkuh2SQapIKlxMRIxKBOQMwgVwzGggbFWyCNk8DGQ+IAIYhg3rINkUyP?=
 =?us-ascii?q?AIHAQoBAQMJkDaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:IpuAbq2YBjKEYSGtHG8oogqjBEIkLtp133Aq2lEZdPWaSL3jqy
 nIpoVm6faUskdtZJhEo7q90ca7MBThHPJOkO0s1PKZLWzbUQiTXeJfBOnZskTd8kTFn4Y36U
 4jSdkdNDSaNykDsS+V2njCL/8QhPaA676hnurTwjNASgtwe7h84woRMGqmO3wzag0DKpYwCY
 aG6tAvnUvHRV0nKuq+QlcKNtKsmzQJrv3biNw9aiLPJDPusdpg0t7HLyQ=
X-Talos-CUID: 9a23:3qgWEWMfqF6I3e5DBXdK0FAbA9IedV7SkWeAKkDkUDd3R+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AKVHKvA8qp2wvxhjJqAGpFFqQf9dhxq71Jk0dq5k?=
 =?us-ascii?q?ht9SfLDJOYGeGrx3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,259,1732575600"; 
   d="scan'208";a="206605076"
X-MGA-submission: =?us-ascii?q?MDGvSpwhU8bvZm+PhJ+fnouXPuo/08Oq2+Wbhg?=
 =?us-ascii?q?UIPFKKZDOQDcMjZxap617gE1YcZ/7QPIJMBNhNVR22uy1+kbSQGtu5cn?=
 =?us-ascii?q?wEX/aguSfkzX2GZbZ9R/uvClcU288/1Gi8q1qM7UEGCXCr92wMDZjsPp?=
 =?us-ascii?q?Rt+1T3LphPoA8e7p8DtR+97g=3D=3D?=
Received: from mail-pl1-f179.google.com ([209.85.214.179])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 21:16:28 +0100
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215770613dbso82759655ad.2;
        Tue, 04 Feb 2025 12:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738700186; x=1739304986; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR/DuzPu4L6UmQMWZ9c+c7Q6VILPpItJGIL+ba1HmaQ=;
        b=RFCueCffa4gwQAt+harDcSq6ANFPmNwcYP8lQ/+6/pfVVNWkcwl7GHCKFKbpcsKZSR
         7jUMUv/PSzQRZjgpM+uyXbVFcU2ajafcEV5TkSHQiFo3xT9/zRP3LXb2s2g0kAQXapLd
         aNvnKSMQ6NL0ZrahSxtg46qDlOcXItEGja7i0XxOCAxJxw5AihR+qRGzu9dJeZt0HqoD
         g9K8RHVY3VC3cvHiddWooNAvINi5YRr65h68sENiNxYBsPIjeZPuUE+/oP+rRenwC234
         CTzewj5s8QwXogQDdfFhLeLvqvQRA+Ek2AbL6YQavwOaDIJxLhGLKJHBnO43DrOxBQIe
         EgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738700186; x=1739304986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KR/DuzPu4L6UmQMWZ9c+c7Q6VILPpItJGIL+ba1HmaQ=;
        b=sCY8+mpenmxQf0jr9+ro65tGntRjQD7btHbgJJ6JidmdmK5Uiv8vfmXUbV+LNBN8GD
         5F+panT3nzUGJtC+keTza6DIFuocpUCKlX1uDYC2SgzDATeVO5tnmH6Sdr2c+XHVIGAa
         noMssIbsnnjAk8dxalv+gjRC6LDbszS8C+LrKtIkKX7brDCk/3FxpLmkUgugP606ALin
         vaeKadOJ6C1USBYdQLQ9oN0K7JrG27KmrvBk7zL96ye116Xh6xoPdlzSthXQlLzOlUQk
         K3i4Dp7C2ypje2JQXydvPd9Xt5SXHk4I1J7kdPTmuIjRAK+PIHLcC0yvioWVkpnpKQHG
         1lJA==
X-Forwarded-Encrypted: i=1; AJvYcCUtA5VMx4AqcdKWidszxt3KrZQyFO5Ji4NcMiu+QOP8nm5fwBzE3xUXJODYlVdXSVBp7gC9T8PLFnum4fo=@inria.fr, AJvYcCXOjlUH7Czo4DzbVkHkeJrREv5Qq4ymICxMn7e3XXZJBPaRTfgOnuQR4zUXU1gUgTs1v4wPKaQ=@inria.fr
X-Gm-Message-State: AOJu0YyZZTWh3I4Uar3zOyhvZeubOKIBSkwV+FYMUGNaM+G5ohpbq9OO
	8Y0Q05cjuUHfbgpYR2ntmcEwgQDen4Vog/EIHStnAflNv+H4UPQr8Jp1b9tfCi8dr4V6FxrgA0B
	pVV4+aOpAQlq7LADOB3OYLzfn4Og=
X-Gm-Gg: ASbGncscPGyOuT3VjBXm+u2MVge+66DlHIhovx/948aMyjYaagfuCXaGA/oKl0jnPbC
	rWGWnJdOQxzJ3+PCdYvIG3xORJSYQEOTq6VXHj+hZD19ixTotslqtM61weU6ka3aNvhcY7/nO
X-Google-Smtp-Source: AGHT+IGMRCnWUgk4azvsM8AKV6n66tF8jJ5hJc5CJaJ9hjxGDmkew2CZ3MuiAN64LXIAW7Ct2k1pbf+SLC7mYsM4D9w=
X-Received: by 2002:a17:902:e54c:b0:215:a04a:89d5 with SMTP id
 d9443c01a7336-21f17df58famr2631635ad.2.1738700185995; Tue, 04 Feb 2025
 12:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com>
 <20250203-converge-secs-to-jiffies-part-two-v2-3-d7058a01fd0e@linux.microsoft.com>
In-Reply-To: <20250203-converge-secs-to-jiffies-part-two-v2-3-d7058a01fd0e@linux.microsoft.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 4 Feb 2025 21:16:13 +0100
X-Gm-Features: AWEUYZltcKp5HWPVuFiXXXLg5FCvpTOIVUsJwjijbmOSBWMbuaFjZjJQs9hspCs
Message-ID: <CAOi1vP9P7c37aGWOXCojBM+eQZ8eQLpHPQK_t2sO=SR53EboKA@mail.gmail.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Dongsheng Yang <dongsheng.yang@easystack.cn>, 
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, cocci@inria.fr, 
	linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [PATCH v2 3/3] libceph: convert timeouts to
 secs_to_jiffies()
Reply-To: Ilya Dryomov <idryomov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2344
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/CAOi1vP9P7c37aGWOXCojBM%2BeQZ8eQLpHPQK_t2sO%3DSR53EboKA%40mail.gmail.com>

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
> While here, remove the no-longer necessary checks for range since there's
> no multiplication involved.
>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  include/linux/ceph/libceph.h | 12 ++++++------
>  net/ceph/ceph_common.c       | 18 ++++++------------
>  net/ceph/osd_client.c        |  3 +--
>  3 files changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 733e7f93db66a7a29a4a8eba97e9ebf2c49da1f9..5f57128ef0c7d018341c15cc5=
9288aa47edec646 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -72,15 +72,15 @@ struct ceph_options {
>  /*
>   * defaults
>   */
> -#define CEPH_MOUNT_TIMEOUT_DEFAULT     msecs_to_jiffies(60 * 1000)
> -#define CEPH_OSD_KEEPALIVE_DEFAULT     msecs_to_jiffies(5 * 1000)
> -#define CEPH_OSD_IDLE_TTL_DEFAULT      msecs_to_jiffies(60 * 1000)
> +#define CEPH_MOUNT_TIMEOUT_DEFAULT     secs_to_jiffies(60)
> +#define CEPH_OSD_KEEPALIVE_DEFAULT     secs_to_jiffies(5)
> +#define CEPH_OSD_IDLE_TTL_DEFAULT      secs_to_jiffies(60)
>  #define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
>  #define CEPH_READ_FROM_REPLICA_DEFAULT 0  /* read from primary */
>
> -#define CEPH_MONC_HUNT_INTERVAL                msecs_to_jiffies(3 * 1000=
)
> -#define CEPH_MONC_PING_INTERVAL                msecs_to_jiffies(10 * 100=
0)
> -#define CEPH_MONC_PING_TIMEOUT         msecs_to_jiffies(30 * 1000)
> +#define CEPH_MONC_HUNT_INTERVAL                secs_to_jiffies(3)
> +#define CEPH_MONC_PING_INTERVAL                secs_to_jiffies(10)
> +#define CEPH_MONC_PING_TIMEOUT         secs_to_jiffies(30)
>  #define CEPH_MONC_HUNT_BACKOFF         2
>  #define CEPH_MONC_HUNT_MAX_MULT                10
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 4c6441536d55b6323f4b9d93b5d4837cd4ec880c..c2a2c3bcc4e91a628c99bd1ce=
f1211d54389efa2 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -527,29 +527,23 @@ int ceph_parse_param(struct fs_parameter *param, st=
ruct ceph_options *opt,
>
>         case Opt_osdkeepalivetimeout:
>                 /* 0 isn't well defined right now, reject it */
> -               if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000=
)
> +               if (result.uint_32 < 1)
>                         goto out_of_range;
> -               opt->osd_keepalive_timeout =3D
> -                   msecs_to_jiffies(result.uint_32 * 1000);
> +               opt->osd_keepalive_timeout =3D secs_to_jiffies(result.uin=
t_32);
>                 break;
>         case Opt_osd_idle_ttl:
>                 /* 0 isn't well defined right now, reject it */
> -               if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000=
)
> +               if (result.uint_32 < 1)
>                         goto out_of_range;
> -               opt->osd_idle_ttl =3D msecs_to_jiffies(result.uint_32 * 1=
000);
> +               opt->osd_idle_ttl =3D secs_to_jiffies(result.uint_32);
>                 break;
>         case Opt_mount_timeout:
>                 /* 0 is "wait forever" (i.e. infinite timeout) */
> -               if (result.uint_32 > INT_MAX / 1000)
> -                       goto out_of_range;
> -               opt->mount_timeout =3D msecs_to_jiffies(result.uint_32 * =
1000);
> +               opt->mount_timeout =3D secs_to_jiffies(result.uint_32);
>                 break;
>         case Opt_osd_request_timeout:
>                 /* 0 is "wait forever" (i.e. infinite timeout) */
> -               if (result.uint_32 > INT_MAX / 1000)
> -                       goto out_of_range;
> -               opt->osd_request_timeout =3D
> -                   msecs_to_jiffies(result.uint_32 * 1000);
> +               opt->osd_request_timeout =3D secs_to_jiffies(result.uint_=
32);
>                 break;
>
>         case Opt_share:
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index b24afec241382b60d775dd12a6561fa23a7eca45..ba61a48b4388c2eceb5b7a299=
906e7f90191dd5d 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4989,8 +4989,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
>         linger_submit(lreq);
>         ret =3D linger_reg_commit_wait(lreq);
>         if (!ret)
> -               ret =3D linger_notify_finish_wait(lreq,
> -                                msecs_to_jiffies(2 * timeout * MSEC_PER_=
SEC));
> +               ret =3D linger_notify_finish_wait(lreq, secs_to_jiffies(2=
 * timeout));
>         else
>                 dout("lreq %p failed to initiate notify %d\n", lreq, ret)=
;
>
>
> --
> 2.43.0
>

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
