Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF20C2BBCA
	for <cocci@archiver.kernel.org>; Tue, 25 Jun 2024 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Y6JtS8dgWDY+bdOIf3N0miP/WZC0W0VngIVS5xMrGh0=;
  b=XKf4iyvRhhxOZfZ2I+l57jTu5cNwSCEm3Aq/Ya6wBGJzhA19+6AejKMR
   DWV2xd+JVOfyRCneoAvMVbOa70gmM8rtwFa+BAejW3NuPcsWPm6RCjwdT
   D3XjfU3BfwhtSELx1MYY6hcIAN0673zWIi5cVZBVouDVkQOblw9h/Lpk4
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.08,263,1712613600"; 
   d="scan'208";a="172345089"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2024 11:39:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3B38FE0AF6; Tue, 25 Jun 2024 11:39:17 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 65667E00B6
	for <cocci@sympa.inria.fr>; Tue, 25 Jun 2024 11:39:12 +0200 (CEST)
IronPort-SDR: 667a9027_YNb0in5Zgp53eIUM+Yf+5BwHc+0HXFV7IC4jt2f1o/nOo4c
 jHF/j/gnk8l1+NfPK2oFolfb5SVRHuoKOGc3MwQ==
X-IPAS-Result: =?us-ascii?q?A0FRAwDej3pmf7PQVdFagQmBT4FyUnxaMwRThFaRagOBE?=
 =?us-ascii?q?5x6FIEsFigPAQMBCwEBOwcCBAEBAwQ4gVOCdAKJAgIeBwEEMgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABASIZBw4OKYV0DYJnARCBDmECB?=
 =?us-ascii?q?QM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINHwRYA?=
 =?us-ascii?q?QEBAQIBEhEdARsWBwEDAQsGBQsNAgImAgIiEQEFARwGNYJfgi8BAw4jAwEQB?=
 =?us-ascii?q?qEagQVCikF6gRUFAhaBAYINBoFZQU65LAoZKA1sA4FgAgEGCQEKgQYuhGYlg?=
 =?us-ascii?q?yYBgVmHaAF6JxuBSUSBFIE8gRwbOD6CYQIBAYEhJxYVg0aCaQSGBIgchlKBC?=
 =?us-ascii?q?INbhW9yWFCBSIE+fyYLgRsQi20IAQYfEAQJCRMGCgJLDQoSAwQDBAQBAgsTC?=
 =?us-ascii?q?QMDAg4CCAMCCAYOAhEBPxIEEwoNCwMEAgUKAwgCAgcCDgEFAgEBAgICAgICA?=
 =?us-ascii?q?wYCEgQCAQIDAgIIAgcBAQIKBwMBAQIGBAMGAgIFBA0DCwEBAgIEAQoCCQ8FA?=
 =?us-ascii?q?gIDAgMBAQIKAwkBBQICAQMCAgQEBwEGAwUDAwQEAwIDAwIMAQUBBQEFAQUEA?=
 =?us-ascii?q?gYBEwISAgILBQYDBg4DCwQEAQICBwYMCQQCAgIGAQIRAwECAQcBAwMCCgEEA?=
 =?us-ascii?q?QsIAQUICAEEAgMGEAIIBQYFAgQBAQICAggGDwMGBwIDAgYDBQUDAwICAgcEB?=
 =?us-ascii?q?AIBAgICARMGBAQCAwIDBAEFBAQDAhcIDgIFBwEJCgkMAQIGAgQCBAcDBgQFB?=
 =?us-ascii?q?AIDAgQRBwsDAgMEAgIEAxECAwQCCgIEBAcCAwEBDAYEBAoCCwMFAQEBAQUDA?=
 =?us-ascii?q?wkHBgIDAwUEBgIFAwMDAgMCCQICAgEJAQEBAhICAw4CBAIBAgUFDAQTAgIDA?=
 =?us-ascii?q?gYIAgICBwMDBAIDBgsBAQERAgICBQMEAgIUAwcEAgQFAgQBBgMDAgQGBQgEA?=
 =?us-ascii?q?gIFAgEBAggCAQ8KBAMEAwUDBwkCBQUDAgQCAgUJAQECAgIDAwMDAwICAwMCB?=
 =?us-ascii?q?wMDAwcDBQMEAgMGBQcDBQMDAgICFAEGAgUNCAYLBQUHAgYCBAgFAgIDAwMCB?=
 =?us-ascii?q?goIAwMDAgUCAgMDAQIGDwYCAgMFBgMDAwMGBgMDAgYDAwIDAgMCAwMBAwIDA?=
 =?us-ascii?q?QIDAgICCAICAwIFBAUCAgIEAggaAgICAgMDCAMDCgQCAgQBBAIEAgQCBgMEA?=
 =?us-ascii?q?gIBBwIDAwIDAgcCAgQCAgICAwIEBwICAwMDAgICAQkCBQEBBgIDAwIDBQMJA?=
 =?us-ascii?q?wQFAgMIAQECAgcHAwMEAwECAQUEAgIGBQIDAgIEAgQFAwIDAgYGAgEDAgoGA?=
 =?us-ascii?q?wUDAwMDAgMDAgMDAgUCCAICBAQFBAIFBAIEAwMDAQoCBgMCAgUBAQICBQMCB?=
 =?us-ascii?q?AQHAgICBw8DAgcFAgUFBQIIAQYFAgIDAgYBAgIGAQYCBAECAg0BAQICAgMBA?=
 =?us-ascii?q?wMDBwIEAwIIAgMDDwEDAwkGBQQFBAMJBA8CBAEIAwEBBAgCBAMCDAICIQIFC?=
 =?us-ascii?q?wQEARoIAwEBAwEBAgICAgIOAwIDAgIDCgIDAgoDBgQCAgYBAQEEBgEEAgECB?=
 =?us-ascii?q?wQOCQUICAEDAgEEBgECEAUCEAkDBwQCEAYKBQMCAwUBAgUVAwgDAgkCBAwDB?=
 =?us-ascii?q?QgDAwIGAwYCBgEGAwcLAQEHCAUDAwMCFgECAg8IBAYPBwIDAwMDDAMSAgYOA?=
 =?us-ascii?q?wMCAwIBAgICAwUEBQIHAwMKBQIIAwIIBQMHCQQKAgoCBgMCAgICBQwBAQEBA?=
 =?us-ascii?q?gMCBQMHBwgIBAUEAwEBBgYMIAICAwQPAwkDBgsBBQUBAwICAg4DBQMCAwYGA?=
 =?us-ascii?q?QkEAQUECQIFBwYFAgEUBw8HBQIKAgcCAgIDAQIICwgCAwIKBAEOBBkCBQECA?=
 =?us-ascii?q?gMDBwIDAhMDAwUEBgMCAgICAwIBCgsDAgIDAwMDBQUDAwIZAwIDAgEKBQIMB?=
 =?us-ascii?q?QQDBAICAQIdAwEFAgMKAQUJAwYCAgMCBQIDBgQCBAEOAQEBAwYLCRQCAgIJC?=
 =?us-ascii?q?AMIAwUNAg0CAwUCAgtBCwUBAQQDAgoYLQIEAgYMAQEBAgMDBgICAhUFBwMFA?=
 =?us-ascii?q?wgBAwECFAgGAgEDCgoCAgQCBgIEAwIKAwEIAgICDwMJAgcCDQICAwMMDwQDA?=
 =?us-ascii?q?wMDCAICAhEJCgICAgwICgIJAgIDAwYBAgMDBQMCAQEBBC8CBAcBAwYKAwICA?=
 =?us-ascii?q?gkICgkDAwUDDAEGBgECAw4BAQITBAkDAgECAQEGCAEBAgQBBAIIBgICAgIKA?=
 =?us-ascii?q?wUDAgMFFQUEAgIZAwIEBQMFAwMEBwECBgQNCQMFAwIEAwMCBAQCCQUJBAMLB?=
 =?us-ascii?q?gEBAQMEAwEBCAcHAwIBAQMBAQoKCA0IAwgDBgkDAQYBAQUSCAMDDgICAgMCA?=
 =?us-ascii?q?QoGCAUCAwYOAgQCGgEMAwEDAwUOBBQDBAUCAg8MAQIDAwQFAwUCAgIDAgICB?=
 =?us-ascii?q?QQBAgQCBAEIBAkBAgICAwIBAQICBAYFAgICAwIHDAcDBAMGAgYCAwIHCwwCA?=
 =?us-ascii?q?wYFBQMFAh4CAwICBAMDHQEBAwEEAQIDAgIDAgMEAQMDAgEBAQEBAQMHAgICB?=
 =?us-ascii?q?AEBAQQGBQICAgMMAgMDAQEGAQMBAg8FBQYEAQUIAwIUAwUiAg8FCAEoAQQCA?=
 =?us-ascii?q?gECPQICAwQNCAUCAgcCBA0CBA8HAw4HFgYBBAgEBQQEAgsKAwgQBwIWEQEBB?=
 =?us-ascii?q?AQCCAQCAg0HAgIMAgIGBAIBAwcjBgMGCQMCBQUXAgIQAgQDBRQEBBsDAQIKA?=
 =?us-ascii?q?gICGwIBBwECGQQCCAEVAgcCEwgBBwMFBAMpHQIJAyMPAwsJCBM9DAcyBDQBF?=
 =?us-ascii?q?BQHBiWBAKkvgxsBWgZhAS0UFgIYeQoqBgI2Ai4MCTKSNzGyWGeDNowPh3wHi?=
 =?us-ascii?q?heDIjOEBZM1kn+YZoJUiyKaawIKBwYRIxKBNwQvgVxNIxVsgjYTPAMZD5Ibh?=
 =?us-ascii?q?RTHfEE1AgE4AgcBCgEBAwmFaYMGM4FIAQE?=
IronPort-PHdr: A9a23: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
 dinqHcSgmqLifY6IKXRIOxCyV0C3sqz
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3AxHGauEaa1oKGoecr0dfgBP7skDVdV00zEX/kB9WHVpmwKj5q
 eTdZMgpGXJYVcqKQodcLW7UpVoLkmsk6KdjbNhWItKGTOWwVdAT7sSkbcKoQeQeBEWn9Q1vc
 wBT0E9MqyJMbETt6fHCWKDYrQdKbe8gcSVbKvlvgpQpMJRB52ILT0VNu9WKCJLrcB9a6YEKA
 ==
X-Talos-CUID: =?us-ascii?q?9a23=3AgYaR6murkjAgO7omDHJo0D7X6Is1Il/w9E3JfHa?=
 =?us-ascii?q?VNmxkZrLMT3mfwqNdxp8=3D?=
X-Talos-MUID: 9a23:9jPQ2gv0YqNPpU+zdc2nnhtmN+lD7LaUOWsUv7II4c3ZJ3d9EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,263,1712613600"; 
   d="scan'208";a="90562363"
X-MGA-submission: =?us-ascii?q?MDHtDOSFPo0nYGi+KmhyGuMS9y0tRMkrN8QDXv?=
 =?us-ascii?q?RKzXxIoQoiIJXZn9bqr10kIPpiIK+q0c3FeJwcz3pP7ZDIyTXdCuXcPC?=
 =?us-ascii?q?+4M6XnBqTr/DCUIB75FJUOOD2/JYOmsbuchv/JluWJ7iK8cg4S+BmO+R?=
 =?us-ascii?q?xMoeMRIXUEgrGl7Ab8hYG4eQ=3D=3D?=
Received: from mail-lj1-f179.google.com ([209.85.208.179])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:38:47 +0200
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec58040f39so28587921fa.2;
        Tue, 25 Jun 2024 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719308327; x=1719913127; darn=inria.fr;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y6JtS8dgWDY+bdOIf3N0miP/WZC0W0VngIVS5xMrGh0=;
        b=DBdkLHmn1dRwu0v6fGKUKtPV94iBsgUpL9V3h69JRcZ2TMuAbJJcjZgFqbV3UCMyiQ
         6ZkG05vrXrO9sq7KrzymY/gvH+xUlzqeAJM6RMqacdouOpvgrUeBx5SNOM2iexbO83bh
         41JSQBt4dmCDrxdAsPpmCwmXEVgFIMPBR5d/1wz4TzC2oC2pA5rMrp4udheCAwafmZJd
         qxzYcK1mVArxwg+Pac0t65PzAAkF+QHLzZAGRSf7iTCcpDcyQJKlZOvZTpDqG1Dw6fd8
         Mv593UIrG3KqUBEirWs8L7jHW81T30Xk9Accsx2eUfqw0hjt2cp+/jtt+ZTrP42HS6t0
         CXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719308327; x=1719913127;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6JtS8dgWDY+bdOIf3N0miP/WZC0W0VngIVS5xMrGh0=;
        b=WMFuQcExajrARhe/5xpuhp2IjOjB5YKKrOwfJ7UgoW7xxgTds76QDsgFFPA7Az8c0/
         NxM6720aoqP/8q2VRkEopEejWMvrFAPy+sGXER4xeAKLF3gWkTwhyKS5sRUIfU9nWdfr
         iBeRL6wEy2cu57S0Xjx1QsYhzujFQLVtAB3Jgvsk5vfMwnZRC+PfwFmmAbQUVxENFyCw
         Go9aNZf7LjOUGumXqtk/Z5Uzo4jlc6h/CxpuuO2GOI3Y/7MdQAssocn+tcA/OwDmd1cS
         pycHCr/YAN4l7muu16TwDGYnyXLZXb4tLLhv+3x5Su/qU41u/aFlqismFdm9hfDchxot
         29ww==
X-Gm-Message-State: AOJu0YxtlfaXUfEb+apVOrgY+YOb27gg9lrI9A0URnbErd5gPldS+2Q3
	OQOxWttLWQZf1bENtI7qIuHLtdLBbYaUAd2R+eb2bc1VvVXWof6/C9WxxA==
X-Google-Smtp-Source: AGHT+IEujPwBydTzcBcNkND0r66FZrS6Q67QrIt9tYOK48dMCJY2F2EACwXgI1KdQ/dlodQojTtjKQ==
X-Received: by 2002:a2e:9083:0:b0:2ec:53ad:464 with SMTP id 38308e7fff4ca-2ec594cfa5fmr41507741fa.34.1719308326286;
        Tue, 25 Jun 2024 02:38:46 -0700 (PDT)
Received: from ?IPv6:2a02:8308:9000:a400:4f9:872c:546a:d737? ([2a02:8308:9000:a400:4f9:872c:546a:d737])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a9975sm162869885e9.14.2024.06.25.02.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 02:38:46 -0700 (PDT)
Message-ID: <ee969df771df6e87e92fa714fbb94529ad80e77f.camel@gmail.com>
From: Jan Tojnar <jtojnar@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Tue, 25 Jun 2024 11:38:45 +0200
In-Reply-To: <35a285c7-bed4-8c72-15ea-e22a672d9373@inria.fr>
References: <c3a8f4e3da654c061f7160c75dd0c4e155f3b51d.camel@gmail.com>
	 <35a285c7-bed4-8c72-15ea-e22a672d9373@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
MIME-Version: 1.0
Subject: Re: [cocci] Flatpak package for Coccinelle
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1798
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/ee969df771df6e87e92fa714fbb94529ad80e77f.camel%40gmail.com>

On Tue, 2024-06-25 at 17:46 +1000, Julia Lawall wrote:
> I believe that I wrote the text.=C2=A0 Unfortunately, it predates the
> websute
> git repository.=C2=A0 Do you have any suggestion about the licenses?

Any of the licenses acceptable for the AppStream metadata is fine:

https://www.freedesktop.org/software/appstream/docs/chap-Metadata.html#tag-=
metadata_license

Personally, I am fond of Creative Commons Attribution-ShareAlike for
websites.

Just like GNU GPL, it requires derived works to use the same license,
preventing the re-licensing to non-open-source license without the
consent of all contributors/copyright holders (though this is currently
trivial, if you are the sole author of the website).

https://creativecommons.org/licenses/by-sa/4.0/deed.en

CC licenses also have more approachable websites and I find the terms
more readable than GNU licenses =E2=80=93 compare GNU Free Documentaion Lic=
ense
with the CC-BY-SA text:

https://www.gnu.org/licenses/fdl-1.3.html
https://creativecommons.org/licenses/by-sa/4.0/legalcode.en

Also it might depend on the agreement you have with your employer. I am
not a lawyer but I believe that typically, the company/university owns
the copyright (well economic rights, at least) to works you produced
=E2=80=9Con their time=E2=80=9D so they might need to agree to any relicens=
ing.

It might be easier to write a new description if you are not sure about
the legal status.

> I would hesitate at the moment to touch the version release script if
> it
> is not necessary.=C2=A0 Currently, we have no maintainer for this code.
> Someone new will start working on Coccinelle in the fall, and perhaps
> this
> person could help with this.=C2=A0 But for now it seems safest not to
> complicate the release process.

If the script were not modified and we included the metainfo file in
the repository, we would need to update the file manually before each
release.

The procedure consists of updating the version and release date in the
metainfo file (the following line):

    <release version=3D"1.2" date=3D"2024-03-28" type=3D"stable"/>

I would say it is easy to forget and pretty amenable to automation.

>=20
> What is the maintenance effort involved here?=C2=A0 Because it is often
> the
> case that if someone reports a bug, then we fix it and hope that the
> person will be able to use the source code from github.

It is pretty much like maintaining a package for any other package
management system/Linux distribution.

- It can break when you break something in the code. This will likely
be also a problem on other platforms so you should fix it.
- It can break when you use a dependency that is not available in the
environment (e.g. require too new version of OCaml) or forget to bundle
a dependency (for simplicity, I made the manifest use bundled
dependencies instead of downloading them from opam). This can be a
problem if you e.g. wanted to use latest OCaml version. It would
require adjusting the manifest.
- It can break when you change the build system API. Currently, the
Flatpak manifest expects standard Autotools build and would need to be
adjusted if it changes.
- The Flatpak SDK or the OCaml extension can break. Hopefully, this
would be rare. In that case, the cause would need to be investigated
and reported.
- Once a year, one should bump Flatpak SDK version to get newer
versions of packages.

I can do the Flatpak-related maintenance for the foreseeable future but
I cannot guarantee timeliness. So I can imagine a situation when you
make a fix, start to rely on sending people Flatpak links to test
changes, only to find out that it is suddenly broken, and I am on
holidays in the Australian outback for a month.


> Sorry, I don't understand the relation between 4 and 5.=C2=A0 Is there on=
e
> thing to do with two benefits?

(4) is prerequisite for (5).

(4) is already implemented in
https://github.com/coccinelle/coccinelle/pull/370

(4) requires Flatpak, flatpak-builder, cloning the Coccinelle
repository and then running a command to have flatpak-builder build
Coccinelle from the manifest.

(5) would just require Flatpak, the other steps would be done by
GitHub/GitLab CI, so user would run command like the following to
install a pre-built package:
https://github.com/flathub/flathub/pull/5354#issuecomment-2184988422

(5) would require introduction of GitHub/GitLab CI configuration file
into the repository and perhaps some configuration changes to
GitHub/GitLab repository (regarding storage of built assets).


Cheers,
Jan
