Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E628C25B08
	for <cocci@archiver.kernel.org>; Wed, 17 Aug 2022 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:in-reply-to:date:cc:
   content-transfer-encoding:message-id:references:to:
   subject:reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=5Ds7EmY36Gp8HmwFCjgL1Hm4HfTFWSMj/4PRSTQO2x0=;
  b=UP6yHwARjUMib5+ej4VA3FX1Mk1JUzmWfXqP3KdA6sdG4RT7m9fhKPlt
   LSb2rrvPhd16EpNi1G1ALG2xfpwESu1e6vgYNqmSHv/vbupCALmNVpOgf
   d9Tt8e0WET57VpuWakJ43LrBTf85DzBqBq7uE4/BSjufi9xVQwHZCvtCq
   M=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,243,1654552800"; 
   d="scan'208";a="49029856"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Aug 2022 16:20:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 01E99E0385; Wed, 17 Aug 2022 16:20:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 59E05E0380
	for <cocci@sympa.inria.fr>; Wed, 17 Aug 2022 16:18:07 +0200 (CEST)
IronPort-SDR: ZVG0H/UBYI1pek4rkfTiqWHW+OGJ0VyfsZ1+h/M6iJsGrsARENTTwBdT84EPn7Ma1ehsSwoVov
 5FQvTUIrJa/LuITXESW+BCypkTGRQjsUH7e+1TKTPfaZGVmVV+uephUEXPRNTccvTpB4rBejSt
 R2F7SBmDJ16qVHfoBFl9NlZoFmEYyE1QgGwaxRL0F4MunpLoW+e9GvETyvqByUYDbeBroKzEGb
 a+qCiPpysRtHB5J8O8j7XCq2MCymo7jeOVzNo0FL5cbR52VHYga1TcqNy50WFHO4clV9ZtI8bc
 JPCN2bL1I5WybYynM+r9x1Gz
X-IPAS-Result: =?us-ascii?q?A0B/AACU9/xiXUHaVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYFRUgcpAYEnLgRQkzWCKIQlhw4DgQaQQ4F8CwEDAQwBQAIEAQGFB?=
 =?us-ascii?q?wKEeQIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBBhwLC?=
 =?us-ascii?q?QcSFQ4FYAFhAwFEgU+BdAsDMQ2CNSkBg2MBAQEBAgESKAYBGx0BAwELBgULA?=
 =?us-ascii?q?QwuIxEBBQEIFAYTIoJbgm0BAw0lAwGbVIEEQoo4eIEXBReBAYIJBoJhgW4KG?=
 =?us-ascii?q?SgNZwNbfgIHCQEIgSsBhk2ERoQzJ4EZgRCBPByCZz6ERBWDeIIuBJkQBAUUD?=
 =?us-ascii?q?wMDAiADCQQHBSweAgkDIxEDCxARBw4BFgEECAEEAwEBAQ4CBQcCBgMDAgICA?=
 =?us-ascii?q?gUBAgoCAQIEAwYGAgMQAQIEAQoEAgMIAgcDAgYECgQCCAIEBQMNAQMFAgMBA?=
 =?us-ascii?q?QMDAgQBAgEBAwgBAwIDAwICAgIFAgMCAgIJAwQBBwMCAwEEAwECCgQEAwQCA?=
 =?us-ascii?q?gcCBwIEBwIBAgYDBQYCAgEHAQEECgQDAwMDAgUCAgMCBhIGBgIEAQMEAgoCA?=
 =?us-ascii?q?gsCBwEBAgEBAQECAwIHBQsBAQEDAgMGBQIBAQMIBgIBBAEFAwEEBQMHAgEFB?=
 =?us-ascii?q?gIJAwMJAwEBBQEDBAMDAwIHAwECDAQIAwMCAwQCAgICAQMCBwUIBAIJAgICA?=
 =?us-ascii?q?QICAgQCAQMaAQIDBQICCQsBBAICAwEDAQECCAQJBAIDBAIBAQMCAQICAQUCD?=
 =?us-ascii?q?gYBAQEBAgMDAQIDAQYHAggCDg4KAQMDAwICBQICAQIDAgIMAQEEAgECAQIGA?=
 =?us-ascii?q?QMBAgIDAQMBAgIDAgYJAgQBBQMDAgIDAQEFDgUCBAIBAgYFAgEBAQQBAwQEB?=
 =?us-ascii?q?gICAQMDAg4CBAEEAQIBASMDBAIDAQMXAQIBAgMDAwQGBwUCAQITAQIBAQEFA?=
 =?us-ascii?q?QIBAQMEBAcJAwICBAMDBQEBAgMCAQEBBwwCAgITAhMDAQYBDgUUAwIEAgIBA?=
 =?us-ascii?q?gIKAwECAgEDAgkCAQIBBSADAQEPJAEBAgICAgMEBwIBBAYDDQICAQEBBQYNA?=
 =?us-ascii?q?wIDCAEMAgcDAgEDBQECAgIEAQIECgkBAgIBAgQFBwIBCAYFDQUJCwEBAgEDB?=
 =?us-ascii?q?wQDEQIFAwUFAwMCAQYEBQIDAQIBAQMEAQMEBgEBAgMCAgEGAgIBAQMDBAMBA?=
 =?us-ascii?q?gYCAgcCAwIBBAIDAwEBAQQCAgICAgMDCAMCCAcFAQYBAgEEAwICAQIHAQQBC?=
 =?us-ascii?q?AIBAwMFAwQBCgMPAwUDAQMDAhQKBQEFCAYJAgQFAgUDAgQCAwMCAggDAgQDA?=
 =?us-ascii?q?gsDAgYEAgcTBwIDAgIFAgICAgIFBAMBAgICAgICBQIEAgEFAQICAQICAgQBA?=
 =?us-ascii?q?gIHBAIDAQMEDgQEAgIHAQICAQYCBwMBAgEEAwEBBAIEAQIFAgQBAwECBgIEA?=
 =?us-ascii?q?woCAgMCAgIGCAMDDAkCAwUCBgEBAgcEAgILAQYCBwICAQIDEQEDAgEEBQUDA?=
 =?us-ascii?q?wMJAgIDAgQCAgoBAQEBAgIBBQUCBAcPAgICBAICAgEDAgIBAQICBQQJEgEBA?=
 =?us-ascii?q?gMGBAYFAwIIGAEGAgIBAQICAgMDAgYCAQIIAgQBBAUCAQICAgIEAQMGAgMBA?=
 =?us-ascii?q?QIBAgIDAwIBBAIEAwMBAQIBAgICAwICAgMCAgEQAgYGAQICAgICAwICAQIBB?=
 =?us-ascii?q?QECAQIEAgcCBAMCAQICBQICAgMBAQYCBAsBAwIHBgEDAgcFAgMBBAMEAwMFB?=
 =?us-ascii?q?gUMCAEFAQMBBR8DAgIIAgcCAQUDBQEPAwICAwICAQQKAQIDBQIEAgECAQQJB?=
 =?us-ascii?q?wIEAQINAwMIAgcFGAECAgcEDAoCAgIFBgIEAQIBAwECAgECAwcCAwIEBQEFA?=
 =?us-ascii?q?gECBQQCAgEBAgUCH02aZBOCSy8pwScHAYNUjnWRLQQull6SDpcCowkBhCYCB?=
 =?us-ascii?q?AEBAQMHBhAjEoEzBYIJMxojUCoBBoI2PhABAgEBAQ0BAgEBAwECAQIJAQECj?=
 =?us-ascii?q?h2DcopgPzQ7AgYLAQEDCYVGhTsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:bEUWU6nC+CGhEpu5xnkkPgTo5gxDIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xJMWjuGPP+LamCmfI12bIrkpx4A65ODyNNmTgJtpC9nQltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTrSs1hlZHWeIcg944f5Ys7N/09UAbeSRWVvX4
 4ui+pKHYTdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /0K7KK0ewsREZTVkf4WSh1KNX5ieq5JreqvzXiX6aR/zmXDenrohvhsVQQ4Y9Be9eFwDmVDs
 /cfLVjhbDjZ37PwkO/9ELA8wJp+RCXoFNt3VnVIzzLdXax+B5/CX43F4NZZ2HE7gcUm8fP2O
 5tBM2syNUuojxtnCG0SA4oQtseTxWj5UwwFjk3JroMv/D2GpOB2+OG1bIC9lsaxbcFcgU+co
 krU/mHzGBhcNdqFyDPD/GjEruTIlij6cJkDEaWxsP9smlyagGIJYCD6TnO+qPi9z0O8ApdRd
 RFS9S0poqw/skesS7ERQiFUvlbD5yAYadZoPNQj4RuG067GxVmFQWsLG2sphMMdiOc6Qjkj1
 1msltzvBCByvLD9dZ573ufExd9VEXhFRVLudRPoXiNevIa++NBbYgbnC4c8QPTs37UZDBmpm
 2jSxBXSkYn/miLi6klW1VXOgjbpq5qQCwBru0PYWWWq6g4/b4mgD2BJ1bQ5xagfRGp6ZgPZ1
 JThpyR4xL1eZX1qvHHSKNjh5Jnzu5643MT02DaD5aUJ+TW34GKEdotN+jx4L0oBGp9aJ2e3P
 xON414KuM870J6WgUlfM9LZ5yMCnfiIKDgZfq28gidmOcUvKlfWrEmCm2bJjjm8yyDAbp3Ty
 b/CKZr2ZZrrIatgyzWySo8gPUwDl0gDKZfobcmjl3yPiOLADFbMEOttGAbQM4gRsfzcyC2Io
 o43H5bbln13DbyuCgGJq9J7BQ5RdhATW8umw/G7g8bGfWKK7kl/W6+NqV7gEqQ+95loehDgo
 CjgBRAAlgWh7ZAFQC3TAk1ehHrUdc4XhRoG0eYEZD5EAlAvPtSi6rkxbZwyceV1/eBv168mQ
 PwMesHGCfNKE2yV9zMYZJj7jYpjaBX73VLUb3T5OGAyL8x6WgjE2t74ZQ+wpiQDCyyAs8Fh8
 bCt0wXsR4UOGlZ5B8HMZfPzlF685CBPmO97U0bSDMNUfUHgrNpjJyDr3604JsgNLVPIwT7Dj
 1SaBhIRpO/spY4p8YmR1frU8dvxS+YnRxhUBWjW67qyJBL2xGv7zN8SSvuMcBDcSHjwp/eva
 OBT+Pf2b68KkVNMhIxjSuo5wK874ezvkL9U1AFTGnvGMgawAbR6L3jahMRCu/EfxrJdvgfqC
 EuD9sMAYueMMcLhVVMTfU8rMLnF2vYTlT3fq/8yJRyitiNw+bOGV2RUPgWN2HMBduoraNt9z
 LdzotMS5iy+lgEuboSMgBdS+jneNXcHSagm6swXDdO5kAYt0V0eM5XQBjWsu8OKYtRId0Qoe
 3qa2veEiLNbyU7PNXE0ECGVj+ZagJ0PvjFMzUMDdwvVwIub3qdv0U0D6ykzQyRU0g5Dj7B5N
 F9tOhAnPq6J5Tpp2JVOUm3E99ut3/FFFpEdCmfllVE1i2GtX23JaWA/YKODoh1f/GVbcTxWu
 rqfzQ4JlNoskN7ZhkMPtYxN8pQPjuCdMiXNncmmG4KOGJxSjf/NnPq1fWRRw/f4KZpZuaAEz
 NWGOM5/bKT6MWgbpKhT50x2E1gPYEjsGVGuis2NME/E8a8wtd1yNfWzx5iNR/5w
IronPort-HdrOrdr: A9a23:BLquMKnau72X+sQEZ9jNE0deR6npDfIP3DAbv31ZSRFFG/FwWf
 re5cjzsiWE8Ar5OUtQ+uxoXZPrfZqyz+8S3WB8B8bHYOCighrOEGgd1/qY/9SQIVydygc178
 4JGMhD4Z/LfCJHZK7BgTVQeOxQpeVvnprY+Ns2DE0AceipUcxdBstCZTpzancGODWuzKBWKK
 ah
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,243,1654552800"; 
   d="scan'208";a="49029517"
X-MGA-submission: =?us-ascii?q?MDF7H4SXQ4rBwgLZFZ8dKgr1mu+Wuzuh8AMJZi?=
 =?us-ascii?q?9hGBar/St3ItQgWB9Uqy/zu7ZF9nQgVtu7/JWlxoOJRNkp4M6ARtTVbw?=
 =?us-ascii?q?AVKDm4ZJoUUDK7TGxjnZUilhxZGMkjJdYASCHWIIR3x4+hi4h62WSyzC?=
 =?us-ascii?q?R083N42+k8GS5NpCL9wCy9+Q=3D=3D?=
Received: from mail-ej1-f65.google.com ([209.85.218.65])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 16:18:07 +0200
Received: by mail-ej1-f65.google.com with SMTP id gk3so24786651ejb.8;
        Wed, 17 Aug 2022 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=5Ds7EmY36Gp8HmwFCjgL1Hm4HfTFWSMj/4PRSTQO2x0=;
        b=VEn3cOnAAKtAXIAGV6W/fnhvXdlsNYUtKVoWxwHFwzwR87+dd8oIdU2jopBs8qV0mT
         Dc5qqnwq5Lj/Mlm8gxOwsMP1dm1kq2n7vdwW4BqwZh4YZhBviqadErMofy9K+Ak1zdYt
         UqZzMJl+xeFee7HaXv2L1MSVo/337blhUtvU26E+3Uv5CrdrOiCAWiBZkV5MQSBEsl2I
         Sc9qOiwR1jHYQVM3nig/mlR03RSasokQ0esI2QyTnh+JUfW/7O82V5tLFa90XbEdyKwf
         t8HvSF9EBZeA3T7TQywLUOjeu5iuBL9RDJ3eBJN8KfFS+XXvEzomH8w5F247Lv4346Zf
         Z2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=5Ds7EmY36Gp8HmwFCjgL1Hm4HfTFWSMj/4PRSTQO2x0=;
        b=ZmDyc24G2nJWXczHvP4vtr7wvRCoufEdKiWEfuiBxrX0OOFMKSOtpYUu1cyPzqJT2r
         tQ2XVHrwVQbaeQF1FlJ0qPw5JEtBH7DrzjwVlwEe9Oqy+2s+IfY5pnQRNLqWocNuTGBG
         JilT41S+UTXFDBjP7V9cuRcP9IJrTcKjWTj7h0EfnEGm8eZ/p2gt6hvRiEy+ou/LlUbf
         6vG1Mkb9dxQHAn4pnJNbbSl14gCbchLmhj78DGQdy/NmXWXEYS2SvXWVgYDO/4Ya06to
         de9YE30d9wBmL3uTJKWJG5LJ+u5JDC57WQtDyzuIkAdcSz/39biKtxHfSyWw+MJdKRZ+
         rrGw==
X-Gm-Message-State: ACgBeo2ZDKi1JlsoPxb/g30Ys9kJwA+Rvbua2i/3meVzcQqAEtVjeC69
	2ZIFJRzjrOucqT/3lMWuYqXHvPx3rmVgZw==
X-Google-Smtp-Source: AA6agR7jAd5EdfAtzL2sz3VzfNjoAkqDk+g1W5U3v2BL2UKOcfa+vaSAk/O3z2Tp1dmQ+ReRIyyJig==
X-Received: by 2002:a17:907:7388:b0:730:fd1f:3564 with SMTP id er8-20020a170907738800b00730fd1f3564mr15988043ejc.576.1660745886173;
        Wed, 17 Aug 2022 07:18:06 -0700 (PDT)
Received: from smtpclient.apple ([2a02:8109:9d80:3f6c:f4b2:956:5d0:dd2a])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7cccf000000b0043e581c30eesm10741627edt.31.2022.08.17.07.18.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:18:05 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
From: Jakob Koschel <jkl820.git@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
Date: Wed, 17 Aug 2022 16:18:04 +0200
Cc: cocci@inria.fr
Content-Transfer-Encoding: quoted-printable
Message-Id: <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
To: Julia Lawall <Julia.Lawall@inria.fr>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] match arbitrary argument position
Reply-To: Jakob Koschel <jkl820.git@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 511
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/A564705D-53D2-44E9-BAF4-AE99E78B09ED%40gmail.com>



> On 16. Aug 2022, at 23:07, Julia Lawall <Julia.Lawall@inria.fr> wrote:
>=20
>>>> Based on that I was wondering if there is a way to say: match if =
the expression is
>>>> within an expression list. So if I for instance have something like =
this:
>>>>=20
>>>> @main@
>>>> type T;
>>>> parameter list P;
>>>> expression list E;
>>>> expression E1;
>>>> identifier func, func_call;
>>>> @@
>>>>=20
>>>> T func(P@E) {
>>>>   ...
>>>>   func_call(E1 in E)
>>>>   ...
>>>> }
>>>>=20
>>>> (above is not valid syntax of course)
>>>>=20
>>>> Ideally I would like to make and get the parameters of 'func' that =
are used in any position
>>>> as arguments in 'func_call' if that makes sense?
>>=20
>> Do you have any idea regarding the expression lists?
>>=20
>> looking at the following code snippet:
>>=20
>> test.c:
>>=20
>>   int func1(int argc, char *argv) {
>>      func2(argc, argv);
>>=20
>>      func3(argc, argv);
>>=20
>>      func3(argv);
>>   }
>>=20
>> what works is (only matches the first func3 call):
>>=20
>>   @main4@
>>   expression list Es;
>>   @@
>>=20
>>   func2(Es)
>>=20
>>   @main5@
>>   expression list main4.Es;
>>   identifier func;
>>   @@
>>=20
>>     func(Es);
>>   + // add comment
>>=20
>>=20
>> what doesn't work (matching on the expression list from the parameter =
list):
>>=20
>>   @main4@
>>   expression list Es;
>>   @@
>>=20
>>   int func1(Ps@Es) {
>>   ...
>>   }
>>=20
>>   @main5@
>>   expression list main4.Es;
>=20
> Could you try
>=20
> expression list main4.Ps;
>=20
> It may transform the parameters into a list of expressions.

I just tried:

@main4@
parameter list Ps;
@@

int func1(Ps) {
...
}

@main5@
expression list main4.Ps;
identifier func;
@@

  func(Es);
+ // add comment

but that throws:

meta: semantic error: incompatible inheritance declaration Ps
  File "test.cocci", line 45, column 24, charpos =3D 539
  around =3D ';',
  whole content =3D expression list main4.Ps;

>=20
> julia
>=20
>>   identifier func;
>>   @@
>>=20
>>     func(Es);
>>   + // add comment
>>=20
>>=20
>> Ideally I would like to 'find' all parameters used in a function =
call,
>> I also tried this:
>>=20
>>   @main4@
>>   parameter P;
>>   expression E;
>>   @@
>>=20
>>   int func1(..., P@E, ...) {
>>   ...
>>   }
>>=20
>>   @main5@
>>   expression main4.E;
>>   identifier func;
>>   @@
>>=20
>>     func(..., E, ...);
>>   + // add comment
>>=20
>>=20
>> But it throws: 'rule starting on line 41 contains unattached =
metavariables: main4.E'.
>>=20
>> Any idea, why e.g. the second one doesn't work? If I print it with =
python the expression list
>> looks the same as for the first one.
>> Also in the end this boils down to: is it possible to match to any of =
the expression list elements?
>>=20
>> Thanks,
>> Jakob
>>=20
>>>>=20
>>>>=20
>>>> Any help is very much appreciated!
>>>>=20
>>>> Thanks,
>>>> Jakob

