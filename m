Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD97FD41D42
	for <cocci@archiver.kernel.org>; Tue, 12 Nov 2024 00:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=i9zKhs2hSqQQ/VCf+j4DqjlRFKc3uvaq1nAilZDlJv4=;
  b=jD85p+wmpqGK9YEp0nOR/RN0kQRIyX18cy0yF2oWdoJBeBRcrhZm4g/V
   CMozYfb2rAyXQQSCZ26HDzjH94De6C82cihdDUg0FvcQHBtlc1KvAn1ae
   d3CrcBJztQO/a1XLjU0EHTiBwPv0cp6cjyb16xuHdmw4GlAl43XyBMgIW
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
X-IronPort-AV: E=Sophos;i="6.12,146,1728943200"; 
   d="scan'208";a="193227550"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2024 01:27:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CE6EDE0D1C; Tue, 12 Nov 2024 01:27:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CF4AEE00B7
	for <cocci@sympa.inria.fr>; Tue, 12 Nov 2024 01:27:14 +0100 (CET)
IronPort-SDR: 6732a0e2_xA3tmygqWWMuDhH3PvNJeUoTpfL4ryzm7a3kyaUumbiuaWi
 PXsybNdN8OtJOQn8mvkttRwg+8Ai92LZJDoqSsw==
X-IPAS-Result: =?us-ascii?q?A0GfAgA1oDJngTTdVdFagQmBU4JEfVozBFOEVpFuA5oQh?=
 =?us-ascii?q?AWBQD4PAQMBCwEBOwkEAQEDBIUAAoo7Ah4HAQQyBw4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDjuFew2CYoElYQICAwMDOAEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCDR9eAQEBAQIBEhEdA?=
 =?us-ascii?q?RsdAQMBCwYDAgsNAgImAgIiEQEFARwGLgeCYIIvAQMOIwMEDZRfj0CBBUKJc?=
 =?us-ascii?q?xo3eoEVBQIWgQGCDQaBWUFP13MKGSgNbAOBYQIBBgkBCoEGLoRzKVyCVAGBb?=
 =?us-ascii?q?Id6eicbgUlEhD8+gmECgUoWFYNGgmkEgkGBNAmCaXYjAocqXoENg3+DR4Yeg?=
 =?us-ascii?q?TOJOggBBh8SCQkTBgoCSwsKEgMEAwQEAQILEwkDAwIOAggDAggGDhEBPxIEE?=
 =?us-ascii?q?woNCwcFHwoHDBEKKAQiBA8SHBADMgMEBQMFAwMEBwECBQQJCAEFAwIEAwMCA?=
 =?us-ascii?q?gMCCAUHBAMKBgEBAwQDAQEFBwcDAgEBAwEBCgsIDQUDCAMGCQMEAQEFDQgCA?=
 =?us-ascii?q?w4CAgIDAgEKBggFAQMGIQEMAwEDAwUMBBQDBAUCAg8MAQIDAwcDBQICAgICA?=
 =?us-ascii?q?gIFBAECBAIEAQgECQECAgIDAgEBBgQCAgIDAgcMBwMEAgYCBgIDAgcLCgIDB?=
 =?us-ascii?q?gUFAwUCHgIDAgIEAwMVAQEDAQIBAgMCAgMCAwQBAwMCAQEBAwcCAgIHBgUCA?=
 =?us-ascii?q?gMMAgMDAQEGAQIBAg8FBQYEAQoDAhQDBSICDwUIASYBLQICAwQNCAUCAgcCB?=
 =?us-ascii?q?AwCBA8FAwMOBhYGAQQIBAYEDAoDBA4HFxEBAQQEAhMHAgsCAgYEAgIHIwYDB?=
 =?us-ascii?q?QgDAgUFEAICCwIEAxUEBBsDAQIIAgIYAgEHAQISAQcCAgEUAgoDAgUGBwIcA?=
 =?us-ascii?q?gIDAwQEAwEFAwQQAwsBBQYFAQEEDgECAQIBAQIDAw4BAgIDAwICAQkCAgEBA?=
 =?us-ascii?q?g0IAQQDAQcCBQMFAwoBAQECAQQJBA8GAwUDAwcDBAIDAgYCBAgCAgMDAgMBA?=
 =?us-ascii?q?wMCAQIDCQIBDw8KDwICAwQCBgICAQQmAgEVBQIDBAICBwICAwECAQICAgQCB?=
 =?us-ascii?q?AICBgMJCAECAgcBAgICAxUCBQEECQMDBRIMIgMDAQICAgMHCgMFAgEBAgQDA?=
 =?us-ascii?q?wMDCQ0HAgMBAgEDBQMBAgECCQMGAgIDAwUSGQUDAg8DAgEFBAIIEgsHAQEPF?=
 =?us-ascii?q?gUECQUVAwYCAwMWCwQFAwMDAQwFDA4CAgsDFwUBAQcBAw4IAwQEAgMDCQIBE?=
 =?us-ascii?q?AEDBAIJAgQBAgoCAgICAgQBAQUEAgQDAgUCAgEIBAMDAw0EAwgIAwUDDBICA?=
 =?us-ascii?q?gIJAgMBAgMDAwQNCBYNAwINGgoVEwcHAwMECwIJAwQNAgQCAgEGAwYKBhYBA?=
 =?us-ascii?q?hgCAgYMBAMDCAMCAwICAQICAgERAgIJCA0FCQUGAhYDAgMIAQkDDwMCFAEGA?=
 =?us-ascii?q?ggDBwEBBAICChEKAQECAgEGKAMBAQIUFAcDCAICAgIGFgwBBQcDBw8FBQQCA?=
 =?us-ascii?q?hYDAxUEBAwCBQICAwMCAQEUBhUBBQIDBgsBBgECBQQCAwQCFAISAwQDCgIPA?=
 =?us-ascii?q?wYDBAYDAQIMEAIEAgkLAQUEAwcFAh8DAwICBQsCCAICBQIFBwMJCwYBAggDB?=
 =?us-ascii?q?AkCFAIQAgICAggUBwICAgIFHgMmAgQDAwMDCwECAg4JAwRDBhMEAgMDAg4BA?=
 =?us-ascii?q?gILAQICBAIDAQQHCQMDCQoHAQoNBwICCggJEAECAg8HAwICAgIGBxEDAhMPB?=
 =?us-ascii?q?QYGAgoHDQoDAgECAhMCAwkGAwUNAwcECg8CFwIYBQMhAggJCwIQHQIJAyMPA?=
 =?us-ascii?q?wsJCBM9DAcyBDQBFBQHBiWBAJ4/R4MtgQkFFBgFHXkwFAUfECwJAh7GDWiDP?=
 =?us-ascii?q?IwWh38HjT0zhASTOxQykkiYd4JWhy6De5VihRgCCgcGESMSgTkMJ4FcTSMVO?=
 =?us-ascii?q?zGCAgEzTwMZD5IbgmTCdkI1OwIHAQoBAQMJjxUBJwQIgUsBAQ?=
IronPort-PHdr: A9a23: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
 LappnNEnh15NZs7ePaWK61OwVxdwKmJu33wvt0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:WoR42q9c3JmjEZ4SqxFuk+AWI+orL9Y04lQ7vn2ZhyYlFPBw8P
 re4cjztCWE8gr5PUtLpTnuAtj4fZqxz+8Q3WBVB8bbYOCEghrWEGgB1/qB/9SIIUSXnZ8/6U
 4jSdkENDSZNzhHZK3BkWyF+rgbsb66GeyT9Jvj5kYoYgdwdal64gt1TiqdGFZnXRRLCPMCeK
 Z0JfApm9NjQxkqhwiAaEXtltKjm+H2
X-Talos-CUID: =?us-ascii?q?9a23=3Adv5pVmokS5vQePE3OJJO7tvmUcpidE3TnW3RGGO?=
 =?us-ascii?q?9G3tpaI+wE07P4ooxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AsPHJ+gw7X9kULoTz3fBP+kwwkXuaqK2OJ3BOnoc?=
 =?us-ascii?q?mgcS/G3ReJQeavh+eU7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,146,1728943200"; 
   d="scan'208";a="193227547"
X-MGA-submission: =?us-ascii?q?MDEG9N715LvseAxDcqLXW/+AStEsqhFd+a0GWw?=
 =?us-ascii?q?O7cT29bgydS6ySrP0tTWZuTUyTERtBOTkpsMdGTw7tIlA+Zk3nnKoKzB?=
 =?us-ascii?q?oSrJEMZkQ1Diwz5Xklwrzfewgzz2qUunP9V/L1Qwi122u93odecD2uYO?=
 =?us-ascii?q?y5v+D3BzPtH4Msf6TOXhAthA=3D=3D?=
Received: from mail-wr1-f52.google.com ([209.85.221.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:27:14 +0100
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso4810245f8f.1;
        Mon, 11 Nov 2024 16:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731371234; x=1731976034; darn=inria.fr;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i9zKhs2hSqQQ/VCf+j4DqjlRFKc3uvaq1nAilZDlJv4=;
        b=UgW4v8sPiBZ41ozoTsAVpM2JleJCvBG4nq7lG8LzDsV8QDIxGHOITUZwnUglzZM6V2
         GKHSUHGthUrkJ+zBS8iyZMHnJ6otYXcnlD/hsT3ycKuqLGZJ9FfBbKv4YkgXV0YFBheA
         4/Ipdi5XHb3oPJteXJfsKEL/iT8RMXaFNXjWAsM2ovmqpXQjGnuC1uWhbvvwUoXRNujE
         04KFrIqhQzXa43cI0I4PdaTZZfBgKwAqaxcD/ewYvJhhbIeznhNz1HNa9FMlDg4nYdyW
         gcQC/p0O6h3462hjR3AjIJO3pzjS+IIZfoApVbnElIionyNndTOM2Iu3xwHt/oFgDjtd
         5TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731371234; x=1731976034;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9zKhs2hSqQQ/VCf+j4DqjlRFKc3uvaq1nAilZDlJv4=;
        b=cXjESU62wtvhwIc+JLjS86v+LrfHWwZktuzYOAgHmHMrajrpmBYq9hBIAbdLVfgK1T
         QUXV1T4lDmV0OWdTkwACrkggkQAFPU0yDIArKafJAlx5UQdYJmVXVLKLDZezKPIUbaOE
         uDJdoYYKXJ8dOWPs6KyO6OPGkBh8L2h90ed9bhiyjYsiz0XY/BwZigQk3VaRXL0fZhlz
         0q+6oUwWmyrsodZIRTR1Grp1Ezft6jF8rtcPxGSDsVpiNuHPvpRWpoVX0ELamtV72as4
         9mqeTOxFZB75KQwjbJkNvwIx73xt2jLuD60PjZwllibaJJlTAwlSWLpVkmjp+DDQQELo
         AA3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6a3Tj9G/BKhQP+2e+wcJkgRQ1txyLHuZZaAlGyG1jjcC++z6EShgMDNgAkU1L5SMj2d7lnR7xnf4Usmo=@inria.fr
X-Gm-Message-State: AOJu0YxWhCG2idcdOPlJ2P+wbhlYe1n5ZubBFVAIjn718AQpISFCiKbb
	voz8M8qBzdfCvAdKR53vM9VCNF08Gf6RBvtU08NtpQNSK5ugaGvwTpwZ1ESPIgQ=
X-Google-Smtp-Source: AGHT+IH0/8nWD4p0wn73rRqyzb1MRo0Jmd3PK76mSb9ycL0C9XaWf2uCZi+jXurvPvmTXgUqPtYFbA==
X-Received: by 2002:a05:6000:1fa1:b0:37d:3e6d:6a00 with SMTP id ffacd0b85a97d-381f1884805mr14172677f8f.47.1731371233580;
        Mon, 11 Nov 2024 16:27:13 -0800 (PST)
Received: from [192.168.1.129] (ip-89-177-205-85.bb.vodafone.cz. [89.177.205.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c1205sm231767965e9.26.2024.11.11.16.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 16:27:12 -0800 (PST)
Message-ID: <52155a5f01e498bb667bc940f8d4fbfe5bc98290.camel@gmail.com>
From: Jan Tojnar <jtojnar@gmail.com>
To: Victor Gambier <victor.gambier@inria.fr>
Cc: cocci@inria.fr, Julia Lawall <julia.lawall@inria.fr>
Date: Tue, 12 Nov 2024 01:27:11 +0100
In-Reply-To: <6f6d90f8-1027-46ed-a518-0c3b4d6285d6@inria.fr>
References: <c3a8f4e3da654c061f7160c75dd0c4e155f3b51d.camel@gmail.com>
	 <35a285c7-bed4-8c72-15ea-e22a672d9373@inria.fr>
	 <ee969df771df6e87e92fa714fbb94529ad80e77f.camel@gmail.com>
	 <6f6d90f8-1027-46ed-a518-0c3b4d6285d6@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
MIME-Version: 1.0
Subject: Re: [cocci] Flatpak package for Coccinelle
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1996
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/52155a5f01e498bb667bc940f8d4fbfe5bc98290.camel%40gmail.com>

On Tue, 2024-11-05 at 15:34 +0100, Victor Gambier wrote:
> Hi everyone,
>=20
> As Julia mentioned above, I started working on Coccinelle earlier
> this=20
> fall.

Hi Victor, love to see more people working on Coccinelle.

>  I'd love to help package Coccinelle into Flatpak! I've read the
> discussion above, but some time has passed since then and things
> might=20
> have changed, so, in short: how can I help? Are you still interested?
> What questions remain?

Unfortunately, I will not be able to drive this forward in the near
future. Feel free to take over.

The primary thing that was missing is the decision on the degree of
integration we want to have, i.e. points (3) through (5) in the opening
message.

Depending on that, we will want to
- merge https://github.com/coccinelle/coccinelle/pull/370
- update the release script to bump the version in the metainfo file
- add CI for building the flatpak image
- push stable version to Flathub =E2=80=93 based on the previous PR
https://github.com/flathub/flathub/pull/5354

> > The procedure consists of updating the version and release date in
> > the
> > metainfo file (the following line):
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 <release version=3D"1.2" date=3D"2024-03-28" t=
ype=3D"stable"/>
> >=20
> > I would say it is easy to forget and pretty amenable to automation.
> (3) I can update the release script to update the version of the=20
> AppStream metadata, that does seem like the best solution.

=F0=9F=91=8D

> > (4) is already implemented in
> > https://github.com/coccinelle/coccinelle/pull/370
> (4) If I understand correctly, you've already written the manifest,
> and=20
> this is something we only have to do once, right?

Yes, the manifest is in the PR. It might need some minor changes in the
future, e.g. bumping the runtime version once a year:
https://freedesktop-sdk.gitlab.io/documentation/updating-sdk/release-notes/
But otherwise it should be pretty stable, as there are no other
dependencies tracked in Flatpak other than the OCaml runtime extension.

> If the license was the=20
> last thing you needed, feel free to mark your PR as ready and I'll=20
> review/merge it.

I have undrafted it, feel free to take a look.

> > (5) would require introduction of GitHub/GitLab CI configuration
> > file
> > into the repository and perhaps some configuration changes to
> > GitHub/GitLab repository (regarding storage of built assets).
> (5) That integration seems nice. I'd like to improve the way we do CI
> and releases, and this seems like a nice addition. We might have to=20
> think about whether or not master is, as it stands, the best branch
> for=20
> this. What would this look like in practice from the point of view of
> the user? Would they just download a .flatpak file from the=20
> GitHub/GitLab releases page?
>=20

Yes, CI would build a Flatpak package, user would download a .flatpak
file from the artifact list on the CI execution page, and install it
directly.

I imagine having it on master (or even temporary development branches)
would be useful for users to test fixes for issues they reported,
without needing the OCaml development environment.

For stable releases, other installation sources (e.g. from Flathub or
Linux distro repository) would probably be more suitable, since if I
understand it correctly, the .flatpak file is more akin to a .exe file
(no automatic updates).

Cheers,

Jan
