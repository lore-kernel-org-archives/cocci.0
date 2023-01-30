Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED59AC54EED
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 06:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8kDOke4LN7w6fpBsUtOXo8T0Zvp1z998++I9bqEffZY=;
  b=J9IXB4hDsvbt7yJJ0aq3zixHuCsdLeCx+9U/7+lfptugZaJmZzstOEEc
   hQ+A0pkon1oe1CD0QZmQAVWF6h4lGoiw2X8sH0F+86JodhP6lmQnNh7Ns
   R7ANgQZ0nyWlSvET9fVpkb/cg5Gk22QLwLrTemWAKKYTFTNnIT4PCY6Dd
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="asc'?scan'208";a="89963831"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 07:13:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B25ADE7441; Mon, 30 Jan 2023 07:13:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9702CE743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 03:00:59 +0100 (CET)
IronPort-SDR: 63d724da_ODHs77XKr5FQFmWfnSn2XmM7xnZNzXw24bQikJ4bmand0VV
 KiwXvYYa/vpExdXmiiQE64k1Yb2pm4+wFkfWClw==
X-IPAS-Result: =?us-ascii?q?A0FEAABQJNdjf7TXVdFaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?QUBAQsBgiyBXi4EUIRPiH6IIQOBE4o/kWuBQD4IBwEDAQgDAQFCAgQBAQMEh?=
 =?us-ascii?q?QAChSUCHQcBBDIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECE?=
 =?us-ascii?q?AEBGQkZBw4OBSSFaA2CNykBdU0DOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEEAn45AQEdAQEBAQIBEhEdARsdAQMMBgUYHA4CAhARA?=
 =?us-ascii?q?gkIAQUBHAYBEiKCXYJtAQMOIwIBnByBBEKKOHqBFQUCFoEBggkGnAoKGSgNa?=
 =?us-ascii?q?AOBVAcCBwkBCIEuAYFTgwFPghYSiGB6JxyCDYEVgnM3PoIghXyCRSIEmw0BA?=
 =?us-ascii?q?wICAwICAwYEAgICBQQCAQMEAg4EDgMBAQICAQECBAgCAgMDAgIIDxMDBwIBB?=
 =?us-ascii?q?gUBAwECBgQCBAELAgIFAgEKAQIEAQICAgEFCQEDAQMBCwICBgICAwUGBAIDC?=
 =?us-ascii?q?QUCAQEDAgINAwIDAgQBBQUBARACBgQJAQYDCwIFAQQDAQIFBwEDBwMCAgICC?=
 =?us-ascii?q?AQSAgMCAgQFAgICAQIEBQIHAgYCAQICAgQCAQMCBAICBAICBAMbAgMFAw4CA?=
 =?us-ascii?q?gICAgEJCwIDAgcEAgMDAQcCAgIBDAEDGAMCAgICAgICAQMJCgQJBAIFAQIBB?=
 =?us-ascii?q?AsBBQEPAgQBAgICAgIDAgEBAwYIBgMLAgcEAgMDBgkPDwoFAgMBBAMCAwIBC?=
 =?us-ascii?q?AsCAwICAisDAwIgA0QdAgkDIw8DCwkIExcoBgMBCgc0BDQBCgELBwUBBAEHA?=
 =?us-ascii?q?wMFBQkOAwQCAQMDAggMCgUBAwYGCAIEBQIFAwIEAgMCAggDAgQDCQMFBAIHE?=
 =?us-ascii?q?QcCAwICBQICAgICBQQDAQICAgICBQIDAgEFAQICAQICAgQBAgIHBAIDAQMED?=
 =?us-ascii?q?gQDAgIHAQICAQYCBwMBAgEEAwEBBAIEAQIFAgQBAwYCBAMKAgIDAgICBgUDA?=
 =?us-ascii?q?goIAgMFAgQBAQIHBAICCwEGAgcCAgMQAQMBBAUFAwMDCQICAwIEAgIKAQEBA?=
 =?us-ascii?q?QIBBwIEBQ0CAgIEAgIBAwIBAgIKEQEBAgMGBAYFAxwFAgEBAgIDAwIGAgECC?=
 =?us-ascii?q?AIEAQQFAgECAgICBAEDBgIDAQECAQICAQMCAQQCBAMDAQIBAgIDAgICAwICA?=
 =?us-ascii?q?Q0CBgYBAgICAgICAgIGAQIBAgQCBwIEAwIBAgIFAgICAwEBBgIECwEDAgcIA?=
 =?us-ascii?q?gcFAgMBAwMEAwMFBgUMCAEFAQMBEQ4DAgIIAgcCAQYFAQ8DAgIDAgIBBAoCA?=
 =?us-ascii?q?wUCBAIBBAgHAgQBAgkDAgYCBgUYAQICBwQMCgECAgUGBAEBAQECAgEBAgMDA?=
 =?us-ascii?q?gMCBAUBBQIBAgQEAgEBAgUNAQEHBgIHAgICAwEEAgECAQMDAgMBAQEDBgYCB?=
 =?us-ascii?q?AQCAwMHAgIEAgIDEgcCBgMEAQ0LBQQFCAECAQEHAgQCBwkOAgEGAQUCAgMCA?=
 =?us-ascii?q?gEFAgEGAwECAgICBQcFAwQFAxMDAQEEAwIBAgECAwIDBwMCBAIDAQIDBAYGA?=
 =?us-ascii?q?QkEBgUNAwQCAgECAQEDBAQEAgIBAgIDAQQCAgEBAwMDAgICAwQCAwMLBAQGB?=
 =?us-ascii?q?wMDAgEFCwQCAwIBAwEGCQQCAgYBAgQCAgICAgICAwEBAwoEAgEDAgIEAwYCA?=
 =?us-ascii?q?QIBCQUCAQkDAQIBAgEEAQMJAQICBAkCAwcFCgICAgIIAgIOAwMCAQEEAgIEB?=
 =?us-ascii?q?QkBAgcCBQEBAwUHAgIBAgIBBAMBCQQBAgMCAQEDEgMDAQQCBQMDDQkGAgIBA?=
 =?us-ascii?q?wIBDQMBAgECAwEFBRcDCAcUAwUCAgQEAQcCAgMDAwIBAgkGAQMBBQIOAwICB?=
 =?us-ascii?q?AQCAQIBAQIDEAUBAQEBFwEDBAIDAQQDAQECAQIDAg4EAQQFCwMBAh0CBAEIC?=
 =?us-ascii?q?AICAgIDAQIDBQECAwQCAQgKAgICAgoCCgMCAwEDBQEDAgkDAQUBAgcCBgEBA?=
 =?us-ascii?q?QICAgYCCAIDCwEDBQYCAQICAQUCAQICBQMFAgICAgQNAgUCAgIGAQIHBAICA?=
 =?us-ascii?q?gMBAgIGAgUBAgcHAgUCAgIDAwoEBAcEAQECAQEFAQIBAwQBAgQBAgECBQMGA?=
 =?us-ascii?q?gICAgECAgEBAQgCAgICAgICAwQCCJ8hPVFVgSdECymjWZ4YR29kgxuBUpkRh?=
 =?us-ascii?q?gcyln+SMIUXkjggkRyWLgIKBwYQIxKBNAYtgVwzGiODN08DGQ+OIINyklo1N?=
 =?us-ascii?q?DsCBwEKAQEDCYVGhl0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 PovgJ6tnmCr
IronPort-HdrOrdr: A9a23:bHrhTqisIyQjiffioqK/En/cX3BQXvUji2hC6mlwRA09TyVXrb
 HIoB0+726ItN9xYgBbpTnkAsO9qBznhPxICOUqTNKftUzdyReVxeJZnPDfKl/balTDH4dmvM
 8KE9kcNDSzNykDsS+T2miF+r0bsb+6Gc6T9IPjJrRWIT2CqZsM0+60MGmm+4RNKjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="asc'?scan'208";a="46301282"
X-MGA-submission: =?us-ascii?q?MDEPQaUP9AxhyHa3bDHvpGlHyY0PUwhj4yY5Wh?=
 =?us-ascii?q?XcwfQMULDtOSBr2bmdGv6/gujn8ueYWrK3FsmO1ILwakU2p3oG8Q8AGM?=
 =?us-ascii?q?m8GhQvr0yqo5n1AnN5YBEq0K4lzAjjYKzpB3Vl+jXC57BhuQv8+6igQI?=
 =?us-ascii?q?0HgZERdwR5qI9cZ2+9Ay+ioA=3D=3D?=
Received: from mail-pg1-f180.google.com ([209.85.215.180])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 03:00:58 +0100
Received: by mail-pg1-f180.google.com with SMTP id 36so6626330pgp.10;
        Sun, 29 Jan 2023 18:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kDOke4LN7w6fpBsUtOXo8T0Zvp1z998++I9bqEffZY=;
        b=mS5KkcO7nR0TP6WHwPu9Nm1d00AEizhWsYErnNqbAlVIBAnQzHDgll8fIgxQ/fv2dl
         EbFiq5YBUycRKvtCPeAfPEFHccpC1b/IPAKpX/nizqtR5yCpddO0Ie9KG8zoOmu0nYgq
         loaudRNi/uIfMujdiAgAzzU5DRcNE0iurLhMdu38Hrk8KBzIwb2QSdYEjpuqPzUXydZx
         PD2+f8S5gClkR1qY3gKF2yoUj++p+V2gjz2tfDG/MJ+JpUORJa8BcXodIBytkVKBWdnf
         2MCxI8dviae0v+hzi2OwMVjIp3Y6h9KIVyIPBySagKSAiRZmX3CpwZsRhTiz/WYxzCAY
         pNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kDOke4LN7w6fpBsUtOXo8T0Zvp1z998++I9bqEffZY=;
        b=oh1HQZSlR6iRvJCwqWxClmrjwlkpOBDRRR+Im31lK9+d6VvwrgeO7HC0PhkE8gDFfU
         DcMM4NGSfknQE9i+Zj0LRkuSod4K0Nu7vI+efF1wlvynyJr93ib3R+sxInd+SgIQXAUp
         S5h7BaIt9tH/qlQl4Is3CSdmwCwbyxvRdOm60upsvTm5+MpBvMEbMKFva4ImYCtr+om4
         8I9E2X+eNFjsKB2R0y4J/RQ1egw9DpOzuNfR/jSaokcxNdZf5tVniWIL1cpjbQ2bObYG
         pKqBmM/lwlionwMwyM9LxvoG4jP4H1VfNrOz96LdzgF3JV98aAPw45Mrz3qkq4ucK5jW
         ngvA==
X-Gm-Message-State: AO0yUKUfLK/7DQxpioYvbAIQfjYvxoflTL7tM8OMCPaPEm7T596Yy+iJ
	TEC+WeJBD6LZYbhZKKHAoro=
X-Google-Smtp-Source: AK7set8QmFISUvk/cmZd+I0vBk9Qx+kmhNcsXx4nKJIiH75seIIq9S4BwtNRaEmkNUti/Gz0eYaBkA==
X-Received: by 2002:aa7:8fb8:0:b0:593:8539:beea with SMTP id t56-20020aa78fb8000000b005938539beeamr7179445pfs.3.1675044055901;
        Sun, 29 Jan 2023 18:00:55 -0800 (PST)
Received: from debian.me (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id 26-20020aa7915a000000b0058d99337381sm6312608pfi.172.2023.01.29.18.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 18:00:54 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
	id 9D84610555F; Mon, 30 Jan 2023 09:00:45 +0700 (WIB)
Date: Mon, 30 Jan 2023 09:00:42 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	linux-doc@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jonathan Corbet <corbet@lwn.net>, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Message-ID: <Y9ckylqsgCDsZ/RQ@debian.me>
References: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZjUcdI54Zb96UmuA"
Content-Disposition: inline
In-Reply-To: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] Documentation: coccinelle: Escape --options to
 fix Sphinx output
Reply-To: Bagas Sanjaya <bagasdotme@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 841
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/Y9ckylqsgCDsZ%2FRQ%40debian.me>


--ZjUcdI54Zb96UmuA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 29, 2023 at 04:14:08PM +0100, Jonathan Neusch=C3=A4fer wrote:
> Without such escaping, -- is rendered as =E2=80=93 (en dash).

Well, the diff below is not what escaping means (to escape dashes is to
prepend each of them with a backslash, i.e. \-\-)

>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/dev-tools/coccinelle.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-t=
ools/coccinelle.rst
> index d9976069ed126..535ce126fb4fa 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -219,7 +219,7 @@ instance::
>      cat cocci.err
>=20
>  You can use SPFLAGS to add debugging flags; for instance you may want to
> -add both --profile --show-trying to SPFLAGS when debugging. For example
> +add both ``--profile --show-trying`` to SPFLAGS when debugging. For exam=
ple
>  you may want to use::
>=20
>      rm -f err.log
> @@ -248,7 +248,7 @@ variables for .cocciconfig is as follows:
>=20
>  - Your current user's home directory is processed first
>  - Your directory from which spatch is called is processed next
> -- The directory provided with the --dir option is processed last, if used
> +- The directory provided with the ``--dir`` option is processed last, if=
 used
>=20
>  Since coccicheck runs through make, it naturally runs from the kernel
>  proper dir; as such the second rule above would be implied for picking u=
p a
> @@ -265,8 +265,8 @@ The kernel coccicheck script has::
>      fi
>=20
>  KBUILD_EXTMOD is set when an explicit target with M=3D is used. For both=
 cases
> -the spatch --dir argument is used, as such third rule applies when wheth=
er M=3D
> -is used or not, and when M=3D is used the target directory can have its =
own
> +the spatch ``--dir`` argument is used, as such third rule applies when w=
hether
> +M=3D is used or not, and when M=3D is used the target directory can have=
 its own
>  .cocciconfig file. When M=3D is not passed as an argument to coccicheck =
the
>  target directory is the same as the directory from where spatch was call=
ed.
>=20
=20
You inline (wrap within inline code markup) these option keywords to match
other keywords.

Regardless, LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--ZjUcdI54Zb96UmuA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9ckqwAKCRD2uYlJVVFO
oyiBAP0aa1/RSNCNahSW+EK6BW1iHcAY44D1wW6DUsAm/3Bo4gD9Gwm7Ygsfm5Rh
01WKHlO/JZInQUNJr0U7/2mlfSvJFgg=
=4V+F
-----END PGP SIGNATURE-----

--ZjUcdI54Zb96UmuA--
