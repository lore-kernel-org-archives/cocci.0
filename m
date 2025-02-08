Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56F9C02198
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2025 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=t5v/uZgg6BtPMujBt3vZZVJeQ4kwIOq2P8MgT2UM5Fs=;
  b=bRMntRSQoSZ4pmVXWDo1w09ded0pvUkPzNRiCbVzgFzaOPm8MI2iyOwc
   TlNlFMbOZdVf8TH3jJx4knv8rLSg+6oQjI4TuFDMKcAEf5EbgBEBfrDVp
   F1JvtOw8CXRqQKTslmypi/SXZbkMZkRrh+PM/5Hv6U03Na1fAOnrD3aim
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,270,1732575600"; 
   d="scan'208";a="207290298"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2025 15:29:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CCA2AE0D1D; Sat,  8 Feb 2025 15:29:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A0330E0260
	for <cocci@sympa.inria.fr>; Sat,  8 Feb 2025 15:29:06 +0100 (CET)
IronPort-SDR: 67a76a32_y0AJ+mxxebUvefSztUYGiz4RY/adCT0ipdyJnqmtj5Dyji8
 nU0EMeRekrqGjtZOcYfoLn0r/Mgp0T+LjcxIe8w==
X-IPAS-Result: =?us-ascii?q?A0HHFgB8aadngAwR49RaHQEBAQEJARIBBQUBQIFTgkRid?=
 =?us-ascii?q?TMEC0iEVo9PgXQwhDuHO4dTiHWDVA8BAwENQQECBAEBAwQ4hEgCiwQCHgcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNg?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMEGQEBESYBBAsLGgImAgJWB?=
 =?us-ascii?q?gEUAQGCfoIwAQMOIwewLX8zgQGCDAEBBtpcHywiV4FlCYEaLoVsgmMBhiaDQ?=
 =?us-ascii?q?nonD4FVRIE8gRSBbz6BD4J7OYNbgmmCM4RIZ4lqiGyESYM3iTBSexwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSlIAyo2MSOBIwU1QTqCDWlJOgINAjWCHiRYgitqBAWBLYI5hEOET?=
 =?us-ascii?q?YVagTpYgWADAxYQAYIxcHgcg1V5HUACAQttPTcJCxsGPZ85iB7GDzQHgjiBZ?=
 =?us-ascii?q?oFjDJ9cBhMvl0MOBpJ7mHwio2+FHYF+I4FcMxokgzZPAxkPjiGELcU1QjU8A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBikQ0gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 TBdeF2oi31XhaI8/QiMtpKV9NwkUOvT8ggV
IronPort-HdrOrdr: A9a23:j0wr0qqLEHKOZPI2yUkQE0kaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AUVgSdmlLgOBlrpoMrfJqhHIyh2/XOS2H7XmXDxK?=
 =?us-ascii?q?TNXgqFYKWR0a1o6RLzMU7zg=3D=3D?=
X-Talos-MUID: 9a23:LmG7fAugIh89pymA682nqhMzCMNZ04+SM1EIro8B5I64G29VEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,270,1732575600"; 
   d="scan'208";a="207290297"
X-MGA-submission: =?us-ascii?q?MDH/Iv6EE2SrfS1zoI2eZV+ydb75FRYqcpJ1UZ?=
 =?us-ascii?q?WAgz5Me3KuRni/boK8lKtAUuyP0jgtKIIZFV6SYNX9h0A83WgH6DbLci?=
 =?us-ascii?q?sJSiSdHSObwAuoDrWP1BcRgkjOL8g93pDkV+3CXGL1nUwoN3hPYM3oXM?=
 =?us-ascii?q?yV6ZHTUBt4iryWf+titxL/iA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 15:29:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739024945; x=1739629745; i=markus.elfring@web.de;
	bh=t5v/uZgg6BtPMujBt3vZZVJeQ4kwIOq2P8MgT2UM5Fs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ih6wI2GmlE7izp2rmBQ7QfWr01sPoyKWalrjC7WuGGiowS0/4s3CipwxPRiekXUn
	 9j0Q4icHp2aYwvjOI5N6A63evx/cAt72PumrqcDAkPTPJHRtYeM/5GBAqiNUbyOaL
	 911WxYEkwiEPGcP4jgQmW55PB6AaZP+fzQZ9RXjEMpuY8l6TGgK4s/hqvsjfyL68x
	 4TDNrIhUSgHgGRx6S/wT+mi5LsNK9Bl2boqjZMTeLBe6sEJSerI5esqLxhoje+3Zk
	 +aOFsKht1XGAViQtMgnZpRMtHbN7pk0s86k8jTvGn7UDkdfsebCj3wX7p81svLPwB
	 AgbyxUoeSTY/rmDntA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.11]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myv72-1tT6cl0ljm-0143PA; Sat, 08
 Feb 2025 15:29:05 +0100
Message-ID: <e25d4a68-1ef5-4ceb-b3d8-b05dd9ed512c@web.de>
Date: Sat, 8 Feb 2025 15:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Johannes Berg <johannes@sipsolutions.net>
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
 <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
 <6bbdaca7-2fa0-4bdf-bdc7-ba76a5a1d171@web.de>
 <alpine.DEB.2.22.394.2502081257090.15422@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2502081257090.15422@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QIBXkCnArS84ASb/K+f13ZTW9nN9sgGd/hh5dGBDM0HjPWvHaOV
 2VChpAZR+9xmJE3QhOqGTTZLU+P3/Ttu3w/QaLh1cnfxZB5dIlMm+40wFL328080SkO9Sg1
 h26MItToXWwjjwV/lwjsBU7eSBq0OnucgDC5vFWtGRPqmaFB+ULvaV+4htp7mPekqkB3bgK
 02iv/u7a5EOMwSTjUC2rQ==
UI-OutboundReport: notjunk:1;M01:P0:AOd3DtPrdbU=;1s5lmbPkwzI1ODkIrgtChDF0aaD
 BGOnFwCT8WtkBfDsC8VgAs8mLxex7ALujOWZt2PBWjjQ65U492ZjbJRxDsxODwASn5ZYfxUzC
 671SmbYM+40fXLdeh22a1Np3+ZhvAWMTrnAT/6kM40fNzDMjQdQqd0VcTyjmxvhgLW0a3m4HN
 bgigm0H8weO2Aca4fH2XfwY1jOWYQOcGVsyrpWCQ+j5MLu30aGSyc+C5uiHGbX0UqOkW59BL2
 oWO/NJbAJunJWtVksESXDyUhF5TC0Blacnsjy+jx5pddDjgjAYyMujigfux6e7GMp8s/n9Sta
 jnCLugwZrR18k8eGOddjJQhAfhd87YN0MQ9I2piChKLdLnYFW22pyxZ7UUK4ge2lkXzglkt2P
 DDD1mqLZYC9Wc6VBDqrS2CEmRTbqPq8v4nYwnxK8hqCK9eUIw6d/qiKusFwJjF/v06zELOsRl
 wNckxj+lZidRhjyOC9B2u6Ncj2FmGagiEDCR3vORzztRMHqDmBPjvjpCXX0+LnZzriVRzbCtl
 6TF7h5Mkrvl6/71EjV0Wh91x3MSLk08hCU0cmIDOUtMVjcOVJt60Cyp5SEte1vUZjxSlEdLYY
 eC+g0xj9EscLzlu0QVsYDMTbreg2Xs6NhfmtaeR/G1cyViOV2zO4uvEcP8Gm57mzaIkw4dKm4
 nzdd5Qt6MG5J+NbxTyvo0/txae9TjPikPfxhvQbcMH4YTk0tQ5H/AKCbX4oMizvDRL7H5cs03
 p5zQfuxTr/UUiBJkXiwjNBvbSvbiuWiupMD42sG5Tl/cVc2NREGvcIlMmgRZwpaEcfDSZyJnu
 FqASbtvodiCrZ2FFgHa1YmW2yZrgx6RPif3PxOStKUsXkuAlmjbIth3cMB3bPxslKUVr6TQUq
 QqtlG+ws5Juarv5CBn8lfgnxsKNXybhcqykFiuRanV25rvHavREpK9buqCcl0/b3Hlcomn4RU
 V3gLh4e910nyv3Vc7sKCYR4NeKbNQV0HNav76ZfH/FEcm9BJ/Et3D3NfWbTu7teAtasHcpulf
 jCW8mHu45L3RSzRGOYC8pM10T/sOhTdEKrE5zI7K5rrOEpGqdSXJrfiU4el/zucioGMOLqJtA
 m0LEael8C6HVu46uMBcawNGFf3rDN/WUuzeN/C0hfeML53d3EF/eD+QCFvUzUJDRC/HH/ABNi
 2zgV2C1oUZ3UbrM8QOZ674JBxs95V5+VyR4vm5L5xiUH4BXwBVFaAzy14SvFRdWs81lcQ3O6r
 YhxVkogU1qB4TTreRX/2gQgrpx9BgNA9/8EigRx1XBsZgm5RrF+A9k32gzSyUpkuKoGn7lwRr
 UJrO/Qg58k0CUoWcH1No1QZoDMi02FFmy+42dCVUDdD+iyKmP+jKUHssFyCpxkDmL4VisEJDU
 hGx4T8v2Nq1Zvz4Lwb/JWKD9uG0C9TLlzgWSkFf88tBWzCl6IHrxvERpBssINoncv7k2IIxZx
 6Ct63zg==
Subject: Re: [cocci] Checking SmPL test cases?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2374
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/e25d4a68-1ef5-4ceb-b3d8-b05dd9ed512c%40web.de>

> The matched if doesn't occur on every control-flow path.
Will further collateral evolution happen according to a test result like t=
he following?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time spatch dele=
te_statement3-Johannes_Berg.cocci test3-beacon_len-20250206.c
=E2=80=A6
diff =3D
warning: deletion, node 22: for[1,2,4,5,7,8,10]* in my_beacon_len may be i=
nconsistently modified
warning: deletion, node 23: [fortrue][1,2,4,5,7,8,10] in my_beacon_len may=
 be inconsistently modified
warning: deletion, node 40: [fortrue][1,2,13,14,15] in my_beacon_len may b=
e inconsistently modified
warning: deletion, node 26: statement[1,2,4,5,7,8,10,11] in my_beacon_len =
may be inconsistently modified
warning: deletion, node 39: for[1,2,13,14,15]* in my_beacon_len may be inc=
onsistently modified
warning: deletion, node 43: statement[1,2,13,14,15,16] in my_beacon_len ma=
y be inconsistently modified
=E2=80=A6
@@ -11,18 +11,8 @@ my_beacon_len(struct cfg80211_mbssid_ele

        if (i < elems->cnt) {
                len =3D elems->elem[i].len;
-               if (rnr_elems) {
-                       len +=3D rnr_elems->elem[i].len;
-                       for (i =3D elems->cnt; i < rnr_elems->cnt; i++)
-                               len +=3D rnr_elems->elem[i].len;
-               }
                return len;
        }

-       if (rnr_elems) {
-               for (i =3D 0; i < rnr_elems->cnt; i++)
-                       len +=3D rnr_elems->elem[i].len;
-       }
-
        return len;
 }

real    0m2,146s
user    0m2,105s
sys     0m0,023s


Regards,
Markus
